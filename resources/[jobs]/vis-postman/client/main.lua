local QBCore = exports['qb-core']:GetCoreObject()

local Base = Config.Postman.Base
local Garage = Config.Postman.Garage
local Marker = Config.Postman.DefaultMarker
local GarageSpawnPoint = Config.Postman.GarageSpawnPoint
local Type = nil
local AmountPayout = 0
local done = 0
local PlayerData = {}
local salary = nil
local Login = false
local experience = 0

hasBag = false
onDuty = false
hasVan = false
inGarageMenu = false
inMenu = false
wasTalked = false
appointed = false
waitingDone = false
CanWork = false
Paycheck = false
hasOpenDoor = false
HasUpdate = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    Login = true
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function()
    PlayerData.job = QBCore.Functions.GetPlayerData().job
end)

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

--[[ Experience BASE
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if Login then
			QBCore.Functions.TriggerCallback('Postman:getexperience', function(cb)
				experience = cb
			end, PlayerData)
			break
		end
	end
end)]]--

-- ON/OFF Duty BASE
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        
        if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 8) then
            sleep = 5
            DrawMarker(Base.Type, Base.Pos.x, Base.Pos.y, Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Base.Size.x, Base.Size.y, Base.Size.z, Base.Color.r, Base.Color.g, Base.Color.b, 100, false, true, 2, false, false, false, false)
            if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 1.2) then
                -- On duty script
                if not onDuty then
                    sleep = 5
                    while NeedsUpdate do
                        QBCore.Functions.TriggerCallback('Postman:getexperience', function(cb)
                            experience = cb
                        end, PlayerData)
                    end

                    DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, '~g~[E]~s~ - Change into work clothes')
                    DrawText3Dss(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.2, '~g~[Level]~s~: '..math.ceil(experience/1000))
                    if IsControlJustPressed(0, Keys['E']) then
                        exports.rprogress:Custom({
                            Duration = 2500,
                            Label = "You're changing your clothes...",
                            Animation = {
                                scenario = "WORLD_HUMAN_COP_IDLES",
                                animationDictionary = "idle_a"
                            },
                            DisableControls = {
                                Mouse = false,
                                Player = true,
                                Vehicle = true
                            }
                        })
                        Citizen.Wait(2500)
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        --These are clothing options for male and female respectively, needs to be changed later
                        if PlayerData.charinfo.gender == 0 then 
                            SetPedComponentVariation(ped, 3, Config.Clothes.male['arms'], 0, 0) --arms
                            SetPedComponentVariation(ped, 8, Config.Clothes.male['tshirt_1'], Config.Clothes.male['tshirt_2'], 0) --t-shirt
                            SetPedComponentVariation(ped, 11, Config.Clothes.male['torso_1'], Config.Clothes.male['torso_2'], 0) --torso2
                            SetPedComponentVariation(ped, 9, Config.Clothes.male['bproof_1'], Config.Clothes.male['bproof_2'], 0) --vest
                            SetPedComponentVariation(ped, 10, Config.Clothes.male['decals_1'], Config.Clothes.male['decals_2'], 0) --decals
                            SetPedComponentVariation(ped, 7, Config.Clothes.male['neck_1'], Config.Clothes.male['neck_2'], 0) --accessory
                            SetPedComponentVariation(ped, 4, Config.Clothes.male['pants_1'], Config.Clothes.male['pants_2'], 0) -- pants
                            SetPedComponentVariation(ped, 6, Config.Clothes.male['shoes_1'], Config.Clothes.male['shoes_2'], 0) --shoes
                        else
                            SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
                            SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) --t-shirt
                            SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0) --torso2
                            SetPedComponentVariation(ped, 9, Config.Clothes.female['bproof_1'], Config.Clothes.female['bproof_2'], 0) --vest
                            SetPedComponentVariation(ped, 10, Config.Clothes.female['decals_1'], Config.Clothes.female['decals_2'], 0) --decals
                            SetPedComponentVariation(ped, 7, Config.Clothes.female['chain_1'], Config.Clothes.female['chain_2'], 0) --accessory
                            SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0) -- pants
                            SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0) --shoes
                        end
                        exports.pNotify:SendNotification({text = "<b>Postman</b></br>You started working!", timeout = 3000})
                        onDuty = true
                        addGarageBlip()
                        exports.pNotify:SendNotification({text = "<b>Postman</b></br> To open the work menu, press <b>[DEL]</b>", timeout = 5000})
                    end
                    -- OffDuty script
                elseif onDuty then
                    sleep = 5
                    DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, '~r~[E]~s~ - Change into citizen clothes')
                    if IsControlJustPressed(0, Keys["E"]) then
                        exports.rprogress:Custom({
                            Duration = 2500,
                            Label = "You're changing your clothes...",
                            Animation = {
                                scenario = "WORLD_HUMAN_COP_IDLES",
                                animationDictionary = "idle_a",
                            },
                            DisableControls = {
                                Mouse = false,
                                Player = true,
                                Vehicle = true
                            }
                        })
                        Citizen.Wait(2500)
                        TriggerServerEvent("qb-clothes:loadPlayerSkin")
                        exports.pNotify:SendNotification({text = "<b>Postman</b><br> You finished work!", timeout = 3000})
                        onDuty = false
                        removeGarageBlip()
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

