local QBCore = exports['qb-core']:GetCoreObject()
local working = false 
local lockpickvan = false 
local inmision = false
local havevan = false 
local robbed = false 
local dyblip = {}
local vanb = {}
local vansb = {}
local van

-- Cores
CreateThread(function()
    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
	AddRelationshipGroup('Guards')
end)


CreateThread(function()
    while true do
        sleep = 500
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        local vanpos = GetEntityCoords(van) 
        local dist1 = GetDistanceBetweenCoords(pcoords, vector3(-90.77, -67.6, 57.93), true)
        if dist1 <= 7.0 then
            sleep = 0
            Marker(-90.77, -67.6, 57.93)
            if dist1 <= 1.5 then
                HelpText(Config.Locale['tpe_room'])

                if IsControlJustPressed(0, 38) then
                    Teleport(ped, vector3(-112.83, -65.93, 42.93))
                end
            end
        end 

        local dist2 = GetDistanceBetweenCoords(pcoords, vector3(-112.83, -65.93, 42.93), true)
        if dist2 <= 1.5 then
            sleep = 0
            Marker(-112.83, -65.93, 42.93)
            if dist2 <= 1.5 then
                HelpText(Config.Locale['tpex_room'])

                if IsControlJustPressed(0, 38) then
                    Teleport(ped, vector3(-90.77, -67.6, 57.93))
                end
            end
        end 

		for i=1, #Config.StartLocations, 1 do
            local dist3 = GetDistanceBetweenCoords(pcoords, Config.StartLocations[i].x, Config.StartLocations[i].y, Config.StartLocations[i].z, true)
            if dist3 <= 3.0 then
                sleep = 0
                Marker(Config.StartLocations[i].x, Config.StartLocations[i].y, Config.StartLocations[i].z)
                if dist3 <= 1.5 then
                    if working == false then
                        HelpText(Config.Locale['get_info'])
                    
                        if IsControlJustPressed(0, 38) then
                            if inmision == false then
                                if robbed == true then
                                    Notify(Config.Locale['robbed'])
                                else
                                    TriggerServerEvent('ivak-vanthief:AkR53PsKWETU98pDUMah')
                                end
                            else
                                Notify(Config.Locale['try'])
                            end
                        end
                    end
                end
            end 
        end

        local dist4 = GetDistanceBetweenCoords(pcoords, vector3(-116.36, -59.71, 55.42), true)
        if dist4 <= 7.0 then
            if IsPedInAnyVehicle(ped) and havevan == true then
                local vehicleModel = GetEntityModel(GetVehiclePedIsIn(ped))
                if vehicleModel == GetHashKey(vansb[1]) then
                    sleep = 0
                    Marker(-116.36, -59.71, 55.42,true)
                    if dist4 <= 1.5 then
                        if working == false then
                            HelpText(Config.Locale['dy_van'])
                        
                            if IsControlJustPressed(0, 38) then
                                local vehicle = GetVehiclePedIsIn(ped)
                                TaskLeaveVehicle(ped, vehicle, 1)
                                Wait(3000)
                                TriggerServerEvent('ivak-vanthief:KUsRmWpBKDuFb7NnmbCQ')
                                QBCore.Functions.DeleteVehicle(vehicle)
                                havevan = false
                                RemoveBlip(dyblip[1])
                                table.remove(dyblip)
                                table.remove(vansb)
                            end
                        end
                    end
                end
            end
        end 
			
        local vandist = GetDistanceBetweenCoords(pcoords, vanpos.x, vanpos.y, vanpos.z, true)
        if vandist <= 3 and lockpickvan == true then
            sleep = 0
            if working == false then
                HelpText(Config.Locale['lockpick_van'])

                if IsControlJustPressed(1, 47) then
                    FreezeEntityPosition(ped, true)
                    TriggerServerEvent('ivak-vanthief:YcB9jfzrY9TbrvWIhUVu', pcoords)
                    working = true
                    ExecuteCommand('e mechanic4') 
                    Wait(30000)
                    ExecuteCommand('e c')
                    SetVehicleDoorsLocked(van, 1)
                    TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(van))
                    RemoveBlip(vanb[1])
                    table.remove(vanb)
                    FreezeEntityPosition(ped, false)
                    lockpickvan = false
                    working = false
                    deliveryblip = AddBlipForCoord(vector3(-116.36, -59.71, 55.42))
                    SetBlipColour(deliveryblip, 1)
                    SetBlipRoute(deliveryblip, true)
                    SetBlipRouteColour(deliveryblip, 1)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString(Config.Locale['dy_blip'])
                    EndTextCommandSetBlipName(deliveryblip)
                    table.insert(dyblip, deliveryblip)
                    TriggerServerEvent('ivak-vanthief:8mwlGHX0z3CU6oeLNRKx')
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        sleep = 500
        if robbed == true then
            sleep = 0
            Wait(Config.TimeForNewRob)
            robbed = false
        end
        Wait(sleep)
    end
end)

