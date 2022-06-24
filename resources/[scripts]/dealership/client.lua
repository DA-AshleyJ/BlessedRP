-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local truck,truck_blip,trailer,trailer_blip
local empresaAtual = nil
local blipAtual = nil

Citizen.CreateThread(function()
	local timer = 1
	while true do
		timer = 2000
		for k,v in pairs(Config.dealership_locations) do
			local x,y,z = table.unpack(v.coord)
			local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
			if not menuactive and distance <= 20.0 then
				timer = 4
				DrawMarker_blip(x,y,z)
				if distance <= 1.0 then
					DrawText3D(x,y,z-0.6, Lang[Config.lang]['open'], 0.40)
					if IsControlJustPressed(0,Config.hotkeys.openNui) then
						empresaAtual = k
						TriggerServerEvent("lc_dealership:getData",empresaAtual)
					end
				end
			end

			for kk,mark in pairs(v.sell_blip_coords) do
				local x,y,z = table.unpack(mark.dealer)
				local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
				if not menuactive and distance <= 20.0 then
					timer = 4
					DrawMarker_blip(x,y,z)
					if distance <= 1.0 then
						DrawText3D(x,y,z-0.6, Lang[Config.lang]['open_dealership'], 0.40)
						if IsControlJustPressed(0,Config.hotkeys.openNui) then
							empresaAtual = k
							blipAtual = kk
							TriggerServerEvent("lc_dealership:openDealership",empresaAtual) 
						end
					end
				end
			end
		end
		Citizen.Wait(timer)
	end
end)

RegisterNetEvent('lc_dealership:open')
AddEventHandler('lc_dealership:open', function(dados,update,isCustomer,isEmployee)
	FreezeEntityPosition(PlayerPedId(),true)
	-- Open NUI
	SendNUIMessage({ 
		showmenu = true,
		update = update,
		isCustomer = isCustomer,
		isEmployee = isEmployee,
		dados = dados
	})
	if update == false then
		menuactive = true
		SetNuiFocus(true,true)
	end
end)

function getVehicleFromVehList(hash)
	for k,v in pairs(Config.vehList) do
		if v.hash == hash then
			if v.name then
				return v.name
			end
		end
	end
end

RegisterNetEvent('lc_dealership:openRequest')
AddEventHandler('lc_dealership:openRequest', function(price)
	-- Open buy request NUI
	SendNUIMessage({ 
		showmenu = true,
		price = price,
		format = Config.format,
		lang = Config.lang
	})
	SetNuiFocus(true,true)
end)

RegisterNetEvent('lc_dealership:closeUI')
AddEventHandler('lc_dealership:closeUI', function()
	closeUI()
end)

