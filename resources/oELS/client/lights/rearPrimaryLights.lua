--[[------------------------------------------------------------------------------
  -- File         : /client/lights/backPrimaryLights.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles backPrimary Lighting
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

local pattern = {{{1}, 75}, {{}, 75}, {{1}, 75}, {{4}, 75}, {{}, 75}, {{4}, 75}}
local lukePattern = {{{2}, 75}, {{}, 75}, {{2}, 75}, {{3}, 75}, {{}, 75}, {{3}, 75}}

local patterns = {
    ["leds"] = {{{1}, 75}, {{}, 75}, {{1}, 75}, {{4}, 75}, {{}, 75}, {{4}, 75}},
    ["btp"] = {{{1}, 75}, {{}, 75}, {{1}, 75}, {{4}, 75}, {{}, 75}, {{4}, 75}},
    ["rotator"] = {{{}, 75}},
}

function RearPrimaryLights(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

        DebugPrint("backPrimary Status: " .. tostring(EnabledVehicles[vehicle].backPrimary))

        if not EnabledVehicles[vehicle].backPrimary then
            SetVehicleSiren(vehicle, false)

            for extra=1, 10 do
                SetVehicleExtra(vehicle, extra, true)
            end
        else
            while EnabledVehicles[vehicle].backPrimary do
                SetVehicleSiren(vehicle, true)
                SetVehicleEngineOn(vehicle, true, true, false)

                if vehicleConfig.lightSetup.useDifferentOnScene then
                    for a,b in pairs(lukePattern) do
                        if EnabledVehicles[vehicle].backPrimary then
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
                else
                    for a,b in pairs(patterns[vehicleConfig.lightSetup.lightPattern]) do
                        if EnabledVehicles[vehicle].backPrimary then
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
end