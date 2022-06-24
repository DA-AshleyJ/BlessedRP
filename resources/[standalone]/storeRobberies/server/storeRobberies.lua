local deadPeds = {}
local shopkeepers = {}
local shopkeepersState = {}
local registerOpened = {}
local registerBusy = {}
local safeOpened = {}
local safeBusy = {}
local SafeCodes = {}
local canRob = {}
local shopkeeperBusy = {}
local copsCalled = {}
randomKeyGen = math.random(100000000,999999999) 

Citizen.CreateThread(function()
    if(Config.Framework == "ESX")then --Only runs if you are using ESX.
        ESX = nil
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    elseif(Config.Framework == "QBUS")then --Only runs if you are using QBUS.
        QBCore = nil
        QBCore = exports['qb-core']:GetCoreObject()
    elseif(Config.Framework == "VRP")then

        local Tunnel = module("vrp", "lib/Tunnel")
        local Proxy = module("vrp", "lib/Proxy")

        vRP = Proxy.getInterface("vRP")
        vRPclient = Tunnel.getInterface("vRP","storeRobberies")


        Citizen.Wait(1000)
        
        AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
            if first_spawn then
                for k, permission in pairs(Config.vRP_Permissions) do --Runs for all the job names set in the config.
                    if vRP.hasPermissions(user_id, permission) then
                        TriggerClientEvent('storeRobberies:client:vRP:JobCheck', user_id, true)
                    end
                end
            end
        end)
        
        AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype)
            for k, groupName in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                if group == groupName then
                    TriggerClientEvent('storeRobberies:client:vRP:JobCheck', user_id, true)
                end
            end
        end)
        
        AddEventHandler("vRP:playerLeaveGroup", function(user_id, group, gtype)
            for k, groupName in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                if group == groupName then
                    TriggerClientEvent('storeRobberies:client:vRP:JobCheck', user_id, false)
                end
            end
        end)

    end

    coreFinished = true

end)

Citizen.CreateThread(function()

        for v = 1, #Config.Shops do
            shopkeepers[v] = math.random(1, #Config.Shopkeepers)
            shopkeeperBusy[v] = false
            deadPeds[v] = false
            shopkeepersState[v] = true
            copsCalled[v] = false
        end

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(Config.ShopkeeperResetTime)

                for v = 1, #Config.Shops do
                    shopkeepers[v] = math.random(1, #Config.Shopkeepers)
                    shopkeepersState[v] = true
                    shopkeeperBusy[v] = false
                end

                TriggerClientEvent('storeRobberies:client:shopkeeperStateUpdate', -1, shopkeepersState, shopkeeperBusy)
                TriggerClientEvent('storeRobberies:client:shopkeeperReset', -1, shopkeepers)
            end
        end)
end)

RegisterServerEvent('storeRobberies:server:shopkeeperUpdate')
AddEventHandler('storeRobberies:server:shopkeeperUpdate', function(source)
    while checker do
        checker = false
        for v = 1, #Config.Shops do
            if(shopkeepers[v] == nil)then
                checker = true
            end
        end
    end

    
    TriggerClientEvent('storeRobberies:client:shopkeeperUpdate', source, shopkeepers)
end)

RegisterServerEvent('storeRobberies:server:shopkeeperStateUpdate')
AddEventHandler('storeRobberies:server:shopkeeperStateUpdate', function(source)
    TriggerClientEvent('storeRobberies:client:shopkeeperStateUpdate', source, shopkeepersState, shopkeeperBusy)
end)

RegisterServerEvent('storeRobberies:server:shopkeeperBusy') 
AddEventHandler('storeRobberies:server:shopkeeperBusy', function(id, state)
    shopkeeperBusy[id] = state
    TriggerClientEvent('storeRobberies:client:shopkeeperBusy', -1, id, state)
end)

RegisterServerEvent('storeRobberies:server:randomKeyGen')
AddEventHandler('storeRobberies:server:randomKeyGen', function(source)
    TriggerClientEvent('storeRobberies:client:randomKeyGen', source, randomKeyGen)
end)

RegisterServerEvent('storeRobberies:server:fightBack')
AddEventHandler('storeRobberies:server:fightBack', function(store, safe, ped)
    TriggerClientEvent('storeRobberies:client:fightBack', -1, store, safe, ped)
end)

RegisterServerEvent('storeRobberies:server:registerOpenedUpdate')
AddEventHandler('storeRobberies:server:registerOpenedUpdate', function(source)

    for v = 1, #Config.Shops do
        registerOpened[v] = false
    end

    for v = 1, #Config.Shops do
        registerBusy[v] = false
    end

    TriggerClientEvent('storeRobberies:client:registerOpenedUpdate', source, registerOpened, registerBusy)
end)

RegisterServerEvent('storeRobberies:server:safeOpenedUpdate')
AddEventHandler('storeRobberies:server:safeOpenedUpdate', function(source)

    for v = 1, #Config.Shops do
        safeOpened[v] = false
    end

    for v = 1, #Config.Shops do
        safeBusy[v] = false
    end

    TriggerClientEvent('storeRobberies:client:safeOpenedUpdate', source, safeOpened, safeBusy)
end)

RegisterServerEvent('storeRobberies:server:animator')
AddEventHandler('storeRobberies:server:animator', function(number, dict, anim, time)
    TriggerClientEvent('storeRobberies:client:animator', -1, number, dict, anim, time)
end)

Citizen.CreateThread(function()
    while true do 
        for v = 1, #Config.Shops do

            if(Config.Shops[v].safeType == "keypad")then
                SafeCodes[v] = math.random(1000, 9999)
            else
                SafeCodes[v] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)}
            end
        end
        TriggerClientEvent("storeRobberies:client:safeCodeUpdate", -1, SafeCodes)
        Citizen.Wait((1000 * 60) * 30)
    end
