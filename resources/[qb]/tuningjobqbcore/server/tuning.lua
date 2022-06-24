local QBCore = exports['qb-core']:GetCoreObject()

-- Turbo Events
RegisterNetEvent('6scripts-tuning:server:Turbo', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('turbo', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['turbo'], "remove", 1)
    TriggerClientEvent('QBCore:Notify', source, "Turbo has been installed", 'success')
end)

QBCore.Functions.CreateUseableItem("turbo", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent("6scripts-tuning:client:applyTurbo", source) 
end)

-- Headlights Events
RegisterNetEvent('6scripts-tuning:server:Xenon', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('headlights', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['headlights'], "remove", 1)
    TriggerClientEvent('QBCore:Notify', source, "Xenon Headlights Installed", 'success')
end)

QBCore.Functions.CreateUseableItem("headlights", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent("6scripts-tuning:client:applyXenons", source)
end)

QBCore.Functions.CreateUseableItem("hidc", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('6scripts-tuning:client:xenonMenu', source)
end)

-- Suspension Events
RegisterNetEvent('6scripts-tuning:server:Suspension', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('suspension', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['suspension'], "remove", 1)
    TriggerClientEvent('QBCore:Notify', source, "Successfully changed vehicle height!", 'success')
end)

QBCore.Functions.CreateUseableItem("suspension", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('6scripts-tuning:client:SuspensionMenu', source)
end)

-- Engine Events

RegisterNetEvent('6scripts-tuning:server:Engine', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('engine', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['engine'], "remove", 1)
    TriggerClientEvent('QBCore:Notify', source, "Successfully changed vehicle engine!", 'success')
end)

QBCore.Functions.CreateUseableItem("engine", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('6scripts-tuning:client:EngineMenu', source)
end)

-- Nitrous System

local VehicleNitrous = {}


QBCore.Functions.CreateUseableItem("nos", function(source, item)
    TriggerClientEvent('6scripts-tuning:client:LoadNitrous', source)
end)

RegisterNetEvent('nitrous:server:LoadNitrous', function(Plate)
    VehicleNitrous[Plate] = {
        hasnitro = true,
        level = 100,
    }
    TriggerClientEvent('nitrous:client:LoadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:SyncFlames', function(netId)
    TriggerClientEvent('nitrous:client:SyncFlames', -1, netId, source)
end)

RegisterNetEvent('nitrous:server:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    TriggerClientEvent('nitrous:client:UnloadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
    TriggerClientEvent('nitrous:client:UpdateNitroLevel', -1, Plate, level)
end)

RegisterNetEvent('nitrous:server:StopSync', function(plate)
    TriggerClientEvent('nitrous:client:StopSync', -1, plate)
end)

-- Event for Saving Vehicle Tuning
RegisterNetEvent("6scripts-tuning:server:UpdateVehicle", function(Car)
    local src = source
    if IsVehicleOwned(Car.plate) then
        MySQL.Async.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(Car), Car.plate})
    end
end)