QBCore = nil
CurrentAction     = nil
CurrentActionMsg  = nil
CurrentActionData = nil
Licenses          = {}
CurrentTest       = nil
CurrentTestType   = nil
CurrentVehicle    = nil
CurrentCheckPoint, DriveErrors = 0, 0
LastCheckPoint    = -1
CurrentBlip       = nil
CurrentZoneType   = nil
IsAboveSpeedLimit = false
LastVehicleHealth = nil

Citizen.CreateThread(function()
	while QBCore == nil do
		QBCore = exports['qb-core']:GetCoreObject()
		Citizen.Wait(200)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if CurrentTest == 'theory' then
			local playerPed = PlayerPedId()
			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(500)
		end
	end
end)

-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'drive' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil
				QBCore.Functions.Notify("Driving test completed!",'success')
				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'drive' then
			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true
							QBCore.Functions.Notify("You're driving too fast, the current speed limit is: " .. v .. " mph!",'error')
							QBCore.Functions.Notify("Mistakes: " .. DriveErrors .. " / " .. Config.MaxErrors,'error')
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1
					QBCore.Functions.Notify("You damaged the vehicle!",'error')
					QBCore.Functions.Notify("Mistakes: " .. DriveErrors .. " / " .. Config.MaxErrors,'error')

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("qb-dmvschool:client:startexam")
AddEventHandler("qb-dmvschool:client:startexam", function()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local closestsit = GetClosestObjectOfType(pos.x, pos.y, pos.z, 3.0, GetHashKey('p_cs_laptop_02'), 0, 0, 0)
	local sitcoords = GetEntityCoords(closestsit)
	local distanceDiff = #(sitcoords - pos)
	if (distanceDiff < 3.0 and closestsit ~= 0) then
		FreezeEntityPosition(ped, true)
		SetEntityCoords(ped, sitcoords.x, sitcoords.y, sitcoords.z + 0.5)
		SetEntityHeading(ped, GetEntityHeading(closestsit) - 180.0)
		local fw = GetEntityForwardVector(closestsit)
		TaskStartScenarioAtPosition(ped, 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER',sitcoords.x-fw.x*1.1,sitcoords.y-fw.y*1.1,sitcoords.z-0.3,GetEntityHeading(closestsit), 0, true, true)
		Wait(2200)
		StartTheoryTest()
	end
end)

RegisterNetEvent("qb-dmvschool:client:starttest")
AddEventHandler("qb-dmvschool:client:starttest", function(type)
	StartDriveTest(type)
end)

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})
	cb()
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb()
end)


RegisterNUICallback("updatestatus",function(data)
    local id, status, cid, type = data["id"], data["status"], data["cid"], data["type"] 
    TriggerServerEvent("qb-dmvschool:updatelicenses", id, status)
    TriggerServerEvent("qb-dmvschool:addLicense", cid, type, status)
    updatePanel()
end)



RegisterNUICallback(
    "closem",
    function(data)
        TriggerScreenblurFadeOut(1000)
        SetNuiFocus(false, false)
    end
)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)