end)

RegisterServerEvent('storeRobberies:server:safeCodeUpdate')
AddEventHandler('storeRobberies:server:safeCodeUpdate', function(source)
    TriggerClientEvent('storeRobberies:client:safeCodeUpdate', source, SafeCodes)
end)

RegisterServerEvent('storeRobberies:server:canRobUpdater')
AddEventHandler('storeRobberies:server:canRobUpdater', function(source)
    TriggerClientEvent('storeRobberies:client:canRobUpdater', source, canRobList)
end)

RegisterServerEvent('storeRobberies:server:pedDead')
AddEventHandler('storeRobberies:server:pedDead', function(store)
    if not deadPeds[store] then
        deadPeds[store] = true
        shopkeepersState[store] = false
        TriggerClientEvent('storeRobberies:client:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = Config.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Citizen.CreateThread(function()
            Wait(wait)
            if not Config.Shops[store].registerOpened then
                for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
                TriggerClientEvent('storeRobberies:client:resetStore', -1, store)
                deadPeds[store] = false
            end
            shopkeepersState[store] = true
        end)
    end
end)

RegisterServerEvent('storeRobberies:server:registerOpen')
AddEventHandler('storeRobberies:server:registerOpen', function(store)

    if(Config.GlobalCooldownShop)then

        for store = 1, #Config.Shops do
            
            local src = source
            Config.Shops[store].registerOpened = true
            TriggerClientEvent('storeRobberies:client:registerOpen', -1, store, true)

            local second = 1000
            local minute = 60 * second
            local hour = 60 * minute
            local cooldown = Config.Shops[store].cooldown
            local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second

            Citizen.CreateThread(function()
                Wait(wait)
                Config.Shops[store].registerOpened = false
                TriggerClientEvent('storeRobberies:client:registerOpen', -1, store, false)
                for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
                TriggerClientEvent('voxlar_robbery:resetStore', -1, store)
            end)
            Citizen.Wait(10)
        end
    else
            local src = source
            Config.Shops[store].registerOpened = true
            TriggerClientEvent('storeRobberies:client:registerOpen', -1, store, true)

            local second = 1000
            local minute = 60 * second
            local hour = 60 * minute
            local cooldown = Config.Shops[store].cooldown
            local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second

            Citizen.CreateThread(function()
                Wait(wait)
                Config.Shops[store].registerOpened = false
                TriggerClientEvent('storeRobberies:client:registerOpen', -1, store, false)
                for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
                TriggerClientEvent('voxlar_robbery:resetStore', -1, store)
            end)
    end
end)

