DrawMissionText = function(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

StartTheoryTest = function()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})
    
    SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
	TriggerServerEvent('qb-dmvschool:pay', Config.Prices['dmv'])
end

StopTheoryTest = function(success)
	CurrentTest = nil
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SendNUIMessage({
		openQuestion = false
	})
	SetNuiFocus(false)
	if success then
		TriggerServerEvent('qb-dmvschool:server:completeexam', 'dmv')
	else
		QBCore.Functions.Notify('You failed the test, better luck next time', 'error')
	end
end


StartDriveTest = function(type)
	SpawnVehicle(Config.VehicleModels[type], Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'drive'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		local plate = GetVehicleNumberPlateText(vehicle)
		TriggerServerEvent('garage:addKeys', plate)
		exports["LegacyFuel"]:SetFuel(vehicle, 100)
	end)

	TriggerServerEvent('qb-dmvschool:pay', Config.Prices[type])
end

StopDriveTest = function(success)
	if success then
		TriggerServerEvent('qb-dmvschool:createapplication', CurrentTestType, DriveErrors)
		QBCore.Functions.Notify("You passed the test, congratulations!",'success')
	else
		QBCore.Functions.Notify("You failed the test, better luck next time!",'error')
	end
	CurrentTest     = nil
	CurrentTestType = nil
end

SetCurrentZoneType = function(type)
	CurrentZoneType = type
end


-- Create Blip
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z)
	SetBlipSprite (blip, 408)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('driving_school_blip'))
	EndTextCommandSetBlipName(blip)
end)

-- Spawn Driving Vehicle
SpawnVehicle = function(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))
	LoadModel(model)
	local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
	local id      = NetworkGetNetworkIdFromEntity(vehicle)
	SetNetworkIdCanMigrate(id, true)
	SetEntityAsMissionEntity(vehicle, true, false)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	SetVehicleNeedsToBeHotwired(vehicle, false)
	SetModelAsNoLongerNeeded(model)
	SetVehRadioStation(vehicle, 'OFF')
	cb(vehicle)
end

function LoadModel(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
end
