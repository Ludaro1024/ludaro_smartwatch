


RegisterCommand(Config.OpenWatch, function(source, args, rawCommand)
	SetNuiFocus(true, false)
    SetNuiFocusKeepInput(true)
    SendNUIMessage({
        type = "hud",
    })
end)

function tooboolean(value)
    if value == 1 then
        return true
    else
        return false
    end
end

nuifocus = false
RegisterCommand(Config.MoveWatch, function(source, args, rawCommand)
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "settings",
	})
    print(nuifocus)
    SetNuiFocusKeepInput(true)
    if nuifocus then
        nuifocus = false
	SetNuiFocus(false, false)
    else
        nuifocus = true
	SetNuiFocus(true, true)
    end
end)

local weatherTypes = {
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
RegisterCommand(Config.ChangeWatchFace, function()
    SendNUIMessage({
        type = "switch",
    })
end)

RegisterKeyMapping(Config.OpenWatch, "Open Watch", "keyboard", Config.OpenWatchKey)
RegisterKeyMapping(Config.MoveWatch, "Move Watch", "keyboard", Config.MoveWatchKey)
RegisterKeyMapping(Config.ChangeWatchFace, "Change Watch Slide", "keyboard", Config.ChangeWatchFace)

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
    seconds = GetClockSeconds()
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




if Config.RealTime then
     time = nil
else
    time = CalculateTimeToDisplay()
end



RegisterNUICallback("onReady", function(data, cb)
    streetname = GetStreetNameFromHashKey(GetStreetNameAtCoord(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z))
    cb({
        -- weather = weather,
        time = time,
        hunger = Config.Functions.GetHunger(),
        thirst = Config.Functions.GetThirst(),
        streetname = streetname,
        health = GetEntityHealth(PlayerPedId()),
        oxygen = 0,
        idd = GetPlayerServerId(PlayerId()),
        armor = GetPedArmour(PlayerPedId())
    })

end)

function Oxygentopercent(oxygen)
    if oxygen == 10.0 or oxygen == 10 then
        oxygen = 0
    elseif oxygen ~= 10.0 or oxygen ~= 10 then
        oxygen *= oxygen 
    end
    return math.round(oxygen)
end

Citizen.CreateThread(function()
    while true do
    Wait(Config.Interval)
		streetname = GetStreetNameFromHashKey(
			GetStreetNameAtCoord(
				GetEntityCoords(PlayerPedId()).x,
				GetEntityCoords(PlayerPedId()).y,
				GetEntityCoords(PlayerPedId()).z
			)
		)
		SendNUIMessage({
			type = "update",
            hunger = Config.Functions.GetHunger(),
		    thirst = Config.Functions.GetThirst(),
		    streetname = streetname,
		    health = GetEntityHealth(PlayerPedId()),
		    oxygen = Oxygentopercent(GetPlayerUnderwaterTimeRemaining(PlayerId())),
		    armor = GetPedArmour(PlayerPedId()),
            idd = GetPlayerServerId(PlayerId()),
		})
end
end)
