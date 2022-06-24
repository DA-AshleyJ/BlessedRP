RegisterNetEvent('storeRobberies:client:shopkeeperUpdate')
AddEventHandler('storeRobberies:client:shopkeeperUpdate', function(shopkeepers)
        for v = 1, #Config.Shops do
            Config.Shops[v].shopKeeper = shopkeepers[v]
        end
end)

RegisterNetEvent('storeRobberies:client:shopkeeperUpdate')
AddEventHandler('storeRobberies:client:shopkeeperUpdate', function(key)
        for v = 1, #Config.Shops do
            Config.Shops[v].copsCalled = key[v]
        end
end)


RegisterNetEvent('storeRobberies:client:randomKeyGen')
AddEventHandler('storeRobberies:client:randomKeyGen', function(key)
    serverKeyGen = key
end)

RegisterNetEvent('storeRobberies:client:registerOpen')
AddEventHandler('storeRobberies:client:registerOpen', function(store, state)
    Config.Shops[store].registerOpened = state
end)

RegisterNetEvent('storeRobberies:client:safeOpen')
AddEventHandler('storeRobberies:client:safeOpen', function(store, state)
    Config.Shops[store].safeOpened = state
end)

RegisterNetEvent('storeRobberies:client:shopkeeperStateUpdate')
AddEventHandler('storeRobberies:client:shopkeeperStateUpdate', function(state, busy)
    for v = 1, #Config.Shops do
        Config.Shops[v].shopKeeperState = state[v]
        Config.Shops[v].shopKeeperBusy = busy[v]
    end
end)

RegisterNetEvent('storeRobberies:client:shopkeeperBusy')
AddEventHandler('storeRobberies:client:shopkeeperBusy', function(id, state)
    Config.Shops[id].shopkeeperBusy = state
end)

RegisterNetEvent('storeRobberies:client:registerOpenedUpdate')
AddEventHandler('storeRobberies:client:registerOpenedUpdate', function(opened, busy)
    for v = 1, #Config.Shops do
        Config.Shops[v].registerOpened = opened[v]
        Config.Shops[v].registerBusy = busy[v]
    end
end)

RegisterNetEvent('storeRobberies:client:safeOpenedUpdate')
AddEventHandler('storeRobberies:client:safeOpenedUpdate', function(opened, busy)
    for v = 1, #Config.Shops do
        Config.Shops[v].safeOpened = opened[v]
        Config.Shops[v].safeBusy = busy[v]
    end
end)

RegisterNetEvent('storeRobberies:client:safeCodeUpdate')
AddEventHandler('storeRobberies:client:safeCodeUpdate', function(safecodes)
    for v = 1, #Config.Shops do
        Config.Shops[v].safeCode = safecodes[v]
    end
end)

RegisterNetEvent('storeRobberies:client:shopkeeperReset')
AddEventHandler('storeRobberies:client:shopkeeperReset', function(shopkeepers)
    Citizen.Wait(1000)

    for i = 1, #Config.Shops do
        Config.Shops[i].shopKeeper = shopkeepers[i]
    end

    if DoesEntityExist(ped) then
        DeletePed(ped)
    end
end)

RegisterNetEvent('storeRobberies:client:resetStore')
AddEventHandler('storeRobberies:client:resetStore', function(i)
    if DoesEntityExist(ped) then
        DeletePed(ped)
    end
end)

RegisterNetEvent('storeRobberies:client:registerBusy')
AddEventHandler('storeRobberies:client:registerBusy', function(id, state)
    Config.Shops[id].registerBusy = state
end)

RegisterNetEvent('storeRobberies:client:safeBusy')
AddEventHandler('storeRobberies:client:safeBusy', function(id, state)
    Config.Shops[id].safeBusy = state
end)

RegisterNetEvent('usingRobberies:client:inCam')
AddEventHandler('usingRobberies:client:inCam', function(state, id)
    inCam = state
    cameraId = id
end)

RegisterNetEvent('storeRobberies:client:canRob')
AddEventHandler('storeRobberies:client:canRob', function(booleanVal, type)
    canRob = booleanVal
    canRobType = type
end)

