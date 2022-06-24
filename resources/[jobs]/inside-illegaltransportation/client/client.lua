QBCore = nil

local QBCore = exports['qb-core']:GetCoreObject()
--------------------------------------------------------------------------------
local PlayerData = {}
local JobStarted = false
local Vehicleout = false
local Vehicle
local Place
local DrugObject, DrugObject2
local activ = false
local DrugTaken,DrugTaken2 = 0,0
local haspackage, haspackage2 = false,false
local packagetrunk = 0
local JobDone = false
local minus = 0
local packmodel
local anim = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function()
	PlayerData.job = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('inside-illegaltransportation:playerdropped')
AddEventHandler('inside-illegaltransportation:playerdropped', function()
	for i, v in pairs(Config.Package) do
		DeleteEntity(v.pack)
	end
	for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
		DeletePed(v.ped)
	end
	QBCore.Functions.DeleteVehicle(Vehicle)
	DeleteEntity(DrugObject)
	DeleteEntity(DrugObject2)
	DeleteEntity(pack)
end)

Citizen.CreateThread(function()
	local ped_hash = GetHashKey(Config.illegaltransportation['BossSpawn'].Type)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossNPC = CreatePed(1, ped_hash, Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z-1, Config.illegaltransportation['BossSpawn'].Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(BossNPC, true)
	SetPedDiesWhenInjured(BossNPC, false)
	SetPedCanPlayAmbientAnims(BossNPC, true)
	SetPedCanRagdollFromPlayerImpact(BossNPC, false)
	SetEntityInvincible(BossNPC, true)
	FreezeEntityPosition(BossNPC, true)
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords,Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z, true) < 9.0) then	
				sleep = 5
				if(GetDistanceBetweenCoords(coords,Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z, true) < 1.5) then	
					if not JobStarted then
						DrawText3Ds(Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z+1.0, 'To start work, press [~g~E~w~]')
						DrawMarker(25, Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
					else
						DrawText3Ds(Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z+1.0, 'To interrupt an assignment, press [~r~E~w~]')
						DrawMarker(25, Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 133, 0, 0, 100, false, true, 2, false, false, false, false)
					end
					if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not JobStarted then
						JobStarted = true
						exports.pNotify:SendNotification({text = "<b>Boss</b></br>Take my car and go to your first destination", timeout = 4500})
						VehicleSpawnB()			
					elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and JobStarted then
						JobStarted = false
						Vehicleout = false
						RemoveBlip(VehicleSpawnBlip)
						QBCore.Functions.DeleteVehicle(Vehicle)
						Vehicle = nil
						RemoveBlip(PlaceBlip)
						Plate = nil
						RemoveBlip(PlaceDrugBlip)
						RemoveBlip(PlaceDrugBlip2)
						DeleteEntity(DrugObject)
						DeleteEntity(DrugObject2)
						activ = false
						DrugTaken = 0
						DrugTaken2 = 0
						haspackage = false
						haspackage2 = false
						packagetrunk = 0
						JobDone = false
						ClearPedTasks(ped)
						DeleteEntity(pack)
						RemoveBlip(PlaceDepotPayoutBlip)
						anim = false
						minus = 0
						exports.pNotify:SendNotification({text = "<b>Boss</b></br>It's bad that you can't make it ...", timeout = 4500})
						for i, v in pairs(Config.Package) do
							DeleteEntity(v.pack)
						end
						for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
							DeletePed(v.ped)
						end
						Place = nil
					end
				else
					DrawMarker(25, Config.illegaltransportation['BossSpawn'].Pos.x, Config.illegaltransportation['BossSpawn'].Pos.y, Config.illegaltransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				end
			end
		Citizen.Wait(sleep)
	end
end)

function VehicleSpawnB()
	VehicleSpawnBlip = AddBlipForCoord(Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z)
	SetBlipSprite(VehicleSpawnBlip, 227)
	SetBlipColour(VehicleSpawnBlip, 0)
	SetBlipAlpha(VehicleSpawnBlip, 250)
	SetBlipScale(VehicleSpawnBlip, 0.8)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Vehicle')
	EndTextCommandSetBlipName(VehicleSpawnBlip)
end

Citizen.CreateThread(function ()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if JobStarted then
			if(GetDistanceBetweenCoords(coords,Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z, true) < 9.0) then	
				sleep = 5
				if(GetDistanceBetweenCoords(coords,Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z, true) < 1.5) then
					if not Vehicleout then	
						DrawText3Ds(Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z+1.0, 'To pull the vehicle out, press [~g~E~w~]')
						DrawMarker(25, Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z-0.55, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
						DrawMarker(36, Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
						if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not Vehicleout then
							if IsSpawnPointClear(vector3(Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z), 2) then					
								QBCore.Functions.SpawnVehicle(Config.illegaltransportation['VehicleSpawn'].Type, function(vehicle)
									Vehicle = vehicle
									SetVehicleNumberPlateText(vehicle, "COK"..tostring(math.random(1000, 9999)))
									SetEntityHeading(vehicle, Config.illegaltransportation['VehicleSpawn'].Pos.h)
									TaskWarpPedIntoVehicle(ped, vehicle, -1)
									SetEntityAsMissionEntity(vehicle, true, true)
									TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
									SetVehicleEngineOn(vehicle, true, true)
									Plate = GetVehicleNumberPlateText(vehicle)
									
									Place = Randomize(Config.Randomize)
									Vehicleout = true
									PlaceB()
									DrugObject = CreateObject(GetHashKey('hei_prop_heist_weed_pallet'), Config.Places[Place.name].DrugPos.x, Config.Places[Place.name].DrugPos.y, Config.Places[Place.name].DrugPos.z-1, false, true, true)
									PlaceObjectOnGroundProperly(DrugObject)
									FreezeEntityPosition(DrugObject, true)

									DrugObject2 = CreateObject(GetHashKey('hei_prop_heist_weed_pallet'), Config.Places[Place.name].DrugPos2.x, Config.Places[Place.name].DrugPos2.y, Config.Places[Place.name].DrugPos2.z-1, false, true, true)
									PlaceObjectOnGroundProperly(DrugObject2)
									FreezeEntityPosition(DrugObject2, true)

									for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
										local ped_hash = GetHashKey('g_m_m_mexboss_01')
										RequestModel(ped_hash)
										while not HasModelLoaded(ped_hash) do
											Citizen.Wait(1)
										end

										v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.5, 0.0, false, true)
										v.blip = AddBlipForEntity(v.ped)
										SetBlipScale(v.blip, 0.6)
										SetEntityHeading(v.ped, v.h)
										SetPedFleeAttributes(v.ped, 0, 0)
										SetPedCombatAttributes(v.ped, 46, 1)
										SetPedCombatAbility(v.ped, 100)
										SetPedCombatMovement(v.ped, 2)
										SetPedCombatRange(v.ped, 2)
										SetPedKeepTask(v.ped, true)
										GiveWeaponToPed(v.ped, GetHashKey(Config.Weapons['Weapons'][math.random(1,#Config.Weapons['Weapons'])].weapon),250,false,true)
										SetPedAsCop(v.ped, true)
										SetPedDropsWeaponsWhenDead(v.ped, false)
									end
								end, vector3(Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z))
							else
								exports.pNotify:SendNotification({text = "<b>Illegal Transportation</b></br>The spawn site is blocked!", timeout = 4000})
							end
						end
					else
						DrawText3Ds(Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z+1.0, 'To hide the car, press [~g~E~w~]')
						DrawMarker(25, Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z-0.55, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
						DrawMarker(36, Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
						if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
							Vehicleout = false
							QBCore.Functions.DeleteVehicle(Vehicle)
							Vehicle = nil
							Plate = nil
							RemoveBlip(PlaceBlip)
							RemoveBlip(PlaceDrugBlip)
							RemoveBlip(PlaceDrugBlip2)
							DeleteEntity(DrugObject)
							DeleteEntity(DrugObject2)
							activ = false
							DrugObject = 0
							DrugTaken = 0
							DrugTaken2 = 0
							haspackage = false
							haspackage2 = false
							packagetrunk = 0
							JobDone = false
							ClearPedTasks(ped)
							DeleteEntity(pack)
							RemoveBlip(PlaceDepotPayoutBlip)
							anim = false
							minus = 0
							for i, v in pairs(Config.Package) do
								DeleteEntity(v.pack)
							end
							for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
								DeletePed(v.ped)
							end
						end
					end
				else
					DrawMarker(36, Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					DrawMarker(25,Config.illegaltransportation['VehicleSpawn'].Pos.x, Config.illegaltransportation['VehicleSpawn'].Pos.y, Config.illegaltransportation['VehicleSpawn'].Pos.z-0.55, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				end
			end
		end 
		Citizen.Wait(sleep)
	end
end)

--##############################

function IsSpawnPointClear(coords, radius)
	local vehicles = GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetClosestVehicle(coords)
	local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function GetVehiclesInArea(coords, area)
	local vehicles       = GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

--##############################

function PlaceB()
	PlaceBlip = AddBlipForCoord(Config.Places[Place.name].Pos.x, Config.Places[Place.name].Pos.y, Config.Places[Place.name].Pos.z)
	SetBlipSprite(PlaceBlip, 310)
	SetBlipColour(PlaceBlip, 0)
	SetBlipAlpha(PlaceBlip, 250)
	SetBlipScale(PlaceBlip, 0.8)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Place')
	EndTextCommandSetBlipName(PlaceBlip)
end

function PlaceDepotPayoutB()
	PlaceDepotPayoutBlip = AddBlipForCoord(Config.illegaltransportation['VehicleDepot'].Pos.x, Config.illegaltransportation['VehicleDepot'].Pos.y, Config.illegaltransportation['VehicleDepot'].Pos.z)
	SetBlipSprite(PlaceDepotPayoutBlip, 500)
	SetBlipColour(PlaceDepotPayoutBlip, 0)
	SetBlipAlpha(PlaceDepotPayoutBlip, 250)
	SetBlipScale(PlaceDepotPayoutBlip, 0.8)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Payout')
	EndTextCommandSetBlipName(PlaceDepotPayoutBlip)
end

function PlaceDrugB()
	PlaceDrugBlip = AddBlipForCoord(Config.Places[Place.name].DrugPos.x, Config.Places[Place.name].DrugPos.y, Config.Places[Place.name].DrugPos.z)
	SetBlipSprite(PlaceDrugBlip, 51)
	SetBlipColour(PlaceDrugBlip, 0)
	SetBlipAlpha(PlaceDrugBlip, 250)
	SetBlipScale(PlaceDrugBlip, 0.5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Drugs')
	EndTextCommandSetBlipName(PlaceDrugBlip)

	PlaceDrugBlip2 = AddBlipForCoord(Config.Places[Place.name].DrugPos2.x, Config.Places[Place.name].DrugPos2.y, Config.Places[Place.name].DrugPos2.z)
	SetBlipSprite(PlaceDrugBlip2, 51)
	SetBlipColour(PlaceDrugBlip2, 0)
	SetBlipAlpha(PlaceDrugBlip2, 250)
	SetBlipScale(PlaceDrugBlip2, 0.5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Drugs')
	EndTextCommandSetBlipName(PlaceDrugBlip2)
end

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		 	if haspackage or haspackage2 then
				sleep = 5 
				local trunkpos = GetOffsetFromEntityInWorldCoords(Vehicle, 0, -2.5, 0)
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2.5 then
					DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.25, 'To put down drugs, press [~g~E~w~]')
					if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
						DeleteEntity(pack)
						anim = false
						startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
						exports.rprogress:Custom({
							Duration = 1000,
							Label = "You put the drugs down...",
							Animation = {
								scenario = "", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "", -- https://alexguirre.github.io/animations-list/
							},
							DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
							}
						})
						Citizen.Wait(1000)
						ClearPedTasks(ped)
						haspackage = false
						haspackage2 = false
						SetVehicleDoorsLocked(Vehicle, 1)
						ClearPedTasks(ped)

						TaskPlayAnim(ped, 'anim@heists@box_carry@', "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)					
						


						
						local coordsPED = GetEntityCoords(ped)

						
						if packmodel == 1 then
							Config.Package[packagetrunk].pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01b'), coordsPED.x, coordsPED.y, coordsPED.z, false, true, true)
						else
							Config.Package[packagetrunk].pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01'), coordsPED.x, coordsPED.y, coordsPED.z, false, true, true)
						end
						SetEntityCollision(Config.Package[packagetrunk].pack, false)

						if packagetrunk < 4 then
							AttachEntityToEntity(Config.Package[packagetrunk].pack, Vehicle, GetEntityBoneIndexByName(Vehicle, 'boot'), -0.2, 1.8-minus, 0.05, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						elseif packagetrunk >= 4 and packagetrunk < 8 then
							if minus >= 1.0 then
								minus = 0.0
							end
							AttachEntityToEntity(Config.Package[packagetrunk].pack, Vehicle, GetEntityBoneIndexByName(Vehicle, 'boot'), 0.2, 1.8-minus, 0.05, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						else 
							if minus >= 1.0 then
								minus = 0.0
							end
							AttachEntityToEntity(Config.Package[packagetrunk].pack, Vehicle, GetEntityBoneIndexByName(Vehicle, 'boot'), 0.0, 1.8-minus, 0.18, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						end
						minus = minus + 0.25
						packagetrunk = packagetrunk + 1
					end
				end
			end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function ()
	while true do
		local ped = PlayerPedId()
		local sleep = 500
		if Vehicleout then
			sleep = 5
			for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
				if IsPedDeadOrDying(v.ped, 1) then
					RemoveBlip(v.blip)
				end
			end
			if IsPedDeadOrDying(ped, 1) then
				JobStarted = false
				Vehicleout = false
				RemoveBlip(VehicleSpawnBlip)
				QBCore.Functions.DeleteVehicle(Vehicle)
				Vehicle = nil
				RemoveBlip(PlaceBlip)
				Plate = nil
				RemoveBlip(PlaceDrugBlip)
				RemoveBlip(PlaceDrugBlip2)
				DeleteEntity(DrugObject)
				DeleteEntity(DrugObject2)
				activ = false
				DrugTaken = 0
				DrugTaken2 = 0
				haspackage = false
				haspackage2 = false
				packagetrunk = 0
				JobDone = false
				ClearPedTasks(ped)
				DeleteEntity(pack)
				minus = 0
				RemoveBlip(PlaceDepotPayoutBlip)
				for i, v in pairs(Config.Package) do
					DeleteEntity(v.pack)
				end
				for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
					DeletePed(v.ped)
				end
				Place = nil	
				exports.pNotify:SendNotification({text = "<b>Illegal Transportation</b></br>The mission ended because you died!", timeout = 4000})			
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if Vehicleout then
			sleep = 5
			if not JobDone then
				if(GetDistanceBetweenCoords(coords,Config.Places[Place.name].Pos.x, Config.Places[Place.name].Pos.y, Config.Places[Place.name].Pos.z, false) < 25.0) and not activ then	
					RemoveBlip(PlaceBlip)
					PlaceDrugB()
					activ = true
					for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
						TaskCombatPed(v.ped, ped, 0, 16)
					end
				end
				
				if(GetDistanceBetweenCoords(coords,Config.Places[Place.name].DrugPos.x, Config.Places[Place.name].DrugPos.y, Config.Places[Place.name].DrugPos.z, true) < 1.5) and DrugObject and not (haspackage or haspackage2) then
					DrawMarker(20, Config.Places[Place.name].DrugPos.x, Config.Places[Place.name].DrugPos.y, Config.Places[Place.name].DrugPos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					DrawText3Ds(Config.Places[Place.name].DrugPos.x, Config.Places[Place.name].DrugPos.y, Config.Places[Place.name].DrugPos.z+1.0, 'To take drugs, press [~g~E~w~]')
					if DrugTaken < 2 then
						DrawText3Ds(Config.Places[Place.name].DrugPos.x, Config.Places[Place.name].DrugPos.y, Config.Places[Place.name].DrugPos.z+0.8, '[~r~'..DrugTaken..'~w~/~g~2~w~]')
					end
					if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
						startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
						exports.rprogress:Custom({
							Duration = 1000,
							Label = "You pick drugs...",
							Animation = {
								scenario = "", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "", -- https://alexguirre.github.io/animations-list/
							},
							DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
							}
						})
						Citizen.Wait(1000)
						ClearPedTasks(ped)

						local coordsPED = GetEntityCoords(ped)
						anim = true
						packmodel = math.random(1,2)

						if packmodel == 1 then
							pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01b'), coordsPED.x, coordsPED.y, coordsPED.z,  false,  true, true)
						else
							pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01'), coordsPED.x, coordsPED.y, coordsPED.z,  false,  true, true)
						end
						SetEntityCollision(pack, false)		
						AttachEntityToEntity(pack, ped, GetPedBoneIndex(ped, 57005), 0.25, 0.05, -0.2, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
				

						haspackage = true
						SetVehicleDoorsLocked(Vehicle, 2)

						DrugTaken = DrugTaken + 1
						if DrugTaken >= 2 then
							DeleteEntity(DrugObject)
							DrugObject = nil
							RemoveBlip(PlaceDrugBlip)
							DrugTaken = 0
						end
					end
				elseif(GetDistanceBetweenCoords(coords,Config.Places[Place.name].DrugPos2.x, Config.Places[Place.name].DrugPos2.y, Config.Places[Place.name].DrugPos2.z, true) < 1.5) and DrugObject2 and (not haspackage2 or haspackage) then
					DrawMarker(20, Config.Places[Place.name].DrugPos2.x, Config.Places[Place.name].DrugPos2.y, Config.Places[Place.name].DrugPos2.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, true, true, 2, false, false, false, false)
					DrawText3Ds(Config.Places[Place.name].DrugPos2.x, Config.Places[Place.name].DrugPos2.y, Config.Places[Place.name].DrugPos2.z+1.0, 'To take drugs, press [~g~E~w~]')
					if DrugTaken2 < 2 then
						DrawText3Ds(Config.Places[Place.name].DrugPos2.x, Config.Places[Place.name].DrugPos2.y, Config.Places[Place.name].DrugPos2.z+0.8, '[~r~'..DrugTaken2..'~w~/~g~2~w~]')
					end
					if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
						startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
						exports.rprogress:Custom({
							Duration = 1000,
							Label = "You pick drugs...",
							Animation = {
								scenario = "", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "", -- https://alexguirre.github.io/animations-list/
							},
							DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
							}
						})
						Citizen.Wait(1000)
						ClearPedTasks(ped)

						local coordsPED = GetEntityCoords(ped)
						anim = true
						packmodel = math.random(1,2)

						if packmodel == 1 then
							pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01b'), coordsPED.x, coordsPED.y, coordsPED.z,  false,  true, true)
						else
							pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01'), coordsPED.x, coordsPED.y, coordsPED.z,  false,  true, true)
						end
						SetEntityCollision(pack, false)

						AttachEntityToEntity(pack, ped, GetPedBoneIndex(ped, 57005), 0.25, 0.05, -0.2, 300.0, 250.0, 20.0, true, true, false, true, 1, true)	

						haspackage2 = true
						SetVehicleDoorsLocked(Vehicle, 2)

						DrugTaken2 = DrugTaken2 + 1
						if DrugTaken2 >= 2 then
							DeleteEntity(DrugObject2)
							DrugObject2 = nil
							RemoveBlip(PlaceDrugBlip2)
							DrugTaken2 = 0
						end
					end
				elseif not DrugObject2 and not DrugObject then
					if packagetrunk >= 11 then
						exports.pNotify:SendNotification({text = "<b>Illegal Transportation</b></br>Go back to the payer for the payout!", timeout = 4000})
						PlaceDepotPayoutB()
						while true do
							local sleep = 500
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							if not JobStarted then
								break
							end
							if(GetDistanceBetweenCoords(coords,Config.illegaltransportation['VehicleDepot'].Pos.x, Config.illegaltransportation['VehicleDepot'].Pos.y, Config.illegaltransportation['VehicleDepot'].Pos.z, true) < 1.5) then	
								sleep = 5
								DrawText3Ds(Config.illegaltransportation['VehicleDepot'].Pos.x, Config.illegaltransportation['VehicleDepot'].Pos.y, Config.illegaltransportation['VehicleDepot'].Pos.z+1.0, 'To collect your paycheck, press [~g~G~w~]')
								DrawMarker(25, Config.illegaltransportation['VehicleDepot'].Pos.x, Config.illegaltransportation['VehicleDepot'].Pos.y, Config.illegaltransportation['VehicleDepot'].Pos.z-0.55, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
								DrawMarker(36, Config.illegaltransportation['VehicleDepot'].Pos.x, Config.illegaltransportation['VehicleDepot'].Pos.y, Config.illegaltransportation['VehicleDepot'].Pos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if IsControlJustReleased(0, Keys['G']) and IsPedInAnyVehicle(ped, false) then
									JobStarted = false
									Vehicleout = false
									RemoveBlip(VehicleSpawnBlip)
									QBCore.Functions.DeleteVehicle(Vehicle)
									Vehicle = nil
									RemoveBlip(PlaceBlip)
									Plate = nil
									RemoveBlip(PlaceDrugBlip)
									RemoveBlip(PlaceDrugBlip2)
									DeleteEntity(DrugObject)
									DeleteEntity(DrugObject2)
									activ = false
									DrugTaken = 0
									DrugTaken2 = 0
									haspackage = false
									haspackage2 = false
									packagetrunk = 0
									JobDone = false
									ClearPedTasks(ped)
									DeleteEntity(pack)
									minus = 0
									anim = false
									RemoveBlip(PlaceDepotPayoutBlip)
									for i, v in pairs(Config.Package) do
										DeleteEntity(v.pack)
									end
									for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
										DeletePed(v.ped)
									end
									QBCore.Functions.TriggerCallback('inside-illegaltransportation:payout', function(money)
										exports.pNotify:SendNotification({text = '<b>Illegal Transportation</b></br>You have earned '..money..'$', timeout = 1500})
									end)
									Place = nil
									
									break
								end
							else
								sleep = 5
								DrawMarker(25, Config.illegaltransportation['VehicleDepot'].Pos.x, Config.illegaltransportation['VehicleDepot'].Pos.y, Config.illegaltransportation['VehicleDepot'].Pos.z-0.55, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								DrawMarker(36, Config.illegaltransportation['VehicleDepot'].Pos.x, Config.illegaltransportation['VehicleDepot'].Pos.y, Config.illegaltransportation['VehicleDepot'].Pos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
							end									
							Citizen.Wait(sleep)
						end
					else
						JobDone = true
					end
				end
			elseif JobDone then
				exports.pNotify:SendNotification({text = "<b>Illegal Transportation</b></br>Go to the next place!", timeout = 4000})
				JobDone = false
				Place = Randomize(Config.Randomize)
				PlaceB()
				DrugObject = CreateObject(GetHashKey('hei_prop_heist_weed_pallet'), Config.Places[Place.name].DrugPos.x, Config.Places[Place.name].DrugPos.y, Config.Places[Place.name].DrugPos.z-1, false, true, true)
				PlaceObjectOnGroundProperly(DrugObject)
				FreezeEntityPosition(DrugObject, true)

				DrugObject2 = CreateObject(GetHashKey('hei_prop_heist_weed_pallet'), Config.Places[Place.name].DrugPos2.x, Config.Places[Place.name].DrugPos2.y, Config.Places[Place.name].DrugPos2.z-1, false, true, true)
				PlaceObjectOnGroundProperly(DrugObject2)
				FreezeEntityPosition(DrugObject2, true)	
				activ = false
				
				for i, v in pairs(Config.Places[Place.name].Peds['Peds']) do
					local ped_hash = GetHashKey('g_m_m_mexboss_01')
					RequestModel(ped_hash)
					while not HasModelLoaded(ped_hash) do
						Citizen.Wait(1)
					end

					v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.5, 0.0, false, true)
					v.blip = AddBlipForEntity(v.ped)
					SetBlipScale(v.blip, 0.6)
					SetEntityHeading(v.ped, v.h)
					SetPedFleeAttributes(v.ped, 0, 0)
					SetPedCombatAttributes(v.ped, 46, 1)
					SetPedCombatAbility(v.ped, 100)
					SetPedCombatMovement(v.ped, 2)
					SetPedCombatRange(v.ped, 2)
					SetPedKeepTask(v.ped, true)
					GiveWeaponToPed(v.ped, GetHashKey('weapon_pistol'),250,false,true)
					SetPedAsCop(v.ped, true)
					SetPedDropsWeaponsWhenDead(v.ped, false)
				end
			end		
		end
		Citizen.Wait(sleep)
	end
end)

function DrawText2Ds(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0.0, 0.0, 0.0, 0.0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

Citizen.CreateThread(function()
	local doo = 0
	while true do
		sleep = 500
		if anim then
			sleep = 0
			RequestAnimDict('anim@heists@box_carry@')
			while not HasAnimDictLoaded('anim@heists@box_carry@') do
			  Citizen.Wait(0)
			end
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle' ,8.0, -8.0, -1, 49, 0, false, false, false)
			doo = doo + 1 
			if doo >= 3 then
				doo = 0
				anim = false
			end
		end			
		Citizen.Wait(sleep)
	end
end)

function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 49, 0, false, false, false)
	end)
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
