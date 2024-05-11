ESX = GetResourceState('es_extended') == 'started'
QB = GetResourceState('qb-core') == 'started'

lib.callback.register('ludaro_smartwatch:GetJobMoneyAndBank', function(source)
    if ESX then
        ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(source)
        local job = xPlayer.job.name
        local money = xPlayer.getMoney()
        local bank = xPlayer.getAccount('bank').money
        return job, money, bank
    elseif QB then
        QB = exports['qb-core']:getModule('Player')
        local xPlayer = QB.GetPlayer(source)
        local job = xPlayer.PlayerData.job.name
        local money = xPlayer.PlayerData.money
        local bank = xPlayer.PlayerData.accounts.bank.money
        return job, money, bank
    else
        -- your own
        return "unemployed", 0, 0
    end
end)