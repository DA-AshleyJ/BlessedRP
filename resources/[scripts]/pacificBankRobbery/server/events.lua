RegisterServerEvent('pacificBankRobbery:server:randomKeyGen') --Used to prevent spawning items and mouney.
AddEventHandler('pacificBankRobbery:server:randomKeyGen', function(source)
    TriggerClientEvent('pacificBankRobbery:client:randomKeyGen', source, randomKeyGen)
end)

RegisterServerEvent('pacificBankRobbery:server:AlarmState') --Used to prevent spawning items and mouney.
AddEventHandler('pacificBankRobbery:server:AlarmState', function(source)
    TriggerClientEvent('pacificBankRobbery:client:AlarmState', source, alarmState)
end)

RegisterServerEvent('pacificBankRobbery:server:policeCheck') --Used to prevent spawning items and mouney.
AddEventHandler('pacificBankRobbery:server:policeCheck', function(source)
    TriggerClientEvent('pacificBankRobbery:client:policeCheck', source, policeCheck)
end)

RegisterServerEvent('pacificBankRobbery:server:globalAlarmState') --Used to prevent spawning items and mouney.
AddEventHandler('pacificBankRobbery:server:globalAlarmState', function(source)
    alarmState = false
    TriggerClientEvent('pacificBankRobbery:client:AlarmState', -1, alarmState)
end)

RegisterServerEvent('pacificBankRobbery:server:PedsUpdate')--Updates client with the current peds and state.
AddEventHandler('pacificBankRobbery:server:PedsUpdate', function(source)
    while checker do
        checker = false
        if(mainReceptionEmployee == nil)then
            checker = true
        end
        Citizen.Wait(100)
    end

    TriggerClientEvent('pacificBankRobbery:client:PedsUpdate', source, mainReceptionEmployee, mainSecurityGuardWeapon, mainReceptionEmployeeState, mainSecurityGuard, mainSecurityGuardState, secondSecurityGuardWeapon, secondSecurityGuard, secondSecurityGuardState,  randomPeds)
end)

RegisterServerEvent('pacificBankRobbery:server:robbed')
AddEventHandler('pacificBankRobbery:server:robbed', function(source)
    TriggerClientEvent('pacificBankRobbery:client:robbedToggler', source, robbed)
end)

RegisterServerEvent('pacificBankRobbery:server:animator')
AddEventHandler('pacificBankRobbery:server:animator', function(type, dict, anim, speech)
    TriggerClientEvent('pacificBankRobbery:client:animator', -1, type, dict, anim, speech)
end)

RegisterServerEvent('pacificBankRobbery:server:stealableUpdate')
AddEventHandler('pacificBankRobbery:server:stealableUpdate', function(source)
    TriggerClientEvent('pacificBankRobbery:client:stealableUpdate', source, safes, lockers, cash)
end)

RegisterServerEvent('pacificBankRobbery:server:doorsUpdate')
AddEventHandler('pacificBankRobbery:server:doorsUpdate', function(source)
    TriggerClientEvent('pacificBankRobbery:client:doorsUpdate', source, doors, vault)
end)

RegisterServerEvent('pacificBankRobbery:server:receptionUnlock')
AddEventHandler('pacificBankRobbery:server:receptionUnlock', function(source)
    TriggerClientEvent('pacificBankRobbery:client:receptionUnlock', -1)
end)

RegisterServerEvent('pacificBankRobbery:server:vaultOpener') 
AddEventHandler('pacificBankRobbery:server:vaultOpener', function(type)
    if(type == "bomb")then
        vault.bombed = true
        TriggerClientEvent("pacificBankRobbery:client:vaultOpener", -1, type)
    elseif(type == "hack")then
        vault.hacked = true
        TriggerClientEvent("pacificBankRobbery:client:vaultOpener", -1, type)
    end
end)

RegisterServerEvent('pacificBankRobbery:server:toggleDoorLock')
AddEventHandler('pacificBankRobbery:server:toggleDoorLock', function(id, statino)

    if(statino ~= nil)then
        doors[id].locked = statino
    else
        doors[id].locked = not doors[id].locked
    end

    TriggerClientEvent('pacificBankRobbery:client:toggleDoorLock', -1, id, doors[id].locked)
end)

