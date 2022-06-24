if Config['enable_purge'] then
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local IsInVehicle = IsPedInAnyVehicle(ped)
            local CurrentVehicle = GetVehiclePedIsIn(ped)
            if IsInVehicle then
                local Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
                if VehicleNitrous[Plate] ~= nil then
                    if VehicleNitrous[Plate].hasnitro then
                        -----------------------------------------------
                        ------- Purge ------- Hood ------- both ------- NUMPAD 8
                        -----------------------------------------------
                        if IsControlJustPressed(0, Config['purge_hood_both']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            PurgeActivated = true
    
                            CreateThread(function()
                                while PurgeActivated do
                                    if VehicleNitrous[Plate].level - 1 ~= 0 then
                                        TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config['purge_amount_use']))
                                        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
                                        SetVehicleNitroPurgeEnabledhoodboth(CurrentVehicle, true)
                                        TriggerServerEvent('purge:server:synchoodboth', true)
                                        
                                    else
                                        TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                        SetVehicleNitroPurgeEnabledhoodboth(CurrentVehicle, false)
                                        TriggerServerEvent('purge:server:synchoodboth', false)
                                        PurgeActivated = false
                                    end
                                    Wait(100)
                                end
                            end)
                        end
    
                        if IsControlJustReleased(0, Config['purge_hood_both']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            if PurgeActivated then
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
                                SetVehicleNitroPurgeEnabledhoodboth(CurrentVehicle, false)
                                TriggerServerEvent('purge:server:synchoodboth', false)
                                PurgeActivated = false
                            end
                        end
                        -----------------------------------------------
                        ------- Purge ------- Hood ------- left ------- NUMPAD 7
                        -----------------------------------------------
                        if IsControlJustPressed(0, Config['purge_hood_left']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            PurgeActivated = true
    
                            CreateThread(function()
                                while PurgeActivated do
                                    if VehicleNitrous[Plate].level - 1 ~= 0 then
                                        TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config['purge_amount_use']))
                                        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
                                        SetVehicleNitroPurgeEnabledhoodleft(CurrentVehicle, true)
                                        TriggerServerEvent('purge:server:synchoodleft', true)
                                        
                                    else
                                        TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                        SetVehicleNitroPurgeEnabledhoodleft(CurrentVehicle, false)
                                        TriggerServerEvent('purge:server:synchoodleft', false)
                                        PurgeActivated = false
                                    end
                                    Wait(100)
                                end
                            end)
                        end
    
                        if IsControlJustReleased(0, Config['purge_hood_left']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            if PurgeActivated then
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
                                SetVehicleNitroPurgeEnabledhoodleft(CurrentVehicle, false)
                                TriggerServerEvent('purge:server:synchoodleft', false)
                                PurgeActivated = false
                            end
                        end
                        -----------------------------------------------
                        ------- Purge ------- Hood ------- right ------ NUMPAD 9
                        -----------------------------------------------
                        if IsControlJustPressed(0, Config['purge_hood_right']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            PurgeActivated = true
    
                            CreateThread(function()
                                while PurgeActivated do
                                    if VehicleNitrous[Plate].level - 1 ~= 0 then
                                        TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config['purge_amount_use']))
                                        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
                                        SetVehicleNitroPurgeEnabledhoodright(CurrentVehicle, true)
                                        TriggerServerEvent('purge:server:synchoodright', true)
                                        
                                    else
                                        TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                        SetVehicleNitroPurgeEnabledhoodright(CurrentVehicle, false)
                                        TriggerServerEvent('purge:server:synchoodright', false)
                                        PurgeActivated = false
                                    end
                                    Wait(100)
                                end
                            end)
                        end
    
                        if IsControlJustReleased(0, Config['purge_hood_right']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            if PurgeActivated then
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,
                                    VehicleNitrous[Plate].level, false)
                                SetVehicleNitroPurgeEnabledhoodright(CurrentVehicle, false)
                                TriggerServerEvent('purge:server:synchoodright', false)
                                PurgeActivated = false
                            end
                        end
                        -----------------------------------------------
                        ------- Purge ------ fender ------ both ------- NUMPAD 5
                        -----------------------------------------------
                        if IsControlJustPressed(0, Config['purge_fender_both']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            PurgeActivated = true
    
                            CreateThread(function()
                                while PurgeActivated do
                                    if VehicleNitrous[Plate].level - 1 ~= 0 then
                                        TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config['purge_amount_use']))
                                        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
                                        SetVehicleNitroPurgeEnabledfenderboth(CurrentVehicle, true)
                                        TriggerServerEvent('purge:server:syncfenderboth', true)
                                        
                                    else
                                        TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                        SetVehicleNitroPurgeEnabledfenderboth(CurrentVehicle, false)
                                        TriggerServerEvent('purge:server:syncfenderboth', false)
                                        PurgeActivated = false
                                    end
                                    Wait(100)
                                end
                            end)
                        end
    
                        if IsControlJustReleased(0, Config['purge_fender_both']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            if PurgeActivated then
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,
                                    VehicleNitrous[Plate].level, false)
                                SetVehicleNitroPurgeEnabledfenderboth(CurrentVehicle, false)
                                TriggerServerEvent('purge:server:syncfenderboth', false)
                                PurgeActivated = false
                            end
                        end
                        -----------------------------------------------
                        ------- Purge ------ fender ------ left ------- NUMPAD 4
                        -----------------------------------------------
                        if IsControlJustPressed(0, Config['purge_fender_left']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            PurgeActivated = true
    
                            CreateThread(function()
                                while PurgeActivated do
                                    if VehicleNitrous[Plate].level - 1 ~= 0 then
                                        TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config['purge_amount_use']))
                                        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
                                        SetVehicleNitroPurgeEnabledfenderleft(CurrentVehicle, true)
                                        TriggerServerEvent('purge:server:syncfenderleft', true)
                                        
                                    else
                                        TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                        SetVehicleNitroPurgeEnabledfenderleft(CurrentVehicle, false)
                                        TriggerServerEvent('purge:server:syncfenderleft', false)
                                        PurgeActivated = false
                                    end
                                    Wait(100)
                                end
                            end)
                        end
    
                        if IsControlJustReleased(0, Config['purge_fender_left']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            if PurgeActivated then
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,
                                    VehicleNitrous[Plate].level, false)
                                SetVehicleNitroPurgeEnabledfenderleft(CurrentVehicle, false)
                                TriggerServerEvent('purge:server:syncfenderleft', false)
                                PurgeActivated = false
                            end
                        end
                        -----------------------------------------------
                        ------- Purge ------ fender ------ right ------ NUMPAD 6
                        -----------------------------------------------
                        if IsControlJustPressed(0, Config['purge_fender_right']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            PurgeActivated = true
    
                            CreateThread(function()
                                while PurgeActivated do
                                    if VehicleNitrous[Plate].level - 1 ~= 0 then
                                        TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config['purge_amount_use']))
                                        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
                                        SetVehicleNitroPurgeEnabledfenderright(CurrentVehicle, true)
                                        TriggerServerEvent('purge:server:syncfenderright', true)
                                        
                                    else
                                        TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                        SetVehicleNitroPurgeEnabledfenderright(CurrentVehicle, false)
                                        TriggerServerEvent('purge:server:syncfenderright', false)
                                        PurgeActivated = false
                                    end
                                    Wait(100)
                                end
                            end)
                        end
    
                        if IsControlJustReleased(0, Config['purge_fender_right']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            if PurgeActivated then
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
                                SetVehicleNitroPurgeEnabledfenderright(CurrentVehicle, false)
                                TriggerServerEvent('purge:server:syncfenderright', false)
                                PurgeActivated = false
                            end
                        end
                    end
                else
                    if not nosupdated then
                        TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
                        nosupdated = true
                    end
                end
            else
                if nosupdated then
                    nosupdated = false
                end
                Wait(1500)
            end
            Wait(3)
        end
    end)    