-- Events
RegisterNetEvent('ivak-vanthief:9mb1Bh0fjClitijWbUOq')
AddEventHandler('ivak-vanthief:9mb1Bh0fjClitijWbUOq', function()
    working = true
    TriggerServerEvent('ivak-vanthief:kppKY43jcIHnjPlCRw4D')
    ExecuteCommand('e type')
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", 3, 30, hack)
end)

RegisterNetEvent('ivak-vanthief:tUznYAPengeJvqdHNxsJ')
AddEventHandler('ivak-vanthief:tUznYAPengeJvqdHNxsJ', function()
    inmision = true
end)

RegisterNetEvent('ivak-vanthief:rnKxIFXMYTeaf9YuAevL')
AddEventHandler('ivak-vanthief:rnKxIFXMYTeaf9YuAevL', function()
    inmision = false
end)

RegisterNetEvent('ivak-vanthief:gtoP7JGjzoYFN8DPWXln')
AddEventHandler('ivak-vanthief:gtoP7JGjzoYFN8DPWXln', function()
    robbed = true
end)

RegisterNetEvent('ivak-vanthief:notify')
AddEventHandler('ivak-vanthief:notify', function(msg)
    Notify(msg)
end)

RegisterNetEvent('ivak-vanthief:KwPlSZkI2vrqqPDi1Pd4')
AddEventHandler('ivak-vanthief:KwPlSZkI2vrqqPDi1Pd4', function(coords)
    local alpha = 250
    local policeblip = AddBlipForRadius(coords.x, coords.y, coords.z, 50.0)

    SetBlipHighDetail(policeblip, true)
    SetBlipColour(policeblip, 1)
    SetBlipAlpha(policeblip, alpha)
    SetBlipAsShortRange(policeblip, true)

    while alpha ~= 0 do
        Wait(170)
        alpha = alpha - 1
        SetBlipAlpha(policeblip, alpha)

        if alpha == 0 then
            RemoveBlip(policeblip)
            return
        end
    end
end)

-- Functions
function SpawnVan()
    local random = math.random(1, #Config.Locations)
    local vans = Config.Locations[random]
    local vmodel = vans.vanmodel
    RequestModel(GetHashKey(vmodel))
    while not HasModelLoaded(GetHashKey(vmodel)) do
        Wait(10)
    end
    van = CreateVehicle(GetHashKey(vmodel), vector3(vans.pos.x, vans.pos.y, vans.pos.z), vans.heading, true, false)
    SetVehicleDoorsLocked(van, 2)
    for i = 1, #vans.guards do
        RequestModel(GetHashKey(vans.guards[i].model))
        while not HasModelLoaded(GetHashKey(vans.guards[i].model)) do
            Wait(10)
        end
		npc = CreatePed(4,GetHashKey(vans.guards[i].model), vans.guards[i].coords[1], vans.guards[i].coords[2], vans.guards[i].coords[3], vans.guards[i].coords[4], true, true)
		SetPedCanSwitchWeapon(npc, true)
		SetPedAccuracy(npc, math.random(10,30))
		SetEntityInvincible(npc, false)
		SetEntityVisible(npc, true)
		GiveWeaponToPed(npc, GetHashKey(Config.GuardsWeapon), 250, false, false)
		SetPedDropsWeaponsWhenDead(npc, false)
		SetPedFleeAttributes(npc, 0, false)
		SetPedRelationshipGroupHash(npc, GetHashKey("Guards"))
		SetPedAlertness(npc,3)
		SetRelationshipBetweenGroups(0, GetHashKey("Guards"), GetHashKey("Guards"))
		SetRelationshipBetweenGroups(5, GetHashKey("Guards"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("Guards"))
		SetModelAsNoLongerNeeded(GetHashKey(GetHashKey(vans.guards[i].model)))
	end
    lockpickvan = true
    havevan = true
    vanblip = AddBlipForCoord(vector3(vans.pos.x, vans.pos.y, vans.pos.z))
    SetBlipColour(vanblip, 1)
    SetBlipRoute(vanblip, true)
    SetBlipRouteColour(vanblip, 1)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Config.Locale['van_blip'])
    EndTextCommandSetBlipName(vanblip)
    table.insert(vanb, vanblip)
    table.insert(vansb, vmodel)
end

function hack(success, timeremaining)
	Wait(1)
	if success then
        working = false
		TriggerEvent('mhacking:hide')
        ExecuteCommand('e c')
        Notify(Config.Locale['suc_hack'])
        SpawnVan()
	else
        working = false
		TriggerEvent('mhacking:hide')
        ExecuteCommand('e c')
        Notify(Config.Locale['fail_hack'])
	end
end

function HelpText(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function Notify(text)
    QBCore.Functions.Notify(text, 'primary')
end

function Teleport(ped, coords)
    DoScreenFadeOut(100)
    Wait(750)
    SetEntityCoords(PlayerPedId(), coords)
    DoScreenFadeIn(100)
end

function Marker(x, y, z, big)
    if big == true then
	    DrawMarker(27, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 3.5, 66, 30, 120, 90, false, true, 2, true, false, false, false)
    else
        DrawMarker(27, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.2, 1.2, 1.2, 66, 30, 120, 90, false, true, 2, true, false, false, false)
    end
end
