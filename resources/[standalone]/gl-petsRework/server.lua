local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('gl-pets:buyPet', function(price, model, variation, name)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money["cash"] > price then
        Player.Functions.RemoveMoney("cash", price)
        MySQL.insert('INSERT INTO gl_pets (owner, model, variation, name) VALUES (?, ?, ?, ?)', {Player.PlayerData.citizenid, model, variation, name})
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
    end
end)

RegisterServerEvent('gl-pets:updatePetStats', function(stats, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.update('UPDATE gl_pets SET stats = ? WHERE id = ?', {json.encode(stats), id})
end)

RegisterNetEvent('gl-pets:k9Search', function(ID, targetID)
    local itemFound = false
    local src = source
    local targetPlayer = QBCore.Functions.GetPlayer(targetID)
    for k, v in pairs(Config.SearchableItems.IllegalItems) do
        local item = targetPlayer.Functions.GetItemByName(k)
        if item and item.amount >= v then
            itemFound = true
        end
    end
    TriggerClientEvent('gl-pets:k9ItemCheck', src, itemFound)
end)

RegisterServerEvent('gl-pets:buyItem', function(item, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money["cash"] > price then
        Player.Functions.RemoveMoney('cash', price)
        Player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", 1)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
    end
end)

QBCore.Functions.CreateUseableItem("doghouse", function(source, item)
    TriggerClientEvent('gl-pets:placeDoghouse', source)
end)

QBCore.Functions.CreateUseableItem("tennisball", function(source, item)
    TriggerClientEvent('gl-pets:playFetch', source)
end)

QBCore.Functions.CreateUseableItem("frisbee", function(source, item)
    TriggerClientEvent('gl-pets:playFrisbee', source)
end)

QBCore.Functions.CreateUseableItem("petfood", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('gl-pets:feedPet', source)
    end
end)

QBCore.Functions.CreateCallback('gl-pets:getAllPets', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    MySQL.query('SELECT * FROM gl_pets WHERE owner = ?', {Player.PlayerData.citizenid}, function(result)
        cb(result)
    end)
end)
