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

    GetJobMoneyAndBank = function(job, money, bank)
        if job and money and bank then
            return job, money, bank
        end
        job, money, bank = lib.callback.await('ludaro_smartwatch:GetJobMoneyAndBank', Config.Interval)
        repeat Wait(0) until job and money and bank
        return job, money, bank
    end,

    Notification = function(msg)
        SetNotificationTextEntry("STRING")
        AddTextComponentString("~r~" .. msg)
        DrawNotification(false, true)
    end
}