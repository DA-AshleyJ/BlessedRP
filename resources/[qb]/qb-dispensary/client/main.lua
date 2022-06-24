PlayerData = {}
local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
end)

local InService = false
local CurrentlyWorking = false
local BlipSell = nil
local TargetPos = nil
local HasDispensary = false
local NearVan = false
local LastGoal = 0
local DeliveriesCount = 0
local Delivered = false
local x = nil
local y = nil
local z = nil
local DispensaryBlip = {}
local ShowBlip = false
local DispensaryDelivered = false
local ownsVan = false

-- Main Blip

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-1169.29, -1572.78, 4.66)
    SetBlipSprite(blip, 496)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, 52)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Smoke on the water')
    EndTextCommandSetBlipName(blip)
end)

--Spawning the Car

function PullOutVehicle()
    if ownsVan == true then
        QBCore.Functions.Notify("You already have a vehicle! Go and collect it or end your job.", "error")
    elseif ownsVan == false then
        CurrentlyWorking = true
        coords = Config.Zones.Spawn.Pos
        QBCore.Functions.SpawnVehicle(Config.CarName, function(veh)
            SetVehicleNumberPlateText(veh, "SMOKE"..tostring(math.random(100, 999)))
            SetEntityHeading(veh, coords.h)
            SetVehicleLivery(veh,2)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            Citizen.Wait(2000)
            --TriggerEvent("chatMessage", "Boss", "normal", 'Thanks for helping out! Grab the vehicle around the back.')
            TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Boss",
            subject = "Delivery Work",
            message = "Thanks for helping out, I left a van on the side street ready for you.",
            })
            Citizen.Wait(3000)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, true, true)
            plaquevehicule = GetVehicleNumberPlateText(veh)
        end, coords, true)
        InService = true
        DrawTarget()
        AddCancelBlip()
        ownsVan = true
    end
end

-- Main 3D text

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentlyWorking == false then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = GetDistanceBetweenCoords(pos, Config.Zones.Vehicle.Pos.x, Config.Zones.Vehicle.Pos.y, Config.Zones.Vehicle.Pos.z, true)
            if dist <= 2.5 then
                local GaragePos = {
                    ["x"] = Config.Zones.Vehicle.Pos.x,
                    ["y"] = Config.Zones.Vehicle.Pos.y,
                    ["z"] = Config.Zones.Vehicle.Pos.z + 1}
                DrawText3Ds(GaragePos["x"],GaragePos["y"],GaragePos["z"], "[~g~G~s~] Become a part time Smoke On The Water delivery driver")
                if dist <= 3.0 then
                    if IsControlJustReleased(0, 47) then
                        PullOutVehicle()
                    end
                end
            end
        end
    end
end)

--Places to Drop off

function DrawTarget()
    local RandomPoint = math.random(1, 10)
    if DeliveriesCount == 4 then
        QBCore.Functions.Notify("All dispensary products delivered.","success")
        RemoveCancelBlip()
        SetBlipRoute(BlipSell, false)
        AddFinnishBlip()
        Delivered = true
				x = nil
				y = nil
				z = nil
    else
      local dispensary = 10 - DeliveriesCount
      if dispensary == 1 then
        QBCore.Functions.Notify("You have delivery left","success")
      else
        if dispensary == 10 then
            dispensary = 'Ten'
        elseif dispensary == 9 then
            dispensary = 'Nine'
        elseif dispensary == 8 then
            dispensary = 'Eight'
        elseif dispensary == 7 then
            dispensary = 'Seven'
        elseif dispensary == 6 then
            dispensary = 'Six'
        elseif dispensary == 5 then
            dispensary = 'Five'
        elseif dispensary == 4 then
          dispensary = 'Four'
        elseif dispensary == 3 then
          dispensary = 'Three'
        elseif dispensary == 2 then
          dispensary = 'Two'
        end
        QBCore.Functions.Notify("You have "..dispensary.." dispensary products left","primary")
      end
        if LastGoal == RandomPoint then
            DrawTarget()
        else
            if RandomPoint == 1 then x = -1931.22 y = 362.59 z = 93.98
                LastGoal = 1
            elseif RandomPoint == 2 then x = -1452.87 y = 545.68 z = 121.0
                LastGoal = 2
            elseif RandomPoint == 3 then x = -1094.79 y = 427.29 z = 75.88
                LastGoal = 3
            elseif RandomPoint == 4 then x = -853.03 y = 695.14 z = 148.99
                LastGoal = 4
            elseif RandomPoint == 5 then x = 198.1 y = 162.11 z = 56.35
                LastGoal = 5
            elseif RandomPoint == 6 then x = -579.69 y = 732.76 z = 184.22
                LastGoal = 6
            elseif RandomPoint == 7 then x = -230.4 y = 487.83 z = 127.77
                LastGoal = 7
            elseif RandomPoint == 8 then x = 57.5 y = 449.67 z = 147.03
                LastGoal = 8
            elseif RandomPoint == 9 then x = 232.24 y = 672.16 z = 189.98
                LastGoal = 9
            elseif RandomPoint == 10 then x = -494.05 y = 796.09 z = 184.34
                LastGoal = 10
            end
		    AddObjBlip(TargetPos)
        end
    end