RegisterServerEvent('storeRobberies:server:safeOpen')
AddEventHandler('storeRobberies:server:safeOpen', function(store)

    if(Config.GlobalCooldownShop)then

        for store = 1, #Config.Shops do

            local src = source
            Config.Shops[store].safeOpened = true
            TriggerClientEvent('storeRobberies:client:safeOpen', -1, store, true)

            local second = 1000
            local minute = 60 * second
            local hour = 60 * minute
            local cooldown = Config.Shops[store].cooldown
            local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
            Citizen.CreateThread(function()
                Wait(wait)
                Config.Shops[store].safeOpened = false
                TriggerClientEvent('storeRobberies:client:safeOpen', -1, store, false)
                for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
                TriggerClientEvent('voxlar_robbery:resetStore', -1, store)
            end)
            Citizen.Wait(10)
        end
    else
            local src = source
            Config.Shops[store].safeOpened = true
            TriggerClientEvent('storeRobberies:client:safeOpen', -1, store, true)

            local second = 1000
            local minute = 60 * second
            local hour = 60 * minute
            local cooldown = Config.Shops[store].cooldown
            local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
            Citizen.CreateThread(function()
                Wait(wait)
                Config.Shops[store].safeOpened = false
                TriggerClientEvent('storeRobberies:client:safeOpen', -1, store, false)
                for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
                TriggerClientEvent('voxlar_robbery:resetStore', -1, store)
            end)
    end
end)

RegisterServerEvent('storeRobberies:server:callCops')
AddEventHandler('storeRobberies:server:callCops', function(store)
    if(Config.UseCopJob)then
        Citizen.Wait(math.random(1,1000))
        if(not copsCalled[store])then
            copsCalled[store] = true

            Citizen.CreateThread(function()
                Citizen.Wait(1000 * Config.PoliceCallSpamPrevention)
                copsCalled[store] = false
            end)

            TriggerClientEvent("storeRobberies:client:callCops", -1, store)
        end
    end
end)

RegisterServerEvent('storeRobberies:server:canRob')
AddEventHandler('storeRobberies:server:canRob', function(source, store)
    local copsChecker = CheckCops(store)
    
    if copsChecker then
        if not Config.Shops[store].registerOpened then
            TriggerClientEvent("storeRobberies:client:canRob", source, true, "none")
        else
            if(Config.Shops[store].registerOpened)then
                TriggerClientEvent("storeRobberies:client:canRob", source, false, "robbed")
            else
                TriggerClientEvent("storeRobberies:client:canRob", source, false, "dead")
            end
        end
    else
        TriggerClientEvent("storeRobberies:client:canRob", source, false, "cops")
    end
end)

RegisterServerEvent('storeRobberies:server:registerBusy') 
AddEventHandler('storeRobberies:server:registerBusy', function(id, state)
    registerBusy[id] = state
    TriggerClientEvent('storeRobberies:client:registerBusy', -1, id, state)
end)

RegisterServerEvent('storeRobberies:server:safeBusy')
AddEventHandler('storeRobberies:server:safeBusy', function(id, state)
    safeBusy[id] = state
    TriggerClientEvent('storeRobberies:client:safeBusy', -1, id, state)
end)