--Searching for work district/assigning
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        
        if onDuty then
            if not inMenu then
                sleep = 2
                if IsControlJustPressed(0, Keys["DEL"]) then
                    inMenu = true
                end
            elseif inMenu then
                sleep =2
                DrawText3Dss(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Search a errand | ~r~[8]~s~ - Cancel errand')
                if IsControlJustPressed(0, Keys["DEL"]) then
                    inMenu = false
                elseif IsControlJustPressed(0, Keys["7"]) then
                    if Type == nil then
                        inMenu = false
                        exports.pNotify:SendNotification({text = "<b>Postman</b></br>Searching a errand...", timeout = 15000})
                        Citizen.Wait(15000)
                        PostalDistrict = Randomize(Config.Postal)
                        CreateWork(PostalDistrict.District)
                        exports.pNotify:SendNotification({text = "<b>Postman</b></br>GPS location set! Drive to " ..PostalDistrict.District, timeout = 2000})
                        if Type == "Westminster" then
                            for i, v in ipairs(Config.Westminster) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        elseif Type == "Canning Town" then
                            for i, v in ipairs(Config.CanningTown) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        elseif Type == "Ruislip" then
                            for i, v in ipairs(Config.Ruislip) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        elseif Type == "Isle Of Dogs" then
                            for i, v in ipairs(Config.IsleOfDogs) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        elseif Type == "Harrow" then
                            for i, v in ipairs(Config.Harrow) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        elseif Type == "Chelsea" then
                            for i, v in ipairs(Config.Chelsea) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        elseif Type == "Royal Docks" then
                            for i, v in ipairs(Config.RoyalDocks) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        elseif Type == "Canary Wharf" then
                            for i, v in ipairs(Config.CanaryWharf) do
                                SetNewWaypoint(v.x, v.y, v.z)
                            end
                        end
                    else
                        exports.pNotify:SendNotification({text = "<b>Postman</b></br>You already have an errand!", timeout = 2000})
                    end
                elseif IsControlJustPressed(0, Keys["8"]) then
                    if Type then
                        CancelWork()
                        DeleteWaypoint()
                        exports.pNotify:SendNotification({text = "<b>Postman</b></br>You canceled your district assignment", timeout = 2000})
                    elseif not Type then
                        exports.pNotify:SendNotification({text = "<b>Postman</b></br>You currently have no appointment", timeout = 2000})
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- Garage Menu

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(ped, false)

                if onDuty then
                    if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Marker.Type, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Garage.Size.x, Garage.Size.y, Garage.Size.z, Garage.Color.r, Garage.Color.g, Garage.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 1.2) then
                            if IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~r~[E]~s~ - Return vehicle\n ~r~[G]~s~ Deliver mail')
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if hasVan then
                                        TriggerServerEvent('Postman:returnVehicle', source)
                                        ReturnVehicle()
                                        exports.pNotify:SendNotification({text = '<b>Postman</b></br>You received £' ..Config.DepositPrice.. ' for returning the vehicle', timeout = 1500})
                                        hasVan = false
                                        Plate = nil
                                    else
                                        exports.pNotify:SendNotification({text = "<b>Postman</b></br>You haven't paid deposit for this vehicle!", timeout = 2500})
                                    end
                                elseif IsControlJustReleased(0, Keys['G']) then
                                    if hasVan then
                                        if not Paycheck then
                                            if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)) then
                                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.95, "You haven't finished collecting all the mail, Get back to your district")
                                                Citizen.Wait(3500)
                                                
                                            end
                                        elseif Paycheck then
                                            if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)) then
                                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.95, "You've collected all the mail in the District")
                                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 1.0, "~g~[G]~s~ Take the money")
                                                if IsControlJustReleased(0, Keys["G"]) then
                                                    TriggerServerEvent('Postman:returnVehicle', source)
                                                    ReturnVehicle()
                                                    hasVan = false
                                                    Plate = nil
                                                    NeedsUpdate = true
                                                    salary = math.random(300, 900)
                                                    TriggerServerEvent('Postman:Payout', salary, AmountPayout)
                                                    exports.pNotify:SendNotification({text = "<b>Postman</b></br>You earned £"..salary.."!", timeout = 2500})
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                end
                                            end
                                        end
                                    end
                                end
                            elseif not IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                if not inGarageMenu then
                                    DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~g~[E]~s~ - Open Garage Menu')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if not inMenu then
                                            FreezeEntityPosition(ped, true)
                                            inGarageMenu = true
                                            exports.pNotify:SendNotification({text = '<b>Postman</b></br>Select a parking space', timeout = 2500})
                                        elseif inMenu then
                                            exports.pNotify:SendNotification({text = "<b>Postman</b></br>Close the work menu!", timeout = 2500})
                                        end
                                    end
                                elseif inGarageMenu then
                                    DrawText3DMenu(Garage.Pos.x - 0.8, Garage.Pos.y, Garage.Pos.z + 0.8, '~g~[7]~s~ - Parking Space #1\n~r~[E]~s~ - Close Garage Menu ')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        inGarageMenu = false
                                        FreezeEntityPosition(ped, false)
                                    elseif IsControlJustReleased(0, Keys["7"]) then
                                        if not hasVan then
                                            QBCore.Functions.TriggerCallback('Postman:checkMoney', function(hasMoney)
                                            if hasMoney then
                                                QBCore.Functions.SpawnVehicle(Config.CompanyVehicle, function(vehicle)
                                                    SetEntityHeading(vehicle, GarageSpawnPoint.Pos1.h)
                                                    SetVehicleNumberPlateText(vehicle, "GRD"..tostring(math.random(1000, 9999)))
                                                    SetVehicleEngineOn(vehicle, true, true)
                                                    SetEntityAsMissionEntity(vehicle, true, true)
                                                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
                                                    exports.pNotify:SendNotification({text = '<b>Postman</b></br>You paid £' ..Config.DepositPrice.. ' to take out the vehicle', timeout = 1500})
                                                    hasVan = true
                                                    Plate = GetVehicleNumberPlateText(vehicle)
                                                end, vector3(GarageSpawnPoint.Pos1.x, GarageSpawnPoint.Pos1.y, GarageSpawnPoint.Pos1.z), true)
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            else
                                                exports.pNotify:SendNotification({text = "<b>Postman</b></br>You don't have enough money!", timeout = 2500})
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            end
                                            end)
                                        elseif hasVan then
                                            exports.pNotify:SendNotification({text = "<b>Postman</b></br>First, return the car you pulled out", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            --end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

            if hasVan then
                if not IsPedInAnyVehicle(ped, false) then
                    if Plate == GetVehicleNumberPlateText(vehicle) then
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.0, 0)
                        if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2) then
                            if not hasOpenDoor then
                                sleep = 5
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[G]~s~ - Open Doors")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    exports.rprogress:Custom({
                                        Duration = 1500,
                                        Label = "You're opening the rear doors",
                                        DisableControls = {
                                            Mouse = false,
                                            Player = true,
                                            Vehicle = true
                                        }
                                    })
                                    Citizen.Wait(1500)
                                    SetVehicleDoorOpen(vehicle, 3, false, false)
                                    SetVehicleDoorOpen(vehicle, 2, false, false)
                                    hasOpenDoor = true
                                end
                            end
                        elseif hasOpenDoor then
                            sleep = 5
                            if hasBag then
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.7, "~g~[E]~s~ - Place Bag in Trunk")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    exports.rprogress:Custom({
                                        Duration = 1000,
                                        Label = "Throwing the postal sack into the van",
                                        DisableControls = {
                                            Mouse = false,
                                            Player = true,
                                            Vehicle = true
                                        }
                                    })
                                    Citizen.Wait(1000)
                                    DeliverAnim()
                                    hasBag = false
                                    SetVehicleDoorShut(vehicle, 3, false)
                                    SetVehicleDoorShut(vehicle, 2, false)
                                    hasOpenDoor = false
                                end
                            elseif not hasBag then
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.7, "~g~[E]~s~ - Close the doors")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    exports.rprogress:Custom({
                                        Duration = 1500,
                                        Label = "Closing the doors",
                                        DisableControls = {
                                            Mouse = false,
                                            Player = true,
                                            Vehicle = true
                                        }
                                    })
                                    Citizen.Wait(1500)
                                    SetVehicleDoorShut(vehicle, 3, false)
                                    SetVehicleDoorShut(vehicle, 2, false)
                                    hasOpenDoor = false
                                end
                            end
                        end
                    end
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
        
            if Type == 'Westminster' then
                for i, v in ipairs(Config.Westminster) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Welcome to the " .. Type .. " Postal District, lets get started shall we?")
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                                if IsControlJustReleased(0, Keys['7']) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    for i, f in ipairs(Config.WestminsterWork) do
                                        BlipsPickup(f)
                                    end
                                    exports.pNotify:SendNotification({text = "<b>Postman</b></br>Collect the mail from the mail boxes", timeout = 5000})
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                end
                            end
                            elseif wasTalked then
                                if not appointed then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Wow, ditching your assigned district? How Professional.")
                                    end
                                elseif appointed then
                                    if not waitingDone then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great, when you are done collecting the mail for this district, head back to the depot!")
                                        end
                                    waitingDone = true
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.WestminsterWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    WorkFlow(v, ped)
                                end
                            end
                        end
                    end
                end
            elseif Type == "Chelsea" then
                for i, v in ipairs(Config.Chelsea) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Welcome to the " .. Type .. " Postal District, lets get started shall we?")
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                                if IsControlJustReleased(0, Keys['7']) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    for i, f in ipairs(Config.ChelseaWork) do
                                        BlipsPickup(f)
                                    end
                                    exports.pNotify:SendNotification({text = "<b>Postman</b></br>Collect the mail from the mail boxes", timeout = 5000})
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                end
                            end
                            elseif wasTalked then
                                if not appointed then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Wow, ditching your assigned district? How Professional.")
                                    elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        CancelWork()
                                    end
                                elseif appointed then
                                    if not waitingDone then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great, when you are done collecting the mail for this district, head back to the depot!")
                                        end
                                        waitingDone = true
                                    end
                                end
                            end
                        end
                    end
                    if CanWork then
                        for i, v in ipairs(Config.ChelseaWork) do
                            if not v.taked then
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                    sleep = 5
                                    DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                        WorkFlow(v, ped)
                                    end
                                end
                            end
                        end
                    end
            elseif Type == 'Canning Town' then
                for i, v in ipairs(Config.CanningTown) do
                    local coordsNPC = GetEntityCoords(v.ped, false)                
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Welcome to the " .. Type .. " Postal District, lets get started shall we?")
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                                if IsControlJustReleased(0, Keys['7']) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    for i, f in ipairs(Config.CanningTownWork) do
                                        BlipsPickup(f)
                                    end
                                    exports.pNotify:SendNotification({text = "<b>Postman</b></br>Collect the mail from the mail boxes", timeout = 5000})
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                end
                            end
                            elseif wasTalked then
                                if not appointed then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Wow, ditching your assigned district? How Professional.")
                                    elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        CancelWork()
                                    end
                                elseif appointed then
                                    if not waitingDone then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great, when you are done collecting the mail for this district, head back to the depot!")
                                        end
                                    waitingDone = true
                                end
                            end
                        end
                    end
                end
            if CanWork then
                for i, v in ipairs(Config.CanningTownWork) do
                    if not v.taked then
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                            sleep = 5
                            DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                WorkFlow(v, ped)
                            end
                        end
                    end
                end
            end
        elseif Type == "Ruislip" then
            for i, v in ipairs(Config.Ruislip) do
                local coordsNPC = GetEntityCoords(v.ped, false)
                
                sleep = 5
                if not IsPedInAnyVehicle(ped, false) then
                    if not wasTalked then
                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Welcome to the " .. Type .. " Postal District, lets get started shall we?")
                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                            if IsControlJustReleased(0, Keys['7']) then
                                wasTalked = true
                                appointed = true
                                CanWork = true
                                FreezeEntityPosition(v.ped, false)
                                for i, f in ipairs(Config.RuislipWork) do
                                    BlipsPickup(f)
                                end
                                exports.pNotify:SendNotification({text = "<b>Postman</b></br>Collect the mail from the mail boxes", timeout = 5000})
                            elseif IsControlJustReleased(0, Keys["8"]) then
                                wasTalked = true
                                appointed = false
                                FreezeEntityPosition(v.ped, false)
                            end
                        end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Wow, ditching your assigned district? How Professional.")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great, when you are done collecting the mail for this district, head back to the depot!")
                                    end
                                waitingDone = true
                            end
                        end
                    end
                end
            end
            if CanWork then
                for i, v in ipairs(Config.RuislipWork) do
                    if not v.taked then
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                            sleep = 5
                            DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                WorkFlow(v, ped)
                            end
                        end
                    end
                end
            end
        elseif Type == "Isle of Dogs" then
            for i, v in ipairs(Config.IsleOfDogs) do
                local coordsNPC = GetEntityCoords(v.ped, false)
                
                sleep = 5
                if not IsPedInAnyVehicle(ped, false) then
                    if not wasTalked then
                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Welcome to the " .. Type .. " Postal District, lets get started shall we?")
                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                            if IsControlJustReleased(0, Keys['7']) then
                                wasTalked = true
                                appointed = true
                                CanWork = true
                                FreezeEntityPosition(v.ped, false)
                                for i, f in ipairs(Config.IsleOfDogsWork) do
                                    BlipsPickup(f)
                                end
                                exports.pNotify:SendNotification({text = "<b>Postman</b></br>Collect the mail from the mail boxes", timeout = 5000})
                            elseif IsControlJustReleased(0, Keys["8"]) then
                                wasTalked = true
                                appointed = false
                                FreezeEntityPosition(v.ped, false)
                            end
                        end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Wow, ditching your assigned district? How Professional.")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great, when you are done collecting the mail for this district, head back to the depot!")
                                    end
                                waitingDone = true
                            end
                        end
                    end
                end
            end
            if CanWork then
                for i, v in ipairs(Config.IsleOfDogsWork) do
                    if not v.taked then
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                            sleep = 5
                            DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                WorkFlow(v, ped)
                            end
                        end
                    end
                end
        elseif Type == "Harrow" then
            for i, v in ipairs(Config.Harrow) do
                local coordsNPC = GetEntityCoords(v.ped, false)
                
                sleep = 5
                if not IsPedInAnyVehicle(ped, false) then
                    if not wasTalked then
                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Welcome to the " .. Type .. " Postal District, lets get started shall we?")
                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                            if IsControlJustReleased(0, Keys['7']) then
                                wasTalked = true
                                appointed = true
                                CanWork = true
                                FreezeEntityPosition(v.ped, false)
                                for i, f in ipairs(Config.HarrowWork) do
                                    BlipsPickup(f)
                                end
                                exports.pNotify:SendNotification({text = "<b>Postman</b></br>Collect the mail from the mail boxes", timeout = 5000})
                            elseif IsControlJustReleased(0, Keys["8"]) then
                                wasTalked = true
                                appointed = false
                                FreezeEntityPosition(v.ped, false)
                            end
                        end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Wow, ditching your assigned district? How Professional.")
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great, when you are done collecting the mail for this district, head back to the depot!")
                                    end
                                waitingDone = true
                            end
                        end
                    end
                end
            end
            if CanWork then
                for i, v in ipairs(Config.HarrowWork) do
                    if not v.taked then
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                            sleep = 5
                            DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                WorkFlow(v, ped)
                            end
                        end
                    end
                end
            end
        elseif Type == "Royal Docks" then
            for i, v in ipairs(Config.RoyalDocks) do
                local coordsNPC = GetEntityCoords(v.ped, false)
                
                sleep = 5
                if not IsPedInAnyVehicle(ped, false) then
                    if not wasTalked then
                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Welcome to the " .. Type .. " Postal District, lets get started shall we?")
                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                            if IsControlJustReleased(0, Keys['7']) then
                                wasTalked = true
                                appointed = true
                                CanWork = true
                                FreezeEntityPosition(v.ped, false)
                                for i, f in ipairs(Config.RoyalDocks) do
                                    BlipsPickup(f)
                                end
                                exports.pNotify:SendNotification({text = "<b>Postman</b></br>Collect the mail from the mail boxes", timeout = 5000})
                            elseif IsControlJustReleased(0, Keys["8"]) then
                                wasTalked = true
                                appointed = false
                                FreezeEntityPosition(v.ped, false)
                            end
                        end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Wow, ditching your assigned district? How Professional.")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great, when you are done collecting the mail for this district, head back to the depot!")
                                    end
                                    waitingDone = true
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.RoyalDocksWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    WorkFlow(v, ped)
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    baseBlip = AddBlipForCoord(Base.Pos.x, Base.Pos.y, Base.Pos.z)
    SetBlipSprite(baseBlip, Base.BlipSprite)
    SetBlipDisplay(baseBlip, 4)
    SetBlipScale(baseBlip, Base.BlipScale)
    SetBlipAsShortRange(baseBlip, true)
    SetBlipColour(baseBlip, Base.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Base.BlipLabel)
    EndTextCommandSetBlipName(baseBlip)