end

function AddObjBlip(TargetPos)
    DispensaryBlip['obj'] = AddBlipForCoord(x, y, z)
    SetBlipSprite(DispensaryBlip['obj'], 480)
    SetBlipColour(DispensaryBlip['obj'], 5)
    SetBlipRoute(DispensaryBlip['obj'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Customer')
	EndTextCommandSetBlipName(DispensaryBlip['obj'])
end

function AddCancelBlip()
    DispensaryBlip['cancel'] = AddBlipForCoord(-1158.38, -1588.77, 4.0)
    SetBlipSprite(DispensaryBlip['cancel'], 440)
	SetBlipColour(DispensaryBlip['cancel'], 59)
    SetBlipScale(DispensaryBlip['cancel'], 0.5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Cancel Orders')
	EndTextCommandSetBlipName(DispensaryBlip['cancel'])
end

function AddFinnishBlip()
    DispensaryBlip['end'] = AddBlipForCoord(-1158.38, -1588.77, 4.0)
    SetBlipSprite(DispensaryBlip['end'], 500)
	SetBlipColour(DispensaryBlip['end'], 2)
    SetBlipRoute(DispensaryBlip['end'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Finish Shift')
	EndTextCommandSetBlipName(DispensaryBlip['end'])
end

function RemoveBlipObj()
    RemoveBlip(DispensaryBlip['obj'])
end

function RemoveCancelBlip()
    RemoveBlip(DispensaryBlip['cancel'])
end

function RemoveAllBlips()
    RemoveBlip(DispensaryBlip['obj'])
    RemoveBlip(DispensaryBlip['cancel'])
    RemoveBlip(DispensaryBlip['end'])
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(pos, x, y, z, true)
        if dist <= 20.0 and CurrentlyWorking and (not HasDispensary) then
            local DeliveryPoint = {
                ["x"] = x,
                ["y"] = y,
                ["z"] = z
            }
            DrawText3Ds(DeliveryPoint["x"],DeliveryPoint["y"],DeliveryPoint["z"], "Take ~y~Dispensary Products~s~ from ~b~vehicle~s~!")
            local Vehicle = GetClosestVehicle(pos, 6.0, 0, 70)
            if IsVehicleModel(Vehicle, GetHashKey(Config.CarName)) then
                local VehPos = GetEntityCoords(Vehicle)
				local distance = GetDistanceBetweenCoords(pos, VehPos, true)
                DrawText3Ds(VehPos.x,VehPos.y,VehPos.z, "[~g~G~s~] Pull out ~y~Dispensary Products")
                if dist >= 4 and distance <= 5 then
                    NearVan = true
                end
            end
        elseif dist <= 25 and HasDispensary and CurrentlyWorking then
            local DeliveryPoint = {
                ["x"] = x,
                ["y"] = y,
                ["z"] = z
            }
            DrawText3Ds(DeliveryPoint["x"],DeliveryPoint["y"],DeliveryPoint["z"], "[~g~G~s~] Deliver ~y~Dispensary Products")
            if dist <= 3 then
                if IsControlJustReleased(0, 47) then
                    DeliverDispensary()
                    DispensaryAnim()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if (not HasDispensary) and NearVan then
			if IsControlJustReleased(0, 47) then
                DispensaryAnim()
                NearVan = false
			end
		end
	end
end)

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

function DispensaryAnim()
    local player = PlayerPedId()
    if not IsPedInAnyVehicle(player, false) then
        local anim = "missfbi4prepp1"
        local prop_name = 'prop_weed_bottle'
        if (DoesEntityExist(player) and not IsEntityDead(player)) then
            --loadAnimDict(anim)
            loadAnimDict(anim)
            TaskPlayAnim(ped, missfbi4prepp1, '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            if HasDispensary then
                TaskPlayAnim(player, anim, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
                DetachEntity(prop, 1, 1)
                DeleteObject(prop)
                Wait(1000)
                ClearPedSecondaryTask(PlayerPedId())
                HasDispensary = false
            else
                local x,y,z = table.unpack(GetEntityCoords(player))
                prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.1, 0.05, 0.0, -75.0, 320.0, 0.0, true, true, false, true, 1, true)
                TaskPlayAnim( player, anim, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                HasDispensary = true
            end
        end
    end
end

--Knock on door anim

function DeliverDispensary()
    if not DispensaryDelivered then
        dist = 27
        QBCore.Functions.Progressbar("sell_dispensary1", "Delivering dispensary products...", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "timetable@jimmy@doorknock@",
            anim = "knockdoor_idle",
            flags = 16,
        }, {}, {}, function() -- Done
                Wait(300)
                TriggerEvent('animations:client:EmoteCommandStart', {"point"})
                Wait(750)
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                DispensaryDelivered = true
                DeliveriesCount = DeliveriesCount + 1
                RemoveBlipObj()
                SetBlipRoute(BlipSell, false)
                HasDispensary = false
                NextDelivery()
                Citizen.Wait(2500)
                DispensaryDelivered = false
        end, function()
            QBCore.Functions.Notify("Failed!", "error")
        end)
    end
end

function NextDelivery()
    TriggerServerEvent('RouteDispensary:Tips')
    Citizen.Wait(300)
    DrawTarget()
end

--Job End

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId() 
        local pos = GetEntityCoords(ped)
        local DistanceFromEndZone = GetDistanceBetweenCoords(pos, -1158.38, -1588.77, 4.0, true)
        local DistanceFromCancelZone = GetDistanceBetweenCoords(pos, -1158.38, -1588.77, 4.0, true)
        if InService then
            if Delivered then
                if DistanceFromEndZone <= 2.5 then
                    local endPoint = {
                        ["x"] = -1158.38,
                        ["y"] = -1588.77,
                        ["z"] = 4.0
                    }
                    DrawText3Ds(endPoint["x"],endPoint["y"],endPoint["z"], "[~g~G~s~] End Shift")
                    if DistanceFromEndZone <= 7 then
                        if IsControlJustReleased(0, 47) then
                            QBCore.Functions.Notify("You finished your shift, Enjoy your time off.", "success")
                            TriggerServerEvent('RouteDispensary:Payment')
                            CurrentlyWorking = false
                            EndOfWork()
                        end
                    end
                end
            else
                if DistanceFromCancelZone <= 2.5 then
                    local cancel = {
                        ["x"] = -1158.38,
                        ["y"] = -1588.77,
                        ["z"] = 4.0
                    }
                    DrawText3Ds(cancel["x"],cancel["y"],cancel["z"], "[~g~G~s~] ~r~Cancel~s~ Orders")
                    if DistanceFromCancelZone <= 7 then
                        if IsControlJustReleased(0, 47) then
                            QBCore.Functions.Notify("Orders Canceled!", "error")
							EndOfWork()
                        end
                    end
                end
            end
        end
    end
end)


function EndOfWork()
    RemoveAllBlips()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local Van = GetVehiclePedIsIn(ped, false)
        if IsVehicleModel(Van, GetHashKey(Config.CarName)) then
            QBCore.Functions.DeleteVehicle(Van)
            InService = false
            BlipSell = nil
            TargetPos = nil
            HasDispensary = false
            LastGoal = nil
            DeliveriesCount = 0
            x = nil
            y = nil
            z = nil
            ownsVan = false
            Delivered = false
        else
            QBCore.Functions.Notify("You must return to vehicle!", "error")
            QBCore.Functions.Notify("If you lost the vehicle cancel the job on foot", "error")
        end
    else
        InService = false
        BlipSell = nil
        TargetPos = nil
        HasDispensary = false
        LastGoal = nil
        DeliveriesCount = 0
        x = nil
        y = nil
        z = nil
        ownsVan = false
        Delivered = false
    end
end

DrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end