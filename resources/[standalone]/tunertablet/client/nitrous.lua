LastEngineMultiplier = 1.0
NitrousActivated = false
PurgeActivated = false
NitrousBoost = Config['nitrous_boost']
VehicleNitrous = {}
Fxs = {}
local vehicles = {}

function trim(value)
    if not value then
        return nil
    end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('nitrous:GetNosLoadedVehs', function(vehs)
        VehicleNitrous = vehs
    end)
end)

if Config['require_turbo'] then
    RegisterNetEvent('smallresource:client:LoadNitroussmall', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
            if IsToggleModOn(veh, 18) then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_small']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_small'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitroussmall', Plate, 25)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end
            else
                QBCore.Functions.Notify(Strings['no_turbo_notify'], 'error')
            end
        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitroussmall', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 25
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrousmedium', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
            if IsToggleModOn(veh, 18) then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_medium']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_medium'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrousmedium', Plate, 50)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end
            else
                QBCore.Functions.Notify(Strings['no_turbo_notify'], 'error')
            end
        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitrousmedium', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 50
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrouslarge', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
            if IsToggleModOn(veh, 18) then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_large']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_large'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrouslarge', Plate, 75)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end
            else
                QBCore.Functions.Notify(Strings['no_turbo_notify'], 'error')
            end
        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitrouslarge', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 75
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrousextralarge', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
            if IsToggleModOn(veh, 18) then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_large_extra']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_large_extra'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrousextralarge', Plate, 100)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end
            else
                QBCore.Functions.Notify(Strings['no_turbo_notify'], 'error')
            end
        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitrousextralarge', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 100
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrous', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
            if IsToggleModOn(veh, 18) then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_item']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_item'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrous', Plate)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end
            else
                QBCore.Functions.Notify(Strings['no_turbo_notify'], 'error')
            end
        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
else
    RegisterNetEvent('smallresource:client:LoadNitroussmall', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_small']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_small'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitroussmall', Plate, 25)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end
        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitroussmall', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 25
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrousmedium', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_medium']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_medium'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrousmedium', Plate, 50)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end

        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitrousmedium', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 50
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrouslarge', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_large']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_large'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrouslarge', Plate, 75)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end

        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitrouslarge', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 75
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrousextralarge', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_large_extra']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_large_extra'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrousextralarge', Plate, 100)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end

        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
    
    RegisterNetEvent('nitrous:client:LoadNitrousextralarge', function(Plate)
        local ped = PlayerPedId()
        VehicleNitrous[Plate] = {
            hasnitro = true,
            level = 100
        }
        local CurrentVehicle = GetVehiclePedIsIn(ped)
        local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
        if CPlate == Plate then
            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
        end
    end)
    
    RegisterNetEvent('smallresource:client:LoadNitrous', function()
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
    
        if not NitrousActivated then
                if IsInVehicle and not IsThisModelABike(GetEntityModel(veh)) then
                    if GetPedInVehicleSeat(veh, -1) == ped then
                        QBCore.Functions.Progressbar("use_nos", Strings['Progress_bar'], 1000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config['nitrous_item']], "remove")
                            TriggerServerEvent("QBCore:Server:RemoveItem", Config['nitrous_item'], 1)
                            local CurrentVehicle = GetVehiclePedIsIn(ped)
                            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                            TriggerServerEvent('nitrous:server:LoadNitrous', Plate)
                        end)
                    else
                        QBCore.Functions.Notify(Strings['wrong_seat_notify'], "error")
                    end
                else
                    QBCore.Functions.Notify(Strings['invalid_vehicle_notify'], 'error')
                end
        else
            QBCore.Functions.Notify(Strings['nos_already_active_notify'], 'error')
        end
    end)
end




RegisterNetEvent('nitrous:client:LoadNitrous', function(Plate)
    local ped = PlayerPedId()
    VehicleNitrous[Plate] = {
        hasnitro = true,
        level = 100
    }
    local CurrentVehicle = GetVehiclePedIsIn(ped)
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then
        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
    end
end)



local nosupdated = false