end)

-- Functions

function ReturnVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    QBCore.Functions.DeleteVehicle(vehicle)
end

function CreateWork(type)
    if type == "Westminster" then
        for i, v in ipairs(Config.Westminster) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Postman] District')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.Peds['Peds'][math.random(1,#Config.Peds['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Canning Town" then
        for i, v in ipairs(Config.CanningTown) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Postman] District')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.Peds['Peds'][math.random(1,#Config.Peds['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Ruislip" then
        for i, v in ipairs(Config.Ruislip) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Postman] District')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.Peds['Peds'][math.random(1,#Config.Peds['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Chelsea" then
        for i, v in ipairs(Config.Chelsea) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Postman] District')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.Peds['Peds'][math.random(1,#Config.Peds['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    end
    Type = type
end

function CancelWork()
    if Type == "Westminster" then
        for i, v in ipairs(Config.Westminster) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.WestminsterWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Canning Town" then
        for i, v in ipairs(Config.CanningTown) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.CanningTownWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Ruislip" then
        for i, v in ipairs(Config.Ruislip) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.RuislipWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Chelsea" then
        for i, v in ipairs(Config.Chelsea) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.ChelseaWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    end
    Type = nil
    appointed = false
    wasTalked = false
    waitingDone = false
    CanWork = false
    Paycheck = false
    salary = nil
    AmountPayout = 0
    done = 0
