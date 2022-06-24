local QBCore = exports['qb-core']:GetCoreObject()

local Base = Config.Electrician.Base
local Garage = Config.Electrician.Garage
local Marker = Config.Electrician.DefaultMarker
local GarageSpawnPoint = Config.Electrician.GarageSpawnPoint

local Type = nil
local AmountPayout = 0
local done = 0
local PlayerData = {}
local salary = nil
local experience = 0

NeedsUpdate = true
onDuty = false
hasVan = false
inGarageMenu = false
inMenu = false
CanWork = false
Paycheck = false
hasOpenDoor = false

hasFuse = false
hasToolKit = false
hasChecked = true

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
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
                    if NeedsUpdate then
                        QBCore.Functions.TriggerCallback('Elec:getexperience', function(cb)
                            experience = cb
                        end, PlayerData)
                        NeedsUpdate = false
                    end

                    DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, '~g~[E]~s~ - Change into work clothes')
                    DrawText3Dss(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.2, '~g~[Level]~s~: '..math.ceil(experience/1000))
                    if IsControlJustPressed(0, Keys['E']) then
                        RProgAnim("You're changing your clothes...", 2500, "WORLD_HUMAN_COP_IDLES", "idle_a")
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
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>You started working!", timeout = 3000})
                        onDuty = true
                        addGarageBlip()
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b></br> To open the work menu, press <b>[DEL]</b>", timeout = 5000})
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
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b><br> You finished work!", timeout = 3000})
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
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>Searching for an assignment...", timeout = 1500})
                        Citizen.Wait(1500)
                        ElecAssignment = Randomize(Config.CityWork)
                        CreateWork(ElecAssignment.Assignment)
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>Work Assignment Set, Please Check GPS", timeou= 2000})
                    else
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>You already have an assignment!", timeout = 2000})
                    end
                elseif IsControlJustPressed(0, Keys["8"]) then
                    if Type then
                        CancelWork()
                        DeleteWaypoint()
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>You canceled your assignment", timeout = 2000})
                    elseif not Type then
                        exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>You currently have no assignment", timeout = 2000})
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
                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~r~[E]~s~ - Return vehicle\n ~r~[G]~s~ Return Vehicle and Get Paycheck')
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if hasVan then
                                        TriggerServerEvent('Elec:returnVehicle', source)
                                        ReturnVehicle()
                                        exports.pNotify:SendNotification({text = '<b>Elec</b></br>You received £' ..Config.DepositPrice.. ' for returning the vehicle', timeout = 1500})
                                        hasVan = false
                                        Plate = nil
                                    else
                                        exports.pNotify:SendNotification({text = "<b>Elec</b></br>You haven't paid deposit for this vehicle!", timeout = 2500})
                                    end
                                elseif IsControlJustReleased(0, Keys['G']) then
                                    if hasVan then
                                        if not Paycheck then
                                            if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)) then
                                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.95, "You haven't finished your assignment")
                                                Citizen.Wait(3500)
                                            end
                                        elseif Paycheck then
                                            if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)) then
                                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.95, "--")
                                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 1.0, "~g~[G]~s~ Take the money")
                                                if IsControlJustReleased(0, Keys["G"]) then
                                                    TriggerServerEvent('Elec:returnVehicle', source)
                                                    ReturnVehicle()
                                                    hasVan = false
                                                    Plate = nil
                                                    NeedsUpdate = true
                                                    salary = math.random(Config.Salary.min, Config.Salary.max)
                                                    TriggerServerEvent('Elec:Payout', salary, AmountPayout)
                                                    exports.pNotify:SendNotification({text = "<b>Elec</b></br>You earned £"..salary.."!", timeout = 2500})
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
                                            exports.pNotify:SendNotification({text = '<b>City Electrician</b></br>Select a parking space', timeout = 2500})
                                        elseif inMenu then
                                            exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>Close the work menu!", timeout = 2500})
                                        end
                                    end
                                elseif inGarageMenu then
                                    DrawText3DMenu(Garage.Pos.x - 0.8, Garage.Pos.y, Garage.Pos.z + 0.8, '~g~[7]~s~ - Parking Space #1\n~r~[E]~s~ - Close Garage Menu ')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        inGarageMenu = false
                                        FreezeEntityPosition(ped, false)
                                    elseif IsControlJustReleased(0, Keys["7"]) then
                                        if not hasVan then
                                            QBCore.Functions.TriggerCallback('Elec:checkMoney', function(hasMoney)
                                                if hasMoney then
                                                    QBCore.Functions.SpawnVehicle(Config.CompanyVehicle, function(vehicle)
                                                        SetEntityHeading(vehicle, GarageSpawnPoint.Pos1.h)
                                                        SetVehicleNumberPlateText(vehicle, "GRD"..tostring(math.random(1000, 9999)))
                                                        SetVehicleEngineOn(vehicle, true, true)
                                                        SetEntityAsMissionEntity(vehicle, true, true)
                                                        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
                                                        exports.pNotify:SendNotification({text = '<b>City Electrician</b></br>You paid £' ..Config.DepositPrice.. ' to take out the vehicle', timeout = 1500})
                                                        hasVan = true
                                                        Plate = GetVehicleNumberPlateText(vehicle)
                                                    end, vector3(GarageSpawnPoint.Pos1.x, GarageSpawnPoint.Pos1.y, GarageSpawnPoint.Pos1.z), true)
                                                    inGarageMenu = false
                                                    FreezeEntityPosition(ped, false)
                                                else
                                                    exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>You don't have enough money!", timeout = 2500})
                                                    inGarageMenu = false
                                                    FreezeEntityPosition(ped, false)
                                                end
                                            end)
                                        elseif hasVan then
                                            exports.pNotify:SendNotification({text = "<b>City Electrician</b></br>First, return the car you pulled out", timeout = 2500})
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
                                    RadialProgress("You're Opening the rear doors", 1500)
                                    SetVehicleDoorOpen(vehicle, 3, false, false)
                                    SetVehicleDoorOpen(vehicle, 2, false, false)
                                    hasOpenDoor = true
                                end
                            elseif hasOpenDoor then
                                if not hasToolKit then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.7, "~g~[E]~s~ - Get Tool Box | ~g~[G]~s~ - Close Doors")
                                    if not hasFuse then
                                        DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.3, "~g~[7]~s~ - Get Fuses")
                                        if IsControlJustReleased(0, Keys['7']) then
                                            RadialProgress("Finding some Fuses", 3000)
                                            LoadAnimation('random@mugging1')
                                            TaskPlayAnim(ped, 'random@mugging1', 'pickup_low', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
                                            hasFuse = true
                                        end
                                    elseif hasFuse then
                                        DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.3, "~g~[7]~s~ - Put away unused Fuses")
                                        if IsControlJustReleased(0, Keys['7']) then
                                            RadialProgress("putting away unused fuses", 1500)
                                            LoadAnimation('random@mugging1')
                                            TaskPlayAnim(ped, 'random@mugging1', 'pickup_low', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
                                            hasFuse = false
                                        end
                                    end
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        RadialProgress("Grabbing your tool box", 2000)
                                        TakeAnim()
                                        hasToolKit = true
                                    elseif IsControlJustReleased(0, Keys["G"]) then
                                        VCloseDoors(vehicle, 500)
                                    end
                                elseif hasToolKit then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.7, "~g~[E]~s~ - Put Away Tool Box | ~g~[G]~s~ - Close Doors")
                                    if not hasFuse then
                                        DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.3, "~g~[7]~s~ - Get Fuses")
                                        if IsControlJustReleased(0, Keys['7']) then
                                            RadialProgress("Finding some Fuses", 3000)
                                            LoadAnimation('random@mugging1')
                                            TaskPlayAnim(ped, 'random@mugging1', 'pickup_low', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
                                            hasFuse = true
                                        end
                                    elseif hasFuse then
                                        DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.3, "~g~[7]~s~ - Put away unused Fuses")
                                        if IsControlJustReleased(0, Keys['7']) then
                                            RadialProgress("putting away unused fuses", 1500)
                                            LoadAnimation('random@mugging1')
                                            TaskPlayAnim(ped, 'random@mugging1', 'pickup_low', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
                                            hasFuse = false
                                        end
                                    end
                                    if IsControlJustReleased(0, Keys['E']) then
                                        RadialProgress("Putting away the toolbox", 750)
                                        PutBack()
                                        hasToolKit = false
                                    elseif IsControlJustReleased(0, Keys["G"]) then
                                        VCloseDoors(vehicle, 500)
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
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        
        if Type == 'Street Lights' then
            for i, v in ipairs(Config.BrokenLights) do
                if not v.fixed then
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                        if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                            if hasToolKit then
                                FixLights(v, ped)
                            elseif not hasToolKit then
                                MissionText('You need to get your equipment')
                            end
                        end
                    end
                end
            end
        elseif Type == 'Pillbox' then
            for i, v in ipairs(Config.PillboxHospital) do
                if not v.fixed then
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Marker.Type, v.x, v.y,v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                        if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                            if hasToolKit then
                                if v.job == 'fuse' and not v.fixed then
                                    FixFusebox(v, ped)
                                elseif v.job == 'plug' and not v.fixed then
                                    FixPlugs(v, ped)
                                elseif v.job == 'lights'and not v.fixed then
                                    FixLights(v, ped)
                                end
                            elseif not hasToolKit then
                                MissionText('You need to get your equipment')
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
    if type == "Street Lights" then
        for i, v in ipairs(Config.BrokenLights) do
            BlipsFix(v)
        end
    elseif type == "Pillbox" then
        for i,v in ipairs(Config.PillboxHospital) do
            BlipsFix(v)
        end
    end
    Type = type
end

function CancelWork()
    if Type == "Street Lights" then
        for i, v in ipairs(Config.BrokenLights) do
            v.fixed = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Pillbox" then
        for i,v in ipairs(Config.PillboxHospital) do
            RemoveBlip(v.blip)
            v.fixed = false
        end
    end
    Type = nil
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

function BlipsFix(v)
    v.blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(v.blip, 1)
    SetBlipColour(v.blip, 24)
    SetBlipScale(v.blip, 0.4)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("[City Electrician] Broken Street Lamp")
    EndTextCommandSetBlipName(v.blip)
end

function MissionText(text,time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
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

function RadialProgress(label, sleep)
    exports.rprogress:Custom({
        Duration = sleep,
        Label = label,
        DisableControls = {
            Mouse = false,
            Player = true,
            Vehicle = true
        }
    })
    Citizen.Wait(sleep)
end

function RProgAnim(label, sleep, scenario, ani)
    exports.rprogress:Custom({
        Duration = sleep,
        Label = label,
        DisableControls = {
            Mouse = false,
            Player = true,
            Vehicle = true
        },
        Animation = {
            scenario = scenario,
            animationDictionary = ani,
        },
    })
    Citizen.Wait(sleep)
end

function VCloseDoors(vehicle, sleep)
    RadialProgress("Closing the Doors", sleep)
    SetVehicleDoorShut(vehicle, 3, false, false)
    SetVehicleDoorShut(vehicle, 2, false, false)
    hasOpenDoor = false
    return hasOpenDoor
end

function TakeAnim()
    local ped = PlayerPedId()
    LoadAnimation('random@mugging1')
    TaskPlayAnim(ped, 'random@mugging1', 'pickup_low', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    ToolBox = CreateObject('prop_tool_box_02', 0, 0, 0, true, true, true)
    AttachEntityToEntity(ToolBox, ped, GetPedBoneIndex(ped, 57005), 0.50, -0.0, -0.10, 0.0, -90.0, 30.0, true, true, false, true, 1, true)
end

function PutBack()
    local ped = PlayerPedId()
    LoadAnimation('random@mugging1')
    TaskPlayAnim(ped, 'random@mugging1', 'pickup_low', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(ToolBox))
    SetTimeout(1250, function()
        DetachEntity(ToolBox, 1, false)
        DeleteObject(ToolBox)
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
        FreezeEntityPosition(ped, false)
        ToolBox = nil
    end)
end

function doneCounter(done)
    local config
    if Type == "Pillbox" then
        config = Config.PillboxHospital
    elseif Type == "Street Lights" then
        config = Config.BrokenLights
    end
    if done == 1 then
        Paycheck = true
        AmountPayout = AmountPayout + 1
        exports.pNotify:SendNotification({text="<b>City Electrician</b></br> Fixed."})
        MissionText("Paycheck is now available, you can fix more lights for more ~g~money~w~", 2000)
    elseif done > 1 and done < #config then
        Paycheck = true
        AmountPayout = AmountPayout + 1
        exports.pNotify:SendNotification({text="<b>City Electrician</b></br> Fixed."})
    elseif done == #config then
        Paycheck = true
        done = 0
        AmountPayout = AmountPayout + 2
        exports.pNotify:SendNotification({text="<b>City Electrician</b></br> Assignment Complete"})
        MissionText("Return your vehicle to receive your paycheck", 2000)
        for i, f in ipairs(Garage.Pos) do
            SetNewWaypoint(f.x, f.y, f.z)
        end
    end
    return AmountPayout, Paycheck, done
end

function FixLights(v, ped)
        sleep = 5
        DrawText3Ds(v.x, v.y, v.z + 0.4,  "~g~[E]~s~ - Fix the light")
        if IsControlJustReleased(0, Keys["E"]) then
            if Type == "Street Lights" then
                DoScreenFadeOut(500)
                RadialProgress("Fixing the streetlamp", 1500)
                Citizen.Wait(1000)
                DoScreenFadeIn(500)
                Citizen.Wait(500)
            elseif "Pillbox" then
                RadialProgress("Fixing the light", 1500)
                Citizen.Wait(1500)
            end
            v.fixed = true
            RemoveBlip(v.blip)
            ClearPedTasks(ped)

            done = done + 1
            doneCounter(done)
        end
    return Paycheck, done, AmountPayout
end

function FixFusebox(v, ped)
    if not v.checked then
        DrawText3Ds(v.x, v.y, v.z + 0.4,  "~g~[E]~s~ - Check the fusebox")
        if IsControlJustReleased(0, Keys["E"]) then
            RadialProgress("Checking the Fusebox", 2000)
            v.checked = true
            RepairProbability = math.random(1, 10)
        end
    end
    if v.checked and RepairProbability <= 4 then
        if not hasFuse then MissionText("You might want to get some fuses from the van", 2000)
        else
            DrawText3Ds(v.x, v.y, v.z + 0.4,  "~g~[E]~s~ - Replace the Fuse")
            if IsControlJustReleased(0, Keys["E"]) then
                RadialProgress("Replacing the Fuse", 2000)
                hasFuse = false
                v.checked = false
                v.fixed = true
                RemoveBlip(v.blip)
                ClearPedTasks(ped)
                MissionText("You've replaced the fuse", 2500)

                done = done + 1
                doneCounter(done)
            end
        end
        return AmountPayout, Paycheck
    else
        MissionText("The fuse is in working order", 2500)
        v.checked = false
        v.fixed = true
        RemoveBlip(v.blip)
        ClearPedTasks(ped)

        done = done + 1
        doneCounter(done)
        return Paycheck, done, AmountPayout
    end
end

function FixPlugs(v, ped)
    local RepairProbability = math.random(1, 10)
    if not v.checked then
        DrawText3Ds(v.x, v.y, v.z + 0.7,  "~g~[E]~s~ - Check the plug")
        if IsControlJustReleased(0, Keys["E"]) then
            RadialProgress("Checking the plug", 2000)
            v.checked = true
        end
    elseif v.checked then 
        if RepairProbability <= 4 then
            DrawText3Ds(v.x, v.y, v.z + 0.4,  "~g~[E]~s~ - rewire the plug")
            if IsControlJustReleased(0, Keys["E"]) then
                RadialProgress("Replacing the Fuse", 2000)
                hasFuse = false
                v.checked = false
                v.fixed = true
                RemoveBlip(v.blip)
                ClearPedTasks(ped)
                MissionText("You've rewired the plug", 2500)

                done = done + 1
                doneCounter(done)
            end
        else
            MissionText("The plug is fine", 2500)
            v.checked = false
            v.fixed = true
            RemoveBlip(v.blip)
            ClearPedTasks(ped)

            done = done + 1
            doneCounter(done)
        end
    end
    return Paycheck, done, AmountPayout
end