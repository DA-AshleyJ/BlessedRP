--[[------------------------------------------------------------------------------
  -- File         : /client/onesync.lua
  -- Created Date : Sunday 11 October 2020
  -- Purpose      : Handles ELS for the now default Onesync version.
  -- Author       : Tom
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

local els = {}

RegisterNetEvent("ELS:UpdateLights:Onesync")
AddEventHandler("ELS:UpdateLights:Onesync", function(net, type, status)
	Citizen.Wait(100)

	local lights = {}

	lights.type = type
	lights.status = status

	if not els[net] then
		els[net] = {}
	end

	els[net].lights = lights
end)

RegisterNetEvent("ELS:UpdateSiren:Onesync")
AddEventHandler("ELS:UpdateSiren:Onesync", function(net, status)
	Citizen.Wait(100)

	if not els[net] then
		els[net] = {}
	end

	els[net].siren = status
end)

RegisterNetEvent("ELS:UpdateStage:Onesync")
AddEventHandler("ELS:UpdateStage:Onesync", function(net, stage)
	Citizen.Wait(100)

	if not els[net] then
		els[net] = {}
	end

	els[net].stage = stage
end)

RegisterNetEvent("ELS:DeleteVehicle:Onesync")
AddEventHandler("ELS:DeleteVehicle:Onesync", function(net)
	Citizen.Wait(100)

	els[net] = nil
end)

Citizen.CreateThread(function()
	while true do
		for net, data in pairs(els) do
			EnsureVehicleIsSetup(net, data)
		end
		Citizen.Wait(500)
	end
end)

function EnsureVehicleIsSetup(net, data)
	if not NetworkDoesNetworkIdExist(net) then return end -- Vehicle does not exist in our render distance

	local veh = NetworkGetEntityFromNetworkId(net)

	if veh == 0 then return end -- Final check to make sure vehicle exists

	if EnabledVehicles[veh] then return end -- Vehicle already has ELS working

	if data.stage then
		Citizen.CreateThread(function()
			pcall(UpdateStage, veh, data.stage)
		end)
	end

	if data.siren then
		Citizen.CreateThread(function()
			pcall(UpdateSiren, veh, data.siren)
		end)
	end

	if data.lights and data.lights.type and data.lights.status then
		Citizen.CreateThread(function()
			pcall(UpdateLights, veh, data.lights.type, data.lights.status)
		end)
	end
end