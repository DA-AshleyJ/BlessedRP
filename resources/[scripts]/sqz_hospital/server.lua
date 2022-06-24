local QBCore = exports['qb-core']:GetCoreObject()
local Player = QBCore.Functions.GetPlayer(source)

RegisterNetEvent('sqz_hospital:PayForHeal')
AddEventHandler('sqz_hospital:PayForHeal', function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)

    if xPlayer.PlayerData.money.cash >= Config.Price then
        xPlayer.Functions.RemoveMoney('cash',Config.Price)
        TriggerClientEvent('QBCore:Notify', source, 'You have paid for the healing', Config.Price)
        TriggerClientEvent('sqz_hospital:HasEnoughMoney', _source)

    elseif Player.PlayerData.money['bank'].money >= Config.Price then
        xPlayer.Functions.RemoveMoney('bank', Config.Price)
        TriggerClientEvent('QBCore:Notify', source,'You have paid for the healing ', Config.Price)
        TriggerClientEvent('sqz_hospital:HasEnoughMoney', _source)


    else
        TriggerClientEvent('QBCore:Notify', source,'You do not have money to pay the service, sorry.')
    end
end)

RegisterNetEvent('sqz_hospital:IamCheating')
AddEventHandler('sqz_hospital:IamCheating', function()
    local _source = source

    DropPlayer(_source, _U('drop_reason'))

end)