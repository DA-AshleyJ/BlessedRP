local clientHide = false
playerCount = 0
scrollCount = 0

RegisterCommand('rpchide', function(source, args)
	if config.allowHide == true then
		if clientHide == true then
			clientHide = false
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = false,
				args = {"^7^*[^4DiscordRPC^7] ^r^7Your Discord status is now ^2^*Shown^r^7!"}
			  })	
		elseif clientHide == false then
			clientHide = true
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = false,
				args = {"^7^*[^4DiscordRPC^7] ^r^7Your Discord status is now ^1^*Hidden^r^7!"}
			  })		
		end
	else
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = false,
			args = {"^7^*[^4DiscordRPC^7] ^r^7This feature has been ^1^*disabled^r^7!"}
		  })	
	end
end, false)

RegisterNetEvent("rpc:sendCount")
AddEventHandler("rpc:sendCount", function(playerTotal)
    playerCount = playerTotal
end)


Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(config.ApplicationID) --LETS GET THIS STARTED IN HERE

		if config.mainTextType == 1 then
			Citizen.Wait(100)
			if playerCount > 1 then
				SetRichPresence("" .. playerCount .. " players")
			else
				SetRichPresence("1 player")
			end	
		elseif config.mainTextType == 2 then
			scrollCount = scrollCount + 1
			if scrollCount > config.mainTextScroll then
				scrollCount = 1
			end
			if scrollCount == 1 then
				SetRichPresence(config.mainText1)
			elseif scrollCount == 2 then
				SetRichPresence(config.mainText2)
			elseif scrollCount == 3 then
				SetRichPresence(config.mainText3)
			elseif scrollCount == 4 then
				SetRichPresence(config.mainText4)
			else
				SetRichPresence(config.mainText5)
			end
		else
			local currHealth = GetEntityHealth(PlayerPedId())
			local maxHealth = GetPedMaxHealth(PlayerPedId())
			if currHealth ~= 1 then
				SetRichPresence("Health: " .. currHealth .. "/" .. maxHealth .. "") --male peds have 200, females have 100. ROCKSTAR = MISOGYNISTS
			else
				SetRichPresence("Dead...")
			end
		end

		SetDiscordRichPresenceAsset('icon')
		SetDiscordRichPresenceAssetText(config.serverName)

		if clientHide == true then 
			SetDiscordRichPresenceAssetSmall('hidden')
			SetDiscordRichPresenceAssetSmallText("Status hidden")
			Citizen.Wait(5000)
		else
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(PlayerPedId(),true))))
			local areaName = GetLabelText(GetNameOfZone(table.unpack(GetEntityCoords(PlayerPedId(),true))))
			local altitude = math.floor(GetEntityHeightAboveGround(GetPlayerPed(-1), true))

			if (config.showAreas == true and areaName == "Galileo Observatory") then
				SetDiscordRichPresenceAssetSmall('observatory')
				SetDiscordRichPresenceAssetSmallText("At the Galileo Observatory")
			elseif (config.showAreas == true and areaName == "GWC and Golfing Society") then
				SetDiscordRichPresenceAssetSmall('golfing')
				SetDiscordRichPresenceAssetSmallText("Golfing at LS Golf Club")
			elseif (config.showAreas == true and areaName == "Mount Chiliad" or areaName == "Mount Josiah" or areaName == "Mount Gordo") then
				SetDiscordRichPresenceAssetSmall('mountain')
				SetDiscordRichPresenceAssetSmallText("Climbing " .. areaName .. "")
			elseif (config.showAreas == true and areaName == "Los Santos International Airport") then
				SetDiscordRichPresenceAssetSmall('airport')
				SetDiscordRichPresenceAssetSmallText("At Los Santos International Airport")
			elseif (config.showAreas == true and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 118.3, -1288.4, 28.2, true) <= 40.000) then
				SetDiscordRichPresenceAssetSmall('stripclub')
				SetDiscordRichPresenceAssetSmallText("At the stripclub!?")
			elseif (config.showAreas == true and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -74.94, -819.1, 326.1, true) <= 40.000) then
				SetDiscordRichPresenceAssetSmall('building')
				SetDiscordRichPresenceAssetSmallText("Ontop the Mazebank Tower")
			elseif (config.showAreas == true and areaName == "Del Perro Beach" or areaName == "Vespucci Beach") then
				SetDiscordRichPresenceAssetSmall('pier')
				SetDiscordRichPresenceAssetSmallText("At " .. areaName .. "")
			elseif (config.showAreas == true and areaName == "Fort Zancudo") then
				SetDiscordRichPresenceAssetSmall('zancudo')
				SetDiscordRichPresenceAssetSmallText("At Fort Zancudo")
			elseif (config.showStation == true and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1853.20, 3690.7, 39.0, true) <= 60.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Sandy SO")
			elseif (config.showStation == true and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 455.9, -992.8, 30.7, true) <= 100.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Missionrow PD")
			elseif (config.showStation == true and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1096.3, -840.1, 37.6, true) <= 100.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Vespucci PD")
			elseif (config.showStation == true and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -450.6, 6006.7, 36.6, true) <=70.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Paleto PD")
			elseif (config.showStation == true and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1687.1, 2604.1, 45.5, true) <= 125.000) then
				SetDiscordRichPresenceAssetSmall('injail')
				SetDiscordRichPresenceAssetSmallText("In prison :(")
			--If you want to add more locations, remove the --'s from the next 3 lines, and remove this line you're reading
			--elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), X, Y, Z, false) < 125.000 then
			--	SetDiscordRichPresenceAssetSmall('ICON_NAME')
			--	SetDiscordRichPresenceAssetSmallText("HOVER_TEXT")
			elseif IsPedOnFoot(PlayerPedId()) == false then
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local vehicleClass = GetVehicleClass(vehicle)
				local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				local vehspeed = math.floor(GetEntitySpeed(vehicle)*2.236936)
				if (vehicle == nil or vehicle == "" or vehicle == "NULL") then 
					SetDiscordRichPresenceAssetSmall('vehicle')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				elseif (vehicleClass == 8 or vehicleClass == 13) then
					SetDiscordRichPresenceAssetSmall('motorcycle')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				elseif vehicleClass == 15 then
					SetDiscordRichPresenceAssetSmall('helicopter')
					if altitude >= 15 then
						SetDiscordRichPresenceAssetSmallText("Piloiting a " .. vehicleName .. "\n " .. altitude .. "m above " .. areaName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Grounded in a " .. vehicleName .. "\n at " .. areaName .. "")
					end
				elseif (vehicleClass == 16) then
						SetDiscordRichPresenceAssetSmall('plane')
					if altitude >= 15 then
						SetDiscordRichPresenceAssetSmallText("Piloiting a " .. vehicleName .. "\n " .. altitude .. "m above " .. areaName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Grounded in a " .. vehicleName .. "\n at " .. areaName .. "")
					end
				elseif IsPedInAnySub(PlayerPedId()) == true then
					SetDiscordRichPresenceAssetSmall('submarine')
					SetDiscordRichPresenceAssetSmallText("Using a " .. vehicleName .. "\n in " .. areaName .. "")
				elseif vehicleClass == 14 then
					SetDiscordRichPresenceAssetSmall('boat')
					SetDiscordRichPresenceAssetSmallText("Sailing in a " .. vehicleName .. "\n" .. vehspeed .. "mph in " .. areaName .. "")
				elseif (IsPlayerRidingTrain(PlayerPedId()) or vehicleClass == 21) then
					SetDiscordRichPresenceAssetSmall('train')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a train at " .. areaName .. "")
					else
					SetDiscordRichPresenceAssetSmallText("Using a train \n" .. vehspeed .. "mph in " .. areaName .. "")
					end
				elseif vehicleClass == 18 then
					SetDiscordRichPresenceAssetSmall('emergency')
					if IsVehicleSirenOn(vehicle) then 
						if vehspeed <= 2 then
							SetDiscordRichPresenceAssetSmallText("Code 3, parked at " .. streetName .. "")
						else
							SetDiscordRichPresenceAssetSmallText("Code 3 going " .. vehspeed .. "mph down " .. streetName .. "")
						end
					elseif vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				else
					SetDiscordRichPresenceAssetSmall('vehicle')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				end
			elseif IsEntityDead(GetPlayerPed(-1)) ~= false then
				SetDiscordRichPresenceAssetSmall('dead')
				SetDiscordRichPresenceAssetSmallText("Dead in " .. areaName .. "")
			elseif GetInteriorFromEntity(GetPlayerPed(-1)) ~= 0 and areaName == "San Andreas" then
				SetDiscordRichPresenceAssetSmall('interior')
				SetDiscordRichPresenceAssetSmallText("In an interior")
			elseif GetInteriorFromEntity(GetPlayerPed(-1)) ~= 0 then
				SetDiscordRichPresenceAssetSmall('interior')
				SetDiscordRichPresenceAssetSmallText("In an interior at " .. areaName .. "")
			elseif (IsPedSwimming(PlayerPedId()) or IsPedSwimmingUnderWater(PlayerPedId())) then
				SetDiscordRichPresenceAssetSmall('swimming')
				SetDiscordRichPresenceAssetSmallText("Swimming in " .. areaName .. "")
			elseif GetPedParachuteState(PlayerPedId()) > 0 then
				SetDiscordRichPresenceAssetSmall('parachute')
				SetDiscordRichPresenceAssetSmallText("Parachuting over " .. areaName .. " at " .. altitude .. "m")
			elseif (altitude >= 400 and altitude <= 600) then
				SetDiscordRichPresenceAssetSmall('clouds')
				SetDiscordRichPresenceAssetSmallText("In the clouds")
			elseif altitude >= 601 then
				SetDiscordRichPresenceAssetSmall('space')
				SetDiscordRichPresenceAssetSmallText("In the Atmosphere?!")
			else
				SetDiscordRichPresenceAssetSmall('walking')
				SetDiscordRichPresenceAssetSmallText("On foot in " .. areaName .. "")
			end

			if config.enableButton1 == true then	
				SetDiscordRichPresenceAction(0, config.buttonText, config.buttonLink)
			end
			if config.enableButton2 == true then
				SetDiscordRichPresenceAction(1, config.buttonText2, config.buttonLink2)
			end
			if config.enableButton3 == true then
				SetDiscordRichPresenceAction(2, config.buttonText3, config.buttonLink3)
			end
			--Every 5 seconds the location and display will update
			Citizen.Wait(5000)
		end
	end --whiletrue end
end)