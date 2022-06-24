local QBCore = exports['qb-core']:GetCoreObject()
local tunedVehicles = {}
local VehicleNitrous = {}

local function IsPolice(job)
    for i = 1, #Config["police_jobs"] do
        if job == Config["police_jobs"][i] then
            return true
        end
    end
    return false
end

if Config['enable_tablet'] then
    QBCore.Functions.CreateUseableItem(Config['tablet_item'], function(source, item)
        TriggerClientEvent('tunertablet:client:openChip', source)
    end)
    RegisterNetEvent('tunertablet:server:TuneStatus', function(plate, bool)
        if bool then
            tunedVehicles[plate] = bool
        else
            tunedVehicles[plate] = nil
        end
    end)
    QBCore.Functions.CreateCallback('tunertablet:server:HasChip', function(source, cb)
        local src = source
        local Ply = QBCore.Functions.GetPlayer(src)
        local Chip = Ply.Functions.GetItemByName(Config['tablet_item'])

        if Chip ~= nil then
            cb(true)
        else
            cb(true)
        end
    end)
end
QBCore.Functions.CreateCallback('tunertablet:server:GetStatus', function(source, cb, plate)
    cb(tunedVehicles[plate])
end)
QBCore.Commands.Add(Strings['check_tune_command'], Strings['check_tune_command_info'], {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if IsPolice(Player.PlayerData.job.name) then
        if Player.PlayerData.job.onduty then
            TriggerClientEvent("tunertablet:client:TuneStatus", source)
        else
            TriggerClientEvent('QBCore:Notify', src, Strings['not_on_duty'], 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Strings['invalid_job'], 'error')
    end
end)

------- Multi item -------
if Config['using_custom_mechanic'] then
    RegisterNetEvent('nitrous:server:LoadNitrous', function(Plate)
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 100
        }
        TriggerClientEvent('nitrous:client:LoadNitrous', -1, Plate)
    end)
end

if Config['multi_nitrous_item'] then
    QBCore.Functions.CreateUseableItem(Config['nitrous_small'], function(source, item)
        TriggerClientEvent('smallresource:client:LoadNitroussmall', source)
    end)
    RegisterNetEvent('nitrous:server:LoadNitroussmall', function(Plate)
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 25
        }
        TriggerClientEvent('nitrous:client:LoadNitroussmall', -1, Plate)
    end)
    QBCore.Functions.CreateUseableItem(Config['nitrous_medium'], function(source, item)
        TriggerClientEvent('smallresource:client:LoadNitrousmedium', source)
    end)
    RegisterNetEvent('nitrous:server:LoadNitrousmedium', function(Plate)
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 50
        }
        TriggerClientEvent('nitrous:client:LoadNitrousmedium', -1, Plate)
    end)
    QBCore.Functions.CreateUseableItem(Config['nitrous_large'], function(source, item)
        TriggerClientEvent('smallresource:client:LoadNitrouslarge', source)
    end)
    RegisterNetEvent('nitrous:server:LoadNitrouslarge', function(Plate)
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 75
        }
        TriggerClientEvent('nitrous:client:LoadNitrouslarge', -1, Plate)
    end)
    QBCore.Functions.CreateUseableItem(Config['nitrous_large_extra'], function(source, item)
        TriggerClientEvent('smallresource:client:LoadNitrousextralarge', source)
    end)
    RegisterNetEvent('nitrous:server:LoadNitrousextralarge', function(Plate)
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 100
        }
        TriggerClientEvent('nitrous:client:LoadNitrousextralarge', -1, Plate)
    end)
else
    QBCore.Functions.CreateUseableItem(Config['nitrous_item'], function(source, item)
        TriggerClientEvent('smallresource:client:LoadNitrous', source)
    end)
    RegisterNetEvent('nitrous:server:LoadNitrous', function(Plate)
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 100
        }
        TriggerClientEvent('nitrous:client:LoadNitrous', -1, Plate)
    end)
end

QBCore.Functions.CreateCallback('tunertablet:server:GetNitrousStatus', function(source, cb, plate)
    cb(VehicleNitrous[plate])
end)
QBCore.Commands.Add(Strings['check_nitrous_command'], Strings['check_nitrous_command_info'], {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if IsPolice(Player.PlayerData.job.name) then
        if Player.PlayerData.job.onduty then
                TriggerClientEvent("tunertablet:client:NitrousStatus", source)
            else
                TriggerClientEvent('QBCore:Notify', src, Strings['not_on_duty'], 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, Strings['invalid_job'], 'error')
        end
    
end)


-----------------------------------------------
------- Nitrous ---------------- Flames -------
-----------------------------------------------
RegisterNetEvent('nitrous:server:SyncFlames', function(netId)
    TriggerClientEvent('nitrous:client:SyncFlames', -1, netId, source)
end)

RegisterNetEvent('nitrous:server:StopSync', function(plate)
    TriggerClientEvent('nitrous:client:StopSync', -1, plate)
end)

-------------------------------------------------

RegisterNetEvent('nitrous:server:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    TriggerClientEvent('nitrous:client:UnloadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
    TriggerClientEvent('nitrous:client:UpdateNitroLevel', -1, Plate, level)
end)
-----------------------------------------------
------- Purge ------- Hood ------- both -------
-----------------------------------------------
RegisterNetEvent('purge:server:synchoodboth', function(CurrentVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent('purge:client:updatehoodboth', player, source, CurrentVehicle)
        end
    end
end)
-----------------------------------------------
------- Purge ------- Hood ------- left -------
-----------------------------------------------
RegisterNetEvent('purge:server:synchoodleft', function(CurrentVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent('purge:client:updatehoodleft', player, source, CurrentVehicle)
        end
    end
end)
-----------------------------------------------
------- Purge ------- Hood ------- right ------
-----------------------------------------------
RegisterNetEvent('purge:server:synchoodright', function(CurrentVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent('purge:client:updatehoodright', player, source, CurrentVehicle)
        end
    end
end)
-----------------------------------------------
------- Purge ------ fender ------ both -------
-----------------------------------------------
RegisterNetEvent('purge:server:syncfenderboth', function(CurrentVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent('purge:client:updatefenderboth', player, source, CurrentVehicle)
        end
    end
end)
-----------------------------------------------
------- Purge ------ fender ------ left -------
-----------------------------------------------
RegisterNetEvent('purge:server:syncfenderleft', function(CurrentVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent('purge:client:updatefenderleft', player, source, CurrentVehicle)
        end
    end
end)
-----------------------------------------------
------- Purge ------ fender ------ right ------
-----------------------------------------------
RegisterNetEvent('purge:server:syncfenderright', function(CurrentVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent('purge:client:updatefenderright', player, source, CurrentVehicle)
        end
    end
end)