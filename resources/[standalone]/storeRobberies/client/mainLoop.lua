ped = nil
objects = {}
robbing = false
canRob = true
canRobType = nil
lockpicking = false
registering = false
safeboxing = false
currentStore = 0
copsCalled = false
serverKeyGen = 0
inCam = false
cameraId = 0
spawner = 0

Citizen.CreateThread(function()
    if(Config.Framework == "ESX")then --Only runs if you are using ESX.

        ESX = nil
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(500)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(500)
        end

        Citizen.CreateThread(function()
            while true do
                ESX.PlayerData = ESX.GetPlayerData()
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
        
        RegisterNetEvent('storeRobberies:client:vRP:JobCheck')
        AddEventHandler('storeRobberies:client:vRP:JobCheck', function(state)
	        vRPCheck = state
        end)

    end
end)

Citizen.CreateThread(function()
    local distance = 1000
    Citizen.Wait(1000)
    while true do
        for v = 1, #Config.Shops do
            if #(globalPlayerCoords - Config.Shops[v].shopKeeperCoords) <= distance then
                distance = #(globalPlayerCoords - Config.Shops[v].shopKeeperCoords)
                currentStore = v
            end
        end
        Citizen.Wait(500)
        distance = 1000
    end
end)

Citizen.CreateThread(function()
    
    ped = nil

    while(globalPlayerId == nil)do
        Wait(100)
    end

    while(Config.Shops[#Config.Shops].shopKeeperState == nil or Config.Shops[#Config.Shops].shopKeeper == nil)do
        TriggerServerEvent("storeRobberies:server:randomKeyGen", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("storeRobberies:server:shopkeeperUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("storeRobberies:server:shopkeeperStateUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("storeRobberies:server:registerOpenedUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("storeRobberies:server:safeOpenedUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("storeRobberies:server:safeCodeUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("storeRobberies:server:copsCalledUpdate", GetPlayerServerId(globalPlayerId))
         
        TriggerServerEvent("storeRobberies:server:canRobUpdater", GetPlayerServerId(globalPlayerId))
        Citizen.Wait(1000)
    end

    TriggerEvent("storeRobberies:client:pedHandler", currentStore)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if(ped ~= nil and currentStore ~= nil)then
                if(DoesEntityExist(ped))then
                    Wait(500)
                    if(Config.Shops[currentStore].shopKeeperState)then
                        Wait(500)
                        if (IsPedDeadOrDying(ped) and DoesEntityExist(ped)) then
                            Wait(500)
                                if (IsPedDeadOrDying(ped) and DoesEntityExist(ped)) then
                                    local deathSource, wep = NetworkGetEntityKillerOfPlayer(ped)

                                    if deathSource == -1 or deathSource == playerPed then
                                        killer = PlayerId()
                                    end

                                    if deathSource == -1 or deathSource == globalPlayerPedId then
                                        TriggerServerEvent('storeRobberies:server:pedDead', currentStore)

                                        if(not copsCalled)then

                                            TriggerServerEvent("storeRobberies:server:callCops", currentStore)
                                            copsCalled = true

                                            Citizen.CreateThread(function()
                                                Citizen.Wait(Config.PoliceCallSpamPrevention * 1000)
                                                copsCalled = false
                                            end)
                                        end
                                    end
                                end
                        end 
                    end
                end
            end
        end
    end)

    while true do
            Wait(5)
            local me = globalPlayerPedId
            if globalIsPedArmed or globalIsPedMeleeArmed == 1 then

                if(Config.UseMeleeRobbing)then
                    if(IsPlayerTargettingAnything(globalPlayerId))then
                        melee = true
                    else
                        melee = false
                    end
                else
                    melee = false
                end

                if globalIsPlayerFreeAiming or melee then
                    if(#(globalPlayerCoords - Config.Shops[currentStore].shopKeeperCoords) <= 8)then
                        if(not IsPedArmed(ped))then

                            if(Config.UseCopJob)then

                                if(Config.NoRobPolice)then
                                    
                                    startRobbing = true

                                    if(Config.Framework == "ESX")then --Only runs if you are using ESX.
                    
                                        while ESX == nil do
                                            Citizen.Wait(100)
                                        end
                    
                                        while ESX.PlayerData == nil do
                                            Citizen.Wait(100)
                                        end
                    

                                        for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                                            if(ESX.PlayerData.job.name == jobname)then
                                                startRobbing = false
                                            end
                                        end
                                    elseif(Config.Framework == "QBUS")then

                                        while PlayerJob == nil do
                                            Citizen.Wait(100)
                                        end
                    
                                        for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                                            if(PlayerJob.name == jobname)then
                                                startRobbing = false
                                            end
                                        end
                                    elseif(Config.Framework == "VRP")then
                                        if(vRPCheck)then
                                            startRobbing = false
                                        end
                                    end

                                else
                                    startRobbing = true
                                end
                            else
                                startRobbing = true
                            end

                            if(DoesEntityExist(ped) and startRobbing)then
                                if HasEntityClearLosToEntityInFront(me, ped, 19) and not IsPedDeadOrDying(ped) then
                                    if not robbing then
                                        Citizen.Wait(1,1000)
                                        if(not Config.Shops[currentStore].shopkeeperBusy)then
                                            
                                            canRob = nil
                                            
                                            TriggerServerEvent("storeRobberies:server:shopkeeperBusy", currentStore, true)

                                            TriggerServerEvent('storeRobberies:server:canRob',GetPlayerServerId(globalPlayerId), currentStore)

                                            while canRob == nil do
                                                Wait(0)
                                            end

                                            local fightBack = 0
                                            local scared = false

                                            if(Config.Shopkeepers[Config.Shops[currentStore].shopKeeper].CallCopsEarlyChance > math.random(1,100) and not copsCalled)then
                                                Citizen.Wait(200)
                                                TriggerServerEvent("storeRobberies:server:callCops", currentStore)
                                                copsCalled = true
                                                Citizen.Wait(300)
                                                Citizen.CreateThread(function()
                                                    Citizen.Wait(Config.PoliceCallSpamPrevention * 1000)
                                                    copsCalled = false
                                                end)
                                            end

                                            if(Config.Shopkeepers[Config.Shops[currentStore].shopKeeper].FightBackChance > math.random(1,100))then
                                                if(canRob)then
                                                    fightBack = math.random(1,3)
                                                else
                                                    fightBack = 1
                                                end
                                            else
                                                fightBack = 0
                                            end

                                            if(Config.Shopkeepers[Config.Shops[currentStore].shopKeeper].ScaredChance > math.random(1,100))then
                                                scared = true
                                            end

                                            local anim,dict,animCamera,dictCamera
                                            local dictCamera = "anim@heists@prison_heiststation@cop_reactions"
                                            local animCamera = "cop_b_idle"

                                            if(scared)then
                                                anim = "missheist_agency2ahands_up"
                                                dict = "handsup_anxious"
                                                PlayPain(ped, 7, 0, 0)
                                                SetFacialIdleAnimOverride(ped, "shocked_1")
                                            else
                                                anim = "random@mugging3"
                                                dict = "handsup_standing_base"
                                                PlayPain(ped, 6, 0, 0)
                                                SetFacialIdleAnimOverride(ped, "mood_stressed_1")
                                            end

                                            TriggerServerEvent("storeRobberies:server:animator", currentStore, anim, dict)
                                            local pedCoords = GetEntityCoords(ped)
                                            
                                            if canRob == true then
                                                robbing = true

                                                Citizen.CreateThread(function()
                                                    while robbing do Wait(0) if IsPedDeadOrDying(ped) then robbing = false end end
                                                end)

                                                if(fightBack == 1)then
                                                    fightBack_function(currentStore)
                                                else
                                                    local randomise
                                                    if(fightBack == 2)then
                                                        randomiser  = math.random(200,4800)
                                                    end

                                                    while not IsPedDeadOrDying(ped) and #(globalPlayerCoords - Config.Shops[v].shopKeeperCoords) <= 12.5 do
                                                        pedCoords = GetEntityCoords(ped)

                                                        DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Languages[Config.Language]['robbingInitialMessage'])

                                                        if(Config.UsingSurveillanceSystem)then
                                                            DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z-0.10, Languages[Config.Language]['robbingInitialMessage-Surv'])
                                                            if IsControlJustPressed(1, Config.DisableCamerasButton) then
                                                                local timer = 0
                                                                loadDict(dictCamera)
                                                                TriggerServerEvent("storeRobberies:server:animator", currentStore, dictCamera, animCamera)
                                                                RemoveAnimDict(dictCamera)
                                                                while(timer <= 5000 and not IsPedDeadOrDying(ped) and  #(globalPlayerCoords - Config.Shops[v].shopKeeperCoords) <= 12.5)do

                                                                    if(fightBack == 2 and timer > randomiser)then
                                                                        fightBack_function(currentStore)
                                                                        break;
                                                                    end
                                                                    

                                                                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Languages[Config.Language]['secondaryMessage'])
                                                                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z-0.10, Languages[Config.Language]['disablingCameras'] .. " - " .. round(timer / 50, 1) .. "%")
                                                                    timer = timer + randomFloat(4.5, 8.2)
                                                                    Citizen.Wait(5)
                                                                end

                                                                if timer>= 5000 then
                                                                    if(not (Config.Shopkeepers[Config.Shops[currentStore].shopKeeper].DisableCamerasFakeChance > math.random(1,100)))then
                                                                        
                                                                        if((fightBack == 3 and not IsPedDeadOrDying(ped)) or Config.Shops[currentStore].registerOpened)then
                                                                            fightBack_function(currentStore)
                                                                            break;
                                                                        else
                                                                            for k, v in pairs(Config.Shops[currentStore].camera) do
                                                                                TriggerServerEvent("cameraSystem:server:updateState", v, false)
                                                                            end
                                                                        end
                                                                    end
                                                                    TriggerServerEvent("storeRobberies:server:animator", currentStore, anim, dict)
                                                                end

                                                            end
                                                        else
                                                            DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z-0.10, Languages[Config.Language]['robbingInitialMessage-noSurv'])
                                                        end
                                                            if IsControlJustPressed(1, Config.EmptyRegisterButton) then
                                                                local timer = 0
                                                                loadDict(dictCamera)
                                                                TriggerServerEvent("storeRobberies:server:animator", currentStore, dictCamera, animCamera)
                                                                RemoveAnimDict(dictCamera)
                                                                while(timer <= 5000 and not IsPedDeadOrDying(ped) and #(globalPlayerCoords - pedCoords) <= 7.5)do

                                                                    if(fightBack == 2 and timer > randomiser)then
                                                                        fightBack_function(currentStore)
                                                                        break;
                                                                    end
                                                                    

                                                                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Languages[Config.Language]['secondaryMessage'])
                                                                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z-0.10, Languages[Config.Language]['unlockRegister'] .. " - " .. round(timer / 50, 1) .. "%")
                                                                    timer = timer + randomFloat(8.5, 12.2)
                                                                    Citizen.Wait(5)
                                                                end

                                                                if timer >= 5000 then
                                                                    if(Config.Shops[currentStore].safeType ~= "padlock")then
                                                                        if(fightBack == 0 and Config.Shopkeepers[Config.Shops[currentStore].shopKeeper].GiveSafeCodeChance > math.random(1,100))then
                                                                            Citizen.CreateThread(function()
                                                                                messager = GetGameTimer() + 10000
                                                                                while messager >= GetGameTimer() do
                                                                                    if IsPedDeadOrDying(ped) then
                                                                                        break
                                                                                    end
                                                                                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Languages[Config.Language]['safecode'] .. " ".. Config.Shops[currentStore].safeCode)
                                                                                    Wait(7)
                                                                                end                                                        
                                                                            end)
                                                                        end
                                                                    end

                                                                    if((fightBack == 3 and not IsPedDeadOrDying(ped)) or Config.Shops[currentStore].registerOpened)then
                                                                        fightBack_function(currentStore)
                                                                        break;
                                                                    elseif not IsPedDeadOrDying(ped) then
                                                                        TriggerServerEvent("storeRobberies:server:animator", currentStore, anim, dict)
                                                                        local cashRegister = GetClosestObjectOfType(GetEntityCoords(ped), 5.0, GetHashKey('prop_till_01'))
                                                                        if DoesEntityExist(cashRegister) then
                                                                            CreateModelSwap(GetEntityCoords(cashRegister), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
                                                                        end
                                                            
                                                                        local model = GetHashKey('prop_poly_bag_01')
                                                                        RequestModel(model)
                                                                        while not HasModelLoaded(model) do Wait(0) end
                                                                        local bag = CreateObject(model, GetEntityCoords(ped), false, false)
                                                                                    
                                                                        AttachEntityToEntity(bag, ped, GetPedBoneIndex(ped, 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
                                                                        timer = GetGameTimer() + 3000
                                                                        while timer >= GetGameTimer() do
                                                                            if IsPedDeadOrDying(ped) then
                                                                                break
                                                                            end
                                                                            Wait(0)
                                                                        end
                                                                        if not IsPedDeadOrDying(ped) then
                                                                            DetachEntity(bag, true, false)
                                                                            timer = GetGameTimer() + 30
                                                                            while timer >= GetGameTimer() do
                                                                                if IsPedDeadOrDying(ped) then
                                                                                    break
                                                                                end
                                                                                Wait(0)
                                                                            end
                                                                            SetEntityHeading(bag, Config.Shops[currentStore].shopKeeperHeading)
                                                                            ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
                                                                            ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
                                                                            table.insert(objects, {bank = ped, object = bag})
                                                                            Citizen.CreateThread(function()
                                                                                while true do
                                                                                    Wait(5)
                                                                                    if DoesEntityExist(bag) then
                                                                                        if  #(globalPlayerCoords - GetEntityCoords(bag)) <= 1.5 then
                                                                                            PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                                                                                            DeleteObject(bag)
                                                                                            TriggerServerEvent("storeRobberies:server:registerMoney", GetPlayerServerId(globalPlayerId), currentStore, serverKeyGen)
                                                                                            break
                                                                                        end
                                                                                    else
                                                                                        break
                                                                                    end
                                                                                end
                                                                            end)
                                                                        else
                                                                            DeleteObject(bag)
                                                                        end
                                                                    end
                                                                    TriggerServerEvent("storeRobberies:server:animator", currentStore, 'mp_am_hold_up', "cower_intro")
                                                                    TriggerServerEvent("storeRobberies:server:registerOpen", currentStore)
                                                                    TriggerServerEvent("storeRobberies:server:shopkeeperBusy", currentStore, false)
                                                                    break
                                                                end

                                                            end
                                                        Citizen.Wait(7)
                                                    end
                                                    TriggerServerEvent("storeRobberies:server:shopkeeperBusy", currentStore, false)
                                                end
                                            elseif canRobType == 'cops' then
                                                if(fightBack == 1)then
                                                    fightBack_function(currentStore)
                                                else
                                                    local wait = GetGameTimer()+10000
                                                    while wait >= GetGameTimer() do
                                                        if  #(globalPlayerCoords - Config.Shops[v].shopKeeperCoords) <= 12.5 then
                                                            Wait(7)
                                                            DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Languages[Config.Language]['no_cops'])
                                                        else
                                                            Wait(7)
                                                            wait = GetGameTimer()
                                                        end
                                                    end
                                                    TriggerServerEvent("storeRobberies:server:shopkeeperBusy", currentStore, false)
                                                end
                                                ClearPedTasks(ped)
                                                SetFacialIdleAnimOverride(ped, "mood_normal_1")
                                            else
                                                if(fightBack == 1)then
                                                    fightBack_function(currentStore)
                                                else
                                                    local wait = GetGameTimer()+10000
                                                    while wait >= GetGameTimer() do
                                                        if  #(globalPlayerCoords - Config.Shops[v].shopKeeperCoords) <= 12.5 then
                                                            Wait(7)
                                                            DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Languages[Config.Language]['robbed'])
                                                        else
                                                            Wait(7)
                                                            wait = GetGameTimer()
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    Citizen.Wait(100)
                                end
                            else
                                Citizen.Wait(100)
                            end
                        else
                            Citizen.Wait(100)
                        end
                    end
                else
                    Citizen.Wait(100)
                end
            else
                Citizen.Wait(500)
            end
    end
end)

Citizen.CreateThread(function() --Register and safe.
    local x,y,z
    while true do
        inRange = false
        for v = 1, #Config.Shops do --Runs for all the shops.
            if (GetDistanceBetweenCoords(globalPlayerCoords, Config.Shops[v].registerCoords, true) <= 3 and (not Config.Shops[v].shopKeeperState) and not Config.Shops[v].registerBusy) then --Checks if he is close to the register, if the shopkeeper is dead, and if the register is not opened.
                x, y, z = table.unpack(Config.Shops[v].registerCoords) --Unpacks the register coords. I did it this method because calling the values themselves takes like 0.15 ms. Scary stuff lol.
                while (GetDistanceBetweenCoords(globalPlayerCoords, Config.Shops[v].registerCoords, true) <= 2 and not lockpicking and not Config.Shops[v].registerBusy) do --This loops runs while the distance between the player and the register is smaller than 2. Was done for optimization 
                    if(canRob)then
                        if(not Config.Shops[v].registerOpened)then
                            DrawText3D(x, y, z, Languages[Config.Language]['crackRegister']) --The draw 3d text for the register.
                            if IsControlJustPressed(1, Config.LockpickRegisterButton) then --If the control is pressed do the below code.

                                
                                if(Config.UseItems)then
                                    if(Config.Framework == "QBUS")then

                                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                            if result then
                                                if not copsCalled then
                                                    Citizen.Wait(200)
                                                    TriggerServerEvent("storeRobberies:server:callCops", currentStore)
                                                    copsCalled = true
                                                    Citizen.Wait(300)
                                                    Citizen.CreateThread(function()
                                                        Citizen.Wait(Config.PoliceCallSpamPrevention * 1000)
                                                        copsCalled = false
                                                    end)
                                                end
            
                                                TriggerServerEvent("storeRobberies:server:registerBusy", currentStore, true)
            
                                                LockpickAnim() --Does the lockpick animation.
                                                lockpick(true) --Callsthe js part of the lockpicking through this function.
                                            else
                                                QBCore.Functions.Notify("Shit i don't have a lockpick with me", "error")
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

                                            if not copsCalled then
                                                Citizen.Wait(200)
                                                TriggerServerEvent("storeRobberies:server:callCops", currentStore)
                                                copsCalled = true
                                                Citizen.Wait(300)
                                                Citizen.CreateThread(function()
                                                    Citizen.Wait(Config.PoliceCallSpamPrevention * 1000)
                                                    copsCalled = false
                                                end)
                                            end
        
                                            TriggerServerEvent("storeRobberies:server:registerBusy", currentStore, true)
        
                                            LockpickAnim() --Does the lockpick animation.
                                            lockpick(true) --Callsthe js part of the lockpicking through this function.

                                        else
                                            ESX.ShowNotification("Shit i don't have a lockpick with me")
                                        end
                                    end
                                else
                                    if not copsCalled then
                                        Citizen.Wait(200)
                                        TriggerServerEvent("storeRobberies:server:callCops", currentStore)
                                        copsCalled = true
                                        Citizen.Wait(300)
                                        Citizen.CreateThread(function()
                                            Citizen.Wait(Config.PoliceCallSpamPrevention * 1000)
                                            copsCalled = false
                                        end)
                                    end

                                    TriggerServerEvent("storeRobberies:server:registerBusy", currentStore, true)

                                    LockpickAnim() --Does the lockpick animation.
                                    lockpick(true) --Callsthe js part of the lockpicking through this function.
                                end
                            end
                        else
                            DrawText3D(x, y, z, Languages[Config.Language]['registerOpened']) --The draw 3d text for the safe.
                        end
                    elseif(canRobType == 'cops')then
                        DrawText3D(x, y, z, Languages[Config.Language]['no_cops']) --The draw 3d text for the safe.
                    end
                    Citizen.Wait(7) --A citizen.wait of 7 is the best for 3d text. No blinking and not as heavy as 0.
                end
                inRange = true --Sets the player that he is inrange of the register.
            elseif (GetDistanceBetweenCoords(globalPlayerCoords, Config.Shops[v].safeCoords, true) <= 3 and not Config.Shops[v].safeBusy) then --Checks if the player is close to the safe and the safe is not opened.
                x, y, z = table.unpack(Config.Shops[v].safeCoords) --Unpacks the safebox coords. I did it this method because calling the values themselves takes like 0.15 ms. Scary stuff lol.
                while (GetDistanceBetweenCoords(globalPlayerCoords, Config.Shops[v].safeCoords, true) <= 2 and not safeboxing and not Config.Shops[v].safeBusy) do --This loops runs while the distance between the player and the safebox is smaller than 2. Was done for optimization 
                    if(canRob)then    
                        if(not Config.Shops[v].safeBusy and not safeboxing)then
                            if(not Config.Shops[v].safeOpened)then
                                    DrawText3D(x, y, z, Languages[Config.Language]['crackSafe']) --The draw 3d text for the safe.
                                    
                                    if IsControlJustPressed(1, Config.SafeButton) then --If the control is pressed do the below code.

                                        Citizen.Wait(100,1200)
                                        if(not Config.Shops[v].safeBusy and not Config.Shops[v].safeOpened)then  
                                            if not copsCalled then
                                                Citizen.Wait(200)
                                                TriggerServerEvent("storeRobberies:server:callCops", currentStore)
                                                copsCalled = true
                                                Citizen.Wait(300)
                                                Citizen.CreateThread(function()
                                                    Citizen.Wait(Config.PoliceCallSpamPrevention * 1000)
                                                    copsCalled = false
                                                end)
                                            end

                                            TriggerServerEvent("storeRobberies:server:safeBusy", currentStore, true)

                                                safeboxing = true
                                                    if Config.Shops[v].safeType == "keypad" then
                                                        SendNUIMessage({
                                                            action = "openKeypad", 
                                                        })
                                                        SetNuiFocus(true, true) --Opens the keypad for the safebox. Sets the mouse active also.
                                                    else
                                                        TriggerEvent("store_safecracking:loop",5) --Starts the padlock minigame.
                                                    end

                                                    if(not(not Config.Shops[v].shopKeeperState or Config.Shops[v].registerOpened))then
                                                        fightBack_function(currentStore, true)
                                                    end
                                        end
                                    end
                            else
                                DrawText3D(x, y, z, Languages[Config.Language]['safeOpened']) --The draw 3d text for the safe.
                            end
                        end
                    elseif(canRobType == 'cops')then
                        DrawText3D(x, y, z, Languages[Config.Language]['no_cops']) --The draw 3d text for the safe.
                    end
                    Citizen.Wait(7) --A citizen.wait of 7 is the best for 3d text. No blinking and not as heavy as 0.
                end
                inRange = true --Sets the player that he is inrange of the safebox.
            end
        end

        if(lockpicking)then --We use this lockpicking value so we don't let peeps crack the register for a second time and get double the money.
            Citizen.Wait(500)
        end

        if(not inRange)then --We use this inRange value so we can optimize the script. If the player is not within range of any of the registers or safes it sleeps this loop for 1 second.
            Citizen.Wait(1000)
        else
            Citizen.Wait(100)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if(currentStore ~= nil and globalPlayerId ~= nil and currentStore ~= 0)then
            Citizen.Wait(10000)
            if #(globalPlayerCoords - Config.Shops[currentStore].shopKeeperCoords) <= 25.0 then
                TriggerServerEvent('storeRobberies:server:canRob',GetPlayerServerId(globalPlayerId), currentStore)
                Citizen.Wait(20000)
            end
        else
            Citizen.Wait(30000)
        end
    end
end)

Citizen.CreateThread(function()
    if(Config.UseBlips)then
        local StoreBlip = {}
        for v = 1, #Config.Shops do
            --SetBlipCoords(StoreBlip[v], Config.Shops[v].blip)

            StoreBlip[v] = AddBlipForCoord(Config.Shops[v].blip)

            SetBlipSprite(StoreBlip[v], 52)
            SetBlipScale(StoreBlip[v], 0.6)
            SetBlipColour(StoreBlip[v], 2)  

            SetBlipDisplay(StoreBlip[v], 4)
            SetBlipAsShortRange(StoreBlip[v], true)
        

            BeginTextCommandSetBlipName("STRING")
            --AddTextComponentSubstringPlayerName(Config.Shops[v].name)
            AddTextComponentSubstringPlayerName("Store")
            EndTextCommandSetBlipName(StoreBlip[v])
        end
    end
end)