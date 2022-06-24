--[[------------------------------------------------------------------------------
  -- File         : /client/lights/warningLights.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles Warning Lighting
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

local pattern = {{{6}, 280}, {{}, 160}, {{5}, 280}, {{}, 160}}

function WarningLights(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

        if not EnabledVehicles[vehicle].warning then
            SetVehicleSiren(vehicle, false)
            SetVehicleExtra(vehicle, 5, 1)
            SetVehicleExtra(vehicle, 6, 1)
        else
            while EnabledVehicles[vehicle].warning do
                SetVehicleSiren(vehicle, true)
                SetVehicleEngineOn(vehicle, true, true, false)

                if vehicleConfig.lightSetup.useCustomLFBPattern then
                    SetVehicleExtra(vehicle, 5, 0)
                    SetVehicleExtra(vehicle, 6, 0)
                    Citizen.Wait(100)
                else
                    for a,b in pairs(pattern) do
                        if EnabledVehicles[vehicle].warning then
                            SetVehicleExtra(vehicle, 5, 1)
                            SetVehicleExtra(vehicle, 6, 1)

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
end