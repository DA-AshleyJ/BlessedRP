--[[------------------------------------------------------------------------------
  -- File         : /client/lights/spotlight.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles SPOTLIGHT Lighting
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

function HandleSptlight(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

        DebugPrint("Spotlight Status: " .. tostring(EnabledVehicles[vehicle].spotlight))

        if not EnabledVehicles[vehicle].spotlight then
            SetVehicleSiren(vehicle, false)
            SetVehicleExtra(vehicle, 7, 1)
            SetVehicleExtra(vehicle, 9, 1)
        else
            if vehicleConfig then
                local entityBone = GetEntityBoneIndexByName(vehicle, "extra_" .. vehicleConfig.misc.spotLight.extra)

                while EnabledVehicles[vehicle].spotlight do
                    local vehicleData = EnabledVehicles[vehicle]

                    SetVehicleSiren(vehicle, true)
                    SetVehicleEngineOn(vehicle, true, true, false)
                    
                    local direct = GetEntityForwardVector(vehicle)
                    local coords = GetWorldPositionOfEntityBone(vehicle, entityBone)

                    DrawSpotLight(coords.x, coords.y, coords.z, direct.x+vehicleData.spotlightX, direct.y+vehicleData.spotlightY, direct.z+vehicleData.spotlightZ, 221, 221, 221, 70.0, 50.0, 4.3, 25.0, 28.6)
                    
                    Citizen.Wait(0)
                end
            end
        end
    end
end