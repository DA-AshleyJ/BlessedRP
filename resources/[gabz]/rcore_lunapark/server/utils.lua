ESX = nil
QBCore = nil

function CreateEntity(hash, coords)
    local entity = CreateObjectNoOffset(hash, coords, true, false, false)

    while not DoesEntityExist(entity) do Wait(0) end

    return entity
end

function CreateEntities(hash, coords)
    local entities = {}

    for i = 1, #coords do
        entities[i] = CreateObjectNoOffset(hash, coords[i], true, false, false)

        while not DoesEntityExist(entities[i]) do Wait(0) end
    end

    return entities
end

function DeleteEntities(netIds)
    for i = 1, #netIds do
        DeleteEntity(NetworkGetEntityFromNetworkId(netIds[i]))
    end
end

function NoPlayersInRange(coords)
    local players = GetPlayers()
    local value = true

    for i = 1, #players do
        if #(coords - GetEntityCoords(GetPlayerPed(players[i]))) < 220 then
            value = false
            break
        end
    end

    return value
end

function IsNetIdAssociatedWithCorrectEntity(netId, hash)
    local entity = NetworkGetEntityFromNetworkId(netId)

    if DoesEntityExist(entity) then
        return GetEntityModel(entity) == hash
    else
        return false
    end
end

function HandleTransaction(source, amount, errorMsg, successEvent, customEvent, ...)
    local args = {...}

    if ESX ~= nil and Config.EnableESX then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getMoney() >= amount then
            xPlayer.removeMoney(amount)

            if successEvent then
                TriggerEvent(successEvent, source, table.unpack(args))
            end
        else
            TriggerClientEvent('esx:showNotification', source, errorMsg)
        end
    elseif QBCore ~= nil and Config.EnableQBCore then
        local Player = QBCore.Functions.GetPlayer(source)

        if Player.PlayerData.money['cash'] >= amount then
            Player.Functions.RemoveMoney('cash', amount)

            if successEvent then
                TriggerEvent(successEvent, source, table.unpack(args))
            end
        else
            TriggerClientEvent('QBCore:Notify', source, errorMsg)
        end
    elseif Config.EnableCustomEvents then
        if customEvent then
            TriggerEvent(customEvent, source, amount, function(paid)
                if paid then
                    if successEvent then
                        TriggerEvent(successEvent or '', source, table.unpack(args))
                    end
                else
                    TriggerClientEvent('lsrp_lunapark:showNotification', source, errorMsg)
                end
            end)
        end
    else
        if successEvent then
            TriggerEvent(successEvent, source, table.unpack(args))
        end
    end
end

CreateThread(function()
    if Config.EnableESX then
        while ESX == nil do Wait(0); ESX = exports['es_extended']:getSharedObject() end
    end

    if Config.EnableQBCore then
        while QBCore == nil do Wait(0); QBCore = exports['qb-core']:GetCoreObject() end
    end
end)