end
-----------------------------------------------
------- Purge ------- Hood ------- both -------
-----------------------------------------------

local vehicles = {}
local particles = {}

function IsVehicleNitroPurgeEnabledhoodboth(CurrentVehicle)
    return vehicles[CurrentVehicle] == true
end

RegisterNetEvent('purge:client:updatehoodboth', function(playerServerId, purgeEnabled, CurrentVehicle)
    local playerId = GetPlayerFromServerId(playerServerId)
    if not NetworkIsPlayerConnected(playerId) then
        return
    end

    local player = GetPlayerPed(playerId)
    local CurrentVehicle = GetVehiclePedIsIn(player, CurrentVehicle)
    local driver = GetPedInVehicleSeat(CurrentVehicle, -1)

    SetVehicleNitroPurgeEnabledhoodboth(CurrentVehicle, purgeEnabled)
end)

function SetVehicleNitroPurgeEnabledhoodboth(CurrentVehicle, enabled)
    if IsVehicleNitroPurgeEnabledhoodboth(CurrentVehicle) == enabled then
        return
    end

    if enabled then
        local bone = GetEntityBoneIndexByName(CurrentVehicle, 'bonnet')
        local pos = GetWorldPositionOfEntityBone(CurrentVehicle, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(CurrentVehicle, pos.x, pos.y, pos.z)
        local ptfxs = {}

        for i = 0, 3 do
            local leftPurge = CreateVehiclePurgeSprayhoodboth(CurrentVehicle, off.x - 0.85, off.y, off.z - 0.25, 40.0, -45.0, 0.0, 0.5)
            local rightPurge = CreateVehiclePurgeSprayhoodboth(CurrentVehicle, off.x + 0.85, off.y, off.z - 0.25, 40.0, 45.0, 0.0, 0.5)

            table.insert(ptfxs, leftPurge)
            table.insert(ptfxs, rightPurge)
        end

        vehicles[CurrentVehicle] = true
        particles[CurrentVehicle] = ptfxs
    else
        if particles[CurrentVehicle] and #particles[CurrentVehicle] > 0 then
            for _, particleId in ipairs(particles[CurrentVehicle]) do
                StopParticleFxLooped(particleId)
            end
        end

        vehicles[CurrentVehicle] = nil
        particles[CurrentVehicle] = nil
    end
end

function CreateVehiclePurgeSprayhoodboth(CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end

-----------------------------------------------
------- Purge ------- Hood ------- left -------
-----------------------------------------------

function IsVehicleNitroPurgeEnabledhoodleft(CurrentVehicle)
    return vehicles[CurrentVehicle] == true
end

RegisterNetEvent('purge:client:updatehoodleft', function(playerServerId, purgeEnabled, CurrentVehicle)
    local playerId = GetPlayerFromServerId(playerServerId)
    if not NetworkIsPlayerConnected(playerId) then
        return
    end

    local player = GetPlayerPed(playerId)
    local CurrentVehicle = GetVehiclePedIsIn(player, CurrentVehicle)
    local driver = GetPedInVehicleSeat(CurrentVehicle, -1)

    SetVehicleNitroPurgeEnabledhoodleft(CurrentVehicle, purgeEnabled)
end)

function SetVehicleNitroPurgeEnabledhoodleft(CurrentVehicle, enabled)
    if IsVehicleNitroPurgeEnabledhoodleft(CurrentVehicle) == enabled then
        return
    end

    if enabled then
        local bone = GetEntityBoneIndexByName(CurrentVehicle, 'bonnet')
        local pos = GetWorldPositionOfEntityBone(CurrentVehicle, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(CurrentVehicle, pos.x, pos.y, pos.z)
        local ptfxs = {}

        for i = 0, 3 do
            local leftPurge = CreateVehiclePurgeSprayhoodleft(CurrentVehicle, off.x - 0.85, off.y - 0.15, off.z - 0.25, 40.0, -20.0, 0.0, 0.5)

            table.insert(ptfxs, leftPurge)
        end

        vehicles[CurrentVehicle] = true
        particles[CurrentVehicle] = ptfxs
    else
        if particles[CurrentVehicle] and #particles[CurrentVehicle] > 0 then
            for _, particleId in ipairs(particles[CurrentVehicle]) do
                StopParticleFxLooped(particleId)
            end
        end

        vehicles[CurrentVehicle] = nil
        particles[CurrentVehicle] = nil
    end
end

function CreateVehiclePurgeSprayhoodleft(CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end

-----------------------------------------------
------- Purge ------- Hood ------- right ------
-----------------------------------------------

function IsVehicleNitroPurgeEnabledhoodright(CurrentVehicle)
    return vehicles[CurrentVehicle] == true
end

RegisterNetEvent('purge:client:updatehoodright', function(playerServerId, purgeEnabled, CurrentVehicle)
    local playerId = GetPlayerFromServerId(playerServerId)
    if not NetworkIsPlayerConnected(playerId) then
        return
    end

    local player = GetPlayerPed(playerId)
    local CurrentVehicle = GetVehiclePedIsIn(player, CurrentVehicle)
    local driver = GetPedInVehicleSeat(CurrentVehicle, -1)

    SetVehicleNitroPurgeEnabledhoodright(CurrentVehicle, purgeEnabled)
end)

function SetVehicleNitroPurgeEnabledhoodright(CurrentVehicle, enabled)
    if IsVehicleNitroPurgeEnabledhoodright(CurrentVehicle) == enabled then
        return
    end

    if enabled then
        local bone = GetEntityBoneIndexByName(CurrentVehicle, 'bonnet')
        local pos = GetWorldPositionOfEntityBone(CurrentVehicle, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(CurrentVehicle, pos.x, pos.y, pos.z)
        local ptfxs = {}

        for i = 0, 3 do
            local rightPurge = CreateVehiclePurgeSprayhoodright(CurrentVehicle, off.x + 0.85, off.y - 0.15, off.z - 0.25, 40.0, 20.0, 0.0, 0.5)

            table.insert(ptfxs, rightPurge)
        end

        vehicles[CurrentVehicle] = true
        particles[CurrentVehicle] = ptfxs
    else
        if particles[CurrentVehicle] and #particles[CurrentVehicle] > 0 then
            for _, particleId in ipairs(particles[CurrentVehicle]) do
                StopParticleFxLooped(particleId)
            end
        end

        vehicles[CurrentVehicle] = nil
        particles[CurrentVehicle] = nil
    end
end

function CreateVehiclePurgeSprayhoodright(CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end

-----------------------------------------------
------- Purge ------ fender ------ both -------
-----------------------------------------------

function IsVehicleNitroPurgeEnabledfenderboth(CurrentVehicle)
    return vehicles[CurrentVehicle] == true
end

RegisterNetEvent('purge:client:updatefenderboth', function(playerServerId, purgeEnabled, CurrentVehicle)
    local playerId = GetPlayerFromServerId(playerServerId)
    if not NetworkIsPlayerConnected(playerId) then
        return
    end

    local player = GetPlayerPed(playerId)
    local CurrentVehicle = GetVehiclePedIsIn(player, CurrentVehicle)
    local driver = GetPedInVehicleSeat(CurrentVehicle, -1)

    SetVehicleNitroPurgeEnabledfenderboth(CurrentVehicle, purgeEnabled)
end)

function SetVehicleNitroPurgeEnabledfenderboth(CurrentVehicle, enabled)
    if IsVehicleNitroPurgeEnabledfenderboth(CurrentVehicle) == enabled then
        return
    end

    if enabled then
        local bone = GetEntityBoneIndexByName(CurrentVehicle, 'engine')
        local pos = GetWorldPositionOfEntityBone(CurrentVehicle, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(CurrentVehicle, pos.x, pos.y, pos.z)
        local ptfxs = {}

        for i = 0, 3 do
            local leftPurge = CreateVehiclePurgeSprayfenderboth(CurrentVehicle, off.x - 0.40, off.y + 0.20, off.z + 0.15, 40.0, -30.0, 0.0, 0.5)
            local rightPurge = CreateVehiclePurgeSprayfenderboth(CurrentVehicle, off.x + 0.40, off.y + 0.20, off.z + 0.15, 40.0, 30.0, 0.0, 0.5)

            table.insert(ptfxs, leftPurge)
            table.insert(ptfxs, rightPurge)
        end

        vehicles[CurrentVehicle] = true
        particles[CurrentVehicle] = ptfxs
    else
        if particles[CurrentVehicle] and #particles[CurrentVehicle] > 0 then
            for _, particleId in ipairs(particles[CurrentVehicle]) do
                StopParticleFxLooped(particleId)
            end
        end

        vehicles[CurrentVehicle] = nil
        particles[CurrentVehicle] = nil
    end
end

function CreateVehiclePurgeSprayfenderboth(CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end

-----------------------------------------------
------- Purge ------ fender ------ left -------
-----------------------------------------------

function IsVehicleNitroPurgeEnabledfenderleft(CurrentVehicle)
    return vehicles[CurrentVehicle] == true
end

RegisterNetEvent('purge:client:updatefenderleft', function(playerServerId, purgeEnabled, CurrentVehicle)
    local playerId = GetPlayerFromServerId(playerServerId)
    if not NetworkIsPlayerConnected(playerId) then
        return
    end

    local player = GetPlayerPed(playerId)
    local CurrentVehicle = GetVehiclePedIsIn(player, CurrentVehicle)
    local driver = GetPedInVehicleSeat(CurrentVehicle, -1)

    SetVehicleNitroPurgeEnabledfenderleft(CurrentVehicle, purgeEnabled)
end)

function SetVehicleNitroPurgeEnabledfenderleft(CurrentVehicle, enabled)
    if IsVehicleNitroPurgeEnabledfenderleft(CurrentVehicle) == enabled then
        return
    end

    if enabled then
        local bone = GetEntityBoneIndexByName(CurrentVehicle, 'engine')
        local pos = GetWorldPositionOfEntityBone(CurrentVehicle, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(CurrentVehicle, pos.x, pos.y, pos.z)
        local ptfxs = {}

        for i = 0, 3 do
            local leftPurge = CreateVehiclePurgeSprayfenderleft(CurrentVehicle, off.x - 0.40, off.y + 0.20, off.z + 0.15, 40.0, -30.0, 0.0, 0.5)

            table.insert(ptfxs, leftPurge)
        end

        vehicles[CurrentVehicle] = true
        particles[CurrentVehicle] = ptfxs
    else
        if particles[CurrentVehicle] and #particles[CurrentVehicle] > 0 then
            for _, particleId in ipairs(particles[CurrentVehicle]) do
                StopParticleFxLooped(particleId)
            end
        end

        vehicles[CurrentVehicle] = nil
        particles[CurrentVehicle] = nil
    end
end

function CreateVehiclePurgeSprayfenderleft(CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end

-----------------------------------------------
------- Purge ------ fender ------ right ------
-----------------------------------------------

function IsVehicleNitroPurgeEnabledfenderright(CurrentVehicle)
    return vehicles[CurrentVehicle] == true
end

RegisterNetEvent('purge:client:updatefenderright', function(playerServerId, purgeEnabled, CurrentVehicle)
    local playerId = GetPlayerFromServerId(playerServerId)
    if not NetworkIsPlayerConnected(playerId) then
        return
    end

    local player = GetPlayerPed(playerId)
    local CurrentVehicle = GetVehiclePedIsIn(player, CurrentVehicle)
    local driver = GetPedInVehicleSeat(CurrentVehicle, -1)

    SetVehicleNitroPurgeEnabledfenderright(CurrentVehicle, purgeEnabled)
end)

function SetVehicleNitroPurgeEnabledfenderright(CurrentVehicle, enabled)
    if IsVehicleNitroPurgeEnabledfenderboth(CurrentVehicle) == enabled then
        return
    end

    if enabled then
        local bone = GetEntityBoneIndexByName(CurrentVehicle, 'engine')
        local pos = GetWorldPositionOfEntityBone(CurrentVehicle, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(CurrentVehicle, pos.x, pos.y, pos.z)
        local ptfxs = {}

        for i = 0, 3 do
            local rightPurge = CreateVehiclePurgeSprayfenderright(CurrentVehicle, off.x + 0.40, off.y + 0.20, off.z + 0.15, 40.0, 30.0, 0.0, 0.5)

            table.insert(ptfxs, rightPurge)
        end

        vehicles[CurrentVehicle] = true
        particles[CurrentVehicle] = ptfxs
    else
        if particles[CurrentVehicle] and #particles[CurrentVehicle] > 0 then
            for _, particleId in ipairs(particles[CurrentVehicle]) do
                StopParticleFxLooped(particleId)
            end
        end

        vehicles[CurrentVehicle] = nil
        particles[CurrentVehicle] = nil
    end
end

function CreateVehiclePurgeSprayfenderright(CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', CurrentVehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end