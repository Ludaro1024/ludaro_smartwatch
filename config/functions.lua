Config.Functions = {

    GetHunger = function()
	TriggerEvent("esx_status:getStatus", "hunger", function(status)
		hunger = math.round(status.getPercent())
	end)
    return hunger
    end,

    GetThirst = function()
	TriggerEvent("esx_status:getStatus", "thirst", function(status)
		thirst = math.round(status.getPercent())
	end)
    return thirst
    end,
}