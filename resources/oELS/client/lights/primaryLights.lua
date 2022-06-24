--[[------------------------------------------------------------------------------
  -- File         : /client/lights/primaryLights.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles Primary Lighting
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

local patterns = {
    ["leds"] = {{{1, 2}, 75}, {{}, 75}, {{1, 2}, 75}, {{3, 4}, 75}, {{}, 75}, {{3, 4}, 75}},
    ["btp"] = {{{1, 2}, 75}, {{}, 75}, {{1, 2}, 75}, {{3, 4}, 75}, {{}, 75}, {{3, 4}, 75}},
    ["rotator"] = {{{1}, 75}, {{2}, 75}, {{3}, 75}, {{4}, 75}},
}

function PrimaryLights(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

        DebugPrint("Primary Status: " .. tostring(EnabledVehicles[vehicle].primary))

        if not EnabledVehicles[vehicle].primary then
            SetVehicleSiren(vehicle, false)

            for extra=1, 10 do
                SetVehicleExtra(vehicle, extra, true)
            end

            if EnabledVehicles[vehicle].siren ~= 0 then
                EnabledVehicles[vehicle].siren = 0

                if EnabledVehicles[vehicle].sound ~= nil then
                    DebugPrint("Sound exists, lets delete")

                    StopSound(EnabledVehicles[vehicle].sound)
                    ReleaseSoundId(EnabledVehicles[vehicle].sound)

                    EnabledVehicles[vehicle].sound = nil
                end
            end
        else
            while EnabledVehicles[vehicle].primary do
                SetVehicleSiren(vehicle, true)
                SetVehicleEngineOn(vehicle, true, true, false)

                if vehicleConfig.lightSetup.lightPattern == 'btp' then
                    SetVehicleExtra(vehicle, 10, 0)
                end

                for a,b in pairs(patterns[vehicleConfig.lightSetup.lightPattern]) do
                    if EnabledVehicles[vehicle].primary then
                        SetVehicleExtra(vehicle, 1, 1)
                        SetVehicleExtra(vehicle, 2, 1)
                        SetVehicleExtra(vehicle, 3, 1)
                        SetVehicleExtra(vehicle, 4, 1)

                        for c,d in pairs(b[1]) do
                            if vehicleConfig and vehicleConfig.extras ~= nil and vehicleConfig.extras['extra' .. d] ~= nil then
                                if vehicleConfig.extras['extra' .. d].enabled then
                                    SetVehicleExtra(vehicle, d, 0)
                                end
                            end
                        end
        
                        Citizen.Wait(b[2])
                    end
                end
            end
        end
    end
end