local QBCore = exports['qb-core']:GetCoreObject()
local searchedBins = {}
local curjobs = {}
local jobzones = {}
local currentvehicles = {}

local function addToSet(set, key)
    set[key] = true
end

local function tableHasKey(table, key)
    return table[key] ~= nil
end

local function removeKey(key)
    local value = curjobs[key]
    if (value == nil) then
        return
    end
    curjobs[key] = nil
    jobzones[value] = nil
    currentvehicles[key] = nil
end

local function addValue(key, value, vehicle)
    if (value == nil) then
        removeKey(key)
        return
    end
    curjobs[key] = value
    jobzones[value] = key
    currentvehicles[key] = vehicle
end

local function getValue(key)
    return curjobs[key]
end

local function getVehicle(key)
    return currentvehicles[key]
end

RegisterNetEvent('gl-garbage:makeMultiJob', function(jobID, zone, vehicle)
    local src = source
    local hasValue = getValue(jobID)
    if hasValue then
        newID = math.random(10000, 99999)
        addValue(newID, zone, vehicle)
        TriggerClientEvent('gl-garbage:newJobID', src, newID)
        TriggerClientEvent("QBCore:Notify", src, "Job ID was in progress, your new job ID is " .. newID)
    else
        addValue(jobID, zone, vehicle)
    end
end)

RegisterNetEvent('gl-garbage:joinMultiJob', function(ID)
    local src = source
    jobID = tonumber(ID)
    local doesJobExist = getValue(jobID)
    if doesJobExist then
        zone = getValue(jobID)
        vehicle = getVehicle(jobID)
        TriggerClientEvent('gl-garbage:joinedMultiJob', src, jobID, zone, vehicle)
        TriggerClientEvent('gl-garbage:updatePeople', -1, jobID)
    else
        TriggerClientEvent("QBCore:Notify", src, "Job ID does not exist", 'error')
    end
end)

RegisterNetEvent('gl-garbage:checkBin', function(netID)
    local src = source
    local searched = tableHasKey(searchedBins, netID)
    if not searched then
        addToSet(searchedBins, netID)
        TriggerClientEvent('gl-garbage:getTrash', src)
    else
        TriggerClientEvent("QBCore:Notify", src, "It seems to be empty!")
    end
end)

RegisterNetEvent('gl-garbage:depositTrash', function(jobID)
    TriggerClientEvent('gl-garbage:depositTrashClient', -1, jobID)
end)

RegisterNetEvent('gl-garbage:cashOut', function(jobID, people)
    TriggerClientEvent('gl-garbage:cashedOut', -1, jobID, people)
end)

RegisterNetEvent('gl-garbage:newShift', function(jobID, zone, vehicle)
    removeKey(jobID)
    addValue(jobID, zone, vehicle)
    TriggerClientEvent('gl-garbage:updateShift', -1, jobID, zone)
end)

RegisterNetEvent('gl-garbage:getPaid', function(trash, people)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Money = (trash * Config.Payout) / people
    Player.Functions.AddMoney('cash', Money)
    local rng = math.random(0, 10)
    if trash >= 10 then
        if rng >= 5 then
            Player.Functions.AddItem('recvoucher', 1)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['recvoucher'], "add", 1)
        end
    end
end)

RegisterNetEvent('gl-garbage:redeemMaterial', function(choice, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local voucher = Player.Functions.GetItemByName('recvoucher')
    if voucher and voucher.amount > 0 then
        Player.Functions.RemoveItem('recvoucher', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['recvoucher'], "remove", 1)
        Player.Functions.AddItem(choice, amount)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[choice], "add", amount)
    else
        TriggerClientEvent("QBCore:Notify", src, "Looks like you don't have any recycling vouchers.", 'error')
    end
end)