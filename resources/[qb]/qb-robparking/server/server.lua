local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-robparking:server:sp1d3r1987')
AddEventHandler('qb-robparking:server:sp1d3r1987', function(count)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local data = {
        worth = math.random(Config.MoneyMin,Config.MoneyMax)
    }
    Player.Functions.AddMoney("cash", data.worth)
    TriggerClientEvent('QBCore:Notify', src, "You got $"..data.worth.." from the parking meter", "success", 5000)
    TriggerClientEvent('QBCore:Notify', src, "Was it really worth it?", "success", 5000)
end)

