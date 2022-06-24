local QBCore = exports['qb-core']:GetCoreObject()

function Notify(msg)
    QBCore.Functions.Notify(msg)
end

RegisterNetEvent('ServerNotify', function(msg)
    Notify(msg)
end)