RegisterServerEvent('pacificBankRobbery:server:breakDoor')
AddEventHandler('pacificBankRobbery:server:breakDoor', function(id)
    doors[id].destroyed = true
    TriggerClientEvent('pacificBankRobbery:client:breakDoor', -1, id, doors[id].destroyed)
end)

RegisterServerEvent('pacificBankRobbery:server:thermiteEffect')
AddEventHandler('pacificBankRobbery:server:thermiteEffect', function(id)
    TriggerClientEvent('pacificBankRobbery:client:thermiteEffect', -1, id)
end)

RegisterServerEvent('pacificBankRobbery:server:busyState') 
AddEventHandler('pacificBankRobbery:server:busyState', function(type, id, state)
    if(type == "safe")then
        safes[id].busy = state
        TriggerClientEvent("pacificBankRobbery:client:busyState", -1, type, id, state)
    elseif(type == "locker")then
        lockers[id].busy = state
        TriggerClientEvent("pacificBankRobbery:client:busyState", -1, type, id, state)
    elseif(type == "cash")then
        cash[id].busy = state
        TriggerClientEvent("pacificBankRobbery:client:busyState", -1, type, id, state)
    end
end)

RegisterServerEvent('pacificBankRobbery:server:stealableOpen')
AddEventHandler('pacificBankRobbery:server:stealableOpen', function(source, type, id, password)
    if(password ~= nil)then
        if(password == randomKeyGen)then
            local randomAmount = nil

            if(type == "safe")then

                if(not safes[id].opened)then
                    safes[id].opened = true
                    randomAmount = math.random(Config.PacificBank.safes[id].safeMoney[1], Config.PacificBank.safes[id].safeMoney[2])
                    TriggerClientEvent("pacificBankRobbery:client:stealableOpen", -1, type, id)
                else
                    DropPlayer(source, 'Pacific: Abusing Safe')
                    randomAmount = 0  
                end

            elseif(type == "locker")then

                if(not lockers[id].opened)then
                    lockers[id].opened = true
                    randomAmount = math.random(Config.PacificBank.lockers[id].lockerMoney[1], Config.PacificBank.lockers[id].lockerMoney[2])
                    TriggerClientEvent("pacificBankRobbery:client:stealableOpen", -1, type, id)
                else
                    DropPlayer(source, 'Pacific: Abusing Lockers')
                    randomAmount = 0  
                end

            elseif(type == "cash")then

                if(not cash[id].stolen)then
                    cash[id].stolen = true
                    randomAmount = math.random(Config.PacificBank.cash[id].cashMoney[1], Config.PacificBank.cash[id].cashMoney[2])
                    TriggerClientEvent("pacificBankRobbery:client:stealableOpen", -1, type, id)
                    TriggerClientEvent("pacificBankRobbery:client:cashModel", -1, id)
                else
                    DropPlayer(source, 'Pacific: Abusing Cash')
                    randomAmount = 0  
                end

            end

            if(Config.Framework == "ESX")then --Checks if your using ESX.
                local xPlayer = ESX.GetPlayerFromId(source) --Gets the player from the server id.
                if(xPlayer ~=nil)then
                    xPlayer.addMoney(randomAmount) --Adds the random amount of money to the player.
                end
            elseif(Config.Framework == "QBUS")then
                local Player = QBCore.Functions.GetPlayer(source)
                if(Player ~= nil)then
                    Player.Functions.AddMoney('cash', randomAmount, "bank-robbery")
                end
            elseif(Config.Framework == "VRP")then
                local user_id = vRP.getUserId({source})
                vRP.giveInventoryItem({user_id,"dirty_money",randomAmount,true})
            else
                print(randomAmount)
                --Give your money here This is for the register. The code for the randomiser is this: math.random(Config.Shops[store].registerMoney[1], Config.Shops[store].registerMoney[2])
            end
        else
            DropPlayer(source, 'Cheating')  
        end
    else
        DropPlayer(source, 'Cheating')  
    end

end)

