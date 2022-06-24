--[[------------------------------------------------------------------------------
  -- File         : /server/onesync.lua
  -- Created Date : Sunday 11 October 2020
  -- Purpose      : Handles ELS for the now default Onesync version.
  -- Author       : Tom
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

local els = {}

Citizen.CreateThread(function()
    if not IsOnesync() then return end

    RegisterServerEvent("ELS:UpdateStatus")
    AddEventHandler("ELS:UpdateStatus", function(type, status)
        local net = GetNetVehicle(source)

        if net == 0 then return end

        TriggerClientEvent("ELS:UpdateLights:Onesync", -1, net, type, status)
    end)

    RegisterServerEvent("ELS:UpdateSiren")
    AddEventHandler("ELS:UpdateSiren", function(status)
        local net = GetNetVehicle(source)

        if net == 0 then return end

        TriggerClientEvent("ELS:UpdateSiren:Onesync", -1, net, status)
    end)

    RegisterNetEvent("ELS:UpdateStage")
    AddEventHandler("ELS:UpdateStage", function(stage)
        local net = GetNetVehicle(source)

        if net == 0 then return end

        TriggerClientEvent("ELS:UpdateStage:Onesync", -1, net, stage)
    end)

    AddEventHandler("entityRemoved", function(entity)
        local net = els[entity]
        if net then
            TriggerClientEvent("ELS:DeleteVehicle:Onesync", -1, net)
            els[entity] = nil
        end
    end)
end)

function GetNetVehicle(player)    
    local ped = GetPlayerPed(player)

    if ped == 0 then return 0 end

    local veh = GetVehiclePedIsIn(ped, false)

    if veh == 0 then return 0 end

    local net = NetworkGetNetworkIdFromEntity(veh)

    if net == 0 then return 0 end

    els[veh] = net

    return net
end

function IsOnesync()
	local isOnesync = (GetConvar("onesync_enabled", "false") == "true") or (GetConvar("onesync", "off") == "on") or (GetConvar("onesync", "off") == "legacy")
	return isOnesync
end