RegisterNetEvent('lc_dealership:spawnVehicle')
AddEventHandler('lc_dealership:spawnVehicle', function(vehicle_model,plate)
	local x,y,z,h = table.unpack(Config.dealership_locations[empresaAtual].cutomers_garage_coord)
	closeUI()
	SpawnVehicle(vehicle_model, { x = x, y = y, z = z }, h, plate, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		
		local vehicleProps = GetVehicleProperties(vehicle)
		vehicleProps.plate = plate
		
		TriggerServerEvent('lc_dealership:setVehicleOwned', vehicleProps, vehicle_model)
	end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------

local cooldown = nil
RegisterNUICallback('buyDealership', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:buyDealership',empresaAtual)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('sellDealership', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:sellDealership',empresaAtual)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('importVehicle', function(data, cb)
	if cooldown == nil then
		cooldown = true

		if truck then
			TriggerEvent("lc_dealership:Notify","negado",Lang[Config.lang]['already_has_job'])
		else
			local x,y,z,h = table.unpack(Config.dealership_locations[empresaAtual]['truck_coord'])
			local checkPos = IsSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
			if checkPos == false then
				TriggerEvent("lc_dealership:Notify","negado",Lang[Config.lang]['occupied_places'])
			else
				local x2,y2,z2,h2 = table.unpack(Config.dealership_locations[empresaAtual]['trailer_coord'])
				local checkPos = IsSpawnPointClear({['x']=x2,['y']=y2,['z']=z2},5.001)
				if checkPos == false then
					TriggerEvent("lc_dealership:Notify","negado",Lang[Config.lang]['occupied_places'])
				else
					if data.isexport == 0 then
						TriggerServerEvent('lc_dealership:importVehicle',empresaAtual,data.vehicle,data.valStockCars)
					else
						TriggerServerEvent('lc_dealership:exportVehicle',empresaAtual,data.vehicle,data.valStockCars)
					end
				end
			end
		end
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('setPrice', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:setPrice',empresaAtual,data.vehicle,data.price)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('buyVehicle', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:buyVehicle',empresaAtual,data.vehicle)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('sellVehicle', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:sellVehicle',empresaAtual,data.vehicle,data.plate,data.price)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('previewVehicle', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:getSpawnedVehicles', empresaAtual, blipAtual, data.vehicle)
		closeUI()
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('cancelSellVehicle', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:cancelSellVehicle',empresaAtual,data.id)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('finishSellVehicle', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:finishSellVehicle',empresaAtual,data.id)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('hirePlayer', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:hirePlayer',empresaAtual,data.user)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('firePlayer', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:firePlayer',empresaAtual,data.user)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('giveComission', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:giveComission',empresaAtual,data.user,data.amount)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('changeProfile', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:changeProfile',empresaAtual,data.user_id,data.banner_img,data.profile_img)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('changeProfileOwner', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:changeProfileOwner',empresaAtual,data.user_id,data.banner_img,data.profile_img)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('requestVehicle', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:requestVehicle',empresaAtual,data.vehicle,data.price)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('cancelRequest', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:cancelRequest',empresaAtual,data.id)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('acceptRequest', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:acceptRequest',empresaAtual,data.id)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('declineRequest', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:declineRequest',empresaAtual,data.id)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('finishRequest', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:finishRequest',empresaAtual,data.id)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('depositMoney', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:depositMoney',empresaAtual,data.amount)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('withdrawMoney', function(data, cb)
	if cooldown == nil then
		cooldown = true
		TriggerServerEvent('lc_dealership:withdrawMoney',empresaAtual)
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('close', function(data, cb)
	closeUI()
end)

function closeUI()
	FreezeEntityPosition(PlayerPedId(),false)
	empresaAtual = nil
	menuactive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ hidemenu = true })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- startContract
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('lc_dealership:startContract')
AddEventHandler('lc_dealership:startContract', function(vehicle,amount,isexport,request_id)
	local key = empresaAtual

	local x,y,z = table.unpack(Config.delivery_locations[math.random(#Config.delivery_locations)])
	local route_blip = createBlip(x,y,z)

	local x2,y2,z2,h2 = table.unpack(Config.dealership_locations[key]['truck_coord'])
	truck,truck_blip = spawnVehicle(Config.dealership_locations[key].truck_name,x2,y2,z2,h2)
	
	local x_trailer,y_trailer,z_trailer,h_trailer = table.unpack(Config.dealership_locations[key]['trailer_coord'])
	if isexport then
		trailer,trailer_blip = spawnVehicle(Config.dealership_locations[key].trailer.full,x_trailer,y_trailer,z_trailer,h_trailer)
	else
		trailer,trailer_blip = spawnVehicle(Config.dealership_locations[key].trailer.empty,x_trailer,y_trailer,z_trailer,h_trailer)
	end

	TriggerEvent("lc_dealership:Notify","sucesso",Lang[Config.lang]['already_is_in_garage'])
	
	closeUI()
	local fase_coleta = 1
	local timer = 2000
	while truck do
		timer = 2000
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)

		if fase_coleta == 1 then
			local distance = #(GetEntityCoords(ped) - vector3(x,y,z))
			if distance <= 50 and veh ~= 0 and IsEntityAttachedToEntity(trailer,veh) then
				timer = 5
				DrawMarker_truck(x,y,z)
				if distance <= 2 then
					DrawText3D2(x,y,z-0.6, Lang[Config.lang]['objective_marker_3'], 0.70)
					if IsControlJustPressed(0,38) then
						BringVehicleToHalt(truck, 2.5, 1, false)
						Citizen.Wait(10)
						DoScreenFadeOut(500)
						Citizen.Wait(500)
						local xt,yt,zt = table.unpack(GetEntityCoords(trailer))
						local ht = GetEntityHeading(trailer)
						DeleteVehicle(trailer)
						RemoveBlip(trailer_blip)
						if isexport then
							trailer,trailer_blip = spawnVehicle(Config.dealership_locations[key].trailer.empty,xt,yt,zt,ht)
						else
							trailer,trailer_blip = spawnVehicle(Config.dealership_locations[key].trailer.full,xt,yt,zt,ht)
						end
						AttachVehicleToTrailer(truck,trailer)

						RemoveBlip(route_blip)
						route_blip = nil
						fase_coleta = 2
						PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
						Citizen.CreateThreadNow(function()
							showScaleform(Lang[Config.lang]['sucess_2'], Lang[Config.lang]['sucess_in_progess_2'], 3)
						end)
						route_blip = createBlip(x2,y2,z2)
					end
				end
			end
		elseif fase_coleta == 2 then
			local distance = #(GetEntityCoords(ped) - vector3(x2,y2,z2))
			if distance <= 50 and veh ~= 0 and IsEntityAttachedToEntity(trailer,veh) then
				timer = 5
				DrawMarker_truck(x2,y2,z2)
				DrawText3D2(x2,y2,z2-0.6, Lang[Config.lang]['garage_marker'], 0.40)
				if distance <= 4 then
					BringVehicleToHalt(truck, 2.5, 1, false)
					Citizen.Wait(10)
					DoScreenFadeOut(500)
					Citizen.Wait(500)
					DeleteVehicle(truck)
					DeleteVehicle(trailer)
					RemoveBlip(truck_blip)
					RemoveBlip(trailer_blip)
					RemoveBlip(route_blip)
					PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
					Citizen.CreateThreadNow(function()
						showScaleform(Lang[Config.lang]['sucess_2'], Lang[Config.lang]['sucess_finished_2'], 3)
					end)
					truck = nil
					trailer = nil
					truck_blip = nil
					trailer_blip = nil
					route_blip = nil
					if request_id then
						TriggerServerEvent("lc_dealership:finishImportRequestVehicle",key,vehicle,request_id)
					else
						if isexport then
							TriggerServerEvent("lc_dealership:finishExportVehicle",key,vehicle,amount)
						else
							TriggerServerEvent("lc_dealership:finishImportVehicle",key,vehicle,amount)
						end
					end
					return
				end
			end
		end

		if not IsEntityAVehicle(truck) then
			DeleteEntity(truck)
			DeleteEntity(trailer)
			RemoveBlip(truck_blip)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			truck = nil
			trailer = nil
			truck_blip = nil
			trailer_blip = nil
			route_blip = nil
			if request_id then
				TriggerServerEvent("lc_dealership:cancelImportRequestVehicle",request_id)
			end
			return
		end

		if IsEntityDead(ped) then
			SetVehicleEngineHealth(truck,-4000)
			SetVehicleUndriveable(truck,true)
			RemoveBlip(truck_blip)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			truck = nil
			trailer = nil
			truck_blip = nil
			trailer_blip = nil
			route_blip = nil
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
			TriggerEvent("lc_dealership:Notify","negado",Lang[Config.lang]['you_died'])
			if request_id then
				TriggerServerEvent("lc_dealership:cancelImportRequestVehicle",request_id)
			end
			return
		end

		engineH = GetVehicleEngineHealth(truck)
		if engineH <= 150 then
			SetVehicleEngineHealth(truck,-4000)
			SetVehicleUndriveable(truck,true)
			RemoveBlip(truck_blip)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			truck = nil
			trailer = nil
			truck_blip = nil
			trailer_blip = nil
			route_blip = nil
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
			TriggerEvent("lc_dealership:Notify","negado",Lang[Config.lang]['vehicle_destroyed'])
			if request_id then
				TriggerServerEvent("lc_dealership:cancelImportRequestVehicle",request_id)
			end
			return
		end
		
		Citizen.Wait(timer)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- previewVehicle
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('lc_dealership:getSpawnedVehicles')
AddEventHandler('lc_dealership:getSpawnedVehicles', function(key,k,veh,vehicle)
	if veh ~= nil then
		DeleteEntity(NetToVeh(veh))
	end

	local x,y,z,h = table.unpack(Config.dealership_locations[key].sell_blip_coords[k].preview)
	SpawnVehicle(vehicle, { x = x, y = y, z = z }, h, nil, function(veh)
		FreezeEntityPosition(veh,true)
		local vehicleNetId = NetworkGetNetworkIdFromEntity(veh)
		SetNetworkIdCanMigrate(vehicleNetId, true)
		SetNetworkIdExistsOnAllMachines(vehicleNetId, true)
		NetworkRegisterEntityAsNetworked(VehToNet(veh))
		TriggerServerEvent('lc_dealership:setSpawnedVehicles', key, k, vehicleNetId)

		TriggerEvent('lc_dealership:createVehicleThread', key, k, veh, vehicle)
	end)
end)

RegisterNetEvent('lc_dealership:syncgetSpawnedVehicles')
AddEventHandler('lc_dealership:syncgetSpawnedVehicles', function(vehicle)
	if NetworkDoesNetworkIdExist(vehicle) then
		local v = NetToVeh(vehicle)
		if DoesEntityExist(v) and IsEntityAVehicle(v) then
			Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
			SetEntityAsMissionEntity(v,true,true)
			SetVehicleHasBeenOwnedByPlayer(v,true)
			NetworkRequestControlOfEntity(v)
			Citizen.InvokeNative(0xEA386986E786A54F,Citizen.PointerValueIntInitialized(v))
			DeleteEntity(v)
			DeleteVehicle(v)
			SetEntityAsNoLongerNeeded(v)
		end
	end
end)

RegisterNetEvent('lc_dealership:createVehicleThread')
AddEventHandler('lc_dealership:createVehicleThread', function(key, k, veh, vehicle)
	local ped = PlayerPedId()
	local timer = 1000
	local xp,yp,zp,hp = table.unpack(Config.dealership_locations[key].sell_blip_coords[k].preview)
	local xd,yd,zd = table.unpack(Config.dealership_locations[key].sell_blip_coords[k].dealer)
	while IsEntityAVehicle(veh) do
		SetVehicleDoorsLocked(veh,1)
		if GetPedInVehicleSeat(veh, -1) == ped then
			timer = 5
			DrawText3D(xp,yp,zp+0.6, Lang[Config.lang]['preview_vehicle'], 0.40)
			if IsControlJustPressed(0,Config.hotkeys.testDrive) then
				local test_drive = Config.dealership_locations[key].test_drive
				if test_drive.teleport then
					DoScreenFadeOut(500)
					Wait(500)
					local xt,yt,zt,ht = table.unpack(test_drive.test_drive_coord)
					SetEntityCoords(veh,xt+0.0001,yt+0.0001,zt+0.0001,1,0,0,1)
					SetEntityHeading(veh,ht+0.0001)
					Wait(500)
					DoScreenFadeIn(500)
				end
				FreezeEntityPosition(veh,false)
				
				local rtime = test_drive.test_drive_time
				TriggerEvent("lc_dealership:Notify","sucesso",Lang[Config.lang]['test_drive_started']:format(rtime))
				while rtime > 0 do
					if GetPedInVehicleSeat(veh, -1) ~= ped then
						DoScreenFadeOut(500)
						Wait(500)
						SetEntityCoords(ped,xd+0.0001,yd+0.0001,zd+0.0001,1,0,0,1)
						if IsEntityAVehicle(veh) then
							DeleteEntity(veh)
						end
						Wait(500)
						DoScreenFadeIn(500)
						return
					end
					rtime = rtime - 1
					Wait(1000)
				end
				if IsEntityAVehicle(veh) then
					DoScreenFadeOut(500)
					Wait(500)
					SetEntityCoords(ped,xd+0.0001,yd+0.0001,zd+0.0001,1,0,0,1)
					if IsEntityAVehicle(veh) then
						DeleteEntity(veh)
					end
					Wait(500)
					DoScreenFadeIn(500)
				end
			end
			
			if IsControlJustPressed(0,Config.hotkeys.buyVehicle) then
				DoScreenFadeOut(500)
				Wait(500)
				empresaAtual = key
				TriggerServerEvent('lc_dealership:buyVehicle',key,vehicle)
				Wait(500)
				DoScreenFadeIn(500)
			end
		end
		Citizen.Wait(timer)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- lock
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread( function()
	local timer = 2000
	while true do
		if truck then
			timer = 5
			if IsControlJustPressed(0,Config.hotkeys.unlockTruck) then
				TriggerServerEvent("lc_dealership:vehicleLock")
			end
		end
		Citizen.Wait(timer)
	end
end)

RegisterNetEvent('lc_dealership:vehicleClientLock')
AddEventHandler('lc_dealership:vehicleClientLock', function()
	local v = truck
	if DoesEntityExist(v) and IsEntityAVehicle(v) then
		local lock = GetVehicleDoorLockStatus(v)
		playAnim(true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
		TriggerEvent("vrp_sound:source",'lock',0.5)
		if lock == 1 then
			SetVehicleDoorsLocked(v,2)
			--TriggerEvent("lc_dealership:Notify","importante",Lang[Config.lang]['vehicle_locked'],8000)
		else
			SetVehicleDoorsLocked(v,1)
			--TriggerEvent("lc_dealership:Notify","importante",Lang[Config.lang]['vehicle_unlocked'],8000)
		end
		SetVehicleLights(v,2)
		Wait(200)
		SetVehicleLights(v,0)
		Wait(200)
		SetVehicleLights(v,2)
		Wait(200)
		SetVehicleLights(v,0)
	end
end)

local anims = {}

function playAnim(upper, seq, looping)
    stopAnim(upper)

    local flags = 0
    if upper then flags = flags+48 end
    if looping then flags = flags+1 end

    Citizen.CreateThread(function()
      for k,v in pairs(seq) do
        local dict = v[1]
        local name = v[2]
        local loops = v[3] or 1

        for i=1,loops do
            local first = (k == 1 and i == 1)
            local last = (k == #seq and i == loops)

            -- request anim dict
            RequestAnimDict(dict)
            local i = 0
            while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
              Citizen.Wait(10)
              RequestAnimDict(dict)
              i = i+1
            end

            -- play anim
            if HasAnimDictLoaded(dict)then
              local inspeed = 8.0001
              local outspeed = -8.0001
              if not first then inspeed = 2.0001 end
              if not last then outspeed = 2.0001 end

              TaskPlayAnim(GetPlayerPed(-1),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
            end

            Citizen.Wait(0)
            while GetEntityAnimCurrentTime(GetPlayerPed(-1),dict,name) <= 0.95 and IsEntityPlayingAnim(GetPlayerPed(-1),dict,name,3) and anims[id] do
              Citizen.Wait(0)
            end
          end
      end
    end)
end
function stopAnim(upper)
	anims = {} -- stop all sequences
	if upper then
	  	ClearPedSecondaryTask(GetPlayerPed(-1))
	else
	  	ClearPedTasks(GetPlayerPed(-1))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- addBlip
-----------------------------------------------------------------------------------------------------------------------------------------

function addBlip(x,y,z,idtype,idcolor,text,scale)
	if idtype ~= 0 then
		local blip = AddBlipForCoord(x,y,z)
		SetBlipSprite(blip,idtype)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,idcolor)
		SetBlipScale(blip,scale)

		if text then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(text)
			EndTextCommandSetBlipName(blip)
		end
		return blip
	end
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.dealership_locations) do
		local x,y,z = table.unpack(v.coord)
		local blips = Config.dealership_types[v.type].blips
		addBlip(x,y,z,blips.id,blips.color,blips.name,blips.scale)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- print_table
-----------------------------------------------------------------------------------------------------------------------------------------

function print_table(node)
	if type(node) == "table" then
		-- to make output beautiful
		local function tab(amt)
			local str = ""
			for i=1,amt do
				str = str .. "\t"
			end
			return str
		end
	
		local cache, stack, output = {},{},{}
		local depth = 1
		local output_str = "{\n"
	
		while true do
			local size = 0
			for k,v in pairs(node) do
				size = size + 1
			end
	
			local cur_index = 1
			for k,v in pairs(node) do
				if (cache[node] == nil) or (cur_index >= cache[node]) then
				
					if (string.find(output_str,"}",output_str:len())) then
						output_str = output_str .. ",\n"
					elseif not (string.find(output_str,"\n",output_str:len())) then
						output_str = output_str .. "\n"
					end
	
					-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
					table.insert(output,output_str)
					output_str = ""
				
					local key
					if (type(k) == "number" or type(k) == "boolean") then
						key = "["..tostring(k).."]"
					else
						key = "['"..tostring(k).."']"
					end
	
					if (type(v) == "number" or type(v) == "boolean") then
						output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
					elseif (type(v) == "table") then
						output_str = output_str .. tab(depth) .. key .. " = {\n"
						table.insert(stack,node)
						table.insert(stack,v)
						cache[node] = cur_index+1
						break
					else
						output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
					end
	
					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					else
						output_str = output_str .. ","
					end
				else
					-- close the table
					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					end
				end
	
				cur_index = cur_index + 1
			end
	
			if (#stack > 0) then
				node = stack[#stack]
				stack[#stack] = nil
				depth = cache[node] == nil and depth + 1 or depth - 1
			else
				break
			end
		end
	
		-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
		table.insert(output,output_str)
		output_str = table.concat(output)
	
		print(output_str)
	else
		print(node)
	end
end