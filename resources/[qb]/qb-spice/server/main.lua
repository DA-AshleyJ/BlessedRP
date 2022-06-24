local QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ["spiceleaf"] = "spiceleaf"
}

local DrugList = {
    ["spicebaggy"] = "spicebaggy"
}


RegisterServerEvent('qb-spice:server:grindleaves')
AddEventHandler('qb-spice:server:grindleaves', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local spiceleaf = Player.Functions.GetItemByName('spiceleaf')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if spiceleaf ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "spiceleaf" and Player.PlayerData.items[k].amount >= 2 then 
                        Player.Functions.RemoveItem("spiceleaf", 2)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['spiceleaf'], "remove")

                        TriggerClientEvent("qb-spice:client:grindleavesMinigame", src)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You dont have enough spice leaves", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have spice leaf", 'error')
                break
            end
        end
    end
end)

RegisterServerEvent('qb-spice:server:spicesell')
AddEventHandler('qb-spice:server:spicesell', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local spicebaggy = Player.Functions.GetItemByName('spicebaggy')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if spicebaggy ~= nil then
                if DrugList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "spicebaggy" and Player.PlayerData.items[k].amount >= 1 then 
                        local random = math.random(50, 65)
                        local amount = Player.PlayerData.items[k].amount * random

                        TriggerClientEvent('chatMessage', source, "Dealer Johnny", "normal", 'Yo '..Player.PlayerData.firstname..', damn you got '..Player.PlayerData.items[k].amount..'bags of spice')
                        TriggerClientEvent('chatMessage', source, "Dealer Johnny", "normal", 'Ill buy all of it for $'..amount )

                        Player.Functions.RemoveItem("spicebaggy", Player.PlayerData.items[k].amount)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['spicebaggy'], "remove")
                        Player.Functions.AddMoney("cash", amount)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You do not have spice", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have spice", 'error')
                break
            end
        end
    end
end)


RegisterServerEvent('qb-spice:server:getleaf')
AddEventHandler('qb-spice:server:getleaf', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("spiceleaf", 10)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['spiceleaf'], "add")
end)

RegisterServerEvent('qb-spice:server:getspice')
AddEventHandler('qb-spice:server:getspice', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("spicebaggy", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['spicebaggy'], "add")
end)