end

function removeGarageBlip()
    RemoveBlip(garageBlip)
end

function addGarageBlip()
    garageBlip = AddBlipForCoord(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
    SetBlipSprite(garageBlip, Garage.BlipSprite)
    SetBlipDisplay(garageBlip, 4)
    SetBlipScale(garageBlip, Garage.BlipScale)
    SetBlipAsShortRange(garageBlip, true)
    SetBlipColour(garageBlip, Garage.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Garage.BlipLabel)
    EndTextCommandSetBlipName(garageBlip)
end

function BlipsPickup(v)
    v.blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(v.blip, 1)
    SetBlipColour(v.blip, 24)
    SetBlipScale(v.blip, 0.4)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("[Postman] Post Boxes")
    EndTextCommandSetBlipName(v.blip)
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

function DrawText3Dss(x, y, z, text)
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
    DrawRect(0.0, 0.0+0.0125, 0.008+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3DMenu(x, y, z, text)
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
    DrawRect(0.0, 0.02+0.0125, -0.14+ factor, 0.08, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function LoadAnimation(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(10) end
end

function AnimCheck()
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if hasBag then
                if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                    ClearPedTasksImmediately(ped)
                    LoadAnimation('missfbi4prepp1')
                    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            else
                break
            end
            Wait(200)
        end
    end)
end

function TakeAnim()
    local ped = PlayerPedId()
    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    garbageObject = CreateObject(`prop_cs_rub_binbag_01`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(garbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
    AnimCheck()
end

function DeliverAnim()
    local ped = PlayerPedId()
    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(garbageVehicle))
    canTakeBag = false
    SetTimeout(1250, function()
        DetachEntity(garbageObject, 1, false)
        DeleteObject(garbageObject)
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
        FreezeEntityPosition(ped, false)
        garbageObject = nil
        canTakeBag = true
    end)
end

function WorkFlow(v, ped)
    sleep = 5
    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Collect the post")
    if IsControlJustReleased(0, Keys["E"]) then
        exports.rprogress:Custom({
            Duration = 1000,
            Label = "Collecting the mail",
            DisableControls = {
                Mouse = false,
                Player = true,
                Vehicle = true
            }
        })
        TakeAnim()
        Citizen.Wait(1000)
        v.taked = true
        hasBag = true
        exports.pNotify:SendNotification({text = "<b>Postman</b></br>Please put the mail in the back of your van", timeout=1000})
        RemoveBlip(v.blip)
        ClearPedTasks(ped)

        done = done + 1
        if done == #Config.WestminsterWork then
            Paycheck = true
            done = 0
            AmountPayout = AmountPayout + 1
            exports.pNotify:SendNotification({text = "<b>Postman</b></br> The mail for this district has all been collected, please return to the depot", timeout=2500})
        elseif done == #Config.CanningTownWork then
            Paycheck = true
            done = 0
            AmountPayout = AmountPayout + 1
            exports.pNotify:SendNotification({text = "<b>Postman</b></br> The mail for this district has all been collected, please return to the depot", timeout=2500})
        elseif done == #Config.RuislipWork then
            Paycheck = true
            done = 0
            AmountPayout = AmountPayout + 1
            exports.pNotify:SendNotification({text = "<b>Postman</b></br> The mail for this district has all been collected, please return to the depot", timeout=2500})
        elseif done == #Config.ChelseaWork then
            Paycheck = true
            done = 0
            AmountPayout = AmountPayout + 1
            exports.pNotify:SendNotification({text = "<b>Postman</b></br> The mail for this district has all been collected, please return to the depot", timeout=2500})
        end
    end
    return Paycheck, done, AmountPayout
end