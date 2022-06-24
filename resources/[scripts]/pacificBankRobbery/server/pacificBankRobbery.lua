mainReceptionEmployee = nil
mainReceptionEmployeeState = nil

mainSecurityGuard = nil
mainSecurityGuardState = nil
mainSecurityGuardWeapon = nil

alarmState = nil

randomPeds = {
    [1] = {
        type = nil,
        animimation = nil,
        state = nil,
    },
    [2] = {
        type = nil,
        animimation = nil,
        state = nil,
    },
    [3] = {
        type = nil,
        animimation = nil,
        state = nil,
    },
    [4] = {
        type = nil,
        animimation = nil,
        state = nil,
    },
    [5] = {
        type = nil,
        animimation = nil,
        state = nil,
    },
}

doors = {
    [1] = {
        locked = nil,
        destroyed = nil,
    },
    [2] = {
        locked = nil,
        destroyed = nil,
    },
    [3] = {
        locked = nil,
        destroyed = nil,
    },
    [4] = {
        locked = nil,
        destroyed = nil,
    },
    [5] = {
        locked = nil,
        destroyed = nil,
    },
    [6] = {
        locked = nil,
        destroyed = nil,
    },
    [7] = {
        locked = nil,
        destroyed = nil,
    },
    [8] = {
        locked = nil,
        destroyed = nil,
    },
    [9] = {
        locked = nil,
        destroyed = nil,
    },
    [10] = {
        locked = nil,
        destroyed = nil,
    },
}

safes = {
    [1] = {
        opened = nil,
        busy = nil
    },
    [2] = {
        opened = nil,
        busy = nil
    }
}

lockers = {
    [1] = {
        opened = nil,
        busy = nil
    },
    [2] = {
        opened = nil,
        busy = nil
    },
    [3] = {
        opened = nil,
        busy = nil
    },
    [4] = {
        opened = nil,
        busy = nil
    },
    [5] = {
        opened = nil,
        busy = nil
    },
    [6] = {
        opened = nil,
        busy = nil
    },
    [7] = {
        opened = nil,
        busy = nil
    },
    [8] = {
        opened = nil,
        busy = nil
    },
    [9] = {
        opened = nil,
        busy = nil
    },
    [10] = {
        opened = nil,
        busy = nil
    }
}

cash = {
    [1] = {
        stolen = nil,
        busy = nil
    },
    [2] = {
        stolen = nil,
        busy = nil
    },
    [3] = {
        stolen = nil,
        busy = nil
    },
}

vault = {
    bombed = nil,
    hacked = nil,
}

robbed = nil

coreFinished = false

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
        vRPclient = Tunnel.getInterface("vRP","pacificBankRobbery")


        Citizen.Wait(1000)
        
        AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
            if first_spawn then
                for k, permission in pairs(Config.vRP_Permissions) do --Runs for all the job names set in the config.
                    if vRP.hasPermissions(user_id, permission) then
                        TriggerClientEvent('pacificBankRobbery:client:vRP:JobCheck', user_id, true)
                    end
                end
            end
        end)
        
        AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype)
            for k, groupName in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                if group == groupName then
                    TriggerClientEvent('pacificBankRobbery:client:vRP:JobCheck', user_id, true)
                end
            end
        end)
        
        AddEventHandler("vRP:playerLeaveGroup", function(user_id, group, gtype)
            for k, groupName in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                if group == groupName then
                    TriggerClientEvent('pacificBankRobbery:client:vRP:JobCheck', user_id, false)
                end
            end
        end)

    end

    coreFinished = true

end)

Citizen.CreateThread(function()

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
            policeCheck = CheckCops()

end)

Citizen.CreateThread(function()
    while true do

        while not coreFinished do
            Citizen.Wait(100)
        end

        policeCheck = CheckCops()
        TriggerClientEvent("pacificBankRobbery:client:policeCheck", -1, policeCheck)
        Citizen.Wait(30000)
    end

end)

function CheckCops() --Checks the current cops online.
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

        if(cops >= Config.PacificBank.copsNeeded)then --Checks if there are enough cops online.
            return true
        else
            return false
        end
    else
        return true --Returns true if you don't need a cop job. Feel free to do whatever the fuck you want here.
    end
end