RegisterServerEvent('pacificBankRobbery:server:robbedToggler')
AddEventHandler('pacificBankRobbery:server:robbedToggler', function()

    robbed = true
    alarmState = true

    TriggerClientEvent('pacificBankRobbery:client:robbedToggler', -1, robbed)
    TriggerClientEvent('pacificBankRobbery:client:alarm', -1)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.PacificBank.cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Citizen.CreateThread(function()
        Wait(wait)
        TriggerEvent("pacificBankRobbery:server:ResetBank")
    end)

end)

RegisterServerEvent('pacificBankRobbery:server:callCops') 
AddEventHandler('pacificBankRobbery:server:callCops', function()
    TriggerClientEvent("pacificBankRobbery:client:callCops", -1)
end)

RegisterServerEvent('pacificBankRobbery:server:pedDead')
AddEventHandler('pacificBankRobbery:server:pedDead', function(type, number)
    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.PacificBank.cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second

    if(type == "reception")then
        if(mainReceptionEmployeeState)then
            mainReceptionEmployeeState = false
            Citizen.CreateThread(function()
                Wait(wait)
                    mainReceptionEmployeeState = true
                    mainSecurityGuardState = true
                    secondSecurityGuardState = true
                    for i = 1, #Config.PacificBank.randomPeds do
                        randomPeds[i].state = true
                    end
                    TriggerClientEvent('pacificBankRobbery:client:reset', -1)
            end)
        end
    elseif(type == "guard")then
        if(mainSecurityGuardState)then
            mainSecurityGuardState = false
            Citizen.CreateThread(function()
                Wait(wait)
                    mainReceptionEmployeeState = true
                    mainSecurityGuardState = true
                    secondSecurityGuardState = true
                    for i = 1, #Config.PacificBank.randomPeds do
                        randomPeds[i].state = true
                    end
                    TriggerClientEvent('pacificBankRobbery:client:reset', -1)
            end)
        end
    elseif(type == "guard2")then
        if(secondSecurityGuardState)then
            secondSecurityGuardState = false
            Citizen.CreateThread(function()
                Wait(wait)
                    mainReceptionEmployeeState = true
                    mainSecurityGuardState = true
                    secondSecurityGuardState = true
                    for i = 1, #Config.PacificBank.randomPeds do
                        randomPeds[i].state = true
                    end
                    TriggerClientEvent('pacificBankRobbery:client:reset', -1)
            end)
        end
    elseif(type == "randomPeds")then
        if(randomPeds[number].state)then
            randomPeds[number].state = false
            Citizen.CreateThread(function()
                Wait(wait)
                    mainReceptionEmployeeState = true
                    mainSecurityGuardState = true
                    secondSecurityGuardState = true
                    for i = 1, #Config.PacificBank.randomPeds do
                        randomPeds[i].state = true
                    end
                    TriggerClientEvent('pacificBankRobbery:client:reset', -1)
            end)
        end
    end

    TriggerClientEvent('pacificBankRobbery:client:pedDead', -1, type, number)
end)

RegisterServerEvent('pacificBankRobbery:server:fightBack') 
AddEventHandler('pacificBankRobbery:server:fightBack', function(ped) --Used for the fightback when the robbery starts in the pacific bank.
    TriggerClientEvent('pacificBankRobbery:client:fightBack', -1, ped)
end)

RegisterServerEvent('pacificBankRobbery:server:pedsRun') 
AddEventHandler('pacificBankRobbery:server:pedsRun', function(ped) --Used for the fightback when the robbery starts in the pacific bank.

    local pedRun = {}

    for i = 1, #Config.PacificBank.randomPeds do
        pedRun[i] = math.random(1,100)
    end

    TriggerClientEvent('pacificBankRobbery:client:pedsRun', -1, pedRun)
end)