RegisterNetEvent('qb-dmvschool:loadLicenses')
AddEventHandler('qb-dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

Citizen.CreateThread(function()
	local laptops = {
		[1] = vector3(-812.33, -1354.49, 8.57),
		[2] = vector3(-812.85, -1355.71, 8.57),
		[3] = vector3(-814.92, -1353.48, 8.57),
		[4] = vector3(-815.42, -1354.64, 8.57),
		[5] = vector3(-810.89, -1351.62, 8.57),
		[6] = vector3(-809.85, -1350.55, 8.57),
		[7] = vector3(-812.12, -1348.72, 8.57),
		[8] = vector3(-812.95, -1349.75, 8.57),
		[9] = vector3(-808.66, -1346.31, 8.57),
		[10] = vector3(-807.61, -1345.6, 8.57),
		[11] = vector3(-806.12, -1348.08, 8.57),
		[12] = vector3(-807.28, -1348.72, 8.57)
	}
	for k,v in pairs(laptops) do
		local closestsit = GetClosestObjectOfType(v.x, v.y,v.z, 2.0, GetHashKey('p_cs_laptop_02'), 0, 0, 0)
		local sitcoords = GetEntityCoords(closestsit)
		local fw = GetEntityForwardVector(closestsit)
		local obj = CreateObject(GetHashKey('gr_prop_gr_chair02_ped'), sitcoords.x-fw.x*1.1,sitcoords.y-fw.y*1.1,sitcoords.z-0.8, false, true, true)
		SetEntityHeading(obj, GetEntityHeading(closestsit) - 180.0)
		FreezeEntityPosition(obj, true)
		-- Wait(5000)
		-- DeleteObject(obj)
	end


	local models = {
	  'p_cs_laptop_02',
	}
	exports['qb-target']:AddTargetModel(models, {
		options = {
		  {
			type = "server",
			event = "qb-dmvschool:server:startexam",
			icon = 'fas fa-laptop',
			label = 'Driving Exam',
			targeticon = 'fas fa-eye',
			canInteract = function(entity)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -809.86, -1349.21, 8.57, true) < 50.0 then
					return true
				else
					return false 
				end
			end,
		  }
		},
		distance = 2.5,
	  }
	)

	local pedModel = GetHashKey('cs_paper')                            
	RequestModel(pedModel)
	while not HasModelLoaded(pedModel) do
		RequestModel(pedModel)
		Wait(100)
	end

	local createdPed = CreatePed(5, pedModel, vector3(-809.43, -1353.27, 5.15- 1.0), 44.66, false, false)
	ClearPedTasks(createdPed)
	ClearPedSecondaryTask(createdPed)
	TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
	SetPedFleeAttributes(createdPed, 0, 0)
	SetPedCombatAttributes(createdPed, 17, 1)

	SetPedSeeingRange(createdPed, 0.0)
	SetPedHearingRange(createdPed, 0.0)
	SetPedAlertness(createdPed, 0)
	SetPedKeepTask(createdPed, true)
	Wait(750) -- for better freeze (not in air)
	FreezeEntityPosition(createdPed, true)
	SetEntityInvincible(createdPed, true)
	exports['qb-target']:AddTargetModel('cs_paper', {
		options = {
			{
				type = "server",
				event = "qb-dmvschool:server:starttest",
				icon = "fas fa-motorcycle",
				label = "Bike Driving Test",
				dtype = "drive_bike"
			},
			{
				type = "server",
				event = "qb-dmvschool:server:starttest",
				icon = "fas fa-car",
				label = "Car Driving Test",
				dtype = "drive"
			},
			{
				type = "server",
				event = "qb-dmvschool:server:starttest",
				icon = "fas fa-truck",
				label = "Truck Driving Test",
				dtype = "drive_truck"
			}
		},
		distance = 3,
	})

	exports['qb-target']:AddBoxZone("name", vector3(-803.50, -1352.70, 5.02), 0.5, 0.5, { 
		name = "dmvjob", 
		heading = 142.55, 
		debugPoly = false, 
		minZ = 4.8, 
		maxZ = 5.4,
		}, {
		options = {
			{
				type = "client",
				event = "qb-dmvschool:openpanel",
				icon = 'fas fa-laptop',
				label = 'Check Database',
				targeticon = 'fas fa-eye',
				job = "dmv",
			}
		},
		distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
  })	
end)


RegisterCommand("ff", function(source, args, rawCommand)
	openPanel()
end, false)



function updatePanel()
    Citizen.Wait(100)
    QBCore.Functions.TriggerCallback("qb-dmvschool:updateInfo",function(applications)
		SendNUIMessage({
			type = "update",
			applications = applications,
		})
	end)
end

RegisterNetEvent("qb-dmvschool:openpanel")
AddEventHandler("qb-dmvschool:openpanel", function()
    openPanel()
end)

function openPanel()
	QBCore.Functions.TriggerCallback("qb-dmvschool:getUsers",function(users)
		local x, y = GetScreenResolution()
		SetNuiFocus(true, true)
		SendNUIMessage({
			type = "open",
			users = users,
			identifier = QBCore.Functions.GetPlayerData().citizenid
		})
		updatePanel()
	end)
end
