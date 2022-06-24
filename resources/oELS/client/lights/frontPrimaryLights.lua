--[[------------------------------------------------------------------------------
  -- File         : /client/lights/frontPrimaryLights.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles Front Primary Lighting
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

local pattern = {}

function FrontPrimaryLights(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

        if vehicleConfig then
            pattern = vehicleConfig.lightSetup.frontPrimary

            if not EnabledVehicles[vehicle].frontPrimary then
                SetVehicleSiren(vehicle, false)

                for extra=1, 10 do
                    SetVehicleExtra(vehicle, extra, true)
                end

                for _, extra2 in pairs(pattern) do
                    SetVehicleExtra(vehicle, tonumber(string.sub(extra2, 6)), 1)
                end
            else
                for extra=1, 10 do
                    SetVehicleExtra(vehicle, extra, true)
                end
                
                while EnabledVehicles[vehicle].frontPrimary do
                    SetVehicleSiren(vehicle, true)
                    SetVehicleEngineOn(vehicle, true, true, false)

                    for _,extra in pairs(pattern) do
                        local cleanExtra = string.sub(extra, 7)

                        SetVehicleExtra(vehicle, tonumber(cleanExtra), 0)

                        Citizen.Wait(100)

                        for _, extra2 in pairs(pattern) do
                            SetVehicleExtra(vehicle, tonumber(string.sub(extra2, 6)), 1)
                        end

                        Citizen.Wait(100)
                    end
                end
            end
        end
    end
end