ped = nil
local objects = {}
robbing = false
lockpicking = false
safeboxing = false
currentStore = 0
copsCalled = false
serverKeyGen = 0
inPoly = false
first = true
canRob = true
allowedToOpen = false
globalClosestDoor = nil
bomb = nil
vault = nil
hacking = nil
vRPCheck = nil
camerasHacked = false
damagedPed = false
target = nil
cash = {}

ReceptionPed = nil
SecurityPed = nil
SecondSecurityPed = nil
RandomPeds = {
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil,
}

local Pacific = PolyZone:Create({
    vector2(232.71, 211.31),
    vector2(229.84, 218.54),
    vector2(250.70, 274.82),
    vector2(298.05, 258.32),
    vector2(275.69, 196.06)
}, {
    name = "Pacific",
    debugGrid = false,
    maxZ = 115.61,
    gridDivisions = 45
})

Citizen.CreateThread(function()
    if(Config.Framework == "ESX")then --Only runs if you are using ESX.

        ESX = nil
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(500)
        end

        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function(xPlayer)
            ESX.PlayerData = xPlayer
        end)

        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function(job)
            ESX.PlayerData.job = job
        end)

        Citizen.CreateThread(function()
            while true do

                if(ESX.PlayerData == nil)then
                    ESX.PlayerData = ESX.GetPlayerData()
                elseif(ESX.PlayerData.job == nil)then
                    ESX.PlayerData = ESX.GetPlayerData()
                end

                Citizen.Wait(30000)

            end
        end)

    elseif(Config.Framework == "QBUS")then --Only runs if you are using QBUS.

        QBCore = nil
        while QBCore == nil do
            local QBCore = exports['qb-core']:GetCoreObject()
            Citizen.Wait(500)
        end


        RegisterNetEvent('QBCore:Client:OnJobUpdate')
        AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
            PlayerJob = JobInfo
        end)

        RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            PlayerJob = QBCore.Functions.GetPlayerData().job
        end)

        Citizen.Wait(100)

        if(PlayerJob == nil)then
            PlayerJob = QBCore.Functions.GetPlayerData().job
        end
    elseif(Config.Framework == "VRP")then

        vRPCheck = false
        
        RegisterNetEvent('pacificBankRobbery:client:vRP:JobCheck')
        AddEventHandler('pacificBankRobbery:client:vRP:JobCheck', function(state)
	        vRPCheck = state
        end)

    end
end)

