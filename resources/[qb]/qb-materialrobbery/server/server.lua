local QBCore = exports['qb-core']:GetCoreObject()

local timer = 10 * 60 * math.random(1000, 10000)

RegisterServerEvent('qb-materialrobbery:server:RoubarCobre', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = math.random(10, 20)
    
    Player.Functions.AddItem("copper", quantity)
    Player.Functions.AddItem("metalscrap", quantity)
    Player.Functions.AddItem("rubber", quantity)
    Player.Functions.AddItem("plastic", quantity)
    Player.Functions.AddItem("aluminum", quantity)
    Player.Functions.AddItem("glass", quantity)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["copper"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["metalscrap"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["rubber"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["plastic"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["aluminum"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["glass"], "add")

end)

RegisterServerEvent('qb-materialrobbery:server:ComecarCooldown')
AddEventHandler('qb-materialrobbery:server:ComecarCooldown', function(caixa)
    comecarCooldown(source, caixa)
end)

function comecarCooldown(id, object)
    Citizen.CreateThread(function()
        Citizen.Wait(timer)
        TriggerClientEvent('qb-materialrobbery:server:ComecarCooldown', id, object)
    end)
end