if Config['enable_nitrous'] then
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local IsInVehicle = IsPedInAnyVehicle(ped)
            local CurrentVehicle = GetVehiclePedIsIn(ped)
            if IsInVehicle then
                local Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
                if VehicleNitrous[Plate] ~= nil then
                    if VehicleNitrous[Plate].hasnitro then
                        if IsControlJustPressed(0, Config['use_nitrous']) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                            SetVehicleEnginePowerMultiplier(CurrentVehicle, NitrousBoost)
                            SetVehicleEngineTorqueMultiplier(CurrentVehicle, NitrousBoost)
                            SetEntityMaxSpeed(CurrentVehicle, 999.0)
                            NitrousActivated = true
    
                            CreateThread(function()
                                while NitrousActivated do
                                        if VehicleNitrous[Plate].level - 1 ~= 0 then
                                            TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config['nitrous_amount_use']))
                                            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
                                            
                                        else
                                            TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                            NitrousActivated = false
                                            SetVehicleEnginePowerMultiplier(CurrentVehicle, LastEngineMultiplier)
                                            SetVehicleEngineTorqueMultiplier(CurrentVehicle, 1.0)
                                            for index, _ in pairs(Fxs) do
                                                StopParticleFxLooped(Fxs[index], 1)
                                                TriggerServerEvent('nitrous:server:StopSync',
                                                    trim(GetVehicleNumberPlateText(CurrentVehicle)))
                                                Fxs[index] = nil
                                            end
                                        end
                                    Wait(100)
                                end
                            end)
                        end
    
                        if IsControlJustReleased(0, Config['use_nitrous']) and GetPedInVehicleSeat(CurrentVehicle, -1) ==
                            ped then
                            if NitrousActivated then
                                local veh = GetVehiclePedIsIn(ped)
                                SetVehicleEnginePowerMultiplier(veh, LastEngineMultiplier)
                                SetVehicleEngineTorqueMultiplier(veh, 1.0)
                                for index, _ in pairs(Fxs) do
                                    StopParticleFxLooped(Fxs[index], 1)
                                    TriggerServerEvent('nitrous:server:StopSync', trim(GetVehicleNumberPlateText(veh)))
                                    Fxs[index] = nil
                                end                         
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
                                NitrousActivated = false
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
-------------------------------------------------


p_flame_location = {"exhaust", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5", "exhaust_6", "exhaust_7",
                    "exhaust_8", "exhaust_9", "exhaust_10", "exhaust_11", "exhaust_12", "exhaust_13", "exhaust_14",
                    "exhaust_15", "exhaust_16"}

ParticleDict = "veh_xs_vehicle_mods"
ParticleFx = "veh_nitrous"
ParticleSize = Config['nitrous_effect_size']

CreateThread(function()
    while true do
        if NitrousActivated then
            local veh = GetVehiclePedIsIn(PlayerPedId())
            if veh ~= 0 then
                TriggerServerEvent('nitrous:server:SyncFlames', VehToNet(veh))
                if Config['nitrous_sound'] then
                    SetVehicleBoostActive(veh, 1)
                end

                for _, bones in pairs(p_flame_location) do
                    if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                        if Fxs[bones] == nil then
                            RequestNamedPtfxAsset(ParticleDict)
                            while not HasNamedPtfxAssetLoaded(ParticleDict) do
                                Wait(0)
                            end
                            SetPtfxAssetNextCall(ParticleDict)
                            UseParticleFxAssetNextCall(ParticleDict)
                            Fxs[bones] = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.02, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)
                        end
                    end
                end
            end
        end
        Wait(20)
    end
end)

local NOSPFX = {}

RegisterNetEvent('nitrous:client:SyncFlames', function(netid, nosid)
    local veh = NetToVeh(netid)
    if veh ~= 0 then
        local myid = GetPlayerServerId(PlayerId())
        if NOSPFX[trim(GetVehicleNumberPlateText(veh))] == nil then
            NOSPFX[trim(GetVehicleNumberPlateText(veh))] = {}
        end
        if myid ~= nosid then
            for _, bones in pairs(p_flame_location) do
                if NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones] == nil then
                    NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones] = {}
                end
                if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                    if NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones].pfx == nil then
                        RequestNamedPtfxAsset(ParticleDict)
                        while not HasNamedPtfxAssetLoaded(ParticleDict) do
                            Wait(0)
                        end
                        SetPtfxAssetNextCall(ParticleDict)
                        UseParticleFxAssetNextCall(ParticleDict)
                        NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones].pfx = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.05, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('nitrous:client:StopSync', function(plate)
    if NOSPFX[plate] then
        for k, v in pairs(NOSPFX[plate]) do
            StopParticleFxLooped(v.pfx, 1)
            NOSPFX[plate][k].pfx = nil
        end
    end
end)

RegisterNetEvent('nitrous:client:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
end)

RegisterNetEvent('nitrous:client:UnloadNitrous', function(Plate)
    local ped = PlayerPedId()
    VehicleNitrous[Plate] = nil
    local CurrentVehicle = GetVehiclePedIsIn(ped)
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then
        NitrousActivated = false
        PurgeActivated = false
        TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
    end
end)