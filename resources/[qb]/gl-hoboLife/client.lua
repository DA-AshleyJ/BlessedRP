local QBCore = exports['qb-core']:GetCoreObject()
local looted = {}
local dumpsters = {1329570871, 218085040, 666561306, -58485588, -206690185, 1511880420, 682791951, 684586828, 909943734, 651101403, 865150065, -1472203944, -468629664, 234941195, 1380691550, 1919238784, -1426008804, -329415894, 1748268526, 437765445, -1096777189, 811169045, 1614656839}
local minTime = Config.MinBegTime * 1000
local maxTime = Config.MaxBegTime * 1000
local bed, chair, rat, ratFood, bucket, bucketOwner = 0, 0, 0, 0, 0, 0
local inProgress, trampSpawned, sellPedSpawned = false, false, false
local npc, sellNPC

local function BendAnimation()
    local ped = PlayerPedId()
    QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
    QBCore.Functions.RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 48, 0, false, false, false)
    Wait(5000)
    ClearPedTasksImmediately(ped)
end

local function CreateRatZone()
    CreateThread(function()
        while true do
            Wait(5000)
            if DoesEntityExist(rat) then
                if Config.RequireUnemployed then
                    exports['qb-target']:AddEntityZone('rat', rat, {
                        name = "rat",
                        debugPoly = false,
                        useZ = true
                    }, {
                        options = {
                            {
                                event = "gl-hoboLife:findFood",
                                icon = "fas fa-search",
                                label = "Find Food",
                                job = "unemployed",
                            },
                            {
                                event = "gl-hoboLife:checkFood",
                                icon = "fas fa-search",
                                label = "Check Food",
                                job = "unemployed",
                            },
                        },
                        distance = 2.5
                    })
                else
                    exports['qb-target']:AddEntityZone('rat', rat, {
                        name = "rat",
                        debugPoly = false,
                        useZ = true
                    }, {
                        options = {
                            {
                                event = "gl-hoboLife:findFood",
                                icon = "fas fa-search",
                                label = "Find Food",
                            },
                            {
                                event = "gl-hoboLife:checkFood",
                                icon = "fas fa-search",
                                label = "Check Food",
                            },
                        },
                        distance = 2.5
                    })
                end
            else
                break
            end
        end
    end)
end

-- Spawn Tramp NPC When you get close, delete when you leave
CreateThread(function()
    while true do
        Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local spawnCoords = vector3(-61.86, -1218.69, 27.7)
        local dst = #(spawnCoords - pedCoords)
        
        if dst < 100 and trampSpawned == false then
            TriggerEvent('gl-hoboLife:spawnPed', spawnCoords, 266.27)
            trampSpawned = true
        end
        if dst >= 101 then
            trampSpawned = false
            DeleteEntity(npc)
        end
    end
end)

-- Spawn Tramp NPC
RegisterNetEvent('gl-hoboLife:spawnPed', function(coords, heading)
    local hash = GetHashKey('a_m_o_tramp_01')
    QBCore.Functions.LoadModel(hash)
    
    trampSpawned = true
    npc = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    exports['qb-target']:AddEntityZone('hobo', npc, {
        name = "hobo",
        debugPoly = false,
        useZ = true
    }, {
        options = {
            {
                event = "gl-hoboLife:learnRules",
                icon = "fas fa-question",
                label = "How to Play",
            },
            {
                event = "gl-hoboLife:betFive",
                icon = "fas fa-money-bill",
                label = "Bet $5",
            },
            {
                event = "gl-hoboLife:betTen",
                icon = "fas fa-money-bill",
                label = "Bet $10",
            },
        },
        distance = 2.5
    })
end)

