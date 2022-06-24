QBCore = nil

QBCore = exports['qb-core']:GetCoreObject()

--------------------------------------------------------------------------------
local PlayerData = {}
local HasOrder,FirstOrder,SecondOrderPayout,ThirdOrderPayout,PayoutForSeventhOrder = false,false,false,false,false
local number,FirstOrderBlip,Plate = nil,nil,nil
local Vehicle

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

Citizen.CreateThread(function()
	local ped_hash = GetHashKey(Config.illegalorders['BossSpawn'].Type)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossNPC = CreatePed(1, ped_hash, Config.illegalorders['BossSpawn'].Pos.x, Config.illegalorders['BossSpawn'].Pos.y, Config.illegalorders['BossSpawn'].Pos.z, Config.illegalorders['BossSpawn'].Pos.h, false, true)
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
		local coordsNPC = GetEntityCoords(BossNPC)	
		if(GetDistanceBetweenCoords(coords,Config.illegalorders['BossSpawn'].Pos.x, Config.illegalorders['BossSpawn'].Pos.y, Config.illegalorders['BossSpawn'].Pos.z, true) < 5.5) then	
			sleep = 5
			if(GetDistanceBetweenCoords(coords,Config.illegalorders['BossSpawn'].Pos.x, Config.illegalorders['BossSpawn'].Pos.y, Config.illegalorders['BossSpawn'].Pos.z, true) < 1.5) then
				if not HasOrder then
					DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z+1.0, 'To talk to the boss, press [~g~E~w~]')
				elseif HasOrder and (SecondOrderPayout or ThirdOrderPayout or PayoutForSeventhOrder) then
					DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z+1.0, 'To collect your paycheck, press [~g~E~w~]')
				end
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not HasOrder then
					HasOrder = true
					Order = Randomize(Config.Orders)
					Orders()
				elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and SecondOrderPayout then
					QBCore.Functions.TriggerCallback('inside-illegalordersType2:payout', function(money)
						exports.pNotify:SendNotification({text = "<b>Boss</b></br>Fuck thanks, here's your payment "..money.."$", timeout = 4500})
					end)
					HasOrder = false
					SecondOrderPayout = false
					number = nil
					Vehicle = nil
				elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and ThirdOrderPayout then
					QBCore.Functions.TriggerCallback('inside-illegalordersType3:payout', function(money)
						exports.pNotify:SendNotification({text = "<b>Boss</b></br>Fuck thanks, here's your payment "..money.."$", timeout = 4500})
					end)
					HasOrder = false
					ThirdOrderPayout = false
					number = nil
					Vehicle = nil
				elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and PayoutForSeventhOrder then
					QBCore.Functions.TriggerCallback('inside-illegalordersType7:payout', function(money)
						exports.pNotify:SendNotification({text = "<b>Boss</b></br>Fuck thanks, here's your payment "..money.."$", timeout = 4500})
					end)
					HasOrder = false
					PayoutForSeventhOrder = false
					number = nil
					Vehicle = nil
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- function AskAgain()
-- 	if Order.name == 'first' then
-- 		exports.pNotify:SendNotification({text = "<b>Boss</b></br>Someone's fucked up my car, bring it to me", timeout = 4500})
-- 	elseif Order.name == 'second' then
-- 		exports.pNotify:SendNotification({text = "<b>Boss</b></br>Some loser is selling drugs without my permission, take them from him", timeout = 4500})
-- 	end
-- end

