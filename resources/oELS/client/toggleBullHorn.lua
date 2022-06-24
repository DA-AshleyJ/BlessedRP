--[[------------------------------------------------------------------------------
  -- File         : /client/ToggleBullHorn.lua
  -- Created Date : Monday April 27 2020
  -- Purpose      : Toggles the bullhorn
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

RegisterNetEvent("ELS:ToggleBullHorn")

AddEventHandler("ELS:ToggleBullHorn", function(player, status)
    DebugPrint("Updating bullhorn to " .. tostring(status)  .. " for " .. player)
    local playerServerId = GetPlayerFromServerId(player)

    if playerServerId == -1 then return end
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(playerServerId))
    local vehicleHash = GetCarHash(vehicle)

    if EnabledVehicles[vehicle] == nil then
        DebugPrint("Adding vehicle to the table")
        AddVehicleToTables(vehicle)
    end

    if AllowedVehicles[vehicleHash] then
        DebugPrint("Vehicle is allowed")

        if EnabledVehicles[vehicle].sound ~= nil then
            DebugPrint("Sound exists, lets delete")

            StopSound(EnabledVehicles[vehicle].sound)
            ReleaseSoundId(EnabledVehicles[vehicle].sound)

            EnabledVehicles[vehicle].sound = nil
        end

        if status and AllowedVehicles[vehicleHash].sirens.bullHorn then
            DebugPrint("Creating the sound and hash")
            new = AllowedVehicles[vehicleHash].sirens.bullHornSound
            EnabledVehicles[vehicle].sound = GetSoundId()
            DebugPrint(new .. " Is my fucking sound cunt")
            DebugPrint(sirenNumber)
            PlaySoundFromEntity(EnabledVehicles[vehicle].sound, AllowedVehicles[vehicleHash].sirens.bullHornSound, vehicle, "DLC_WMSIRENS_SOUNDSET", 0, 0)
        else
            if EnabledVehicles[vehicle].siren ~= 0 then
                local sirenNumber = EnabledVehicles[vehicle].siren
                DebugPrint(sirenNumber)
                
                local sirenHash = AllowedVehicles[vehicleHash].sirens.sounds[sirenNumber]

                DebugPrint("Detected Hash " .. sirenHash)

                EnabledVehicles[vehicle].sound = GetSoundId()
                local blipId = GetSoundId()
                PlaySoundFromEntity(blipId, "SULTAN_HORN", vehicle, 0, 0, 0)
            end
        end
    end
end)