-- Spawn Selling NPC when close by
CreateThread(function()
    while true do
        Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local spawnCoords = vector3(-470.74, -1718.31, 17.7)
        local dst = #(spawnCoords - pedCoords)
        
        if dst < 100 and sellPedSpawned == false then
            TriggerEvent('gl-hoboLife:spawnSellPed', spawnCoords, 273.3)
            sellPedSpawned = true
        end
        if dst >= 101 then
            sellPedSpawned = false
            DeleteEntity(sellNPC)
        end
    end
end)

-- Spawn Selling NPC
RegisterNetEvent('gl-hoboLife:spawnSellPed', function(coords, heading)
    local hash = GetHashKey('ig_trafficwarden')
    QBCore.Functions.LoadModel(hash)
    
    sellPedSpawned = true
    sellNPC = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(sellNPC, true)
    SetEntityInvincible(sellNPC, true)
    SetBlockingOfNonTemporaryEvents(sellNPC, true)
    
    if Config.RequireUnemployed then
        exports['qb-target']:AddEntityZone('sellNPC', sellNPC, {
            name = "sellNPC",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:takeTrash",
                    icon = "fas fa-recycle",
                    label = "Sell Recycling",
                    job = "unemployed",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddEntityZone('sellNPC', sellNPC, {
            name = "sellNPC",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:takeTrash",
                    icon = "fas fa-recycle",
                    label = "Sell Recycling",
                },
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('gl-hoboLife:learnRules', function()
    QBCore.Functions.Notify("It's a game of chance. Guess the number I'm gonna roll!", "primary", 8500)
end)

RegisterNetEvent('gl-hoboLife:betFive', function()
    TriggerServerEvent('gl-hoboLife:checkBet', 5)
end)

RegisterNetEvent('gl-hoboLife:betTen', function()
    TriggerServerEvent('gl-hoboLife:checkBet', 10)
end)

RegisterNetEvent('gl-hoboLife:betAccepted', function()
    QBCore.Functions.RequestAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(npc, "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Wait(1500)
    ClearPedTasks(npc)
    exports['qb-target']:RemoveZone('hobo')
    
    if Config.RequireUnemployed then
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:Pick1",
                    icon = "fas fa-dice-one",
                    label = "It's One!",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:Pick2",
                    icon = "fas fa-dice-two",
                    label = "Probably Two!",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:Pick3",
                    icon = "fas fa-dice-three",
                    label = "Gotta be Three!",
                    job = "unemployed",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:Pick1",
                    icon = "fas fa-dice-one",
                    label = "It's One!",
                },
                {
                    event = "gl-hoboLife:Pick2",
                    icon = "fas fa-dice-two",
                    label = "Probably Two!",
                },
                {
                    event = "gl-hoboLife:Pick3",
                    icon = "fas fa-dice-three",
                    label = "Gotta be Three!",
                },
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('gl-hoboLife:Pick1', function()
    TriggerServerEvent('gl-hoboLife:choice', 1)
    exports['qb-target']:RemoveZone('hobo')
    
    if Config.RequireUnemployed then
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:learnRules",
                    icon = "fas fa-question",
                    label = "How to Play",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:betFive",
                    icon = "fas fa-money-bill",
                    label = "Bet $5",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:betTen",
                    icon = "fas fa-money-bill",
                    label = "Bet $10",
                    job = "unemployed",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:learnRules",
                    icon = "fas fa-question",
                    label = "How to Play",
                },
                {
                    event = "gl-hoboLife:betFive",
                    icon = "fas fa-money-bill",
                    label = "Bet $5",
                },
                {
                    event = "gl-hoboLife:betTen",
                    icon = "fas fa-money-bill",
                    label = "Bet $10",
                },
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('gl-hoboLife:Pick2', function()
    TriggerServerEvent('gl-hoboLife:choice', 2)
    exports['qb-target']:RemoveZone('hobo')
    
    if Config.RequireUnemployed then
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:learnRules",
                    icon = "fas fa-question",
                    label = "How to Play",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:betFive",
                    icon = "fas fa-money-bill",
                    label = "Bet $5",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:betTen",
                    icon = "fas fa-money-bill",
                    label = "Bet $10",
                    job = "unemployed",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:learnRules",
                    icon = "fas fa-question",
                    label = "How to Play",
                },
                {
                    event = "gl-hoboLife:betFive",
                    icon = "fas fa-money-bill",
                    label = "Bet $5",
                },
                {
                    event = "gl-hoboLife:betTen",
                    icon = "fas fa-money-bill",
                    label = "Bet $10",
                },
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('gl-hoboLife:Pick3', function()
    TriggerServerEvent('gl-hoboLife:choice', 3)
    exports['qb-target']:RemoveZone('hobo')
    
    if Config.RequireUnemployed then
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:learnRules",
                    icon = "fas fa-question",
                    label = "How to Play",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:betFive",
                    icon = "fas fa-money-bill",
                    label = "Bet $5",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:betTen",
                    icon = "fas fa-money-bill",
                    label = "Bet $10",
                    job = "unemployed",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddEntityZone('hobo', npc, {
            name = "hobo",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:learnRules",
                    icon = "fas fa-question",
                    label = "How to Play",
                },
                {
                    event = "gl-hoboLife:betFive",
                    icon = "fas fa-money-bill",
                    label = "Bet $5",
                },
                {
                    event = "gl-hoboLife:betTen",
                    icon = "fas fa-money-bill",
                    label = "Bet $10",
                },
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('gl-hoboLife:search', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dumpster
    for i = 1, #dumpsters do
        dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
        local alreadySearched = tableHasKey(looted, dumpster)
        if dumpster ~= 0 then
            QBCore.Functions.Progressbar("search_dumpster", "Searching...", 4000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            }, {
                task = "PROP_HUMAN_BUM_BIN"
            }, {}, {}, function()
                ClearPedTasks(ped)
                ClearPedTasksImmediately(ped)
                if alreadySearched then
                    QBCore.Functions.Notify("Nothing here.", "error")
                else
                    addToSet(looted, dumpster)
                    TriggerServerEvent('gl-hoboLife:addItem')
                end
            end)
            break
        end
    end
end)

if Config.RequireUnemployed then
    exports['qb-target']:AddTargetModel(dumpsters, {
        options = {
            {
                event = "gl-hoboLife:search",
                icon = "fas fa-hand-paper",
                label = "Search",
                job = "unemployed",
            },
        },
        distance = 1.7
    })
else
    exports['qb-target']:AddTargetModel(dumpsters, {
        options = {
            {
                event = "gl-hoboLife:search",
                icon = "fas fa-hand-paper",
                label = "Search",
            },
        },
        distance = 1.7
    })
end

local bin = {
    1437508529
}

if Config.RequireUnemployed then
    exports['qb-target']:AddTargetModel(bin, {
        options = {
            {
                event = "gl-hoboLife:emptyBin",
                icon = "fas fa-hand-paper",
                label = "Empty",
                job = "unemployed",
            },
        },
        distance = 1.7
    })
else
    exports['qb-target']:AddTargetModel(bin, {
        options = {
            {
                event = "gl-hoboLife:emptyBin",
                icon = "fas fa-hand-paper",
                label = "Empty",
            },
        },
        distance = 1.7
    })
end

local cart1 = {
    'prop_skid_trolley_2',
}

if Config.RequireUnemployed then
    exports['qb-target']:AddTargetModel(cart1, {
        options = {
            {
                type = "client",
                event = "gl-hoboLife:pushCart",
                icon = "fas fa-hand-paper",
                label = "Push",
                job = "unemployed",
            },
            {
                type = "client",
                event = "gl-hoboLife:grabSign",
                icon = "fas fa-hand-paper",
                label = "Take out a Sign",
                job = "unemployed",
            },
            {
                type = "client",
                event = "gl-hoboLife:grabBed",
                icon = "fas fa-hand-paper",
                label = "Take out a Bed",
                job = "unemployed",
            },
            {
                type = "client",
                event = "gl-hoboLife:grabSeat",
                icon = "fas fa-hand-paper",
                label = "Take out a Seat",
                job = "unemployed",
            },
        },
        distance = 1.7
    })
else
    exports['qb-target']:AddTargetModel(cart1, {
        options = {
            {
                type = "client",
                event = "gl-hoboLife:pushCart",
                icon = "fas fa-hand-paper",
                label = "Push",
            },
            {
                type = "client",
                event = "gl-hoboLife:grabSign",
                icon = "fas fa-hand-paper",
                label = "Take out a Sign",
            },
            {
                type = "client",
                event = "gl-hoboLife:grabBed",
                icon = "fas fa-hand-paper",
                label = "Take out a Bed",
            },
            {
                type = "client",
                event = "gl-hoboLife:grabSeat",
                icon = "fas fa-hand-paper",
                label = "Take out a Seat",
            },
        },
        distance = 1.7
    })
end


local cart2 = {
    'prop_rub_trolley02a'
}

if Config.RequireUnemployed then
    exports['qb-target']:AddTargetModel(cart2, {
        options = {
            {
                type = "client",
                event = "gl-hoboLife:pushCart",
                icon = "fas fa-hand-paper",
                label = "Push",
                job = "unemployed",
            },
            {
                type = "client",
                event = "gl-hoboLife:placeTrash",
                icon = "fas fa-hand-paper",
                label = "Place Trash",
                job = "unemployed",
            },
            {
                type = "client",
                event = "gl-hoboLife:takeOutTrash",
                icon = "fas fa-hand-paper",
                label = "Take Out Trash",
                job = "unemployed",
            },
        },
        distance = 1.7
    })
else
    exports['qb-target']:AddTargetModel(cart2, {
        options = {
            {
                type = "client",
                event = "gl-hoboLife:pushCart",
                icon = "fas fa-hand-paper",
                label = "Push",
            },
            {
                type = "client",
                event = "gl-hoboLife:placeTrash",
                icon = "fas fa-hand-paper",
                label = "Place Trash",
            },
            {
                type = "client",
                event = "gl-hoboLife:takeOutTrash",
                icon = "fas fa-hand-paper",
                label = "Take Out Trash",
            },
        },
        distance = 1.7
    })
end


-- Called to add the  ID to a table
function addToSet(set, key)
    set[key] = true
end

-- Called to check if the IDs exists in the set table
function tableHasKey(table, key)
    return table[key] ~= nil
end

local lastCoords = 0

RegisterNetEvent('gl-hoboLife:grabBed', function()
    TriggerServerEvent('gl-hoboLife:checkItems', 'sleepingbag')
end)

RegisterNetEvent('gl-hoboLife:grabSeat', function()
    TriggerServerEvent('gl-hoboLife:checkItems', 'cratechair')
end)

RegisterNetEvent('gl-hoboLife:grabSign', function()
    TriggerServerEvent('gl-hoboLife:checkItems', 'sign')
end)

RegisterNetEvent('gl-hoboLife:placeBed', function()
    BendAnimation()
    local hash = GetHashKey('prop_skid_sleepbag_1')
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.5))
    QBCore.Functions.LoadModel(hash)
    DeleteObject(bed)
    bed = CreateObjectNoOffset(hash, x, y, z - 1.41, true, false)
    SetModelAsNoLongerNeeded(hash)
    FreezeEntityPosition(bed, true)
    if Config.RequireUnemployed then
        exports['qb-target']:AddEntityZone('bed', bed, {
            name = "bed",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:layDown",
                    icon = "fas fa-bed",
                    label = "Lay down",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:removeBed",
                    icon = "fas fa-bed",
                    label = "Pick up Bed",
                    job = "unemployed",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddEntityZone('bed', bed, {
            name = "bed",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:layDown",
                    icon = "fas fa-bed",
                    label = "Lay down",
                },
                {
                    event = "gl-hoboLife:removeBed",
                    icon = "fas fa-bed",
                    label = "Pick up Bed",
                },
            },
            distance = 2.5
        })
    end
    Wait(120000)
    DeleteObject(bed)
end)

RegisterNetEvent('gl-hoboLife:removeBed', function()
    BendAnimation()
    DeleteObject(bed)
end)

RegisterNetEvent('gl-hoboLife:removeChair', function()
    BendAnimation()
    DeleteObject(chair)
end)

RegisterNetEvent('gl-hoboLife:layDown', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("prop_skid_sleepbag_1"), false)
    local objCoords = GetEntityCoords(closestObject)
    local objHeading = GetEntityHeading(closestObject)
    TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_BUM_SLUMPED', objCoords.x, objCoords.y, objCoords.z + 0.5, -objHeading, 0, 0, 1)
    inProgress = true
end)

RegisterNetEvent('gl-hoboLife:placeChair', function()
    BendAnimation()
    local hash = GetHashKey('prop_crate_11b')
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.5))
    QBCore.Functions.LoadModel(hash)
    DeleteObject(chair)
    chair = CreateObjectNoOffset(hash, x, y, z - 1.1, true, false)
    SetEntityRotation(chair, 0, 180.0, 0, 0, 0)
    SetModelAsNoLongerNeeded(hash)
    FreezeEntityPosition(chair, true)
    
    if Config.RequireUnemployed then
        exports['qb-target']:AddEntityZone('chair', chair, {
            name = "chair",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:sitChair",
                    icon = "fas fa-chair",
                    label = "Sit down",
                    job = "unemployed",
                },
                {
                    event = "gl-hoboLife:removeChair",
                    icon = "fas fa-chair",
                    label = "Pick up Chair",
                    job = "unemployed",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddEntityZone('chair', chair, {
            name = "chair",
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = "gl-hoboLife:sitChair",
                    icon = "fas fa-chair",
                    label = "Sit down",
                },
                {
                    event = "gl-hoboLife:removeChair",
                    icon = "fas fa-chair",
                    label = "Pick up Chair",
                },
            },
            distance = 2.5
        })
    end
    Wait(120000)
    DeleteObject(chair)
end)

RegisterNetEvent('gl-hoboLife:placeTrash', function()
    if DoesEntityExist(garbagebag) then
        DeleteObject(garbagebag)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        Prop = 'hei_prop_heist_binbag'
        QBCore.Functions.LoadModel(Prop)
        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_rub_trolley02a"), false)
        local cCoords = GetEntityCoords(closestObject)
        pProp = CreateObject(GetHashKey(Prop), cCoords.x, cCoords.y, cCoords.z, true, true, true)
        SetModelAsNoLongerNeeded(Prop)
        AttachEntityToEntity(pProp, closestObject, GetPedBoneIndex(ped, 28422), 0.0, -0.30, 0.50, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
    end
end)

RegisterNetEvent('gl-hoboLife:takeOutTrash', function()
    if DoesEntityExist(pProp) then
        DeleteObject(pProp)
        if DoesEntityExist(garbagebag) then
            QBCore.Functions.Notify("You cannot carry more", "error")
        else
            local ped = PlayerPedId()
            garbagebag = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)-- creates object
            AttachEntityToEntity(garbagebag, ped, GetPedBoneIndex(ped, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)-- object is attached to right hand
        end
    end
end)

-- [[Empty The Barrel/Grab the Bag]]
RegisterNetEvent('gl-hoboLife:emptyBin', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local objectId = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey("prop_bin_01a"), false)
    local alreadySearched = tableHasKey(looted, objectId)
    QBCore.Functions.Progressbar("emptying_bin", "Emptying Bin...", 4000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true,
    }, {
        task = "PROP_HUMAN_BUM_BIN"
    }, {}, {}, function()
        ClearPedTasksImmediately(ped)
        if alreadySearched then
            QBCore.Functions.Notify("Nothing in this bin.", "error")
        else
            if DoesEntityExist(garbagebag) then
                QBCore.Functions.Notify("You cannot carry more", "error")
            else
                addToSet(looted, objectId)
                garbagebag = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)-- creates object
                AttachEntityToEntity(garbagebag, ped, GetPedBoneIndex(ped, 57005), 0.05, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)-- object is attached to right hand
            end
        end
    end)
