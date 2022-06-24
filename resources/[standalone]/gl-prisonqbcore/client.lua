local QBCore = exports['qb-core']:GetCoreObject()

-- Ped Stuff
local pedSpawned = false
local prisonPed
-- Job Stuff
local curWorking = false
local jobTasks = 0
local curJob = nil
-- (Cooking)
local cooking = false
-- (Cleaning)

-- (Electrical)

-- (Empty Garbage)
local garbagebag
local searched = {} -- Table used to store barrel ID's in
local trashCan
-- (Prisoner)
local whatJob = nil
local hasFinger = false
local opp
local fightJob = false
local onCooldown = false
local curRunning = false
-- (BrainStorm!!!!!!!!!!!!)

-- (Prison Gangs)
local gangRep = 0
local gang = nil
local nearGang = 'None'

-- (Recreational Activities)
-- Baseball
local ball
local isPlaying = false
local hasBall = false
local ballObj
local ballID = 0
-- Basketball
local ballBasket
local isPlayingBasket = false
local hasBasketBall = false
local ballBasketObj
local ballBasketID = 0


-- (For Jailing People)
local isJailed = false
local time = 0

-- (For Drug Making)
local startTime = 0
local finishedTime = nil
local curMixing = false
local baking = false
local onDrug = false
local drugTime = 300000

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["injail"] > 0 then
            sendToJailLoaded(PlayerData.metadata["injail"])
        end
    end)
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	isJailed = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

-- Ped Spawning
Citizen.CreateThread(function()
    while true do
        sleep = 5000
        if isJailed then
            sleep = 5
            local pedCoords = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.NPCLocations) do

                local dst = #(pedCoords - v.coords)
                if dst < 20 and not pedSpawned then
                    TriggerEvent('gl-prison:spawnPed',v.coords,v.heading,v.event,v.label,v.model,v.scenario,v.icon,v.event2,v.label2,v.headVar,v.gang)
                    nearGang = v.gang
                    pedSpawned = true
                else
                    if DoesEntityExist(prisonPed) and pedSpawned then
                        local dst2 = #(pedCoords - GetEntityCoords(prisonPed))
                        if dst2 > 9 then
                            pedSpawned = false
                            DeleteEntity(prisonPed)
                            nearGang = 'None'
                        end
                    end
                end

            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('gl-prison:spawnPed',function(coords,heading,event,label,model,scenario,icon,event2,label2,headVar,gang)
    local hash = GetHashKey(model)
    
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
      Wait(10)
    end
    prisonPed = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(prisonPed, true)
    SetEntityInvincible(prisonPed, true)
    SetBlockingOfNonTemporaryEvents(prisonPed, true)
    if headVar ~= nil then
        SetPedComponentVariation(prisonPed,2,1,1,1)
        SetPedComponentVariation(prisonPed,0,headVar,headVar,headVar)
    end

    SetModelAsNoLongerNeeded(hash)

    if scenario ~= nil then
        TaskStartScenarioInPlace(prisonPed,scenario, 0, false)
    end
    if event2 ~= nil then
    exports['qb-target']:AddEntityZone('prisonPed', prisonPed, {
            name="prisonPed",
            debugPoly=false,
            useZ = true
              }, {
              options = {
                {
                event = event,
                icon = icon,
                label = label,
                },
                {
                event = 'gl-prison:turnInJob',
                icon = icon,
                label = "I've Finished!",
                },
                {
                event = event2,
                icon = icon,
                label = label2,
                },     
                {
                event = 'gl-prison:joinPrisonGang',
                icon = icon,
                label = 'Join ' .. gang,
                },                                
              },
                --job = {"all"},
                distance = 1.5
              })
    else
    exports['qb-target']:AddEntityZone('prisonPed', prisonPed, {
            name="prisonPed",
            debugPoly=false,
            useZ = true
              }, {
              options = {
                {
                event = event,
                icon = icon,
                label = label,
                },
                {
                event = 'gl-prison:turnInJob',
                icon = icon,
                label = "I've Finished!",
                },
                
              },
                --job = {"all"},
                distance = 1.5
              })        
    end





end)

RegisterNetEvent('gl-prison:beginCook',function()
    if not curWorking then
        curWorking = true
        beginWork('Cook')
    else
        curWorking = false
    end
end)




