local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local pedspawned = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(Player)
    PlayerData =  QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
     PlayerJob = job
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k, v in pairs(Config.Pedlocation) do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(v.Cords - pos)
			if dist < 40 and pedspawned == false then
				TriggerEvent('spawn1:ped',v.Cords,v.h)
				pedspawned = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(npc)
			end
		end
	end
end)

RegisterNetEvent('spawn1:ped')
AddEventHandler('spawn1:ped',function(coords,heading)
	local hash = GetHashKey('s_m_m_paramedic_01')
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		Wait(10)
	end
	while not HasModelLoaded(hash) do 
		Wait(10)
	end
    pedspawned = true
	npc = CreatePed(5, hash, coords, heading, false, false)
	FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
	loadAnimDict("amb@world_human_cop_idles@male@idle_b") 
	while not TaskPlayAnim(npc, "amb@world_human_cop_idles@male@idle_b", "idle_e", 8.0, 1.0, -1, 17, 0, 0, 0, 0) do
	Wait(1000)
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

RegisterNetEvent('qb-ambulancegarage:garage')
AddEventHandler('qb-ambulancegarage:garage', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 337.8, ['y'] = -578.75, ['z'] = 28.8, ['h'] = 339.12 } 
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "EMS"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        SetEntityHeading(veh, coords.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        local veh = GetVehiclePedIsIn(me, false)
        local hash = pd.vehicle
        local vehname = GetDisplayNameFromVehicleModel(hash):lower()
        TriggerServerEvent('qb-transfer:saveCar1', QBCore.Shared.Vehicles[vehname], veh, GetVehicleNumberPlateText(veh))
        QBCore.Functions.Notify("Vehicle Locked", "error")
    end, coords, true)     
end)

RegisterNetEvent('qb-ambulancegarage:storecar')
AddEventHandler('qb-ambulancegarage:storecar', function()
QBCore.Functions.Notify('Vehicle Removed!')
local car = GetVehiclePedIsIn(PlayerPedId(),true)
DeleteVehicle(car)
DeleteEntity(car)
end)

RegisterNetEvent('garage1:menu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Ambulance Garage",
            txt = "Here you can spawn 2 ambulances. You can also store vehicles within the garage here at Pillbox!"
        },
        {
            header = "Dodge RAM Ambulance",
            txt = "",
            params = {
                event = "qb-ambulancegarage:garage",
                args = {
                    vehicle = '20ramambo',
                    	}
        }
        },
        {
            header = "Ford Ambulance",
            txt = "",
            params = {
                event = "qb-ambulancegarage:garage",
                args = {
                    vehicle = 'ambulance',
                }
            }
        },
        {
            header = "Ambulance Garage",
            txt = "Store Vehicle",
            params = {
                event = "qb-garages:client:putpublicgarage",
                args = {
                    
                }
            }
        },
        {
            header = "Ambulance Garage",
            txt = "Buy Vehicle",
            params = {
                event = "qb-transfer:giveCar1",
                args = {
                    
                }
            }
        },
        {
            header = "Close (ESC)",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
                args = {
                    
                }
            }
        },
        
    })
end)


