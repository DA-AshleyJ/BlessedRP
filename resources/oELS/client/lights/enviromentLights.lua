--[[------------------------------------------------------------------------------
  -- File         : /client/lights/enviromentLights.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Handles Envromental Lighting
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

function EnviromentalLights(vehicle)
    DebugPrint("Enviromental Lights requested for " .. vehicle)
    local vehicleHash = GetCarHash(vehicle)
    local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

    while true do
        if DoesEntityExist(vehicle) and vehicleConfig then
            
            if EnabledVehicles[vehicle] and not EnabledVehicles[vehicle].primary and EnabledVehicles[vehicle].siren ~= 0 then
                EnabledVehicles[vehicle].siren = 0

                if EnabledVehicles[vehicle].sound ~= nil then
                    DebugPrint("Sound exists, lets delete")

                    StopSound(EnabledVehicles[vehicle].sound)
                    ReleaseSoundId(EnabledVehicles[vehicle].sound)

                    EnabledVehicles[vehicle].sound = nil
                end
            end

            SetVehicleAutoRepairDisabled(vehicle, true)
            DisableVehicleImpactExplosionActivation(vehicle, true)

            for i=1, 10 do
                if IsVehicleExtraTurnedOn(vehicle, i) then
                    local entityBone = GetEntityBoneIndexByName(vehicle, "extra_" .. i)

                    if entityBone ~= -1 then
                        if vehicleConfig and vehicleConfig.extras and vehicleConfig.extras["extra" .. i] then
                            ExtraInfo = vehicleConfig.extras["extra" .. i]

                            if ExtraInfo.enabled and ExtraInfo.allowEnvLight then
                                local ExtraLightConfig = vehicleConfig.extraRotations["extra" .. i]

                                if ExtraLightConfig then
                                    for _, lightInfo in pairs(ExtraLightConfig) do
                                        if vehicleConfig.lightSetup.useDifferentOnScene then
                                            CreateEnviromentLight(vehicle, entityBone, ExtraInfo.offSetX, ExtraInfo.offSetY, ExtraInfo.offSetZ, lightInfo.rotateX, -lightInfo.rotateY, lightInfo.rotateZ, ExtraInfo.colour)
                                        else
                                            CreateEnviromentLight(vehicle, entityBone, ExtraInfo.offSetX, ExtraInfo.offSetY, ExtraInfo.offSetZ, lightInfo.rotateX, lightInfo.rotateY, lightInfo.rotateZ, ExtraInfo.colour)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            EnabledVehicles[vehicle] = nil
            break
        end
        Citizen.Wait(0)
    end
end

function CreateEnviromentLight(vehicle, entityBone, offsetX, offsetY, offsetZ, rotateX, rotateY, rotateZ, rawColour)
    local colour = string.lower(rawColour)

    local entityCoords = GetEntityCoords(vehicle)
    local coords = GetWorldPositionOfEntityBone(vehicle, entityBone)
    local offset = GetOffsetFromEntityInWorldCoords(vehicle, tonumber(rotateX), tonumber(rotateY), tonumber(rotateZ))
    local sometelse = offset - entityCoords
    local somethingelse = norm(sometelse)

    local pos = GetOffsetFromEntityGivenWorldCoords(vehicle, coords + vector3(tonumber(offsetX), tonumber(offsetY), tonumber(offsetZ)))
    local rotX, rotY, rotZ = table.unpack(GetWorldRotationOfEntityBone(vehicle, entityBone))

    if colour == 'blue' then
        DrawSpotLight(coords.x, coords.y, coords.z, somethingelse, 0, 0, 255, 60.0, 1.0, 0.0, 45.0, 100.0) -- Blue Lights
    elseif colour == 'red' then
        DrawSpotLight(coords.x, coords.y, coords.z, somethingelse, 255, 0, 0, 60.0, 1.0, 0.0, 45.0, 100.0) -- Red Lights
    elseif colour == 'green' then
        DrawSpotLight(coords.x, coords.y, coords.z, somethingelse, 0, 255, 0, 60.0, 1.0, 0.0, 45.0, 100.0) -- Green Lights
    elseif colour == 'white' then
        DrawSpotLight(coords.x, coords.y, coords.z, somethingelse, 255, 255, 255, 60.0, 1.0, 0.0, 45.0, 100.0) -- White Lights
    elseif colour == 'alley' then
        DrawLightWithRangeAndShadow(coords.x, coords.y, coords.z, 255, 255, 255, 30.0, 0.80, 2.0) -- Alley Lights
    elseif colour == 'amber' then
        DrawSpotLight(coords.x, coords.y, coords.z, somethingelse, 255, 194, 0, 60.0, 1.0, 0.0, 45.0, 100.0) -- Amber Lights
    end
end

function RotAnglesToVec(rot) -- input vector3
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end