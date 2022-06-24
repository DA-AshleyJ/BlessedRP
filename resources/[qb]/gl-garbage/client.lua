local QBCore = exports['qb-core']:GetCoreObject()

local onJob = false
local jobID = 0
local VehicleNetId = nil
local CurrentGarbageBag = nil

local zoneID = 0
local zoneBlip = nil
local GarbageZone = nil
local inGarbageZone = false

local trashAmt = 0
local people = 1

local npcSpawned = false
local NPC

local PlayerData = {}

-- Functions
local function SpawnNPC(coords, heading)
    local hash = GetHashKey('s_m_y_garbage')
    QBCore.Functions.LoadModel(hash)
    NPC = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(NPC, true)
    SetEntityInvincible(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    SetModelAsNoLongerNeeded(hash)
    TaskStartScenarioInPlace(NPC,'WORLD_HUMAN_HANG_OUT_STREET')

    exports['qb-target']:AddEntityZone('NPC', NPC, {
        name="NPC",
        debugPoly=false,
        useZ = true
    }, {
        options = {
            {
                event = 'gl-garbage:getJob',
                icon = "fas fa-clipboard",
                label = "Start Shift",
                canInteract = function(entity)
                    return not onJob
                end,
                job = (Config.RequireJob and "garbage" or "all"),
            },
            {
                event = 'gl-garbage:newShift',
                icon = "fas fa-clipboard",
                label = "Start New Shift",
                canInteract = function(entity)
                    return (onJob and trashAmt == Config.TrashAmt)
                end,
                job = (Config.RequireJob and "garbage" or "all"),
            },
            {
                event = 'gl-garbage:joinMultiJob',
                icon = "fas fa-clipboard",
                label = "Join A Shift",
                job = (Config.RequireJob and "garbage" or "all"),
            },
            {
                event = 'gl-garbage:endJob',
                icon = "fas fa-clipboard",
                label = "End Shift",
                canInteract = function(entity)
                    return onJob
                end,
                job = (Config.RequireJob and "garbage" or "all"),
            },
            {
                event = 'gl-garbage:turnInVoucher',
                icon = "fas fa-clipboard",
                label = "Redeem Voucher",
                job = (Config.RequireJob and "garbage" or "all"),
            },
        },
        distance = 2.5
    })
end

local function ChangeClothing(remove)
    remove = remove or false
    if Config.UseClothing and not remove then
        if PlayerData.charinfo.gender == 0 then
            TriggerEvent('qb-clothing:client:loadOutfit', Config.Outfits['male'])
        else
            TriggerEvent('qb-clothing:client:loadOutfit', Config.Outfits['female'])
        end
    elseif Config.UseClothing and remove then
        TriggerServerEvent("qb-clothes:loadPlayerSkin")
    end
end

local function RemoveZoneBlip()
    if zoneBlip then
       RemoveBlip(zoneBlip)
    end
end

local function CreateZoneBlip(id)
    RemoveZoneBlip()
    zoneBlip = AddBlipForRadius(GarbageZone:getCenter(), GarbageZone:getRadius())
    SetBlipSprite(zoneBlip,9)
    SetBlipColour(zoneBlip,49)
    SetBlipAlpha(zoneBlip,75)
end

local function CreateBinTarget()
    exports['qb-target']:AddTargetModel(Config.Bins, {
        options = {
            {
                icon = "fas fa-clipboard",
                label = "Grab Trash",
                action = function(entity)
                    TriggerServerEvent('gl-garbage:checkBin', NetworkGetNetworkIdFromEntity(entity))
                end,
                canInteract = function (entity)
                    return inGarbageZone
                end
            },
        },
        distance = 2.0
    })
end

local function CreateVehicleTarget()
    exports['qb-target']:AddGlobalVehicle({
        options = {
            {
                icon = 'fas fa-trash',
                label = 'Throw In Trash',
                action = function(entity)
                    if DoesEntityExist(CurrentGarbageBag) then
                        if trashAmt < Config.TrashAmt then
                            TriggerServerEvent('gl-garbage:depositTrash', jobID)
                            DeleteEntity(CurrentGarbageBag)
                        else
                            DeleteEntity(CurrentGarbageBag)
                            QBCore.Functions.Notify('Vehicle Seems To Be Full!')
                        end
                    end
                end,
                canInteract = function(entity, distance, data)
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local vehicle = NetworkGetEntityFromNetworkId(VehicleNetId)
                    local boot = GetEntityBoneIndexByName(vehicle,'boot')
                    local bootDst = GetWorldPositionOfEntityBone(vehicle,boot)
                    local dst = #(coords - bootDst)
                    if dst < 3.0 and GetVehicleDoorAngleRatio(vehicle, 5) ~= 0 and IsVehicleModel(vehicle, 'trash') then
                        return onJob and vehicle == entity and IsVehicleModel(vehicle,'trash')
                    end
                    return false
                end,
            }
        },
        distance = 2.5,
    })
end

local function RemoveVehicleTarget()
    exports['qb-target']:RemoveGlobalVehicle({ "Throw In Trash" })
end

local function CreateZone(id)
    -- Create Zone
    GarbageZone = CircleZone:Create(Config.Zones[id].Coords, Config.Zones[id].Radius, {
        name = "Zone_"..id,
        debugPoly=false,
    })
    GarbageZone:onPlayerInOut(function(isPointInside, point)
        inGarbageZone = isPointInside
    end)
end

local function RemoveZone()
    if GarbageZone then GarbageZone:destroy() end 
end

-- Main Thread
CreateThread(function()
    -- Spawn NPC
    while true do
        Wait(1000)
        local garCoords = vector3(-321.77,-1545.84,30.02)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dst = #(garCoords - pedCoords)
        if dst < 200 and npcSpawned == false then
            SpawnNPC(garCoords, 353.24)
            npcSpawned = true
        end
        if dst >= 201  then
            npcSpawned = false
            DeleteEntity(NPC)
        end
    end
end)

-- Player Loaded
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    if not Config.RequireJob or PlayerData.job.name == "garbage" then
        blip = AddBlipForCoord(-321.77,-1545.84,30.02)
        SetBlipSprite(blip, 318)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garbage")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Job Change
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    if not Config.RequireJob or PlayerData.job.name == "garbage" then
        blip = AddBlipForCoord(-321.77,-1545.84,30.02)
        SetBlipSprite(blip, 318)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garbage")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Job
RegisterNetEvent('gl-garbage:getJob',function()
    if not onJob then
        ChangeClothing()
        QBCore.Functions.SpawnVehicle('trash', function(veh)
            vehicle = veh
            exports['LegacyFuel']:SetFuel(vehicle, 100)
            SetEntityAsMissionEntity(vehicle, true, true)
            SetEntityHeading(vehicle, Config.VehicleSpawn.w)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))
            onJob = true
            jobID = math.random(10000,99999)
            zoneID = math.random(#Config.Zones)
            people = 1
            CreateVehicleTarget()
            CreateBinTarget()
            QBCore.Functions.Notify('Head to the marked area and pick up ' .. Config.TrashAmt .. ' loads of trash')
            QBCore.Functions.Notify("Your Job ID is " .. jobID)
            CreateZone(zoneID)
            CreateZoneBlip(zoneID)
            VehicleNetId = NetworkGetNetworkIdFromEntity(vehicle)
            TriggerServerEvent('gl-garbage:makeMultiJob', jobID, zoneID, VehicleNetId)
        end, vector3(Config.VehicleSpawn.x, Config.VehicleSpawn.y, Config.VehicleSpawn.z), false)
    end
end)

