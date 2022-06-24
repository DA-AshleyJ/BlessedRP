--[[------------------------------------------------------------------------------
  -- File         : /client/updateSiren.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Manages the states of the siren
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

RegisterNetEvent("ELS:UpdateSiren")

AddEventHandler("ELS:UpdateSiren", function(player, status)
    DebugPrint("Updating sirens to " .. status  .. " for " .. player)
    local playerPed = PlayerPedId()
    local playerServerId = GetPlayerFromServerId(player)

    if playerServerId == -1 then return end
    
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(playerServerId))

    UpdateSiren(vehicle, status)
end)

function UpdateSiren(vehicle, status)
    local vehicleHash = GetCarHash(vehicle)

    if EnabledVehicles[vehicle] == nil then
        DebugPrint("Adding vehicle to the table")
        AddVehicleToTables(vehicle)
    end

    DebugPrint(vehicleHash)

    if AllowedVehicles[vehicleHash] then
        DebugPrint("Vehicle is allowed")
        EnabledVehicles[vehicle].siren = status
        
        local playerVehicle = GetVehiclePedIsUsing(playerPed)

        if playerVehicle ~= 0 and vehicle == playerVehicle then
            PlaySoundFrontend(-1, "sirenswitch", "DLC_ELS_SOUNDSET", true)
    
            if status == 0 then
                Citizen.Wait(200)
                PlaySoundFrontend(-1, "sirenswitch", "DLC_ELS_SOUNDSET", true)
            end

            Citizen.Wait(100)
        end

        if EnabledVehicles[vehicle].sound ~= nil then
            DebugPrint("Sound exists, lets delete")

            StopSound(EnabledVehicles[vehicle].sound)
            ReleaseSoundId(EnabledVehicles[vehicle].sound)

            EnabledVehicles[vehicle].sound = nil
        end

        DebugPrint("Updating to " .. status .. " out of " .. #AllowedVehicles[vehicleHash].sirens.sounds)

        if #AllowedVehicles[vehicleHash].sirens.sounds >= status and status ~= 0 then
            DebugPrint("Creating the sound and hash")

            local sirenHash = AllowedVehicles[vehicleHash].sirens.sounds[status]

            DebugPrint("Detected Hash " .. sirenHash)

            EnabledVehicles[vehicle].sound = GetSoundId()
            PlaySoundFromEntity(EnabledVehicles[vehicle].sound, sirenHash, vehicle, "DLC_WMSIRENS_SOUNDSET", 0, 0)
        end
    end
end