RegisterServerEvent('storeRobberies:server:registerMoney')
AddEventHandler('storeRobberies:server:registerMoney', function(source, store, password)
    if(password ~= nil)then
        if(password == randomKeyGen)then
            if(Config.Framework == "ESX")then --Checks if your using ESX.
                local xPlayer = ESX.GetPlayerFromId(source) --Gets the player from the server id.
                if(xPlayer ~=nil)then
                    local randomAmount = math.random(Config.Shops[store].registerMoney[1], Config.Shops[store].registerMoney[2]) --Makes a random number between the low and high of the register.
                    xPlayer.addMoney(randomAmount) --Adds the random amount of money to the player.
                end
            elseif(Config.Framework == "QBUS")then
                local Player = QBCore.Functions.GetPlayer(source)
                if(Player ~= nil)then
                    local randomAmount = math.random(Config.Shops[store].registerMoney[1], Config.Shops[store].registerMoney[2]) 
                    Player.Functions.AddMoney('cash', randomAmount, "robbery-store-register")
                end
            elseif(Config.Framework == "VRP")then
                local randomAmount = math.random(Config.Shops[store].registerMoney[1], Config.Shops[store].registerMoney[2]) 
                local user_id = vRP.getUserId({source})
                vRP.giveInventoryItem({user_id,"dirty_money",randomAmount,true})
            end
        else
            DropPlayer(source, 'Cheating')  
        end
    else
        DropPlayer(source, 'Cheating')  
    end
end)

RegisterServerEvent('storeRobberies:server:safeMoney')
AddEventHandler('storeRobberies:server:safeMoney', function(source, store, password)
    if(password ~= nil)then
        if(password == randomKeyGen)then
            if(not safeOpened[store])then
                if(Config.Framework == "ESX")then --Checks if your using ESX.
                    local xPlayer = ESX.GetPlayerFromId(source) --Gets the player from the server id.
                    if(xPlayer ~=nil)then
                        local randomAmount = math.random(Config.Shops[store].safeMoney[1], Config.Shops[store].safeMoney[2]) --Makes a random number between the low and high of the safe.
                        xPlayer.addMoney(randomAmount) --Adds the random amount of money to the player.
                    end
                elseif(Config.Framework == "QBUS")then
                    local Player = QBCore.Functions.GetPlayer(source)
                    if(Player ~= nil)then
                        local randomAmount = math.random(Config.Shops[store].safeMoney[1], Config.Shops[store].safeMoney[2]) 
                        Player.Functions.AddMoney('cash', randomAmount, "robbery-store-safe")
                    end
                elseif(Config.Framework == "VRP")then
                    local randomAmount = math.random(Config.Shops[store].safeMoney[1], Config.Shops[store].safeMoney[2])  
                    local user_id = vRP.getUserId({source})
                    vRP.giveInventoryItem({user_id,"dirty_money",randomAmount,true})
                end
            else
                DropPlayer(source, 'Safe Abusing') 
            end
        else
            DropPlayer(source, 'Cheating')  
        end
    else
        DropPlayer(source, 'Cheating')  
    end
end)

function CheckCops(store) --Checks the current cops online.
    if(Config.UseCopJob)then
        local cops = 0 --Sets current cops to 0 to do the check.
            if(Config.Framework == "ESX")then --Checks if your using ESX.

                for k, v in pairs(ESX.GetPlayers()) do
                    for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.

                        Citizen.Wait(10)

                        local Player = ESX.GetPlayerFromId(v) --Gets the player with an esx function.
                        if(Player ~= nil)then
                            if Player.job.name == jobname then --Checks if he is a cop or not.
                                cops = cops + 1 --Adds +1 if he a is a cop.
                            end
                        end
                    end
                end

            elseif(Config.Framework == "QBUS")then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.

                        Citizen.Wait(10)

                        local Player = QBCore.Functions.GetPlayer(v)
                        if Player ~= nil then
                            if (Player.PlayerData.job.name == jobname and Player.PlayerData.job.onduty) then
                                cops = cops + 1 --Adds +1 if he a is a cop.
                            end
                        end
                    end
                end
            elseif(Config.Framework == "VRP")then
                for k, permission in pairs(Config.vRP_Permissions) do
                    local users = vRP.getUsersByPermission({permission})
                    cops = cops + #users
                end
            else
                for k, jobname in pairs(Config.CopJobs) do
                    --DO YOUR CHECK HERE. IF IT FINDS THE JOB IT NEEDS TO ADD +1 TO POLICE CHECK. CHECK THE ESX CODE ABOVE.
                end
            end
        if(cops >= Config.Shops[store].copsNeeded)then --Checks if there are enough cops online.
            return true
        else
            return false
        end
    else
        return true --Returns true if you don't need a cop job. Feel free to do whatever the fuck you want here.
    end
end