-- Main Box Thread
CreateThread(function()

    exports['qb-target']:AddBoxZone("PoliceAlarm", vector3(1771.74, 2491.82, 49.67), 1, 5, {
        name="PoliceAlarm",
        heading=120,
        debugPoly=false,
        minZ=48,
        maxZ=50
    }, {
        options = {
            {
                event = "gl-prison:triggerAlarm",
                icon = 'fas fa-hand-paper',
                label = 'Trigger Alarm',
            },
        },
            job = "police",
            distance = 1.5 
    })


    exports['qb-target']:AddBoxZone("PrisonFridge", vector3(1784.62, 2564.86, 45.67), 1, 2, {
        name="PrisonFridge",
        heading=0,
        debugPoly=false,
        minZ=Z,
        maxZ=Z
    }, {
        options = {
            {
                event = "gl-prison:grabIngredients",
                icon = 'fas fa-hand-paper',
                label = 'Take Ingredients',
            },
        },
            --job = {"all"},
            distance = 1.5 
    })

    exports['qb-target']:AddBoxZone("PrisonGrill", vector3(1780.85, 2565.03, 45.67), 1, 1.5, {
        name="PrisonGrill",
        heading=0,
        debugPoly=false,
        minZ=Z,
        maxZ=Z
    }, {
        options = {
            {
                event = "gl-prison:cookFood",
                icon = 'fas fa-hand-paper',
                label = 'Cook',
            },
        },
            --job = {"all"},
            distance = 1.5 
    })

    exports['qb-target']:AddBoxZone("PrisonFood", vector3(1780.88, 2559.95, 45.67), 1, 3.8, {
        name="PrisonFood",
        heading=0,
        debugPoly=false,
        minZ=Z,
        maxZ=Z
    }, {
        options = {
            {
                event = "gl-prison:getFood",
                icon = 'fas fa-hand-paper',
                label = 'Grab some Food',
            },
        },
            --job = {"all"},
            distance = 1.5 
    })

    exports['qb-target']:AddBoxZone("PrisonDrinks", vector3(1777.72, 2560.23, 45.67), 1, 2, {
        name="PrisonDrinks",
        heading=0,
        debugPoly=false,
        minZ=Z,
        maxZ=Z
    }, {
        options = {
            {
                event = "gl-prison:getDrink",
                icon = 'fas fa-hand-paper',
                label = 'Grab a Drink',
            },
        },
            --job = {"all"},
            distance = 1.5 
    })

    local poopTable = {`prop_big_shit_02`}

    exports['qb-target']:AddTargetModel(poopTable, {
        options = {
            {
                event = "gl-prison:pickUpPoop",
                icon = 'fas fa-hand-paper',
                label = 'Grab The Shit',
            },

        },
        --job = {"all"},
        distance = 1.5
    })


    exports['qb-target']:AddBoxZone("DrugToilet", vector3(1767.8, 2502.87, 48.69), 0.5, 0.5, {
        name="DrugToilet",
        heading=30,
        debugPoly=false,
        minZ=48,
        maxZ=49
    }, {
        options = {
            {
                event = "gl-prison:mixDrugs",
                icon = 'fas fa-hand-paper',
                label = 'Do some Mixin',
            },
        },
            --job = {"all"},
            distance = 1.5 
    })

    exports['qb-target']:AddBoxZone("DrugOven", vector3(1782.71, 2564.89, 45.67), 1, 1.8, {
        name="DrugOven",
        heading=30,
        debugPoly=false,
        minZ=45,
        maxZ=46
    }, {
        options = {
            {
                event = "gl-prison:bakeDrug",
                icon = 'fas fa-hand-paper',
                label = 'Place',
            },
            {
                event = "gl-prison:removeFinishedDrug",
                icon = 'fas fa-hand-paper',
                label = 'Remove',
            },            
        },
            --job = {"all"},
            distance = 1.5 
    })

    exports['qb-target']:AddBoxZone("PrisonStorage", vector3(1784.25, 2560.56, 45.67), 0.5, 0.5, {
        name="PrisonStorage",
        heading=0,
        debugPoly=false,
        minZ=45,
        maxZ=46
    }, {
        options = {
            {
                event = Config.StashEvent,
                icon = 'fas fa-hand-paper',
                label = 'Open',
            },    
        },
            --job = {"all"},
            distance = 1.5 
    })

    exports['qb-target']:AddBoxZone("prisonleave", vector3(1828.77, 2579.64, 45.91), 0.5, 0.3, {
        name="prisonleave",
        heading=90,
        debugPoly=false,
        minZ=46.01,
        maxZ=47.01
      }, {
        options = {
            {
                event = 'prison:client:Leave',
                icon = 'fas fa-sign-out-alt',
                label = 'Leave Prison',
            },    
        },
            --job = {"all"},
            distance = 1.5 
    })

end)

RegisterNetEvent('gl-prison:openStash',function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "TrashCan", {
        maxweight = 500000,
        slots = 10,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "TrashCan")
end)

RegisterNetEvent('gl-prison:mixDrugs',function()
    if not curMixing then
        TriggerServerEvent('gl-prison:checkDrugIngredients')
    end
end)

RegisterNetEvent('gl-prison:doTheMixing',function()
    local ped = PlayerPedId()
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 1, 0, false, false, false )
    Wait(30000)
    ClearPedTasks(ped)
end)

RegisterNetEvent('gl-prison:doTheBaking',function()
    baking = true
    QBCore.Functions.Notify("You've set a Timer for 2 Hours", 'primary', 10000) 
    startTime = GetGameTimer()
    local mathStuff = (Config.DryTime * 60000) * 60
    finishedTime = startTime + mathStuff
end)


RegisterNetEvent('gl-prison:bakeDrug',function()
    if not baking then
        TriggerServerEvent('gl-prison:bakeDrugs')
    end
end)

RegisterNetEvent('gl-prison:removeFinishedDrug',function()
    if baking then
        local curTime = GetGameTimer()
        local timeLeft = finishedTime - curTime
        local timeInMinutes = timeLeft / 60000
        QBCore.Functions.Notify("Looks like " .. round(timeInMinutes, 0) .. " minutes left", 'primary', 10000)  
        if curTime >= finishedTime then
            curMixing = false
            baking = false
            TriggerServerEvent('gl-prison:drugReady')
            startTime = 0
            finishedTime = nil
        end
    end
end)

-- Kitchen Events --

RegisterNetEvent('gl-prison:grabIngredients',function()
    if curJob == 'Cook' or curJob == 'Prisoner' then
        TriggerServerEvent('gl-prison:checkIngredients')
    else
        QBCore.Functions.Notify("Get Out of my Kitchen if you ain't working", 'primary', 10000)  
    end
end)

RegisterNetEvent('gl-prison:getFood',function()
    local foodItems = {}
    for k, v in pairs(Config.FoodStuffs) do
        foodItems[#foodItems + 1] = {
            id = k,
            header = 'Grab a ',
            txt = v.label,
            params = {
                event = 'gl-prison:takeItem',
                arg1 = {
                    item = v.databasename,

                }                
            }
        }
    end
    exports['qb-menu']:openMenu(foodItems)
end)

RegisterNetEvent('gl-prison:openCommissary',function()
    local comItems = {}
    for k, v in pairs(Config.Commissary) do
        comItems[#comItems+1] = {
            header = 'Only ' .. v.cost .. ' for a',
            txt = v.label,
            params = {
                event = 'gl-prison:takeItemComm',
                arg1 = {
                    item = v.databasename,
                    cost = v.cost,
                    curr = v.currency
                }                
            }
        }
end
    exports['qb-menu']:openMenu(comItems)
end)

RegisterNetEvent('gl-prison:takeItemComm',function(data)
local item = data.item
local cost = data.cost
local curr = data.curr
TriggerServerEvent('gl-prison:buyFromCom',item,cost,curr)
end)

