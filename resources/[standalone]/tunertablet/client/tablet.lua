QBCore = exports['qb-core']:GetCoreObject()

function setVehData(veh, data)
    local multp = Config['tablet_multiplier']
    local dTrain = 0.0
    if tonumber(data.drivetrain) == 2 then
        dTrain = 0.5
    elseif tonumber(data.drivetrain) == 3 then
        dTrain = 1.0
    end
    if not DoesEntityExist(veh) or not data then
        return nil
    end
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost * multp)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", data.acceleration * multp)
    SetVehicleEnginePowerMultiplier(veh, data.gearchange * multp)
    LastEngineMultiplier = data.gearchange * multp
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", dTrain * 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.breaking * multp)
end

function resetVeh(veh)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", 1.0)
    SetVehicleEnginePowerMultiplier(veh, 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", 0.5)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", 1.0)
end

--end

RegisterNUICallback('save', function(data)
    QBCore.Functions.TriggerCallback('tunertablet:server:HasChip', function(HasChip)
        if HasChip then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
            setVehData(veh, data)
            lastVeh = veh
            lastStats = stats
            QBCore.Functions.Notify(Strings['tuned_notify'], 'success')

            TriggerServerEvent('tunertablet:server:TuneStatus', QBCore.Functions.GetPlate(veh), true)
        end
    end)
end)

RegisterNetEvent('tunertablet:client:TuneStatus', function()
    local ped = PlayerPedId()
    local closestVehicle = GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 70)
    local plate = QBCore.Functions.GetPlate(closestVehicle)
    local vehModel = GetEntityModel(closestVehicle)
    if vehModel ~= 0 then
        QBCore.Functions.TriggerCallback('tunertablet:server:GetStatus', function(status)
            if status then
                QBCore.Functions.Notify(Strings['has_been_tuned'], 'success')
            else
                QBCore.Functions.Notify(Strings['not_tuned'], 'error')
            end
        end, plate)
    else
        QBCore.Functions.Notify(Strings['no_vehicle'], 'error')
    end
end)

RegisterNetEvent('tunertablet:client:NitrousStatus', function()
    local ped = PlayerPedId()
    local closestVehicle = GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 70)
    local plate = QBCore.Functions.GetPlate(closestVehicle)
    local vehModel = GetEntityModel(closestVehicle)
    if vehModel ~= 0 then
        QBCore.Functions.TriggerCallback('tunertablet:server:GetNitrousStatus', function(status)
            if status then
                QBCore.Functions.Notify(Strings['has_nitrous'], 'success')
            else
                QBCore.Functions.Notify(Strings['no_nitrous'], 'error')
            end
        end, plate)
    else
        QBCore.Functions.Notify(Strings['no_vehicle'], 'error')
    end
end)

RegisterNUICallback('checkItem', function(data, cb)
    local retval = false
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            retval = true
        end
        cb(retval)
    end, data.item)
end)

RegisterNUICallback('reset', function(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    resetVeh(veh)
    QBCore.Functions.Notify(Strings['reset_notify'], 'primary')
end)

if Config['enable_tablet'] then
    RegisterNetEvent('tunertablet:client:openChip', function()
        local ped = PlayerPedId()
        local inVehicle = IsPedInAnyVehicle(ped)

        if inVehicle then
            QBCore.Functions.Progressbar("connect_laptop", Strings['connecting_notify'], 2000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }, {
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flags = 16
            }, {}, {}, function() -- Done
                StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                SetNuiFocus(true, true)
                SendNUIMessage({
                    action = "ui",
                    toggle = true
                })
            end, function() -- Cancel
                StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                QBCore.Functions.Notify("Canceled", "error")
            end)
        else
            QBCore.Functions.Notify(Strings['not_in_vehicle'], "error")
        end
    end)
end


RegisterNUICallback('exit', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "ui",
        toggle = false
    })
end)