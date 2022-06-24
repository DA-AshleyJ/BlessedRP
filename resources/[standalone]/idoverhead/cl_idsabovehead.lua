local disPlayerNames = 5
local playerDistances = {}

local function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz)-vector3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	Wait(500)
    while true do
		if IsControlPressed(0, 213) then
			for _, id in ipairs(GetActivePlayers()) do
				if playerDistances[id] then
					if (playerDistances[id] < disPlayerNames) then
						if IsPedInAnyVehicle(GetPlayerPed(id), true) then
							local vehicle = GetVehiclePedIsIn(GetPlayerPed(id), true)
							
							if GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(id) then
								x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
								DrawText3D(x2, y2-0.3, z2+1, GetPlayerServerId(id), 255,255,255)
							elseif GetPedInVehicleSeat(vehicle, 0) == GetPlayerPed(id) then
								x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
								DrawText3D(x2, y2+0.3, z2+1, GetPlayerServerId(id), 255,255,255)
							elseif GetPedInVehicleSeat(vehicle, 1) == GetPlayerPed(id) then
								x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
								DrawText3D(x2+1, y2-0.3, z2+1, GetPlayerServerId(id), 255,255,255)
							elseif GetPedInVehicleSeat(vehicle, 2) == GetPlayerPed(id) then
								x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
								DrawText3D(x2+1, y2+0.3, z2+1, GetPlayerServerId(id), 255,255,255)
							elseif GetPedInVehicleSeat(vehicle, 3) == GetPlayerPed(id) then
								x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
								DrawText3D(x2+2.1, y2-0.3, z2+1, GetPlayerServerId(id), 255,255,255)
							elseif GetPedInVehicleSeat(vehicle, 4) == GetPlayerPed(id) then
								x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
								DrawText3D(x2+2.1, y2+0.3, z2+1, GetPlayerServerId(id), 255,255,255)
							end
						else
							x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
							DrawText3D(x2, y2, z2+1, GetPlayerServerId(id), 255,255,255)
						end
					end 
				end
			end
		end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for _, id in ipairs(GetActivePlayers()) do
            x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
            distance = math.floor(#(vector3(x1,  y1,  z1)-vector3(x2,  y2,  z2)))
			playerDistances[id] = distance
        end
        Citizen.Wait(1000)
    end
end)