RegisterNetEvent('pacificBankRobbery:server:ResetBank')
AddEventHandler('pacificBankRobbery:server:ResetBank', function()
    
    TriggerClientEvent("pacificBankRobbery:client:teleport", -1)
    Citizen.Wait(1000)
    alarmState = false

    mainReceptionEmployee = math.random(1, #Config.Reception)
    mainReceptionEmployeeState = true
    
    mainSecurityGuard = math.random(1, #Config.SecurityPeds)
    mainSecurityGuardWeapon = Config.SecurityPeds[mainSecurityGuard].Weapons[math.random(1, #Config.SecurityPeds[mainSecurityGuard].Weapons)]
    mainSecurityGuardState = true

    secondSecurityGuard = math.random(1, #Config.SecurityPeds)
    secondSecurityGuardWeapon = Config.SecurityPeds[secondSecurityGuard].Weapons[math.random(1, #Config.SecurityPeds[secondSecurityGuard].Weapons)]
    secondSecurityGuardState = true

    for i = 1, #Config.PacificBank.randomPeds do

        local notfinished = true

        while notfinished do
        
            local number =  math.random(1, #Config.RandomPeds)

            if(not Config.RandomPeds[number].isUsed)then
                randomPeds[i].type = number
                Config.RandomPeds[number].isUsed = true
                notfinished = false
            else
                notfinished = true
            end
            Citizen.Wait(0)
        end

        notfinished = true

        while notfinished do
        
            local number =  math.random(1, #Config.RandomAnimations)

            if(not Config.RandomAnimations[number].isUsed)then
                randomPeds[i].animation = number
                Config.RandomAnimations[number].isUsed = true
                notfinished = false
            else
                notfinished = true
            end
            Citizen.Wait(0)
        end

        randomPeds[i].state = true
    end

    for i = 1, #Config.PacificBank.doors do
        doors[i].locked = true
        doors[i].destroyed = false
    end
    

    for v=1, #Config.PacificBank.safes do
        safes[v].opened = false
        safes[v].busy = false
    end

    for v=1, #Config.PacificBank.lockers do
        lockers[v].opened = false
        lockers[v].busy = false
    end

    for v=1, #Config.PacificBank.cash do
        cash[v].stolen = false
        cash[v].busy = false
    end

    vault.bombed = false
    vault.hacked = false

    robbed = false
    alarmState = false

    Citizen.Wait(1500)

    TriggerClientEvent('pacificBankRobbery:client:PedsUpdate', -1, mainReceptionEmployee, mainSecurityGuardWeapon, mainReceptionEmployeeState, mainSecurityGuard, mainSecurityGuardState, secondSecurityGuardWeapon, secondSecurityGuard, secondSecurityGuardState,  randomPeds)

    TriggerClientEvent('pacificBankRobbery:client:stealableUpdate', -1, safes, lockers, cash)

    TriggerClientEvent('pacificBankRobbery:client:doorsUpdate', -1, doors, vault)

    TriggerClientEvent('pacificBankRobbery:client:AlarmState', -1, alarmState)

    TriggerClientEvent('pacificBankRobbery:client:robbedToggler', -1, robbed)
    
    policeCheck = CheckCops()

    TriggerClientEvent('pacificBankRobbery:client:policeCheck', -1, policeCheck)
end)

RegisterNetEvent('pacificBankRobbery:server:removeItem')
AddEventHandler('pacificBankRobbery:server:removeItem', function(type, source, password)
    if(password ~= nil)then
        if(password == randomKeyGen)then

            local item = nil

            if(type == "melt")then
                item = "thermite"
            elseif(type == "bomb")then
                item = "c4"
            elseif(type == "hack")then
                item = "electronickit"
            end

            if(item ~= nil)then
                if(Config.Framework == "QBUS")then

                    local Player = QBCore.Functions.GetPlayer(source) 
                    Player.Functions.RemoveItem(item, 1)

                elseif(Config.Framework == "ESX")then

                    local xPlayer = ESX.GetPlayerFromId(source)
                    xPlayer.removeInventoryItem(item, 1)

                end
            else
                print(GetPlayerName(source) .. 'Pacific Bank Robbery - Cheating')
            end
        else
            print(GetPlayerName(source) .. 'Pacific Bank Robbery - Cheating')
        end
    else
        print(GetPlayerName(source) .. 'Pacific Bank Robbery - Cheating') 
    end
end)