RegisterNetEvent('storeRobberies:client:animator')
AddEventHandler('storeRobberies:client:animator', function(number, dict, anim, time)
    if(ped ~= nil)then
        if(DoesEntityExist(ped) and currentStore == number)then
            if(time ~= nil)then
                ClearPedTasks(ped)
                Citizen.Wait(300)
                loadDict(dict)
                local timer = GetGameTimer() + time * 1000
                while timer >= GetGameTimer() do
                    if(not IsEntityPlayingAnim(ped, dict, anim, 3))then
                        TaskPlayAnim(ped, dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
                        RemoveAnimDict(dict)
                    end
                    Wait(100)
                end
            else
                ClearPedTasks(ped)
                Citizen.Wait(300)
                loadDict(dict)
                TaskPlayAnim(ped, dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
                RemoveAnimDict(dict)
            end
        end
    end
end)

RegisterNetEvent('storeRobberies:client:fightBack')
AddEventHandler('storeRobberies:client:fightBack', function(store, safe, targeter)

    target = GetPlayerPed(GetPlayerFromServerId(targeter))

    if(store == currentStore and DoesEntityExist(ped)and DoesEntityExist(target))then
        pedTalk()
        Citizen.Wait(200)
        ClearPedTasks(ped)
        if(safe)then
            TaskCombatPed(ped, target, 0, 16)
            GiveWeaponToPed(ped, `WEAPON_BAT`, 150, 0, 1)
        else
            GiveWeaponToPed(ped, Config.Shopkeepers[Config.Shops[store].shopKeeper].Weapons[math.random(1, #Config.Shopkeepers[Config.Shops[store].shopKeeper].Weapons)], 150, 0, 1)
            TaskCombatPed(ped, target, 0, 16)
            TaskShootAtEntity(ped, target, 60000, 1)
            TaskShootAtEntity(ped, target, 60000, 1)
            TaskShootAtEntity(ped, target, 60000, 1)
        end

        while(not IsPedDeadOrDying(target) and not IsPedDeadOrDying(ped))do
            Citizen.Wait(200)
        end

        ClearPedTasks(ped)
    end
end)

RegisterNetEvent('storeRobberies:client:pedHandler')
AddEventHandler('storeRobberies:client:pedHandler', function()
    Citizen.CreateThread(function()
        while true do
                if not inCam then
                   v = currentStore
                else

                    for i=1, #Config.Shops do
                        for k, number in pairs(Config.Shops[i].camera) do
                            if(cameraId == number)then
                                v = i
                            end
                        end
                    end
                end
                if(#(globalPlayerCoords - Config.Shops[v].shopKeeperCoords) <= 20.0) or inCam then
                    if(not DoesEntityExist(ped))then
                        ped = _CreatePed(Config.Shopkeepers[Config.Shops[v].shopKeeper].model, Config.Shops[v].shopKeeperCoords, Config.Shops[v].shopKeeperHeading)
                        local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(ped), 5.0, GetHashKey('prop_till_01_dam'))
                        if DoesEntityExist(brokenCashRegister) then
                            CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
                        end

                        if(not Config.Shops[v].shopKeeperState)then
                            SetEntityHealth(ped, 0)
                        end
                    end
                else
                    if(DoesEntityExist(ped))then
                        DeletePed(ped)
                    end
                    Citizen.Wait(1000)
                end
            Citizen.Wait(500)
        end
    end)
end)

RegisterNetEvent('storeRobberies:client:onPedDeath')
AddEventHandler('storeRobberies:client:onPedDeath', function(v)
    if(currentStore == v)then
        if(DoesEntityExist(ped))then
            SetEntityHealth(ped, 0)
        end
    end
    Config.Shops[v].shopKeeperState = false
end)

RegisterNetEvent('storeRobberies:client:callCops')
AddEventHandler('storeRobberies:client:callCops', function(store)

        if(Config.Framework == "ESX")then --Only runs if you are using ESX.

            while ESX == nil do
                Citizen.Wait(100)
            end

            while ESX.PlayerData == nil do
                Citizen.Wait(100)
            end

            for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                if(ESX.PlayerData.job.name == jobname)then

                    if(Config.UsingSurveillanceSystem)then
                        local CCTV
                        CCTV = ""
                        for k, v in pairs(Config.Shops[store].camera) do
                            CCTV = CCTV .. "[" .. v .. "]"
                        end
                        

                        TriggerEvent('chatMessage', 'DISPATCH', 'your-code-here', 'Store Robbery in progress at ' .. Config.Shops[store].name ..  ' (CCTV: ' .. CCTV .. ')')
                    else
                        TriggerEvent('chatMessage', 'DISPATCH', 'your-code-here', 'Store Robbery in progress at ' .. Config.Shops[store].name ..  '.')
                    end

                    TriggerEvent("storeRobberies:client:alertBlip", store)

                end
            end
    
        elseif(Config.Framework == "QBUS")then --Only runs if you are using QBUS.
    
            while PlayerJob == nil do
                Citizen.Wait(100)
            end

            for k, jobname in pairs(Config.CopJobs) do --Runs for all the job names set in the config.
                if(PlayerJob.name == jobname)then
                    
                    if(Config.UsingSurveillanceSystem)then
                        local CCTV
                        CCTV = ""
                        for k, v in pairs(Config.Shops[store].camera) do
                            CCTV = CCTV .. "[" .. v .. "]"
                        end
                        

                        TriggerEvent('chatMessage', 'DISPATCH', 'your-code-here', 'Store Robbery in progress at ' .. Config.Shops[store].name ..  ' (CCTV: ' .. CCTV .. ')')
                    else
                        TriggerEvent('chatMessage', 'DISPATCH', 'your-code-here', 'Store Robbery in progress at ' .. Config.Shops[store].name ..  '.')
                    end

                    TriggerEvent("storeRobberies:client:alertBlip", store)

                end
            end
        elseif(Config.Framework == "VRP")then --Only runs if you are using VRP
            if(vRPCheck)then
                if(Config.UsingSurveillanceSystem)then
                    local CCTV
                    CCTV = ""
                    for k, v in pairs(Config.Shops[store].camera) do
                        CCTV = CCTV .. "[" .. v .. "]"
                    end
                    

                    TriggerEvent('chatMessage', 'DISPATCH', 'your-code-here', 'Store Robbery in progress at ' .. Config.Shops[store].name ..  ' (CCTV: ' .. CCTV .. ')')
                else
                    TriggerEvent('chatMessage', 'DISPATCH', 'your-code-here', 'Store Robbery in progress at ' .. Config.Shops[store].name ..  '.')
                end

                TriggerEvent("storeRobberies:client:alertBlip", store)

            end
        end 
end)

RegisterNetEvent('storeRobberies:client:alertBlip')
AddEventHandler('storeRobberies:client:alertBlip', function(store)
        local transG = Config.PoliceCallTimer * 2
        local blip = AddBlipForCoord(Config.Shops[store].blip)
        SetBlipSprite(blip, 487)
        SetBlipColour(blip, 43)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.2)
        SetBlipFlashes(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.Shops[store].name .. " - Robbery")
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(500)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
end)