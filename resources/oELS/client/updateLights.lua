--[[------------------------------------------------------------------------------
  -- File         : /client/updateLights.lua
  -- Created Date : Monday April 27 2020
  -- Purpose      : Manages the states of the lights
  -- Author       : Matt Whitaker, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

RegisterNetEvent("ELS:ToggleSpotlight")

AddEventHandler("ELS:ToggleSpotlight", function(player, status)
    local playerServerId = GetPlayerFromServerId(player)

    if playerServerId == -1 then return end
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(playerServerId))

    if EnabledVehicles[vehicle] == nil then
        DebugPrint("Adding vehicle to the table")
        AddVehicleToTables(vehicle)
    end

    EnabledVehicles[vehicle].spotlight = status

    if status then
        HandleSptlight(vehicle)
    end
end)

RegisterNetEvent("ELS:UpdateIndicator")

AddEventHandler("ELS:UpdateIndicator", function(player, indicator, status)
    DebugPrint(indicator)
    DebugPrint(status)
    local playerServerId = GetPlayerFromServerId(player)

    if playerServerId == -1 then return end
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(playerServerId))

    SetVehicleIndicatorLights(vehicle, indicator, status)
end)

RegisterNetEvent("ELS:UpdateSpotlight")

AddEventHandler("ELS:UpdateSpotlight", function(player, newX, newY, newZ)
    local playerServerId = GetPlayerFromServerId(player)

    if playerServerId == -1 then return end
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(playerServerId))

    if EnabledVehicles[vehicle] == nil then
        DebugPrint("Adding vehicle to the table")
        AddVehicleToTables(vehicle)
    end

    EnabledVehicles[vehicle].spotlightX = newX
    EnabledVehicles[vehicle].spotlightY = newY
    EnabledVehicles[vehicle].spotlightZ = newZ
end)

RegisterNetEvent("ELS:UpdateStage")

AddEventHandler("ELS:UpdateStage", function(player, stage)
    local playerServerId = GetPlayerFromServerId(player)

    if playerServerId == -1 then return end
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(playerServerId))

    UpdateStage(vehicle, stage)
end)

function UpdateStage(vehicle, stage)
    if EnabledVehicles[vehicle] == nil then
        DebugPrint("Adding vehicle to the table")
        AddVehicleToTables(vehicle)
    end

    EnabledVehicles[vehicle].stage = stage
end

RegisterNetEvent("ELS:UpdateLights")

AddEventHandler("ELS:UpdateLights", function(player, type, status)
    DebugPrint("Activating " .. type .. " lights for " .. player)

    local playerServerId = GetPlayerFromServerId(player)

    if playerServerId == -1 then return end
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(playerServerId))

    UpdateLights(vehicle, type, status)
end)

function UpdateLights(vehicle, type, status)
    if EnabledVehicles[vehicle] == nil then
        DebugPrint("Adding vehicle to the table")
        AddVehicleToTables(vehicle)
    end

    if type == "primary" then
        EnabledVehicles[vehicle].primary = status

        EnabledVehicles[vehicle].backPrimary = false
        EnabledVehicles[vehicle].frontPrimary = false

        if not status then
            EnabledVehicles[vehicle].secondary = false
            EnabledVehicles[vehicle].warning = false
            EnabledVehicles[vehicle].backPrimary = false
            EnabledVehicles[vehicle].frontPrimary = false
            EnabledVehicles[vehicle].wigWags = false
        else
            EnabledVehicles[vehicle].wigWags = true

            if AllowedVehicles[GetCarHash(vehicle)].lightSetup.seconaryWithPrimary then
                EnabledVehicles[vehicle].secondary = true

                Citizen.CreateThread(function()
                    SecondaryLights(vehicle)
                end)
            end

            if AllowedVehicles[GetCarHash(vehicle)].lightSetup.warningWithPrimary then
                EnabledVehicles[vehicle].warning = true
                
                Citizen.CreateThread(function()
                    WarningLights(vehicle)
                end)
            end
        end

        Citizen.CreateThread(function()
            PrimaryLights(vehicle)
        end)
    end

    if type == "secondary" then
        EnabledVehicles[vehicle].secondary = status
        
        Citizen.CreateThread(function()
            SecondaryLights(vehicle)
        end)
    end

    if type == "warning" then
        EnabledVehicles[vehicle].warning = status

        Citizen.CreateThread(function()
            WarningLights(vehicle)
        end)
    end

    if type == "backPrimary" then
        EnabledVehicles[vehicle].primary = false
        EnabledVehicles[vehicle].warning = false
        EnabledVehicles[vehicle].backPrimary = status

        Citizen.CreateThread(function()
            RearPrimaryLights(vehicle)
        end)
    end
end