Citizen.CreateThread(function()
    while Config.UseLasers do
        Citizen.Wait(1000)
        if(inPoly)then
            if(Config.PacificBank.vaultDoor.bombed)then
                if not lasersInitiated then
                    lasersInitiated = true
                    lasersToggler(true)
                end
                Citizen.Wait(2000)
            else
                if lasersInitiated then
                    lasersInitiated = false
                    lasersToggler(false)
                end
            end
        else
            if lasersInitiated then
                lasersInitiated = false
                lasersToggler(false)
            end
            Citizen.Wait(2000)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)

    while true do
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        inPoly = Pacific:isPointInside(coord)
        if inPoly and not insidePacific then
            insidePacific = true
            robbingSecond = false
            TriggerEvent("pacificBankRobbery:client:locker_markers")
            TriggerEvent("pacificBankRobbery:client:vault")

            if first then
                first = false
                TriggerEvent("pacificBankRobbery:client:pedHandler")
                CreateSafe()
                CreateCash()

                if(Config.UseLasers)then
                    initialiseLasers()
                end
            end

            for i = 1, #Config.PacificBank.doors do
                    local closestDoor = GetClosestObjectOfType(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, 1.0, Config.PacificBank.doors[i].objName, false, false, false)
                    
                    if(Config.PacificBank.doors[i].destroyed)then
                        FreezeEntityPosition(closestDoor, false)
                    else
                        if(Config.PacificBank.doors[i].locked)then
                            FreezeEntityPosition(closestDoor, true)
                        else
                            FreezeEntityPosition(closestDoor, false)
                        end
                    end
            end

            TriggerEvent("pacificBankRobbery:client:damagedPeds")

            if(Config.UseCopJob)then

                allowedToOpen = false

                if(Config.Framework == "ESX")then --Only runs if you are using ESX.

                    while ESX == nil do
                        Citizen.Wait(100)
                    end

                    while ESX.PlayerData == nil do
                        Citizen.Wait(100)
                    end

                    for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                        if(ESX.PlayerData.job.name == jobname)then
                            allowedToOpen = true
                        end
                    end
            
                elseif(Config.Framework == "QBUS")then --Only runs if you are using QBUS.
            
                    while PlayerJob == nil do
                        Citizen.Wait(100)
                    end

                    for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                        if(PlayerJob.name == jobname)then
                            allowedToOpen = true
                        end
                    end

                elseif(Config.Framework == "VRP")then --Only runs if you are using QBUS.
                    if vRPCheck then
                        allowedToOpen = true
                    end
                end

            end
            
            Citizen.CreateThread(function()
            
                while inPoly do

                    local inRange = false

                        if(not inRange)then
                            if((#(globalPlayerCoords - Config.PacificBank.vaultDoor.vaultCoords) < 1.5) and not (Config.PacificBank.vaultDoor.hacked or Config.PacificBank.vaultDoor.bombed))then

                                inRange = true

                                DrawText3D(Config.PacificBank.vaultDoor.bombLocation.x, Config.PacificBank.vaultDoor.bombLocation.y, Config.PacificBank.vaultDoor.bombLocation.z, Languages[Config.Language]['plant']) --The draw 3d text for the alarm.
                            
                                if IsControlJustPressed(1, Config.PlantBombButton) then --If the control is pressed do the below code.

                                    if(Config.UseItems)then
                                        if(Config.Framework == "QBUS")then

                                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                                if result then

                                                    Citizen.Wait(math.random(1,100))
                                                
                                                    TriggerServerEvent("pacificBankRobbery:server:removeItem", "bomb", GetPlayerServerId(globalPlayerId), serverKeyGen)
    
                                                    plantBomb()

                                                else
                                                    QBCore.Functions.Notify(Languages[Config.Language]['BombItems'], "error")
                                                end
                                            end, "c4")

                                        elseif(Config.Framework == "ESX")then

                                            local inventory = ESX.GetPlayerData().inventory
                                            local Count = 0
                                        
                                            for k,v in pairs(inventory) do
                                                if v.name == 'c4' then
                                                    Count = Count + v.count
                                                end
                                            end

                                            if(Count > 0)then

                                                Citizen.Wait(math.random(1,100))
                                                
                                                TriggerServerEvent("pacificBankRobbery:server:removeItem", "bomb", GetPlayerServerId(globalPlayerId), serverKeyGen)

                                                plantBomb()

                                            else
                                                ESX.ShowNotification(Languages[Config.Language]['BombItems'])
                                            end
                                        end
                                    else
                                
                                        Citizen.Wait(math.random(1,100))

                                        plantBomb()

                                    end
                                end
                            
                            end
                        end

                        if(not inRange)then
                            if((#(globalPlayerCoords - Config.PacificBank.vaultDoor.hackCoords) < 1.5) and not (Config.PacificBank.vaultDoor.hacked or Config.PacificBank.vaultDoor.bombed))then

                                inRange = true

                                DrawText3D(Config.PacificBank.vaultDoor.hackCoords.x, Config.PacificBank.vaultDoor.hackCoords.y, Config.PacificBank.vaultDoor.hackCoords.z, Languages[Config.Language]['hack']) --The draw 3d text for the alarm.
                            
                                if IsControlJustPressed(1, Config.HackPanelButton) then --If the control is pressed do the below code.

                                    if(Config.UseItems)then
                                        if(Config.Framework == "QBUS")then

                                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                                if result then

                                                    Citizen.Wait(math.random(1,100))
                                                
                                                    TriggerServerEvent("pacificBankRobbery:server:removeItem", "hack", GetPlayerServerId(globalPlayerId), serverKeyGen)
    
                                                    hackPanel()

                                                else
                                                    QBCore.Functions.Notify(Languages[Config.Language]['ElectronicItems'], "error")
                                                end
                                            end, "electronickit")

                                        elseif(Config.Framework == "ESX")then

                                            local inventory = ESX.GetPlayerData().inventory
                                            local Count = 0
                                        
                                            for k,v in pairs(inventory) do
                                                if v.name == 'electronickit' then
                                                    Count = Count + v.count
                                                end
                                            end

                                            if(Count > 0)then

                                                Citizen.Wait(math.random(1,100))
                                                
                                                TriggerServerEvent("pacificBankRobbery:server:removeItem", "hack", GetPlayerServerId(globalPlayerId), serverKeyGen)

                                                hackPanel()

                                            else
                                                ESX.ShowNotification(Languages[Config.Language]['ElectronicItems'])
                                            end
                                        end
                                    else
                                
                                        Citizen.Wait(math.random(1,100))

                                        hackPanel()

                                    end
                                end
                            
                            end
                        end

                        if(not inRange)then
                            if(#(globalPlayerCoords - Config.PacificBank.AlarmCoords) < 1 and Config.PacificBank.AlarmState)then

                                inRange = true
                                
                                DrawText3D(Config.PacificBank.AlarmCoords.x, Config.PacificBank.AlarmCoords.y, Config.PacificBank.AlarmCoords.z, Languages[Config.Language]['alarm']) --The draw 3d text for the alarm.

                                if IsControlJustPressed(1, Config.AlarmButton) then --If the control is pressed do the below code.
                                    Citizen.Wait(math.random(1,1000))

                                    dict = "anim@mp_radio@garage@high"
                                    loadDict(dict)
                                                                    
                                    while(not HasAnimDictLoaded(dict) and globalPlayerPed == nil)do
                                        Citizen.Wait(100)
                                    end
                                
                                    TaskPlayAnim(globalPlayerPed, dict, "button_press", 3.0, -1, -1, 49, 0, false, false, false)
                                    Citizen.Wait(850)
                                    ClearPedTasks(globalPlayerPed)

                                    TriggerServerEvent("pacificBankRobbery:server:globalAlarmState") --Starts the padlock minigame.
                                end

                            end
                        end

                        if(not inRange)then

                            if(Config.UseCopJob)then
                
                                if(Config.Framework == "ESX")then --Only runs if you are using ESX.
                
                                    while ESX == nil do
                                        Citizen.Wait(100)
                                    end
                
                                    while ESX.PlayerData == nil do
                                        Citizen.Wait(100)
                                    end
                
                                    for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                                        if(ESX.PlayerData.job.name == jobname)then
                                            if(#(globalPlayerCoords - Config.PacificBank.ResetBank) < 1.5 and Config.PacificBank.robbed)then

                                                inRange = true
                                                
                                                DrawText3D(Config.PacificBank.ResetBank.x, Config.PacificBank.ResetBank.y, Config.PacificBank.ResetBank.z, Languages[Config.Language]['reset']) --The draw 3d text for the alarm.
                
                                                if IsControlJustPressed(1, Config.ResetButton) then --If the control is pressed do the below code.
                                                    Citizen.Wait(math.random(1,1000))
                
                                                    dict = "anim@mp_radio@garage@high"
                                                    loadDict(dict)
                                                                                    
                                                    while(not HasAnimDictLoaded(dict) and globalPlayerPed == nil)do
                                                        Citizen.Wait(100)
                                                    end
                                                
                                                    TaskPlayAnim(globalPlayerPed, dict, "button_press", 3.0, -1, -1, 49, 0, false, false, false)
                                                    Citizen.Wait(850)
                                                    ClearPedTasks(globalPlayerPed)
                
                                                    TriggerServerEvent("pacificBankRobbery:server:ResetBank") --Starts the padlock minigame.
                                                end
                
                                            end
                                        end
                                    end
                            
                                elseif(Config.Framework == "QBUS")then --Only runs if you are using QBUS.
                            
                                    while PlayerJob == nil do
                                        Citizen.Wait(100)
                                    end
                
                                    for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                                        if(PlayerJob.name == jobname)then
                                            if(#(globalPlayerCoords - Config.PacificBank.ResetBank) < 1.5 and Config.PacificBank.robbed)then

                                                inRange = true
                                                
                                                DrawText3D(Config.PacificBank.ResetBank.x, Config.PacificBank.ResetBank.y, Config.PacificBank.ResetBank.z, Languages[Config.Language]['reset']) --The draw 3d text for the alarm.
                
                                                if IsControlJustPressed(1, Config.ResetButton) then --If the control is pressed do the below code.
                                                    Citizen.Wait(math.random(1,1000))
                
                                                    dict = "anim@mp_radio@garage@high"
                                                    loadDict(dict)
                                                                                    
                                                    while(not HasAnimDictLoaded(dict) and globalPlayerPed == nil)do
                                                        Citizen.Wait(100)
                                                    end
                                                
                                                    TaskPlayAnim(globalPlayerPed, dict, "button_press", 3.0, -1, -1, 49, 0, false, false, false)
                                                    Citizen.Wait(850)
                                                    ClearPedTasks(globalPlayerPed)
                
                                                    TriggerServerEvent("pacificBankRobbery:server:ResetBank") --Starts the padlock minigame.
                                                end
                
                                            end
                                        end
                                    end
                            
                                elseif(Config.Framework == "VRP")then --Only runs if you are using QBUS.
                                    if(vRPCheck)then
                                        if(#(globalPlayerCoords - Config.PacificBank.ResetBank) < 1.5 and Config.PacificBank.robbed)then

                                            inRange = true
                                            
                                            DrawText3D(Config.PacificBank.ResetBank.x, Config.PacificBank.ResetBank.y, Config.PacificBank.ResetBank.z, Languages[Config.Language]['reset']) --The draw 3d text for the alarm.
            
                                            if IsControlJustPressed(1, Config.ResetButton) then --If the control is pressed do the below code.
                                                Citizen.Wait(math.random(1,1000))
            
                                                dict = "anim@mp_radio@garage@high"
                                                loadDict(dict)
                                                                                
                                                while(not HasAnimDictLoaded(dict) and globalPlayerPed == nil)do
                                                    Citizen.Wait(100)
                                                end
                                            
                                                TaskPlayAnim(globalPlayerPed, dict, "button_press", 3.0, -1, -1, 49, 0, false, false, false)
                                                Citizen.Wait(850)
                                                ClearPedTasks(globalPlayerPed)
            
                                                TriggerServerEvent("pacificBankRobbery:server:ResetBank") --Starts the padlock minigame.
                                            end
            
                                        end
                                    end
                                end
                            end
                        end

                        if(not inRange)then
                            for i = 1, #Config.PacificBank.safes do
                                if(#(globalPlayerCoords - Config.PacificBank.safes[i].safeCoords) < 1.5)then

                                    inRange = true

                                    if(policeCheck)then
                                        if(not safeboxing)then

                                            if(not Config.PacificBank.safes[i].opened and not Config.PacificBank.safes[i].busy)then
                                                DrawText3D(Config.PacificBank.safes[i].safeCoords.x, Config.PacificBank.safes[i].safeCoords.y, Config.PacificBank.safes[i].safeCoords.z, Languages[Config.Language]['crackSafe']) --The draw 3d text for the safe.
                                                
                                                if IsControlJustPressed(1, Config.CrackSafeButton) then --If the control is pressed do the below code.
                                                    Citizen.Wait(math.random(1,1000))
                                                    Citizen.Wait(math.random(1,200))
                                                    if(not Config.PacificBank.safes[i].busy)then
                                                        safeboxing = true
                                                        TriggerServerEvent("pacificBankRobbery:server:busyState", "safe", i, true)
                                                        TriggerEvent("pacific_safecracking:loop", i) --Starts the padlock minigame.
                                                    end
                                                end
                                            else
                                                DrawText3D(Config.PacificBank.safes[i].safeCoords.x, Config.PacificBank.safes[i].safeCoords.y, Config.PacificBank.safes[i].safeCoords.z, Languages[Config.Language]['safeOpened']) --The draw 3d text for the safe.
                                            end
                                        end
                                    else
                                        DrawText3D(Config.PacificBank.safes[i].safeCoords.x, Config.PacificBank.safes[i].safeCoords.y, Config.PacificBank.safes[i].safeCoords.z, Languages[Config.Language]['no_cops']) --The draw 3d text for the safe.
                                    end
                                end
                            end
                        end

                        if(not inRange)then
                            for i = 1, #Config.PacificBank.lockers do
                                if(#(globalPlayerCoords - Config.PacificBank.lockers[i].lockerCoords) < 0.5)then

                                    inRange = true

                                    local lockering = false

                                    if(policeCheck)then
                                        if(not lockering)then
                                            if(not Config.PacificBank.lockers[i].opened and not Config.PacificBank.lockers[i].busy)then
                                                DrawText3D(Config.PacificBank.lockers[i].lockerCoords.x, Config.PacificBank.lockers[i].lockerCoords.y, Config.PacificBank.lockers[i].lockerCoords.z, Languages[Config.Language]['breakLocker']) --The draw 3d text for the safe.
                                                
                                                if IsControlJustPressed(1, Config.BreakLockerButton) then --If the control is pressed do the below code.

                                                    if(Config.UseItems)then
                                                        if(Config.Framework == "QBUS")then
                
                                                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                                                if result then
                    
                                                                    Citizen.Wait(math.random(1,1000))
                                                                    Citizen.Wait(math.random(1,200))
                                                                    if(not Config.PacificBank.lockers[i].busy)then
                                                                        safeboxing = true
                                                                        TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", i, true)
                                                                        breakLocker(i)
                                                                    end
                
                                                                else
                                                                    QBCore.Functions.Notify(Languages[Config.Language]['OxycutterItems'], "error")
                                                                end
                                                            end, "oxycutter")
                
                                                        elseif(Config.Framework == "ESX")then
                
                                                            local inventory = ESX.GetPlayerData().inventory
                                                            local Count = 0
                                                        
                                                            for k,v in pairs(inventory) do
                                                                if v.name == 'oxycutter' then
                                                                    Count = Count + v.count
                                                                end
                                                            end
                
                                                            if(Count > 0)then
                    
                                                                Citizen.Wait(math.random(1,1000))
                                                                Citizen.Wait(math.random(1,200))
                                                                if(not Config.PacificBank.lockers[i].busy)then
                                                                    safeboxing = true
                                                                    TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", i, true)
                                                                    breakLocker(i)
                                                                end
                
                                                            else
                                                                ESX.ShowNotification(Languages[Config.Language]['OxycutterItems'])
                                                            end
                                                        end
                                                    else
                                                
                                                        Citizen.Wait(math.random(1,1000))
                                                        Citizen.Wait(math.random(1,200))
                                                        if(not Config.PacificBank.lockers[i].busy)then
                                                            safeboxing = true
                                                            TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", i, true)
                                                            breakLocker(i)
                                                        end
                
                                                    end
                                                end
                                            else
                                                DrawText3D(Config.PacificBank.lockers[i].lockerCoords.x, Config.PacificBank.lockers[i].lockerCoords.y, Config.PacificBank.lockers[i].lockerCoords.z, Languages[Config.Language]['lockerOpened']) --The draw 3d text for the safe.
                                            end
                                        end
                                    else
                                        DrawText3D(Config.PacificBank.lockers[i].lockerCoords.x, Config.PacificBank.lockers[i].lockerCoords.y, Config.PacificBank.lockers[i].lockerCoords.z, Languages[Config.Language]['no_cops']) --The draw 3d text for the safe.
                                    end     
                                end
                            end
                        end

                        if(not inRange)then
                            for i = 1, #Config.PacificBank.cash do
                                if(((#(globalPlayerCoords.xy - Config.PacificBank.cash[i].cashCoords.xy) < 0.70) and (globalPlayerCoords.z - Config.PacificBank.cash[i].cashCoords.z) < 2.00) and (not Config.PacificBank.cash[i].stolen))then
                                    inRange = true

                                    DrawText3D(Config.PacificBank.cash[i].cashCoords.x, Config.PacificBank.cash[i].cashCoords.y, Config.PacificBank.cash[i].cashCoords.z, Languages[Config.Language]['steal']) --The draw 3d text for the alarm.
                                
                                    if IsControlJustPressed(1, Config.StealCashButton) then --If the control is pressed do the below code.
                                        stealCash(i)
                                    end
                                
                                end
                            end
                        end

                    if not inRange then
                        Citizen.Wait(500)
                    end

                    Citizen.Wait(4)
                end
            end)

            if(Config.PacificBank.robbed)then
                Citizen.Wait(1000)
                if(Config.PacificBank.mainSecurityGuardState or Config.PacificBank.secondSecurityGuardState)then
                    if(DoesEntityExist(SecurityPed) and DoesEntityExist(SecondSecurityPed))then
                        TriggerEvent("pacificBankRobbery:client:fightBack", target)
                    end
                end
            end

        elseif not inPoly and insidePacific then
            insidePacific = false
            lasersToggler(false)
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()

    while(globalPlayerId == nil)do
        Wait(100)
    end

    while(Config.PacificBank.robbed == nil)do --Makes sure we get all the data from the server.

        TriggerServerEvent("pacificBankRobbery:server:randomKeyGen", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:PedsUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:stealableUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:doorsUpdate", GetPlayerServerId(globalPlayerId))
         
        TriggerServerEvent("pacificBankRobbery:server:AlarmState", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:robbed", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:policeCheck", GetPlayerServerId(globalPlayerId))

        Citizen.Wait(1000)
    end

    Citizen.CreateThread(function() --Checks whether the peds are dead or not. Also sends a robbery alert
        while true do
            Wait(3000)
                    local callCops = false
                    
                    if(DoesEntityExist(ReceptionPed))then
                        if(Config.PacificBank.mainReceptionEmployeeState)then
                            Wait(500)
                            if (IsPedDeadOrDying(ReceptionPed) and DoesEntityExist(ReceptionPed)) then
                                Wait(500)
                                if (IsPedDeadOrDying(ReceptionPed) and DoesEntityExist(ReceptionPed)) then
                                    local deathSource, wep = NetworkGetEntityKillerOfPlayer(ReceptionPed)

                                    if deathSource == -1 or deathSource == playerPed then
                                        killer = PlayerId()
                                    end

                                    if deathSource == -1 or deathSource == globalPlayerPedId then
                                        TriggerServerEvent('pacificBankRobbery:server:pedDead', "reception")
                                        callCops = true
                                    end
                                end
                            end
                        end
                    end

                    if(DoesEntityExist(SecurityPed))then
                        Wait(500)
                        if(Config.PacificBank.mainSecurityGuardState)then
                            Wait(500)
                            if (IsPedDeadOrDying(SecurityPed) and DoesEntityExist(SecurityPed)) then
                                Wait(500)
                                if (IsPedDeadOrDying(SecurityPed) and DoesEntityExist(SecurityPed)) then
                                    local deathSource, wep = NetworkGetEntityKillerOfPlayer(SecurityPed)

                                    if deathSource == -1 or deathSource == playerPed then
                                        killer = PlayerId()
                                    end

                                    if deathSource == -1 or deathSource == globalPlayerPedId then
                                        TriggerServerEvent('pacificBankRobbery:server:pedDead', "guard")
                                        callCops = true
                                    end
                                end
                            end 
                        end
                    end

                    if(DoesEntityExist(SecondSecurityPed))then
                        Wait(500)
                        if(Config.PacificBank.secondSecurityGuardState)then
                            Wait(500)
                            if (IsPedDeadOrDying(SecondSecurityPed) and DoesEntityExist(SecondSecurityPed)) then
                                Wait(500)
                                    if (IsPedDeadOrDying(SecondSecurityPed) and DoesEntityExist(SecondSecurityPed)) then
                                        local deathSource, wep = NetworkGetEntityKillerOfPlayer(SecondSecurityPed)

                                        if deathSource == -1 or deathSource == playerPed then
                                            killer = PlayerId()
                                        end

                                        if deathSource == -1 or deathSource == globalPlayerPedId then
                                            TriggerServerEvent('pacificBankRobbery:server:pedDead', "guard2")
                                            callCops = true
                                        end
                                    end
                            end 
                        end
                    end

                    for i = 1, #Config.PacificBank.randomPeds do
                        if(DoesEntityExist(RandomPeds[i]))then
                            if(Config.PacificBank.randomPeds[i].state)then
                                Wait(500)
                                if (IsPedDeadOrDying(RandomPeds[i]) and DoesEntityExist(RandomPeds[i])) then
                                    Wait(500)
                                    if (IsPedDeadOrDying(RandomPeds[i]) and DoesEntityExist(RandomPeds[i])) then
                                        local deathSource, wep = NetworkGetEntityKillerOfPlayer(RandomPeds[i])

                                        if deathSource == -1 or deathSource == playerPed then
                                            killer = PlayerId()
                                        end
        
                                        if deathSource == -1 or deathSource == globalPlayerPedId then
                                            TriggerServerEvent('pacificBankRobbery:server:pedDead', "randomPeds", i)
                                            callCops = true
                                        end
                                    end
                                end
                            end
                        end
                    end
        end
    end)

    Citizen.CreateThread(function() -- Used for drawing 3d text while the doors are locked/unlocked. Feel free to delete this code if you have it done by your doorlock script.
        while true do
            if(inPoly)then
                    for i = 1, #Config.PacificBank.doors do
                        if(#(globalPlayerCoords - Config.PacificBank.doors[i].objCoords) <= 1.0)then
                            globalClosestDoor = i

                            local closestDoor = GetClosestObjectOfType(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, 1.0, Config.PacificBank.doors[i].objName, false, false, false)

                            if(Config.PacificBank.doors[i].destroyed)then
                                FreezeEntityPosition(closestDoor, false)
                            else
                                if(Config.PacificBank.doors[i].locked)then
                                    FreezeEntityPosition(closestDoor, true)
                                else
                                    FreezeEntityPosition(closestDoor, false)
                                end
                            end

                            if(not Config.PacificBank.doors[i].destroyed)then
                                while(#(globalPlayerCoords - Config.PacificBank.doors[i].objCoords) <= 1.0 and not Config.PacificBank.doors[i].destroyed)do
                                    if(allowedToOpen)then

                                        if(Config.PacificBank.doors[i].locked)then
                                            DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['doorLocked'])
                                        else
                                            DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['doorUnlocked'])
                                        end

                                        if IsControlJustPressed(1, Config.DoorButton) then --If the control is pressed do the below code.
                                            Citizen.Wait(math.random(1,100))
                                            TaskPlayAnim(globalPlayerPed, "anim@heists@keycard@", "exit", 3.0, -1, -1, 50, 0, false, false, false)
                                            TriggerServerEvent("pacificBankRobbery:server:toggleDoorLock", i)
                                            Citizen.Wait(1000)
                                            ClearPedTasks(globalPlayerPed)
                                        else
                                            FreezeEntityPosition(closestDoor, Config.PacificBank.doors[i]["locked"])
                                        end 

                                    else
                                        if(Config.PacificBank.doors[i].locked)then
                                            if(policeCheck)then
                                                if(Config.PacificBank.doors[i].type == "lockpick")then
                                                    DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['lockpickDoor'])
                                                
                                                    if IsControlJustPressed(1, Config.DoorButton) then --If the control is pressed do the below code.

                                                        if(Config.UseItems)then
                                                            if(Config.Framework == "QBUS")then

                                                                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                                                    if result then
                                                                        if not robbing and not Config.PacificBank.robbed then
                                                                            TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                                        end
            
                                                                        Citizen.Wait(math.random(1,100))
                                                                        LockpickAnim()
                                                                        lockpick(true)
                                                                    else
                                                                        QBCore.Functions.Notify(Languages[Config.Language]['LockpickItems'], "error")
                                                                    end
                                                                end, "advancedlockpick")

                                                            elseif(Config.Framework == "ESX")then

                                                                local inventory = ESX.GetPlayerData().inventory
                                                                local Count = 0
                                                            
                                                                for k,v in pairs(inventory) do
                                                                    if v.name == 'advancedlockpick' then
                                                                        Count = Count + v.count
                                                                    end
                                                                end

                                                                if(Count > 0)then

                                                                    if not robbing and not Config.PacificBank.robbed then
                                                                        TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                                    end
        
                                                                    Citizen.Wait(math.random(1,100))
                                                                    LockpickAnim()
                                                                    lockpick(true)

                                                                else
                                                                    ESX.ShowNotification(Languages[Config.Language]['LockpickItems'])
                                                                end
                                                            end
                                                        else
                                                    
                                                            if not robbing and not Config.PacificBank.robbed then
                                                                TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                            end

                                                            Citizen.Wait(math.random(1,100))
                                                            LockpickAnim()
                                                            lockpick(true)

                                                        end
                                                        
                                                    end

                                                elseif(Config.PacificBank.doors[i].type == "thermite")then

                                                    DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['meltDoor'])
                                                
                                                    if IsControlJustPressed(1, Config.DoorButton) then --If the control is pressed do the below code.

                                                        if(Config.UseItems)then
                                                            if(Config.Framework == "QBUS")then

                                                                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                                                    if result then

                                                                        TriggerServerEvent("pacificBankRobbery:server:removeItem", "melt", GetPlayerServerId(globalPlayerId), serverKeyGen)
            
                                                                        Citizen.Wait(math.random(1,100))

                                                                        if not robbing and not Config.PacificBank.robbed then
                                                                            TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                                        end
                
                                                                        meltDoor(i)

                                                                    else
                                                                        QBCore.Functions.Notify(Languages[Config.Language]['ThermiteItems'], "error")
                                                                    end
                                                                end, "thermite")

                                                            elseif(Config.Framework == "ESX")then

                                                                local inventory = ESX.GetPlayerData().inventory
                                                                local Count = 0
                                                            
                                                                for k,v in pairs(inventory) do
                                                                    if v.name == 'thermite' then
                                                                        Count = Count + v.count
                                                                    end
                                                                end

                                                                if(Count > 0)then

                                                                    Citizen.Wait(math.random(1,100))
                                                                    
                                                                    TriggerServerEvent("pacificBankRobbery:server:removeItem", "melt", GetPlayerServerId(globalPlayerId), serverKeyGen)

                                                                    if not robbing and not Config.PacificBank.robbed then
                                                                        TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                                    end
            
                                                                    meltDoor(i)

                                                                else
                                                                    ESX.ShowNotification(Languages[Config.Language]['ThermiteItems'])
                                                                end
                                                            end
                                                        else
                                                    
                                                            Citizen.Wait(math.random(1,100))

                                                            if not robbing and not Config.PacificBank.robbed then
                                                                TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                            end

                                                            meltDoor(i)

                                                        end
                                                    end
                                                end
                                            else
                                                DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['no_cops'])
                                            end
                                        else
                                            DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['doorUnlockedCriminal'])
                                        end
                                    end

                                    Citizen.Wait(5)
                                end
                            else
                                FreezeEntityPosition(closestDoor, false)
                            end
                        else
                            Citizen.Wait(100)
                        end
                    end
                Citizen.Wait(5)
            else
                Citizen.Wait(500)
            end
        end
    end)

    while true do
            Wait(5)
            local me = globalPlayerPedId
            if inPoly then
                if(not Config.PacificBank.robbed)then
                    
                    if globalIsPedArmed or damagedPed  then --Checks if ped is armed. The check is actually done from garbageCollector.lua for optimization.
                        
                        if globalIsPlayerFreeAiming or globalIsPedShooting == 1 or damagedPed or Config.TriggerOnArmed then

                            
                            if(DoesEntityExist(ReceptionPed))then

                                if(Config.TriggerOnArmed)then

                                    if (HasEntityClearLosToEntityInFront(me, SecurityPed, 19) or HasEntityClearLosToEntityInFront(me, SecondSecurityPed, 19)) and not IsPedDeadOrDying(ReceptionPed) then
            
                                        if(policeCheck)then

                                            if not robbing then
                                                TriggerEvent("pacificBankRobbery:client:startRobbery")
                                            end
                                        
                                        else
                                            if not robbingSecond then
                                                TriggerEvent("pacificBankRobbery:client:noCopsReaction")
                                            end

                                            Citizen.CreateThread(function()
                                                while inPoly do
                                                    Wait(5)
                                                    DrawText3D(Config.PacificBank.mainReceptionEmployeeCoords.x, Config.PacificBank.mainReceptionEmployeeCoords.y, Config.PacificBank.mainReceptionEmployeeCoords.z, Languages[Config.Language]['no_cops'])
                                                end
                                            end) 
                                            Citizen.Wait(5000) 
                                        end

                                    else
                                        Citizen.Wait(100)
                                    end
                                    
                                else
                                    if (HasEntityClearLosToEntityInFront(me, SecurityPed, 19) or HasEntityClearLosToEntityInFront(me, SecondSecurityPed, 19)) and not IsPedDeadOrDying(ReceptionPed) then
            
                                        if(policeCheck)then

                                            if not robbing then
                                                TriggerEvent("pacificBankRobbery:client:startRobbery")
                                            end
                                        
                                        else
                                            Citizen.CreateThread(function()
                                                while inPoly do
                                                    Wait(5)
                                                    DrawText3D(Config.PacificBank.mainReceptionEmployeeCoords.x, Config.PacificBank.mainReceptionEmployeeCoords.y, Config.PacificBank.mainReceptionEmployeeCoords.z, Languages[Config.Language]['no_cops'])
                                                end
                                            end) 
                                            Citizen.Wait(5000) 
                                        end

                                    else
                                        Citizen.Wait(100)
                                    end
                                end
                            else
                                Citizen.Wait(100)
                            end
                        else
                            Citizen.Wait(100)
                        end
                    else
                        Citizen.Wait(500)
                    end
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(1000)
            end
    end
end)

Citizen.CreateThread(function()
    if(Config.UseBlips)then

        PacificBlip = AddBlipForCoord(Config.PacificBank.blip)

        SetBlipSprite(PacificBlip, 278)
        SetBlipScale(PacificBlip, 1.2)
        SetBlipColour(PacificBlip, 43)  

        SetBlipDisplay(PacificBlip, 4)
        SetBlipAsShortRange(PacificBlip, true)
        

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Central Pacific Bank")
        EndTextCommandSetBlipName(PacificBlip)
    end
end)