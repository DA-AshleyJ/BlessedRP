
local ZoneCreated = false
local sit = false

local function CloseSit()
	if sit then 
		local ped = PlayerPedId()
		ClearPedTasksImmediately(ped)
		sit = false
	end
end

local function CreateZone()
	ZoneCreated = true
	local IrishPub = 
	PolyZone:Create({
	  vector2(140.48356628418, -1056.9443359375),
	  vector2(128.21255493164, -1052.3610839844),
	  vector2(126.87837219238, -1055.5599365234),
	  vector2(125.92752838135, -1054.5068359375),
	  vector2(127.81992340088, -1049.3084716797),
	  vector2(124.74887084961, -1047.4136962891),
	  vector2(127.45231628418, -1039.9501953125),
	  vector2(132.4228515625, -1030.7188720703),
	  vector2(131.38262939453, -1029.4982910156),
	  vector2(132.94140625, -1024.4697265625),
	  vector2(137.43328857422, -1026.2930908203),
	  vector2(135.19456481934, -1031.1561279297),
	  vector2(136.64680480957, -1031.5002441406),
	  vector2(138.21221923828, -1026.5231933594),
	  vector2(141.51676940918, -1027.8022460938),
	  vector2(139.63436889648, -1032.5660400391),
	  vector2(140.69223022461, -1032.5766601563),
	  vector2(142.36959838867, -1028.0650634766),
	  vector2(145.73153686523, -1029.0500488281),
	  vector2(143.91368103027, -1034.1427001953),
	  vector2(144.96228027344, -1034.6080322266),
	  vector2(146.52839660645, -1029.6029052734),
	  vector2(150.78114318848, -1031.1793212891)
	}, {
	  name="pub",
	  --minZ = 22.701028823853,
	  --maxZ = 23.027851104736
	})
	
	IrishPub:onPlayerInOut(function(isPointInside)
		if isPointInside then
			RegisterCommand('+closeImportMenu', CloseSit, false)
			RegisterKeyMapping("+closeImportMenu", "CloseSit~", "keyboard", Config.CloseSitKey)
		end
	end)
end


CreateThread(function()
	for k, v in pairs(Chairs) do
		exports['qb-target']:AddBoxZone("IrishPubChair"..k, v.location, v.width, v.height, { 
			name="IrishPubChair"..k, 
			heading = v.heading, 
			debugPoly=false, 
			minZ = v.minZ, 
			maxZ = v.maxZ 
			}, 
			{ 
				options = {
				{ 
					event = "qb-irishpub:client:chair", 
					icon = "fas fa-chair", 
					label = "Sit Down", 
					loc = v.location, 
					head = v.heading,
					job = {"all"}
 
				}, 
			},
			distance = v.distance
		})
	end
	if not ZoneCreated then
		CreateZone()
	end
end)


RegisterNetEvent('qb-irishpub:client:chair', function(data)
	local ped = PlayerPedId()
    if not sit then
	    TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", data.loc.x, data.loc.y, data.loc.z-0.5, data.head, 0, 1, true)
        sit = true
    else
        ClearPedTasksImmediately(ped)
        sit = false
    end
end)

Chairs = {
    --- table next to bar 
	{ location = vector3(136.33, -1051.79, 22.88), heading = 247.71, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
	{ location = vector3(835.23, -104.89, 79.72), heading = 243.72, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
	{ location = vector3(837.83, -106.32, 79.72), heading = 66.91, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
	{ location = vector3(837.29, -107.31, 79.72), heading = 55.53, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
    -- Window mid
    { location = vector3(840.98, -108.17, 79.72), heading = 243.72, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
    { location = vector3(840.29, -109.18,79.72), heading = 243.72, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
    --- Window Enrty 
    { location = vector3(843.51, -109.61, 79.72), heading = 66.91, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
    { location = vector3(842.95, -110.56, 79.72), heading = 55.53, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
    --- Near WC Window
    { location = vector3(845.89, -117.18, 79.72), heading = 53.05, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
    { location = vector3(844.25, -119.94, 79.72), heading = 55.45, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.60, distance = 3.7 },
    ---WC
    { location = vector3(838.89, -120.83, 79.72), heading = 235.05, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.20, distance = 3.7 },
    { location = vector3(837.9, -122.43, 79.72), heading = 246.47, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.20, distance = 3.7 },
    { location =vector3(837.05, -124.05, 79.72), heading = 246.47, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.20, distance = 3.7 },
    
    -- Kitchen
    { location =vector3(828.29, -109.94, 79.72), heading = 143.29, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.20, distance = 3.7 },
    -- Office
    { location =vector3(830.5, -118.66,  80.42), heading = 350.82, width = 0.6, height = 0.6, minZ = 79.10, maxZ = 80.20, distance = 3.7 },
}