function Orders()
	local ped = PlayerPedId()
	if Order.name == 'first' then
		exports.pNotify:SendNotification({text = "<b>Boss Car</b></br>Someone's fucked up my car, bring it to me", timeout = 4500})
		number = math.random(1,#Config.FirstOrder['CarSpawn'])
		FirstOrderBlip = AddBlipForCoord(Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z)	
		SetBlipSprite (FirstOrderBlip, 1)
		SetBlipDisplay(FirstOrderBlip, 4)
		SetBlipScale  (FirstOrderBlip, 1.0)
		SetBlipColour (FirstOrderBlip, 0)
		SetBlipAsShortRange(FirstOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('The boss vehicle')
		EndTextCommandSetBlipName(FirstOrderBlip)		
		Citizen.CreateThread(function()
			while true do
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				if(GetDistanceBetweenCoords(coords,Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z, true) < 50.0) then
					QBCore.Functions.SpawnVehicle(Config.FirstOrder['CarSpawn'][number].Type, function(vehicle)
						SetEntityHeading(vehicle, Config.FirstOrder['CarSpawn'][number].Pos.h)
						Vehicle = vehicle
						SetVehicleNumberPlateText(vehicle, "BOSS"..tostring(math.random(100, 999)))
						Plate = GetVehicleNumberPlateText(vehicle)
						TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
						for i, v in pairs(Config.FirstOrder['CarSpawn'][number].Peds['Peds']) do
							local ped_hash = GetHashKey('g_m_m_mexboss_01')
							RequestModel(ped_hash)
							while not HasModelLoaded(ped_hash) do
								Citizen.Wait(1)
							end
							v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.5, 0.0, false, true)
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
						FirstOrder()
					end, vector3(Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z))
					break
				end					
				Citizen.Wait(5)
			end
		end)	
	elseif Order.name == 'second' then
		exports.pNotify:SendNotification({text = "<b>Boss Drugs</b></br>Some loser is selling drugs without my permission, take them from him", timeout = 4500})
		number = math.random(1,#Config.SecondOrder['PedSpawn'])
		SecondOrderBlip = AddBlipForCoord(Config.SecondOrder['PedSpawn'][number].Pos.x, Config.SecondOrder['PedSpawn'][number].Pos.y, Config.SecondOrder['PedSpawn'][number].Pos.z)	
		SetBlipSprite (SecondOrderBlip, 1)
		SetBlipDisplay(SecondOrderBlip, 4)
		SetBlipScale  (SecondOrderBlip, 1.0)
		SetBlipColour (SecondOrderBlip, 0)
		SetBlipAsShortRange(SecondOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Dealer')
		EndTextCommandSetBlipName(SecondOrderBlip)	
		
		local ped_hash = GetHashKey(Config.SecondOrder['PedSpawn'][number].Type)
		RequestModel(ped_hash)
		while not HasModelLoaded(ped_hash) do
			Citizen.Wait(1)
		end
		DealerPed = CreatePed(1, ped_hash, Config.SecondOrder['PedSpawn'][number].Pos.x, Config.SecondOrder['PedSpawn'][number].Pos.y, Config.SecondOrder['PedSpawn'][number].Pos.z-0.5, 0.0, false, true)	
		SetEntityHeading(DealerPed, Config.SecondOrder['PedSpawn'][number].Pos.h)
		SetBlockingOfNonTemporaryEvents(DealerPed, true)
		SetPedCanPlayAmbientAnims(DealerPed, true)
		SetPedCanRagdollFromPlayerImpact(DealerPed, false)
		SetEntityInvincible(DealerPed, true)
		startAnim(DealerPed, "amb@world_human_cop_idles@female@idle_b", "idle_d")
		FreezeEntityPosition(DealerPed, true)
		SecondOrder()
	elseif Order.name == 'third' then
		exports.pNotify:SendNotification({text = "<b>Boss Murder</b></br>There is some influential man in town, kill him for me", timeout = 4500})
		number = math.random(1,#Config.ThirdOrder['PedSpawn'])

		ThirdBlipp = AddBlipForCoord(Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z)	
		SetBlipSprite (ThirdBlipp, 1)
		SetBlipDisplay(ThirdBlipp, 4)
		SetBlipScale  (ThirdBlipp, 1.0)
		SetBlipColour (ThirdBlipp, 0)
		SetBlipAsShortRange(ThirdBlipp, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Important person')
		EndTextCommandSetBlipName(ThirdBlipp)
		while true do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords,Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z, true) < 50.0) then
				RemoveBlip(ThirdBlipp)
				QBCore.Functions.SpawnVehicle(Config.ThirdOrder['PedSpawn'][number].Car, function(vehicle)
					SetEntityHeading(vehicle, Config.ThirdOrder['PedSpawn'][number].Pos.h)
					local ped_hash = GetHashKey(Config.ThirdOrder['PedSpawn'][number].Type)
					RequestModel(ped_hash)
					while not HasModelLoaded(ped_hash) do
						Citizen.Wait(1)
					end
					Vehicle = vehicle
					DealerPed = CreatePed(1, ped_hash, Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z+1.0, 0.0, false, true)
					SetPedIntoVehicle(DealerPed, vehicle, -1)
					TaskVehicleDriveWander(DealerPed, vehicle, 25.0, 1)
					ThirdOrderBlip = AddBlipForEntity(DealerPed)
					SetBlipSprite (ThirdOrderBlip, 1)
					SetBlipDisplay(ThirdOrderBlip, 4)
					SetBlipScale  (ThirdOrderBlip, 1.0)
					SetBlipColour (ThirdOrderBlip, 0)
					SetBlipAsShortRange(ThirdOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Important person')
					EndTextCommandSetBlipName(ThirdOrderBlip)
					TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						if IsPedDeadOrDying(DealerPed, 1) then
							exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>Now go to the boss", timeout = 4500})
							RemoveBlip(ThirdOrderBlip)
							Citizen.Wait(3000)
							DeletePed(DealerPed)
							ThirdOrderPayout = true
							break
						end
						Citizen.Wait(5)
					end										
				end, vector3(Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z))
				break
			end					
			Citizen.Wait(5)
		end				
	elseif Order.name == 'fourth' then
		exports.pNotify:SendNotification({text = "<b>Boss Delivery</b></br>I have goods to deliver, please do it for me", timeout = 4500})
		number = math.random(1,#Config.FourthOrder['CarSpawn'])	
		FourthBlipp = AddBlipForCoord(Config.FourthOrder['CarSpawn'][number].Pos.x, Config.FourthOrder['CarSpawn'][number].Pos.y, Config.FourthOrder['CarSpawn'][number].Pos.z)	
		SetBlipSprite (FourthBlipp, 1)
		SetBlipDisplay(FourthBlipp, 4)
		SetBlipScale  (FourthBlipp, 1.0)
		SetBlipColour (FourthBlipp, 0)
		SetBlipAsShortRange(FourthBlipp, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Delivery vehicle')
		EndTextCommandSetBlipName(FourthBlipp)
		while true do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].Pos.x, Config.FourthOrder['CarSpawn'][number].Pos.y, Config.FourthOrder['CarSpawn'][number].Pos.z, true) < 50.0) then
				RemoveBlip(FourthBlipp)
				QBCore.Functions.SpawnVehicle(Config.FourthOrder['CarSpawn'][number].Car, function(vehicle)
					SetEntityHeading(vehicle, Config.FourthOrder['CarSpawn'][number].Pos.h)
					Vehicle = vehicle
					FourthOrderBlip = AddBlipForEntity(vehicle)
					SetBlipSprite (FourthOrderBlip, 1)
					SetBlipDisplay(FourthOrderBlip, 4)
					SetBlipScale  (FourthOrderBlip, 1.0)
					SetBlipColour (FourthOrderBlip, 0)
					SetBlipAsShortRange(FourthOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Delivery vehicle')
					EndTextCommandSetBlipName(FourthOrderBlip)
		
					SetVehicleNumberPlateText(vehicle, "BOSS"..tostring(math.random(100, 999)))
					Plate = GetVehicleNumberPlateText(vehicle)
					TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
					while true do
						local sleep = 250
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						if IsPedInAnyVehicle(ped, false) then
							local vehicle2 = GetVehiclePedIsIn(GetPlayerPed(-1), true)
							if GetVehicleNumberPlateText(vehicle2) == Plate then
								RemoveBlip(FourthOrderBlip)
		
								FourthOrderBlip = AddBlipForCoord(Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z)	
								SetBlipSprite (FourthOrderBlip, 1)
								SetBlipDisplay(FourthOrderBlip, 4)
								SetBlipScale  (FourthOrderBlip, 1.0)
								SetBlipColour (FourthOrderBlip, 0)
								SetBlipAsShortRange(FourthOrderBlip, true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Delivery point')
								EndTextCommandSetBlipName(FourthOrderBlip)
		
								exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>Take the vehicle to the unloading point", timeout = 4500})
								FourthOrder()
								break
							end
						end
						Citizen.Wait(sleep)
					end
				end, vector3(Config.FourthOrder['CarSpawn'][number].Pos.x, Config.FourthOrder['CarSpawn'][number].Pos.y, Config.FourthOrder['CarSpawn'][number].Pos.z))
				break
			end		
			Citizen.Wait(5)
		end		
	elseif Order.name == 'fifth' then
		exports.pNotify:SendNotification({text = "<b>Boss Rob</b></br>Someone tricked me, rob his shop", timeout = 4500})
		number = math.random(1,#Config.FifthOrder['PedSpawn'])

		local ped_hash = GetHashKey(Config.FifthOrder['PedSpawn'][number].Type)
		RequestModel(ped_hash)
		while not HasModelLoaded(ped_hash) do
			Citizen.Wait(1)
		end			

		StorePed = CreatePed(1, ped_hash, Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z-0.5, 0.0, false, true)	
		SetEntityHeading(StorePed, Config.FifthOrder['PedSpawn'][number].Pos.h)
		SetBlockingOfNonTemporaryEvents(StorePed, true)
		SetPedCanPlayAmbientAnims(StorePed, true)
		SetPedCanRagdollFromPlayerImpact(StorePed, false)
		SetEntityInvincible(StorePed, true)
		startAnim(StorePed, "amb@world_human_cop_idles@female@idle_b", "idle_d")
		FreezeEntityPosition(StorePed, true)

		FifthOrderBlip = AddBlipForCoord(Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z)	
		SetBlipSprite (FifthOrderBlip, 1)
		SetBlipDisplay(FifthOrderBlip, 4)
		SetBlipScale  (FifthOrderBlip, 1.0)
		SetBlipColour (FifthOrderBlip, 0)
		SetBlipAsShortRange(FifthOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Shop to be robbed')
		EndTextCommandSetBlipName(FifthOrderBlip)	

		FifthOrder()
	elseif Order.name == 'sixth' then
		exports.pNotify:SendNotification({text = "<b>Boss Arson</b></br>You have to burn down one building for me", timeout = 4500})
		number = math.random(1,#Config.SixthOrder['Place'])

		SixthOrderBlip = AddBlipForCoord(Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z)	
		SetBlipSprite (SixthOrderBlip, 1)
		SetBlipDisplay(SixthOrderBlip, 4)
		SetBlipScale  (SixthOrderBlip, 1.0)
		SetBlipColour (SixthOrderBlip, 0)
		SetBlipAsShortRange(SixthOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Necessary things to set on fire')
		EndTextCommandSetBlipName(SixthOrderBlip)	

		SixthOrder()
	elseif Order.name == 'seventh' then
		exports.pNotify:SendNotification({text = "<b>Boss Important papers</b></br>You need to take important papers for me, but stop the alarm", timeout = 4500})
		number = math.random(1,#Config.SeventhOrder['Place'])

		SeventhOrderBlip = AddBlipForCoord(Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z)	
		SetBlipSprite (SeventhOrderBlip, 1)
		SetBlipDisplay(SeventhOrderBlip, 4)
		SetBlipScale  (SeventhOrderBlip, 1.0)
		SetBlipColour (SeventhOrderBlip, 0)
		SetBlipAsShortRange(SeventhOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Turn off the alarm')
		EndTextCommandSetBlipName(SeventhOrderBlip)	

		SeventhOrder()
	end
end

function FirstOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 5
			if(GetDistanceBetweenCoords(coords,Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z, true) < 10.5) then
				for i, v in pairs(Config.FirstOrder['CarSpawn'][number].Peds['Peds']) do
					TaskCombatPed(v.ped, ped, 0, 16)
				end
			end
			if IsPedInAnyVehicle(ped, false) then
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
				if GetVehicleNumberPlateText(vehicle) == Plate then
					exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>Now go to the boss", timeout = 4500})
					RemoveBlip(FirstOrderBlip)
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep2 = 500
							if(GetDistanceBetweenCoords(coords,Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z, true) < 25.0) then
								sleep2 = 0
								DrawMarker(25, Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z-0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z, true) < 2.0) then
									DrawText3Ds(Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z+1.4, 'To return the vehicle, press [~g~E~w~]')
									if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
										local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
										if GetVehicleNumberPlateText(vehicle) == Plate then
											QBCore.Functions.DeleteVehicle(vehicle)
											QBCore.Functions.TriggerCallback('inside-illegalordersType1:payout', function(money)
												exports.pNotify:SendNotification({text = "<b>Boss</b></br>Fuck thanks, here's your payment "..money.."$", timeout = 4500})
											end)
											Vehicle = nil
											for i, v in pairs(Config.FirstOrder['CarSpawn'][number].Peds['Peds']) do
												DeletePed(v.ped)
											end
											Plate = nil
											number = nil
											HasOrder = false
											break
										end
									end
								end
							end
						Citizen.Wait(sleep2)
					end
					break
				end
			end
		Citizen.Wait(sleep)
	end
end

function SecondOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local coordsNPC = GetEntityCoords(DealerPed)
		local sleep = 5
		local frezze = true
		if(GetDistanceBetweenCoords(coords, Config.SecondOrder['PedSpawn'][number].Pos.x, Config.SecondOrder['PedSpawn'][number].Pos.y, Config.SecondOrder['PedSpawn'][number].Pos.z, true) < 5.5) and frezze then
			FreezeEntityPosition(DealerPed, false)
			frezze = false
		end
		if(GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
			local text = true
			if text then
				DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.2, "Take the drugs, press [~g~E~w~]")
			end
			if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
				text = false
				TaskTurnPedToFaceEntity(DealerPed, PlayerPedId(), 0.2)	
				startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
				exports.rprogress:Custom({
					Duration = 3000,
					Label = "Taking drugs...",
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
				Citizen.Wait(3000)
				ClearPedTasks(ped)
				ClearPedTasks(DealerPed)
				TaskGoToCoordAnyMeans(DealerPed, Config.SecondOrder['PedSpawn'][number].Pos.x+5, Config.SecondOrder['PedSpawn'][number].Pos.y+5, Config.SecondOrder['PedSpawn'][number].Pos.z, 1.3)
				exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>Now go to the boss", timeout = 4500})
				SecondOrderPayout = true
				RemoveBlip(SecondOrderBlip)
				local displaying = true
				Citizen.CreateThread(function()
					Wait(3000)
					displaying = false
				end)
				inspection = true
				while displaying do
					Wait(0)
					local coordsPed = GetEntityCoords(DealerPed, false)
					local coords = GetEntityCoords(PlayerPedId(), false)
					local dist = Vdist2(coordsPed, coords)
					if dist < 150 then                
						DrawText3Ds(coordsPed['x'], coordsPed['y'], coordsPed['z'] + 1.2, "Fuck you")
					end
				end	
				Citizen.Wait(3000)
				DeletePed(DealerPed)
				break
			end
		end
	Citizen.Wait(sleep)
	end
end

function ThirdOrder()
	--Done in the orders function
end

function FourthOrder()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 10.5) then
			sleep = 5
			if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 5.5) then
				DrawMarker(2, Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 2.5) then
					DrawText3Ds(Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z+1.0, 'To deliver the vehicle, press [~g~E~w~]')
					if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
						local vehicle2 = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if GetVehicleNumberPlateText(vehicle2) == Plate then
							RemoveBlip(FourthOrderBlip)
							Plate = nil
							number = nil
							HasOrder = false
							QBCore.Functions.TriggerCallback('inside-illegalordersType4:payout', function(money)
								exports.pNotify:SendNotification({text = "<b>Boss</b></br>Fuck thanks, here's your payment "..money.."$", timeout = 4500})
							end)
							FreezeEntityPosition(Vehicle)
							TaskLeaveVehicle(ped, Vehicle)
							SetVehicleDoorShut(Vehicle)
							Citizen.Wait(3000)
							DeleteVehicle(Vehicle)
							Vehicle = nil
							break
						else 
							exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>This is not a delivery vehicle", timeout = 4500})
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end

function FifthOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		local block = false
		if(GetDistanceBetweenCoords(coords,Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z, true) < 5.5) and not block then
			block = true
			FreezeEntityPosition(StorePed, false)	
			SetBlockingOfNonTemporaryEvents(StorePed, false)
			SetPedCanPlayAmbientAnims(StorePed, false)
			SetPedCanRagdollFromPlayerImpact(StorePed, true)
			SetEntityInvincible(StorePed, false)	
		end
		if(GetDistanceBetweenCoords(coords,Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z, true) < 10.5) then
			sleep = 5
			if IsPlayerFreeAiming(PlayerId()) then
				local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
				if IsPedFleeing(targetPed) and targetPed == StorePed then
					startAnim(StorePed, 'anim@mp_player_intuppersurrender', 'enter')
					local displaying = true
					Citizen.CreateThread(function()
						Wait(3000)
						displaying = false
					end)
					while displaying do
						Wait(0)
						local coordsPed = GetEntityCoords(StorePed, false)             
						DrawText3Ds(coordsPed['x'], coordsPed['y'], coordsPed['z'] + 1.2, "Take anything you want")
					end	
					exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>Steal the cash", timeout = 4500})
					RemoveBlip(FifthOrderBlip)
					FifthOrderBlip = AddBlipForCoord(Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z)	
					SetBlipSprite (FifthOrderBlip, 1)
					SetBlipDisplay(FifthOrderBlip, 4)
					SetBlipScale  (FifthOrderBlip, 0.6)
					SetBlipColour (FifthOrderBlip, 0)
					SetBlipAsShortRange(FifthOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Cash')
					EndTextCommandSetBlipName(FifthOrderBlip)						
					while true do
						local ped2 = PlayerPedId()
						local coords3 = GetEntityCoords(ped2)
						if(GetDistanceBetweenCoords(coords3,Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z, true) < 6.5) then
							DrawMarker(25, Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
							if(GetDistanceBetweenCoords(coords3,Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z, true) < 1.5) then
								DrawText3Ds(Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z+1.4, 'To rob, press [~g~E~w~]')
								if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
									SetEntityHeading(ped2, Config.FifthOrder['PedSpawn'][number].PosToRob.h)
									startAnim(ped2, "anim@gangops@facility@servers@bodysearch@", "player_search")
									exports.rprogress:Custom({
										Duration = 3000,
										Label = "Robbing...",
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
									Citizen.Wait(3000)
									QBCore.Functions.TriggerCallback('inside-illegalordersType5:payout', function(money)
										exports.pNotify:SendNotification({text = "<b>Boss</b></br>Fuck thanks, here's your payment "..money.."$", timeout = 4500})
									end)
									Vehicle = nil
									ClearPedTasks(ped2)
									RemoveBlip(FifthOrderBlip)	
									number = nil
									HasOrder = false
									Citizen.Wait(3000)
									DeletePed(StorePed)
									break
								end
							end
						end
						Citizen.Wait(5)
					end
					break
				end
			end
		end
		Citizen.Wait(sleep)
	end
end

function SixthOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z, true) < 10.5) then
			sleep = 5
			DrawMarker(25, Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z, true) < 1.5) then
				DrawText3Ds(Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z+1.4, 'To take items to set fire to a building, press [~g~E~w~]')
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
					SetEntityHeading(ped, Config.SixthOrder['Place'][number].Pos.h)
					startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
					exports.rprogress:Custom({
						Duration = 3000,
						Label = "Taking Necessary things...",
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
					Citizen.Wait(3000)
					ClearPedTasks(ped)
					exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>Now go to the designated building", timeout = 4500})
					RemoveBlip(SixthOrderBlip)

					SixthOrderBlip = AddBlipForCoord(Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z)	
					SetBlipSprite (SixthOrderBlip, 1)
					SetBlipDisplay(SixthOrderBlip, 4)
					SetBlipScale  (SixthOrderBlip, 1.0)
					SetBlipColour (SixthOrderBlip, 0)
					SetBlipAsShortRange(SixthOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Place to set on fire')
					EndTextCommandSetBlipName(SixthOrderBlip)					
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep = 500
							if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z, true) < 10.5) then
								sleep = 5
								DrawMarker(25, Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z, true) < 1.5) then
									DrawText3Ds(Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z+1.4, 'To set it on fire, press [~g~E~w~]')
									if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
										startAnim(ped, "weapon@w_sp_jerrycan", "fire")
										exports.rprogress:Custom({
											Duration = 3000,
											Label = "Fire!...",
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
										Citizen.Wait(3000)
										RemoveBlip(SixthOrderBlip)
										ClearPedTasks(ped)
										exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>You set it on fire, run away", timeout = 4500})	
										Citizen.Wait(4000)
										currentFires = {}
										fire = StartScriptFire(Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z+0.20, 24, false)
										table.insert(currentFires, fire)
										QBCore.Functions.TriggerCallback('inside-illegalordersType6:payout', function(money)
											exports.pNotify:SendNotification({text = "<b>Boss</b></br>Thanks, here's your payment "..money.."$", timeout = 4500})
										end)
										Vehicle = nil
										number = nil
										HasOrder = false
										StopFire()
										break
									end
								end
							end
						Citizen.Wait(sleep)
					end
					break
				end
			end
		end
		Citizen.Wait(sleep)			
	end
end

function SeventhOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z, true) < 10.5) then
			sleep = 5
			DrawMarker(25, Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z, true) < 1.5) then
				DrawText3Ds(Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z+1.4, 'To turn off the electricity, press [~g~E~w~]')
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
					SetEntityHeading(ped, Config.SeventhOrder['Place'][number].Pos.h)
					startAnim(ped, "mini@repair", "fixing_a_ped")
					exports.rprogress:Custom({
						Duration = 5000,
						Label = "Power off...",
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
					Citizen.Wait(5000)
					RemoveBlip(SeventhOrderBlip)
					exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>The electricity is off, go take papers", timeout = 4500})
					SeventhOrderBlip = AddBlipForCoord(Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z)	
					SetBlipSprite (SeventhOrderBlip, 1)
					SetBlipDisplay(SeventhOrderBlip, 4)
					SetBlipScale  (SeventhOrderBlip, 1.0)
					SetBlipColour (SeventhOrderBlip, 0)
					SetBlipAsShortRange(SeventhOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Papers')
					EndTextCommandSetBlipName(SeventhOrderBlip)	
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep = 500
							if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z, true) < 10.5) then
								sleep = 5
								DrawMarker(25, Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z, true) < 1.5) then
									DrawText3Ds(Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z+1.4, 'To look for papers, press [~g~E~w~]')
									if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then	
										SetEntityHeading(ped, Config.SeventhOrder['Place'][number].PosTake.h)
										startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
										exports.rprogress:Custom({
											Duration = 5000,
											Label = "Finding the necessary papers...",
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
										Citizen.Wait(5000)		
										ClearPedTasks(ped)
										RemoveBlip(SeventhOrderBlip)
										exports.pNotify:SendNotification({text = "<b>Illegal Orders</b></br>Now go to the boss", timeout = 4500})
										PayoutForSeventhOrder = true
										break
									end
								end
							end
						Citizen.Wait(sleep)
					end
					break
				end
			end
		end
	Citizen.Wait(sleep)
	end
end

function StopFire()
	Wait(10000)
	for k, v in ipairs(currentFires) do
		RemoveScriptFire(v)
	end
end
 
function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
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

RegisterNetEvent('inside-illegalorders:removecars')
AddEventHandler('inside-illegalorders:removecars', function()
	DeleteVehicle(Vehicle)
end)


