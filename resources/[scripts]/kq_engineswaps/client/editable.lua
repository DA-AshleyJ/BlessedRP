function CanVehicleBeSwapped(veh)
    local blacklists = Config.Blacklists

    local class = GetVehicleClass(veh)

    if Contains(blacklists.Classes, class) then
        return false
    end

    if GetVehicleHighGear(veh) <= blacklists.MinimumGears then
        return false
    end

    for k, model in pairs(blacklists.Models) do
        if GetEntityModel(veh) == GetHashKey(model) then
            return false
        end
    end


    return true
end


-- This function gets the vehicle max "physical" size of the engine that will be able to be swapped.
-- It simply gets the vehicles dimensions and adds maxSize points based on that
function GetVehicleMaxEngineSize(veh)
    local size = GetVehicleDimensions(veh)

    local maxSize = 0

    if size.x > 2.1 then
        maxSize = maxSize + 5
    elseif size.x > 2.0 then
        maxSize = maxSize + 4
    elseif size.x > 1.9 then
        maxSize = maxSize + 3
    elseif size.x > 1.7 then
        maxSize = maxSize + 2
    elseif size.x > 1.6 then
        maxSize = maxSize + 1
    end

    if size.y > 4.5 then
        maxSize = maxSize + 3
    elseif size.y > 4.0 then
        maxSize = maxSize + 2
    elseif size.y > 1.7 then
        maxSize = maxSize + 1
    end


    return maxSize
end


if Config.UseHoodCommand then
    RegisterCommand('hood', function(source, args)
        local playerPed = PlayerPedId()
        if not IsPedInAnyVehicle(playerPed, false) then
            return
        end

        local veh = GetVehiclePedIsIn(playerPed, false)
        local door = 4
        if IsEngineInRear(veh) then
            door = 5
        end

        if GetVehicleDoorAngleRatio(veh, door) > 0.4 then
            SetVehicleDoorShut(veh, door, false)
        else
            SetVehicleDoorOpen(veh, door, false, false)
        end
    end)
end


function CanUseWorkshop(workshop)
    return (job and job.name == workshop.jobWorkshop and job.grade.level >= workshop.permissions.swapJobGrade) or workshop.playerWorkshop
end

function CanUsePurchaseEngines(workshop)
    return (job and job.name == workshop.jobWorkshop and job.grade.level >= workshop.permissions.purchaseEngineJobGrade) or workshop.playerWorkshop
end





--[[
    <!> ADVANCED <!>

    If enabled in the config this function will replace the built-in function that handles
    the editing of the vehicle handling. This function gets called at every sync to ensure the vehicles
    handling remains the same as some events can revert the handling back to default.

    The built-in function is WAY more complex than this.

    This should be an example of how you could make your own function

--]]
function CustomSetVehicleEngine(veh, engine)
    local fInitialDriveForce = (engine.power / 1000 + 0.0) * Config.PowerMultiplier
    local fInitialDriveMaxFlatVel = engine.maxV * Config.MaxVMultiplier

    SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
    SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel', fInitialDriveMaxFlatVel)

    -- We need to call ModifyVehicleTopSpeed to refresh the handling data
    ModifyVehicleTopSpeed(veh, 0.0)

    ForceVehicleEngineAudio(veh, engine.sound)
end











-- This function is responsible for all the tooltips displayed on top right of the screen, you could
-- replace it with a custom notification etc.
function ShowTooltip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end


-- This function is responsible for drawing all the 3d texts ('Press [E] to prepare for an engine swap' e.g)
function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