RegisterNetEvent('gl-garbage:getJobId',function()
    QBCore.Functions.Notify('Your job ID is ' .. jobID)
end)

RegisterNetEvent('gl-garbage:newJobID',function(ID)
    jobID = ID
end)

RegisterNetEvent('gl-garbage:endJob',function()
    if onJob then
        TriggerServerEvent('gl-garbage:cashOut', jobID, people)
    end
end)

RegisterNetEvent('gl-garbage:newShift',function()
    local newZoneId = math.random(#Config.Zones)
    TriggerServerEvent('gl-garbage:newShift', jobID, newZoneId, VehicleNetId)
end)

RegisterNetEvent('gl-garbage:updateShift',function(ID, zone)
    if jobID == ID then
        RemoveZone()
        zoneID = zone
        CreateZone(zoneID)
        CreateZoneBlip(zoneID)
        TriggerServerEvent('gl-garbage:getPaid', trashAmt, people)
        trashAmt = 0
        QBCore.Functions.Notify('You/Your jobmates have started a new shift')
        QBCore.Functions.Notify('Head to the marked area and pick up ' .. Config.TrashAmt .. ' loads of trash')
    end
end)

RegisterNetEvent('gl-garbage:cashedOut',function(ID, people)
    if jobID == ID then
        local vehicle = NetworkGetEntityFromNetworkId(VehicleNetId)
        if DoesEntityExist(vehicle) then
            VehicleNetId = nil
            QBCore.Functions.DeleteVehicle(vehicle)
        end
        QBCore.Functions.Notify('You/Your jobmates have cashed out')
        jobID = 0
        onJob = false
        exports['qb-target']:RemoveZone(Config.Bins)
        TriggerServerEvent('gl-garbage:getPaid', trashAmt, people)
        people = 1
        trashAmt = 0
        RemoveZone()
        RemoveVehicleTarget()
        RemoveZoneBlip()
        ChangeClothing(true)
    end
end)

-- Multi Job
RegisterNetEvent('gl-garbage:joinMultiJob',function()
    local keyboard = exports["qb-input"]:ShowInput({
        header = "Enter Job ID",
        submitText = "Submit",
        inputs = {
            {
                isRequired = true,
                type = 'number',
                txt = "Job ID",
                name = 'jobid'
            },
        }
    })
    if keyboard then
        TriggerServerEvent('gl-garbage:joinMultiJob', keyboard.jobid)
    end
end)

RegisterNetEvent('gl-garbage:joinedMultiJob',function(ID, zone, vehicle)
    jobID = ID
    QBCore.Functions.Notify('You have joined Job ID ' .. jobID)
    zoneID = zone
    VehicleNetId = vehicle
    onJob = true
    ChangeClothing()
    CreateVehicleTarget()
    CreateZone(zoneID)
    CreateZoneBlip(zoneID)
    CreateBinTarget()
end)

RegisterNetEvent('gl-garbage:updatePeople',function(ID)
    if jobID == ID then
        people = people + 1
        QBCore.Functions.Notify('Another person has joined the job')
    end
end)

-- Voucher
RegisterNetEvent('gl-garbage:turnInVoucher',function()
    local voucherMenu = {}
    for k, v in pairs(Config.VoucherList) do
        voucherMenu[#voucherMenu + 1] = {
            header = v.label,
            txt = "Get " .. v.amount .. " " ..  v.label,
            params = {
                event = 'gl-garbage:redeemMaterial',
                args = {
                    choice = v.databasename,
                    amount = v.amount
                }
            }
        }
    end
    exports['qb-menu']:openMenu(voucherMenu)
end)

RegisterNetEvent('gl-garbage:redeemMaterial',function(data)
    TriggerServerEvent('gl-garbage:redeemMaterial', data.choice, data.amount)
end)

-- Trash
RegisterNetEvent('gl-garbage:getTrash',function()
    if DoesEntityExist(CurrentGarbageBag) then
        QBCore.Functions.Notify('You are already carrying Trash', 'error')
    else
        local ped = PlayerPedId()
        QBCore.Functions.Notify('Dump the trash in the back of the Truck', 'success')
        CurrentGarbageBag = CreateObject(`hei_prop_heist_binbag`, 0, 0, 0, true, true, true)
        AttachEntityToEntity(CurrentGarbageBag, ped, GetPedBoneIndex(ped, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    end
end)

RegisterNetEvent('gl-garbage:depositTrashClient',function(ID)
    if jobID == ID then
        trashAmt = trashAmt + 1
        QBCore.Functions.Notify(trashAmt .. ' / ' .. Config.TrashAmt .. ' left')
        if trashAmt == Config.TrashAmt then
            QBCore.Functions.Notify('Finished, Return To The Trash Master!', 'success')
        end
    end
end)