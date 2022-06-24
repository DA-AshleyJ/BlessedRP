local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-acunitsearch:server:startAirconTimer')
AddEventHandler('qb-acunitsearch:server:startAirconTimer', function(acunitsearch)
    startTimer(source, acunitsearch)
end)

RegisterNetEvent('qb-acunitsearch:server:recieveItem', function(item, itemAmount)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    ply.Functions.AddItem(item, itemAmount)
end)

RegisterNetEvent('qb-acunitsearch:server:givemoney', function(money)
local src = source
local ply = QBCore.Functions.GetPlayer(src)
ply.Functions.AddMoney("cash", money)
end)

function startTimer(id, object)
    local timer = 10 * 1000

    while timer > 0 do
        Wait(100)
        timer = timer - 10
        if timer == 0 then
            TriggerClientEvent('qb-acunitsearch:server:removeAircon', id, object)
        end
    end
end