RegisterNetEvent('gl-prison:takeItem',function(data)
    item = data.item
    TriggerServerEvent('gl-prison:tryTakeItem',item)
end)

RegisterNetEvent('gl-prison:getDrink',function()
    local drinkItems = {}
    for k, v in pairs(Config.DrinkStuffs) do
        drinkItems[#drinkItems+1] = {
            header = 'Grab a ',
            txt = v.label,
            params = {
                event = 'gl-prison:takeItem',
                arg1 = {
                    item = v.databasename,

                }                
            }
        }
end
    exports['qb-menu']:openMenu(drinkItems)
end)


RegisterNetEvent('gl-prison:cookFood',function()
    if curJob == "Cook" then
        local cookWhat = {}
        for k, v in pairs(Config.CookingStuff) do
            cookWhat[#cookWhat+1] = {
                header = 'Cook A Meal',
                txt = v.Label,
                params = {
                    event = 'gl-prison:checkCanCook',
                    arg1 = {
                        item = v.Product,
                        ingredientCost = v.IngredientCost,
                        time = v.Time
                    }                
                }
            }
    end
        exports['qb-menu']:openMenu(cookWhat)
    end
end)

RegisterNetEvent('gl-prison:checkCanCook',function(data)
    if cooking then
        QBCore.Functions.Notify('Wait awhile before cooking again.', 'primary', 10000) 
    else
        cooking = true
        item = data.item
        time = data.time
        cost = data.ingredientCost
        TriggerServerEvent('gl-prison:checkCanCook',item,time,cost)
        Wait(time)
        cooking = false
    end
end)

RegisterNetEvent('gl-prison:beginCookFood',function(time,cost)
    TaskStartScenarioInPlace(PlayerPedId(),'PROP_HUMAN_BBQ', 0, false)
    Wait(time)
    jobTasks = jobTasks + cost
    ClearPedTasks(PlayerPedId())
end)


-- Cleaning Events --

RegisterNetEvent('gl-prison:beginClean',function()
    if not curWorking then
        curWorking = true
        beginWork('Clean')
    else
        curWorking = false
    end
end)

RegisterNetEvent('gl-prison:spawnDaPoop',function()
    local radius = 5.0
    local poopLimit = 0
        while poopLimit < 11 do
            poopLimit = poopLimit + 1
        local x = 1766.03 + math.random(-radius,radius)
        local y = 2595.12 + math.random(-radius,radius)
            poop = CreateObject('prop_big_shit_02',x,y,45.73, -1,0,0,0)
            PlaceObjectOnGroundProperly(poop)
            FreezeEntityPosition(poop, true)
            Wait(100)
        end
end)


RegisterNetEvent('gl-prison:pickUpPoop',function()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local objectId = GetClosestObjectOfType(pedCoords, 2.0, GetHashKey("prop_big_shit_02"), false)
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
    Wait(24000)
    ClearPedTasks(PlayerPedId())
    jobTasks = jobTasks + 2
    DeleteEntity(objectId)

    local ranChance = math.random(1,100)
    if ranChance <= Config.SteroidChance then
        TriggerServerEvent('gl-prison:tryTakeItem','steroid')
    end
end)


-- Eletrical Stuff --


RegisterNetEvent('gl-prison:beginElectrical',function()
    if not curWorking then
        curWorking = true
        beginWork('Electrical')
    else
        curWorking = false
    end
end)

RegisterNetEvent('gl-prison:electricalBoxes',function()
    for k, v in pairs (Config.ElectricalBoxes) do
        exports['qb-target']:AddBoxZone(k, v.coords, 1, 2, {
            name=k,
            heading=v.heading,
            debugPoly=false,
            minZ=v.coords.z,
            maxZ=v.coords.z+1
        }, {
            options = {
                {
                    event = "gl-prison:useElectricalBox",
                    icon = v.icon,
                    label = 'Fix',
                },
            },
                --job = {"all"},
                distance = 1.5 
        })
    
    end
end)

RegisterNetEvent('gl-prison:useElectricalBox',function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    for k, v in pairs (Config.ElectricalBoxes) do
        local dst = #(pedCoords - v.coords)
        if dst < 2 then
            exports['qb-target']:RemoveZone(k)
            TaskStartScenarioInPlace(ped,'WORLD_HUMAN_WELDING', 0, false)
            Wait(24000)
            ClearPedTasks(ped)
            jobTasks = jobTasks + 2
            local ranChance = math.random(1,100)
            if ranChance <= Config.TinfoilChance then
                TriggerServerEvent('gl-prison:tryTakeItem','tinfoil')
            end
        end
    end
end)

-- Empty Garbage -- 

RegisterNetEvent('gl-prison:beginTrash',function()
    if not curWorking then
        curWorking = true
        beginWork('Trash')
    else
        curWorking = false
    end
end)

RegisterNetEvent('gl-prison:barrelTask',function()
    local trashBarrel = {
    `prop_barrel_03d`,
    }
    exports['qb-target']:AddTargetModel(trashBarrel,  {
            options = {
                {
                event = "gl-prison:emptyBarrel",
                icon = "fas fa-hand-paper",
                label = "Empty",
                },
            },
            --job = {"all"},
            distance = 2.5
    })

    local hash = GetHashKey('prop_bin_08open')
    
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    trashCan = CreateObject(hash,1718.88,2567.78,45.73, -1,0,0,0)
    PlaceObjectOnGroundProperly(trashCan)
    SetModelAsNoLongerNeeded(hash)
    FreezeEntityPosition(trashCan,true)

    exports['qb-target']:AddEntityZone('trashCan', trashCan, {
            name="trashCan",
            debugPoly=false,
            useZ = true
              }, {
              options = {
                {
                event = "gl-prison:turnInTrash",
                icon = 'fas fa-trash',
                label = 'Dump Trash',
                },
              },
                --job = {"all"},
                distance = 1.5
              })
end)

RegisterNetEvent('gl-prison:turnInTrash',function()
    if DoesEntityExist(garbagebag) then
        DetachEntity(garbagebag)
        DeleteEntity(garbagebag)
        jobTasks = jobTasks + 5
    end
end)


