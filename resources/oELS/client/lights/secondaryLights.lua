--[[------------------------------------------------------------------------------
  -- File         : /client/lights/secondaryLights.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles Secondary Lighting
  -- Author       : Matt Whitaker, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

local patterns = {
    ["leds"] = {{{9}, 120}, {{}, 120}, {{7}, 120}, {{}, 120}},
    ["btp"] = {{{9}, 120}, {{}, 120}, {{7}, 120}, {{}, 120}},
    ["rotator"] = {{{9}, 240}, {{}, 240}, {{7}, 240}, {{}, 240}}
}

function SecondaryLights(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

        DebugPrint("Secondary Status: " .. tostring(EnabledVehicles[vehicle].secondary))

        if not EnabledVehicles[vehicle].secondary then
            SetVehicleSiren(vehicle, false)
            SetVehicleExtra(vehicle, 7, 1)
            SetVehicleExtra(vehicle, 9, 1)
        else
            while EnabledVehicles[vehicle].secondary do
                SetVehicleSiren(vehicle, true)
                SetVehicleEngineOn(vehicle, true, true, false)

                for a,b in pairs(patterns[vehicleConfig.lightSetup.lightPattern]) do
                    if EnabledVehicles[vehicle].secondary then
                        SetVehicleExtra(vehicle, 7, 1)
                        SetVehicleExtra(vehicle, 9, 1)

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