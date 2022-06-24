if (IsDuplicityVersion()) then
    RegisterServerEvent("blacklist.checkForAdminPermissions")
    AddEventHandler('blacklist.checkForAdminPermissions', function()
        if IsPlayerAceAllowed(source, "blacklist.bypass") then
            TriggerClientEvent("blacklist.setAdminPermissions", source, true)
        end
    end)
else
    local allowedToBypass = false

    local blockedModels = { -- change this list and add the cars you want.
        "trailer3",
    }

    RegisterNetEvent("blacklist.setAdminPermissions")
    AddEventHandler("blacklist.setAdminPermissions", function(allowed)
        if allowed then
            allowedToBypass = allowed
        end
    end)

    Citizen.CreateThread(function()
        TriggerServerEvent("blacklist.checkForAdminPermissions")
        while true do
            Citizen.Wait(1)
            if not allowedToBypass then
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if DoesEntityExist(veh) and IsEntityAVehicle(veh) and not IsEntityDead(veh) then
                        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
                            for _,car in pairs(blockedModels) do
                                local model = GetEntityModel(veh)
                                if GetHashKey(car) == model then
                                    SetEntityAsMissionEntity(veh, true, true)
                                    DeleteVehicle(veh)
                                    notify()
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    
    function notify()
        SetNotificationTextEntry("STRING")
        AddTextComponentSubstringPlayerName("~r~This model is blacklisted, you are not allowed to drive it.")
        DrawNotification(true, true)
    end
end