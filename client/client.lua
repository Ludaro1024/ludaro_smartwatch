local weatherTypes <const> = {
    [GetHashKey("CLEAR")] = "CLEAR",
    [GetHashKey("EXTRASUNNY")] = "EXTRASUNNY",
    [GetHashKey("CLOUDS")] = "CLOUDS",
    [GetHashKey("OVERCAST")] = "OVERCAST",
    [GetHashKey("RAIN")] = "RAIN",
    [GetHashKey("CLEARING")] = "CLEARING",
    [GetHashKey("THUNDER")] = "THUNDER",
    [GetHashKey("SMOG")] = "SMOG",
    [GetHashKey("FOGGY")] = "FOGGY",
    [GetHashKey("XMAS")] = "XMAS",
    [GetHashKey("SNOWLIGHT")] = "SNOWLIGHT",
    [GetHashKey("BLIZZARD")] = "BLIZZARD"
}

local function tooBoolean(value)
    return value == 1
end

RegisterCommand(Config.OpenWatch, function(source, args, rawCommand)
	SetNuiFocus(true, false)
    SetNuiFocusKeepInput(true)
    SendNUIMessage({
        type = "hud",
    })
end)


local nuiFocus = false
RegisterCommand(Config.MoveWatch, function(source, args, rawCommand)
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "settings",
	})

    SetNuiFocusKeepInput(true)
    if nuiFocus then
        nuiFocus = false
	    SetNuiFocus(false, false)
    else
        nuiFocus = true
	    SetNuiFocus(true, true)
    end
end)

RegisterCommand(Config.ChangeWatchFace, function()
    SendNUIMessage({
        type = "switch",
    })
end)

RegisterKeyMapping(Config.OpenWatch, "Open Watch", "keyboard", Config.OpenWatchKey)
RegisterKeyMapping(Config.MoveWatch, "Move Watch", "keyboard", Config.MoveWatchKey)
RegisterKeyMapping(Config.ChangeWatchFace, "Change Watch Slide", "keyboard", Config.ChangeWatchFace)

function CalculateTimeToDisplay()
    ---@type number|string, number|string, number|string
	local hour, minute, seconds = GetClockHours(), GetClockMinutes(), GetClockSeconds()
	if hour <= 24 then
        if string.len(hour) < 2 then
		    hour = "0" .. hour
        end
	end
	if minute <= 60 then

        if string.len(minute) <2 then
		    minute = "0" .. minute
        end
	end
    if seconds <= 60 then
        seconds = seconds
    end

    return hour .. ":" .. minute .. ":" .. seconds
end

local time = Config.RealTime and nil or CalculateTimeToDisplay()

RegisterNUICallback("onReady", function(data, cb)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z))
    cb({
        -- weather = weather,
        realtime = Config.RealTime,
        time = time,
        hunger = Config.Functions.GetHunger(),
        thirst = Config.Functions.GetThirst(),
        streetname = streetName,
        health = GetEntityHealth(PlayerPedId()),
        oxygen = 0,
        idd = GetPlayerServerId(PlayerId()),
        armor = GetPedArmour(PlayerPedId()),
        job = job,
        money = money,
        bank = bank
    })
end)

function Oxygentopercent(oxygen)
    if oxygen == 10.0 or oxygen == 10 then
        oxygen = 0
    elseif oxygen ~= 10.0 or oxygen ~= 10 then
        oxygen *= oxygen
    end

    ---@diagnostic disable-next-line: undefined-field
    return math.round(oxygen)
end

Citizen.CreateThread(function()
    while true do
        Wait(Config.Interval)
        job, money, bank = Config.Functions.GetJobMoneyAndBank()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

		local streetName = GetStreetNameFromHashKey(
			GetStreetNameAtCoord(
				playerCoords.x,
				playerCoords.y,
				playerCoords.z
			)
		)

		SendNUIMessage({
			type = "update",
            hunger = Config.Functions.GetHunger(),
		    thirst = Config.Functions.GetThirst(),
		    streetname = streetName,
		    health = GetEntityHealth(PlayerPedId()),
		    oxygen = Oxygentopercent(GetPlayerUnderwaterTimeRemaining(PlayerId())),
		    armor = GetPedArmour(PlayerPedId()),
            idd = GetPlayerServerId(PlayerId()),
            job = job,
            money = money,
            bank = bank
		})

    end
end)



Citizen.CreateThread(function()
    while true do
        Wait(Config.HungerWarning.Interval)
        local hunger = Config.Functions.GetHunger()
        if hunger <= Config.HungerWarning.threshold then
            Config.Functions.Notification(Config.HungerWarning.message)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(Config.ThirstWarning.Interval)
        local thirst = Config.Functions.GetThirst()
        if thirst <= Config.ThirstWarning.threshold then
            Config.Functions.Notification(Config.ThirstWarning.message)
        end
    end
end)