RegisterNetEvent('gl-prison:emptyBarrel',function()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local objectId = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey("prop_barrel_03d"), false)    
    local alreadySearched = tableHasKey(searched,objectId)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    if alreadySearched then
        QBCore.Functions.Notify('Nothing in this barrel', 'primary', 10000)
    else
        if DoesEntityExist(garbagebag) then
            QBCore.Functions.Notify('You cannot carry anymore bags', 'primary', 10000)
        else
            jobTasks = jobTasks + 5
            addToSet(searched,objectId)
            garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true) -- creates object
            AttachEntityToEntity(garbagebag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
            local doMath = math.random(1,100)
            if doMath < Config.RandomTrashChance then
                local item = Config.RandomTrashReward[math.random(#Config.RandomTrashReward)] 
                TriggerServerEvent('gl-prison:tryTakeItem',item)
            end
        end
    end
end)

-- Clean Toilets --

RegisterNetEvent('gl-prison:beginToilet',function()
    if not curWorking then
        curWorking = true
        beginWork('Toilet')
    else
        curWorking = false
    end
end)


RegisterNetEvent('gl-prison:toiletBoxes',function()
    for k, v in pairs (Config.Toilets) do
        exports['qb-target']:AddBoxZone(k, v.coords, .5, .5, {
            name=k,
            heading=v.heading,
            debugPoly=false,
            minZ=v.coords.z,
            maxZ=v.coords.z+1
        }, {
            options = {
                {
                    event = "gl-prison:useToilet",
                    icon = v.icon,
                    label = 'Clean',
                },
            },
                --job = {"all"},
                distance = 1.5 
        })
    
    end
end)

RegisterNetEvent('gl-prison:useToilet',function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    for k, v in pairs (Config.Toilets) do
        local dst = #(pedCoords - v.coords)
        if dst < 2 then
            exports['qb-target']:RemoveZone(k)
            LoadAnimDict('amb@medic@standing@kneel@base')
            LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
            TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
            TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
            Wait(24000)
            ClearPedTasks(ped)
            jobTasks = jobTasks + 2
        end
    end
end)

-- Prisoner Tasks

RegisterNetEvent('gl-prison:prisonerTasks',function()
    if gang == nil then
        getGangRep()
    end

    if not curWorking and gang == nearGang then
        if not onCooldown then
            curWorking = true
            beginWork('Prisoner')
            doCooldown()
        else
            QBCore.Functions.Notify('Come back later I will have more for you to do.', 'primary', 10000)
        end
    else
        QBCore.Functions.Notify('Tryna get shanked? I only put out work for the homies.', 'primary', 10000)
        curWorking = false
    end

end)
RegisterNetEvent('gl-prison:prisonJobInteract',function()
    TriggerServerEvent('gl-prison:prisonerJob',whatJob.ingredient,whatJob.amount)
end)

RegisterNetEvent('gl-prison:prisonJobDoThing',function()
    if curWorking then
        local ped = PlayerPedId()
        exports['qb-target']:RemoveZone(whatJob)
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
        Wait(24000)
        ClearPedTasks(ped)
        TriggerServerEvent('gl-prison:tryTakeItem',whatJob.requirement)
        jobTasks = 20
        curWorking = false
    end
end)

-- Doctor Stuff

RegisterNetEvent('gl-prison:useDoctor',function()
    QBCore.Functions.Notify('You have been moved to a bed for Treatment.', 'primary', 10000)
    SetEntityCoords(PlayerPedId(), 1761.87,2591.6,46.66)
    LoadAnimDict('anim@gangops@morgue@table@')
    TaskPlayAnim(PlayerPedId(), 'anim@gangops@morgue@table@' , 'body_search' ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), 266.96)
    ---[[ -- Set these to whatever revive/wound system you use
    Wait(20000)
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerServerEvent('esx_ambulancejob:bedRevive')
    SetEntityHealth(PlayerPedId(),200)
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify('You are good now, stop getting in trouble.', 'primary', 10000)
    --]]
end)


RegisterNetEvent('gl-prison:triggerAlarm',function()
    TriggerServerEvent('gl-prison:alarmSounded')
end)

RegisterNetEvent('gl-prison:breakOutAlarm',function()
    QBCore.Functions.Notify('A Prison Break is being attempted! Do not pick up Hitchhikers!', 'primary', 10000)
    playAlarm()
end)

local playSiren = false
function playAlarm()
    local sirenTime = 6
    playSiren = true
    CreateThread(function()
        while playSiren do
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local dst = #(pedCoords - vector3(1818.94,2594.02,45.72))
            Wait(10000)
            if dst < 300 then
                TriggerEvent('InteractSound_CL:PlayOnOne', 'prisonalarm', 0.3)
                
                sirenTime = sirenTime - 1
            end
            if sirenTime <= 0 then
                break
            end
        end
    end)
end


-- Turn in Job (For All)
RegisterNetEvent('gl-prison:turnInJob',function()
    if curJob ~= nil then

        if curJob == 'Prisoner' then
            if jobTasks == 20 then
                if fightJob then
                    curJob = nil
                    curWorking = false
                    TriggerServerEvent('gl-prison:checkPrisonerJob',nil,whatJob.minAmount,whatJob.maxAmount,gangRep)
                else
                TriggerServerEvent('gl-prison:checkPrisonerJob',whatJob.requirement,whatJob.minAmount,whatJob.maxAmount,gangRep)
                curJob = nil
                curWorking = false
                end
            elseif fightJob and jobTasks == 0 then
                curWorking = false
            end
        elseif curJob == 'Trash' and jobTasks >= 20 then
            if DoesEntityExist(trashCan) then 
                DeleteEntity(trashCan) 
            end
            if DoesEntityExist(garbagebag) then 
                DetachEntity(garbagebag)
                DeleteEntity(garbagebag) 
            end
            TriggerServerEvent('gl-prison:turnInJob',curJob) -- Add reward here
        elseif jobTasks >= 20 then
            TriggerServerEvent('gl-prison:turnInJob',curJob) -- Add reward here
            QBCore.Functions.Notify("Yeah I knew you could do it didn't doubt you for a minute.", 'primary', 10000)
            curJob = nil
            curWorking = false
        elseif curJob ~= nil then
            QBCore.Functions.Notify('Not done with current Job ' .. jobTasks .. '/20', 'primary', 10000)
        end
    end
end)

-- Prison Gang Stuff

RegisterNetEvent('gl-prison:updateGangRep',function(updateRep)
    gangRep = gangRep + updateRep
    TriggerServerEvent('gl-prison:updatePrisonRep',gangRep)
end)

RegisterNetEvent('gl-prison:joinPrisonGang',function()
    getGangRep()
    if gang == nil then
        TriggerServerEvent('gl-prison:joinPrisonGang',nearGang)
        QBCore.Functions.Notify("Yo playa welcome to the " .. nearGang, 'primary', 10000)
    else
        QBCore.Functions.Notify("You're already in a gang fool", 'primary', 10000)
    end
end)

RegisterNetEvent('gl-prison:openGangShop',function()

    if gang == nil then
        getGangRep()
        if nearGang == gang then
            local gangShop = {}
            for k, v in pairs(Config.GangShops[gang]) do
                gangShop[#gangShop+1] = {
                    header = 'Trade ' .. v.Cost .. ' ' .. v.Currency .. ' for ',
                    txt = v.Label,
                    params = {
                        event = 'gl-prison:tradeForItem',
                        arg1 = {
                            item = v.Item,
                            rep = v.Minrep,
                            cost = v.Cost
                        }                
                    }
                }
            end
            exports['qb-menu']:openMenu(gangShop)
        end
    elseif nearGang == gang then
        local gangShop = {}
        for k, v in pairs(Config.GangShops[gang]) do
            gangShop[#gangShop+1] = {
                header = 'Trade ' .. v.Cost .. ' ' .. v.Currency .. ' for ',
                txt = v.Label,
                params = {
                        event = 'gl-prison:tradeForItem',
                        arg1 = {
                            item = v.Item,
                            rep = v.Minrep,
                            cost = v.Cost
                        }                  
                }
            }
        end
        exports['qb-menu']:openMenu(gangShop)
    end
end)

RegisterNetEvent('gl-prison:tradeForItem',function(data)
    local item = data.item
    local rep = data.rep
    local cost = data.cost
    if gangRep >= rep then
        TriggerServerEvent('gl-prison:checkTrade',item,cost)
    else
        QBCore.Functions.Notify("We ain't that cool man", 'primary', 10000)
    end
end)

RegisterNetEvent('gl-prison:spawnOpp',function(model,coords,whatDo)
    fightJob = true
    local hash = GetHashKey(model)
    
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
      Wait(10)
    end
    opp = CreatePed(5, hash, coords, heading, true, false)
    SetModelAsNoLongerNeeded(hash)
    TaskWanderStandard(opp,10.0,10)

oppSpawned(whatDo)
end)

function oppSpawned(whatDo)
    CreateThread(function()
        while true do
            Wait(5000)
            if not curWorking then
                break
            end
            if DoesEntityExist(opp) then
                local oppHP = GetEntityHealth(opp)
                if whatDo == 'kill' then
                    if oppHP <= 100 then
                        jobTasks = 20
                        finishedJob = true    
                        break
                    end
                elseif whatDo == 'wound' then
                    if oppHP > 140 and oppHP < 200 then
                        ClearPedTasks(opp)
                        TaskReactAndFleePed(prisonPed,PlayerPedId())
                        finishedJob = true
                        jobTasks = 20
                        break
                    end
                end
            else
                break
            end
        end
    end)

end

RegisterNetEvent('gl-prison:checkItemBed',function()
    searchChance = 15
    for k,v in pairs(Config.BedLocations) do
        exports['qb-target']:AddBoxZone(k, v.coords, 2, 1, {
            name=k,
            heading=v.heading,
            debugPoly=false,
            minZ=v.coords.z,
            maxZ=v.coords.z+1
        }, {
            options = {
                {
                    event = "gl-prison:searchBed",
                    icon = v.icon,
                    label = 'Search',
                },
            },
                --job = {"all"},
                distance = 1.5 
        })
    end
end)

RegisterNetEvent('gl-prison:searchBed',function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
    Wait(30000)
    ClearPedTasksImmediately(ped)
    if jobTasks == 0 then
        local doMath = math.random(1,100)
        if doMath <= searchChance then
            TriggerServerEvent('gl-prison:foundBedItem',whatJob.requirement,whatJob.amount)
            jobTasks = 20
        else
            searchChance = searchChance + 15
            QBCore.Functions.Notify("Nothing here.", 'primary', 10000)
        end

        for k, v in pairs (Config.BedLocations) do
            local dst = #(pedCoords - v.coords)
            if dst < 2 then
                exports['qb-target']:RemoveZone(k)
            end
        end
    end
end)


--EntityZone

--[[
exports['qb-target']:AddEntityZone('NAMEHERE', PEDHERE, {
            name="NAMEHERE",
            debugPoly=false,
            useZ = true
              }, {
              options = {
                {
                event = "EVENTHERE",
                icon = v.icon,
                label = 'LABELHERE',
                },
              },
                --job = {"all"},
                distance = 1.5
              })
]]

--Boxzone
--[[
    exports['qb-target']:AddBoxZone("ZONENAME", vector3(COORDSHERE), 1, 1, {
        name="ZONENAME",
        heading=0,
        debugPoly=false,
        minZ=Z,
        maxZ=Z
    }, {
        options = {
            {
                event = "EVENTHERE",
                icon = v.icon,
                label = 'LABELHERE',
            },
        },
            --job = {"all"},
            distance = 1.5 
    })
]]

--TargetModel
--[[
    exports['qb-target']:AddTargetModel(TABLEHERE, {
        options = {
            {
                event = "EVENTHERE",
                icon = v.icon,
                label = 'LABELHERE',
            },

        },
        --job = {"all"},
        distance = 1.5
    })
]]


function beginWork(job)
    curJob = job
    jobTasks = 0
    if curJob == 'Cook' then
        QBCore.Functions.Notify('Grab some Ingredients from the Fridge and cook up some meals for me, the worse the better!', 'primary', 10000)
    end
    
    if curJob == 'Clean' then
        QBCore.Functions.Notify('Head into the Infirmary and clean up the mess.', 'primary', 10000)
        TriggerEvent('gl-prison:spawnDaPoop')
    end
    
    if curJob == 'Electrical' then
        QBCore.Functions.Notify('Help me out by fixing up the other boxes around the Prison, should be 10.', 'primary', 10000) 
        TriggerEvent('gl-prison:electricalBoxes')
    end

    if curJob == 'Trash' then
        QBCore.Functions.Notify('Collect the trash out of the barrels in the yard and bring them to me.', 'primary', 10000) 
        TriggerEvent('gl-prison:barrelTask')
    end

    if curJob == 'Toilet' then
        QBCore.Functions.Notify('Clean some of the bottom floor toilets for me would ya pal.', 'primary', 10000) 
        TriggerEvent('gl-prison:toiletBoxes')
    end

    if curJob == 'Prisoner' then
        if gangRep == 0 then
            getGangRep()
        end
        whatJob = Config.IllegalStuff[math.random(#Config.IllegalStuff)]
        gangRep = gangRep - Config.RepCostForTask
        QBCore.Functions.Notify(whatJob.message, 'primary', 10000)
        if whatJob.additionalEvent ~= nil then
            TriggerEvent(whatJob.additionalEvent,whatJob.oppModel,whatJob.spawnCoords,whatJob.killorwound)
        else
            exports['qb-target']:AddBoxZone('PrisonerInteractTask', vector3(whatJob.coords), whatJob.boxW, whatJob.boxL, {
                name='PrisonerInteractTask',
                heading=whatJob.heading,
                debugPoly=false,
                minZ=whatJob.coords.z,
                maxZ=whatJob.coords.z+1
            }, {
                options = {
                    {
                        event = "gl-prison:prisonJobInteract",
                        icon = whatJob.icon,
                        label = 'Interact',
                    },
                },
                    --job = {"all"},
                    distance = 1.5 
            })
        end
    end   
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

-- Called to add the Barrels ID to a table
function addToSet(set, key)
    set[key] = true
end

-- Called to check if the Barrels exists in the set table
function tableHasKey(table,key)
    return table[key] ~= nil
end

function getGangRep()
    QBCore.Functions.TriggerCallback("gl-prison:getGangAffil", function(cb)
        gangInfo = table.unpack(cb)
        if gangInfo ~= nil then
            gang = gangInfo.gang
            gangRep = gangInfo.reputation
        end
    end)
    Wait(1000)
end

function doCooldown()
    if not curRunning then
        curRunning = true
        onCooldown = true
        local cdTimer = Config.IllegalCooldown
        CreateThread(function()
            while onCooldown do
                Wait(10000)
                cdTimer = cdTimer - 10000
                if cdTimer <= 0 then
                    onCooldown = false
                    curRunning = false
                end
            end
        end)
    end
end

-- Recreational Stuff

RegisterCommand('throw',function()
TriggerEvent('gl-prison:throwBall')
end)

RegisterCommand('join',function()
    isPlaying = true
    QBCore.Functions.Notify('You joined the game', 'primary', 10000)
    getBall()
end)
RegisterCommand('leave',function()
    isPlaying = false
    hasBall = false
    QBCore.Functions.Notify('You quit playing.', 'primary', 10000)
end)


RegisterNetEvent('gl-prison:throwBall',function()
        hasBall = false
        local hash = 'prop_tennis_ball'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(0) end
        ballObj = CreateObjectNoOffset(hash, x, y, z, true, false)
        ballID = NetworkGetNetworkIdFromEntity(ballObj)
        SetModelAsNoLongerNeeded(hash)
        AttachEntityToEntity(ballObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
        local forwardVector = GetEntityForwardVector(PlayerPedId())
        local force = 50.0
        local animDict = "melee@unarmed@streamed_variations"
        local anim = "plyr_takedown_front_slap"
        ClearPedTasks(PlayerPedId())
        while (not HasAnimDictLoaded(animDict)) do
            RequestAnimDict(animDict)
            Citizen.Wait(5)
        end
        TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        Wait(500)
        DetachEntity(ballObj)
        ApplyForceToEntity(ballObj,1,forwardVector.x*force,forwardVector.y*force + 5.0,forwardVector.z,0,0,0,0,false,true,true,false,true)
        TriggerServerEvent('gl-prison:syncBall', ballID)
        isPlaying = true
        getBall()


end)

function getBall()
    CreateThread(function()
        while isPlaying do
            Wait(0)
            if hasBall then
                if IsControlJustReleased(0,38) then
                    hasBall = false
                    local hash = 'prop_tennis_ball'
                    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do Citizen.Wait(0) end
                    ballObj = CreateObjectNoOffset(hash, x, y, z, true, false)
                    ballID = NetworkGetNetworkIdFromEntity(ballObj)
                    SetModelAsNoLongerNeeded(hash)
                    AttachEntityToEntity(ballObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
                    local forwardVector = GetEntityForwardVector(PlayerPedId())
                    local force = 50.0
                    local animDict = "melee@unarmed@streamed_variations"
                    local anim = "plyr_takedown_front_slap"
                    ClearPedTasks(PlayerPedId())
                    while (not HasAnimDictLoaded(animDict)) do
                        RequestAnimDict(animDict)
                        Citizen.Wait(5)
                    end
                    TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
                    Wait(500)
                    DetachEntity(ballObj)
                    ApplyForceToEntity(ballObj,1,forwardVector.x*force,forwardVector.y*force + 5.0,forwardVector.z,0,0,0,0,false,true,true,false,true)
                    TriggerServerEvent('gl-prison:syncBall', ballID)
                    isPlaying = true
                    --getBall()
                end
            else
                local ballCoords = GetEntityCoords(ball)
                DrawMarker(20, ballCoords.x, ballCoords.y, ballCoords.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 228, 71, 12, 80, 1, 1, 0, 1)
                    local dst = #(GetEntityCoords(ball) - GetEntityCoords(PlayerPedId()))
                    if dst < 1 then
                        hasBall = true
                        QBCore.Functions.Notify('You have the ball! Throw it with E', 'primary', 10000)
                        TriggerServerEvent('gl-prison:sendDeleteBall',ballID)
                    end
            end
        end
    end)
end

RegisterNetEvent('gl-prison:syncBall',function(ballID)
    ball = NetworkGetEntityFromNetworkId(ballID)
    hasBall = false
end)

RegisterNetEvent('gl-prison:deleteBall',function()
    DeleteEntity(ball)
end)

RegisterNetEvent('gl-prison:teachRec',function()
    QBCore.Functions.Notify('/throw to throw the ball against the wall', 'primary', 10000)
    Wait(10000)
    QBCore.Functions.Notify('/join to join any game in progress', 'primary', 10000)
    Wait(10000)
    QBCore.Functions.Notify('/leave to leave the game', 'primary', 10000)
    Wait(10000)
    QBCore.Functions.Notify('Goal is to throw the ball at the wall, then catch it before it goes out. E to throw a caught ball.', 'primary', 10000)
end)

-- 

-- Basketball Stuff
RegisterCommand('basketball',function()
TriggerEvent('gl-prison:throwBasketBall')
end)

RegisterCommand('joinbasketball',function()
    isPlayingBasket = true
    QBCore.Functions.Notify('You joined the game', 'primary', 10000)
    getBasketBall()
end)
RegisterCommand('leavebasketball',function()
    isPlayingBasket = false
    hasBasketBall = false
    QBCore.Functions.Notify('You quit playing.', 'primary', 10000)
end)

RegisterNetEvent('gl-prison:throwBasketBall',function()
        hasBasketBall = false
        local hash = 'prop_bskball_01'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(0) end
        ballBasketObj = CreateObjectNoOffset(hash, x, y, z, true, false)
        ballBasketID = NetworkGetNetworkIdFromEntity(ballBasketObj)
        SetModelAsNoLongerNeeded(hash)
        AttachEntityToEntity(ballBasketObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
        local forwardVector = GetEntityForwardVector(PlayerPedId())
        local force = 35.0
        local animDict = "amb@world_human_cheering@male_a"
        local anim = "base"
        ClearPedTasks(PlayerPedId())
        while (not HasAnimDictLoaded(animDict)) do
            RequestAnimDict(animDict)
            Citizen.Wait(5)
        end
        TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        Wait(700)
        ClearPedTasks(PlayerPedId())
        DetachEntity(ballBasketObj)
        ApplyForceToEntity(ballBasketObj,1,forwardVector.x*force,forwardVector.y*force + 5.0,forwardVector.z + 15,0,0,0,0,false,true,true,false,true)
        TriggerServerEvent('gl-prison:syncBasketBall', ballBasketID)
        isPlayingBasket = true
        getBasketBall()


end)

function getBasketBall()
    CreateThread(function()
        while isPlayingBasket do
            Wait(0)
            if hasBasketBall then
                if IsControlJustReleased(0,38) then
                    hasBasketBall = false
                    local hash = 'prop_bskball_01'
                    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do Citizen.Wait(0) end
                    ballBasketObj = CreateObjectNoOffset(hash, x, y, z, true, false)
                    ballBasketID = NetworkGetNetworkIdFromEntity(ballBasketObj)
                    SetModelAsNoLongerNeeded(hash)
                    AttachEntityToEntity(ballBasketObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
                    local forwardVector = GetEntityForwardVector(PlayerPedId())
                    local force = 35.0
                    local animDict = "amb@world_human_cheering@male_a"
                    local anim = "base"
                    ClearPedTasks(PlayerPedId())
                    while (not HasAnimDictLoaded(animDict)) do
                        RequestAnimDict(animDict)
                        Citizen.Wait(5)
                    end
                    TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
                    Wait(700)
                    ClearPedTasks(PlayerPedId())
                    DetachEntity(ballBasketObj)
                    ApplyForceToEntity(ballBasketObj,1,forwardVector.x*force,forwardVector.y*force + 5.0,forwardVector.z + 15,0,0,0,0,false,true,true,false,true)
                    TriggerServerEvent('gl-prison:syncBasketBall', ballBasketID)
                    isPlayingBasket = true
                end
            else
                local ballCoords = GetEntityCoords(ballBasket)
                DrawMarker(20, ballCoords.x, ballCoords.y, ballCoords.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 228, 71, 12, 80, 1, 1, 0, 1)
                    local dst = #(GetEntityCoords(ballBasket) - GetEntityCoords(PlayerPedId()))
                    if dst < 1 then
                        hasBasketBall = true
                        QBCore.Functions.Notify('You have the ball! Throw it with E', 'primary', 10000)
                        TriggerServerEvent('gl-prison:sendDeleteBasketBall',ballBasketID)
                    end
            end
        end
    end)
end

RegisterNetEvent('gl-prison:syncBasketBall',function(ballBasketID)
    ballBasket = NetworkGetEntityFromNetworkId(ballBasketID)
    hasBasketBall = false
end)

RegisterNetEvent('gl-prison:deleteBasketBall',function()
    DeleteEntity(ballBasket)
end)


-- Throwing Drugs out of Prison
RegisterNetEvent('gl-prison:throwFullBag',function()
        local hash = 'hei_prop_hei_paper_bag'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(0) end
        local tossedDrugs = CreateObjectNoOffset(hash, x, y, z, true, false)
        local drugID = NetworkGetNetworkIdFromEntity(tossedDrugs)

        SetModelAsNoLongerNeeded(hash)
        AttachEntityToEntity(tossedDrugs, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
        local forwardVector = GetEntityForwardVector(PlayerPedId())
        local force = 45.0
        local animDict = "amb@world_human_cheering@male_a"
        local anim = "base"
        ClearPedTasks(PlayerPedId())
        while (not HasAnimDictLoaded(animDict)) do
            RequestAnimDict(animDict)
            Citizen.Wait(5)
        end
        TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        Wait(700)
        ClearPedTasks(PlayerPedId())
        DetachEntity(tossedDrugs)
        ApplyForceToEntity(tossedDrugs,1,forwardVector.x*force,forwardVector.y*force,forwardVector.z + 30,0,0,0,0,false,true,true,false,true)
        TriggerServerEvent('gl-prison:syncTossedDrug', drugID)

end)

RegisterNetEvent('gl-prison:syncTossedDrug',function(drugID)

    local entID = NetworkGetEntityFromNetworkId(drugID)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local dst = #(GetEntityCoords(entID) - pedCoords)
        if dst < 100 then
            Wait(5000)
            exports['qb-target']:AddEntityZone(entID, entID, {
            name=entID,
            debugPoly=false,
            useZ = true
              }, {
              options = {
                {
                event = 'gl-prison:openDrugBag',
                icon = 'fas fa-hand-paper',
                label = 'Open Bag',
                },                            
              },
                --job = {"all"},
                distance = 1.5
              })
        end

end)

RegisterNetEvent('gl-prison:openDrugBag',function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 2.0, GetHashKey("hei_prop_hei_paper_bag"), false)
    local objCoords = GetEntityCoords(closestObject)
    local drugID = NetworkGetNetworkIdFromEntity(closestObject)
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
    Wait(5000)
    ClearPedTasks(ped)
    TriggerServerEvent('gl-prison:openedDrugBag',drugID)
end)

RegisterNetEvent('gl-prison:deleteDrugBag',function(bagID)
    local entID = NetworkGetEntityFromNetworkId(bagID)
    if DoesEntityExist(entID) then
        DeleteEntity(entID)
    end   
end)

-- Jail Stuff

function sendToJailLoaded(timeLeft)
    QBCore.Functions.Notify("You're in jail for "..timeLeft.." months..", "error")
    isJailed = true
    time = timeLeft
    local ped = PlayerPedId()
    TriggerServerEvent("prison:server:SetJailStatus", time)
	TriggerServerEvent("prison:server:SaveJailItems", time)
    DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Citizen.Wait(100)
	end
    FreezeEntityPosition(ped,false)
    SetEntityCoords(ped,Config.CellLocation)
    SetEntityHeading(ped,Config.CellHeading) 
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5) 
    DoScreenFadeIn(1000)
end

RegisterNetEvent('gl-prison:reduceJailTime',function()
    if time > 15 then
        time = time - 5
    else
        time = time - 1
    end
    TriggerServerEvent("prison:server:SetJailStatus", time)
end)

RegisterNetEvent('prison:client:Enter',function(jailTime)
    QBCore.Functions.Notify("You're in jail for "..jailTime.." months..", "error")
    DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Citizen.Wait(100)
	end
    isJailed = true
    time = jailTime
    local ped = PlayerPedId()
    SetEntityCoords(ped,Config.MugshotTP)
    SetEntityHeading(ped,Config.MugshotH)
    FreezeEntityPosition(ped,true)
    TriggerServerEvent("prison:server:SetJailStatus", time)
	TriggerServerEvent("prison:server:SaveJailItems", time)
    DoScreenFadeIn(1000)
    Wait(10000)
    DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end
    FreezeEntityPosition(ped,false)
    SetEntityCoords(ped,Config.CellLocation)
    SetEntityHeading(ped,Config.CellHeading) 
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5) 
    DoScreenFadeIn(1000)
end)

RegisterNetEvent('prison:client:Leave',function()
    if isJailed and time > 0 then
        QBCore.Functions.Notify("You still have to... "..time.." months..")
    else
        unJail()
    end
end)

RegisterNetEvent('prison:client:UnjailPerson', function()
    if time > 0 then
        unJail()
    end
end)

function unJail()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "cellcall", 0.5) 
    isJailed = false
    time = 0
    TriggerServerEvent("prison:server:SetJailStatus", time)
    TriggerServerEvent('prison:server:GiveJailItems')
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetEntityCoords(ped,Config.SetFreeLoc)
    QBCore.Functions.Notify('You have been set free, stay out of trouble!', 'success', 5000)
    finishedTime = nil
    Citizen.Wait(500)

    DoScreenFadeIn(1000)
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

CreateThread(function()
    while true do
        Wait(10)
        if time > 0 and isJailed then
            Wait(60000)
            time = time - 1
            if time <= 0 then
                time = 0
                QBCore.Functions.Notify("Your time is up! Check yourself out at the visitors center", "success", 10000)
            else
                TriggerServerEvent("prison:server:SetJailStatus", time)
                QBCore.Functions.Notify(time .." Months left", 'primary', 5000)
            end
        else
            Wait(5000)
        end
    end
end)

-- On Sangria

RegisterNetEvent('gl-prison:onSangria', function()
    local ped = PlayerPedId()
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
      Citizen.Wait(0)
    end    
    SetPedCanRagdoll( ped, true )
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedMotionBlur(ped, true)
    SetPedIsDrunk(ped, true)
    Wait(1500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(13500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(120500)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
end)


RegisterNetEvent('gl-prison:onMud', function()
    local ped = PlayerPedId()
    LoadAnimDict("amb@world_human_aa_smoke@male@idle_a")
    TaskPlayAnim(ped, "amb@world_human_aa_smoke@male@idle_a" ,"idle_c" ,8.0, -8.0, -1, 1, 0, false, false, false )
    Wait(6000)
    ClearPedTasks(ped)
    AnimpostfxPlay("rampage" , 1 ,false) 
    Wait(25000)
    AnimpostfxStopAll()
    Wait(35000)
    AnimpostfxPlay("rampage" , 1 ,false) 
    Wait(60000)
    AnimpostfxStopAll()
    usedDrug()
    drugTimer()
end)

function usedDrug()
    onDrug = true
    while onDrug do
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 1.0) -- Increase Melee
    end
   
end

function drugTimer()
    while onDrug do
        drugTime = drugTime - 1000
        if drugTime <= 0 then
            onDrug = false
            AnimpostfxStopAll()
            drugTime = 120000
        end
        Wait(1000)
    end
    
end