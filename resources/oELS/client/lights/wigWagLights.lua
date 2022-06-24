--[[------------------------------------------------------------------------------
  -- File         : /client/lights/wigWayLights.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles Wig Wag Lighting
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

function WigWagLights(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]
        if not EnabledVehicles[vehicle].wigWags then
            SetVehicleLights(vehicle,0)
        else
            local brighteness = 0.0
            SetVehicleLights(vehicle,1)

            while EnabledVehicles[vehicle].wigWags do
                local brighteness = 0.0

                for i = 1, 9 do
                    local entityBone = GetEntityBoneIndexByName(vehicle, "headlight_l")
                    local coords = GetWorldPositionOfEntityBone(vehicle, entityBone)
                    local rotX, rotY, rotZ = table.unpack(RotAnglesToVec(GetEntityRotation(vehicle, 2)))

                    DrawSpotLight(coords, rotX, rotY, rotZ, 255, 255, 255, 20.0, brighteness, 0.0, 45.0, 100.0)

                    brighteness = brighteness + 4.0
                    
                    Citizen.Wait(0)
                end
                
                for i = 1, 9 do
                    local entityBone = GetEntityBoneIndexByName(vehicle, "headlight_l")
                    local coords = GetWorldPositionOfEntityBone(vehicle, entityBone)
                    local rotX, rotY, rotZ = table.unpack(RotAnglesToVec(GetEntityRotation(vehicle, 2)))

                    DrawSpotLight(coords, rotX, rotY, rotZ, 255, 255, 255, 20.0, brighteness, 0.0, 45.0, 100.0)

                    brighteness = brighteness - 4.0
                    
                    Citizen.Wait(0)
                end

                for i = 1, 9 do
                    local entityBone = GetEntityBoneIndexByName(vehicle, "headlight_r")
                    local coords = GetWorldPositionOfEntityBone(vehicle, entityBone)
                    local rotX, rotY, rotZ = table.unpack(RotAnglesToVec(GetEntityRotation(vehicle, 2)))

                    DrawSpotLight(coords, rotX, rotY, rotZ, 255, 255, 255, 20.0, brighteness, 0.0, 45.0, 100.0)

                    brighteness = brighteness + 4.0
                    
                    Citizen.Wait(0)
                end
                
                for i = 1, 9 do
                    local entityBone = GetEntityBoneIndexByName(vehicle, "headlight_r")
                    local coords = GetWorldPositionOfEntityBone(vehicle, entityBone)
                    local rotX, rotY, rotZ = table.unpack(RotAnglesToVec(GetEntityRotation(vehicle, 2)))

                    DrawSpotLight(coords, rotX, rotY, rotZ, 255, 255, 255, 20.0, brighteness, 0.0, 45.0, 100.0)

                    brighteness = brighteness - 4.0
                    
                    Citizen.Wait(0)
                end
            end
        end
    end
end

function RotAnglesToVec(rot) -- input vector3
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end