end)


RegisterNetEvent('gl-hoboLife:sitChair', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("prop_crate_11b"), false)
    local objCoords = GetEntityCoords(closestObject)
    local objHeading = GetEntityHeading(closestObject)
    TaskStartScenarioAtPosition(ped, 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER', objCoords.x, objCoords.y, objCoords.z, objHeading, 0, 187, 1)
    inProgress = true
end)

RegisterNetEvent('gl-hoboLife:takeTrash', function()
    if DoesEntityExist(garbagebag) then
        DeleteObject(garbagebag)
        TriggerServerEvent('gl-hoboLife:takeTrash')
    end
end)

RegisterNetEvent('gl-hoboLife:piccoloOfRats', function()
    if DoesEntityExist(rat) then
        DeletePed(rat)
    else
        PlaySoundFrontend(-1, "Whistle", "DLC_TG_Running_Back_Sounds", false)
        local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 2.0, 0.0)
        local hash = GetHashKey('a_c_rat')
        QBCore.Functions.LoadModel(hash)
        rat = CreatePed(28, hash, pos.x, pos.y, pos.z - 1, 0.0, true, true)
        SetPedAsGroupMember(rat, GetPedGroupIndex(PlayerPedId()))
        CreateRatZone()
    end
end)

RegisterNetEvent('gl-hoboLife:findFood', function()
    local rng = math.random(0, 1)
    pedCoords = GetEntityCoords(rat)
    ranCoords = math.random(-100, 100)
    --TaskWanderStandard(ped,10.0,10)
    TaskWanderInArea(rat, pedCoords.x + ranCoords, pedCoords.y + ranCoords, pedCoords.z, 1000, 500, 25000)
    Wait(8000)
    TaskWanderInArea(rat, pedCoords.x - ranCoords, pedCoords.y - ranCoords, pedCoords.z, 1000, 500, 25000)
    Wait(8000)
    TaskGoToEntity(rat, PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
    --SetPedAsGroupMember(rat, GetPedGroupIndex(PlayerPedId()))
    Wait(5000)
    ratFood = ratFood + rng
end)

RegisterNetEvent('gl-hoboLife:checkFood', function()
    if ratFood > 0 then
        TriggerServerEvent('gl-hoboLife:findFood', ratFood)
        ratFood = ratFood - 1
    end
end)

RegisterNetEvent('gl-hoboLife:sendBucketServer', function()
    TriggerServerEvent('gl-hoboLife:makeBucket')
end)

RegisterNetEvent('gl-hoboLife:makeBucketZone', function(owner)
    bucketOwner = PlayerPedId(owner)
    Prop = 'prop_bucket_02a'
    local pldist = GetEntityCoords(bucketOwner)
    QBCore.Functions.LoadModel(Prop)
    bucket = CreateObject(GetHashKey(Prop), pldist.x + 0.5, pldist.y, pldist.z - 1, true, true, true)
    
    exports['qb-target']:AddEntityZone('bucket', bucket, {
        name = "bucket",
        debugPoly = false,
        useZ = true
    }, {
        options = {
            {
                event = "gl-hoboLife:addMoney",
                icon = "fas fa-money-bill-wave",
                label = "Put in 5 dollars",
            },
            {
                event = "gl-hoboLife:takeMoney",
                icon = "fas fa-money-bill-wave",
                label = "Take Money",
            },
        },
        distance = 2.5
    })
    Wait(120000)
    DeleteObject(bucket)
end)

RegisterNetEvent('gl-hoboLife:removeBucket', function()
    TriggerServerEvent('gl-hoboLife:updateBucket')
    DeleteObject(bucket)
end)

RegisterNetEvent('gl-hoboLife:addMoney', function()
    TriggerServerEvent('gl-hoboLife:donateMoney')
end)

RegisterNetEvent('gl-hoboLife:takeMoney', function()
    TriggerServerEvent('gl-hoboLife:takeMoney')
end)

RegisterNetEvent('gl-hoboLife:pushCart', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_skid_trolley_2"), false)
    if closestObject == 0 then
        closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_rub_trolley02a"), false)
    end
    local closestPlayer, closestPlayerDist = QBCore.Functions.GetClosestPlayer()
    if closestPlayer ~= -1 and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
            QBCore.Functions.Notify("Somebody is already using this!", "error")
            return
        end
    end
    
    NetworkRequestControlOfEntity(closestObject)
    while not NetworkHasControlOfEntity(closestObject) do Wait(0) end
    QBCore.Functions.RequestAnimDict("anim@heists@box_carry@")
    AttachEntityToEntity(closestObject, ped, GetPedBoneIndex(ped, 28422), -0.00, -0.49, -0.763, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
    
    while IsEntityAttachedToEntity(closestObject, ped) do
        Wait(5)
        
        if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end
        
        if IsPedDeadOrDying(ped) then
            DetachEntity(closestObject, true, true)
        end
        
        if IsControlJustPressed(0, 73) then
            DetachEntity(closestObject, true, true)
        end
    end
end)


RegisterNetEvent('gl-hoboLife:useSign', function()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local dst = #(pCoords - lastCoords)
    
    if dst < 100 then
        QBCore.Functions.Notify("I should find a new location.", "error")
    else
        lastCoords = GetEntityCoords(ped)
        QBCore.Functions.RequestAnimDict("amb@world_human_bum_freeway@male@base")
        Prop = 'prop_beggers_sign_03'
        local pldist = GetEntityCoords(ped)
        local waitTime = math.random(minTime, maxTime)
        QBCore.Functions.LoadModel(Prop)
        pProp = CreateObject(GetHashKey(Prop), pldist.x, pldist.y, pldist.z + 0.2, true, true, true)
        AttachEntityToEntity(pProp, ped, GetPedBoneIndex(ped, 58868), 0.19, 0.18, 0.0, 5.0, 0.0, 40.0, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(Prop)
        TaskPlayAnim(ped, "amb@world_human_bum_freeway@male@base", "base", 8.0, 8.0, -1, 1, 0, 0, 0, 0)
        Wait(waitTime)
        local PlayerPeds = {}
        if next(PlayerPeds) == nil then
            for _, player in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(player)
                PlayerPeds[#PlayerPeds + 1] = ped
            end
        end
        local closestPed, closestDistance = QBCore.Functions.GetClosestPed(lastCoords, PlayerPeds)
        if closestDistance < math.floor(closestDistance) and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) then
            TaskGoToEntity(closestPed, ped, -1, 0, 1.0, 0, 0)
            if Config.AggressivePeds then
                local chance = math.random(1, 5)
                if chance >= 4 then
                    TaskCombatPed(closestPed, ped, 0, 16)
                else
                    if dst < 2 then
                        QBCore.Functions.RequestAnimDict("mp_safehouselost@")
                        TaskPlayAnim(closestPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
                        TriggerServerEvent('gl-hoboLife:addItem')
                        Wait(3000)
                        ClearPedTasksImmediately(closestPed)
                    else
                        ClearPedTasksImmediately(closestPed)
                    end
                end
            end
        end
        DeleteObject(pProp)
        ClearPedTasks(ped)
    end
end)

CreateThread(function()
    while true do
        if inProgress then
            if IsControlJustPressed(0, 73) then
                ClearPedTasks(PlayerPedId())
                inProgress = false
            end
        end
        Wait(0)
    end
end)
