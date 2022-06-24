local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local displayPet
local displayVariation = 0
local totalVariation
local petState
local petShopNPC

-- [[ Purchasing Pets ]]
local displayModel
local displayPrice

-- [[ Pet Stat Stuff]]
local health = 100
local petStam
local petSpeed
local petLoyalty
local petSpeed
local petHunger
local petName
local myPet
local petID
local carrying = false
local petAttacking = false
-- [[ Pet Time Stuff]]
local calledPetTime 
local dismissedPettime
local curPet
local lastPet = 0
local resting
local restTime
-- [[ Pet Props]]
local ballObj
local foodObj
local treatObj
local dogHouse
local bowlObj

-- Functions
local function GetNearbyPet()
    local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        PlayerPeds[#PlayerPeds+1] = ped
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    return QBCore.Functions.GetClosestPed(coords, PlayerPeds)
end

local function PetMenu()
    TriggerEvent('gl-pets:viewPet')
end

local function GetPedInDirection()
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)

  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
  local _, _, _, _, pedHandle = GetRaycastResult(rayHandle)
  return pedHandle 
end

local function spawnShopNPC()
    local hash = GetHashKey('a_f_y_soucent_03')
    QBCore.Functions.LoadModel(hash)
    petShopNPC = CreatePed(5, hash, 563.76,2753.27,41.88,178.33, false, false)
    FreezeEntityPosition(petShopNPC, true)
    SetEntityInvincible(petShopNPC, true)
    SetBlockingOfNonTemporaryEvents(petShopNPC, true)
    SetModelAsNoLongerNeeded(hash)
    exports['qb-target']:AddTargetEntity(petShopNPC, {
        options = {
            {
                event = "gl-pets:getPetMenu",
                icon = "fas fa-shopping-basket",
                label = 'Open Shop',
            },
        },
        distance = 2.5
    })
end

-- [[ K9 Actions ]]
local function k9Search()
    if PlayerData.job.name == 'police' then
        local ped = PlayerPedId()
        if DoesEntityExist(myPet) then
            local target = GetPedInDirection()
            if IsEntityAPed(target) then
                QBCore.Functions.RequestAnimDict('gestures@f@standing@casual')
                TaskPlayAnim(ped,'gestures@f@standing@casual','gesture_point' ,8.0, -8, 1500, 16, 0, false, false, false)
                TaskGoToEntity(myPet, target, 5000, 2.0, petSpeed, 1073741824.0, 0)
                Wait(5000)
                local player, distance = QBCore.Functions.GetClosestPlayer()
                if player ~= -1 and distance <= 10.0 then
                    TriggerServerEvent('gl-pets:k9Search',GetPlayerServerId(ped), GetPlayerServerId(player))
                end
            end
        end
    end
end

local function k9Attack()
    if PlayerData.job.name == 'police' then
        local target = GetPedInDirection()
        local ped = PlayerPedId()
        if IsEntityAPed(target) and not petAttacking then
            --SetRelationshipBetweenGroups(5, GetHashKey('Friendly'),  GetHashKey('PLAYER'))
            SetPedRelationshipGroupHash(myPet,GetHashKey('COUGAR'))
            SetCanAttackFriendly(myPet, true, false)
            QBCore.Functions.RequestAnimDict('gestures@f@standing@casual')
            TaskPlayAnim(ped,'gestures@f@standing@casual','gesture_point' ,8.0, -8, 1500, 16, 0, false, false, false)
            TaskPutPedDirectlyIntoMelee(myPet, target, 0.0, -1.0, 0.0, 0)
            petAttacking = true
            CreateThread(function()
                while petAttacking do
                    Wait(1000)
                    if IsEntityDead(target) then
                        SetPedRelationshipGroupHash(myPet, GetHashKey('Friendly'))
                        break
                    end
                end
            end)
        elseif petAttacking then
            SetPedRelationshipGroupHash(myPet,GetHashKey('Friendly'))
            --SetRelationshipBetweenGroups(0, GetHashKey('Friendly'),  GetHashKey('PLAYER'))  
            QBCore.Functions.RequestAnimDict('taxi_hail')
            TaskPlayAnim(ped, 'taxi_hail','hail_taxi' ,8.0, -8, 1500, 16, 0, false, false, false)
            TaskGoToEntity(myPet, ped, -1, 0.1, petSpeed, 1073741824.0, 0)
            SetPedKeepTask(myPet,true) 
            petAttacking = false
        end
    end
end
-- [[ End K9 Actions ]]

-- [[ Ped Actions ]]
local function playFetch()
    local hasBall = false
    TaskGoToEntity(myPet, ballObj, -1, 1.0, petSpeed, 1073741824.0, 0)
    while DoesEntityExist(ballObj) do
        Wait(1000)
        local distance = #(GetEntityCoords(myPet) - GetEntityCoords(ballObj))
        if distance < 2.0 and not hasBall then
            --DeleteEntity(ballObj)
            TaskGoToEntity(myPet, PlayerPedId(), -1, 0.1, petSpeed, 1073741824.0, 0)
            AttachEntityToEntity(ballObj, myPet, GetPedBoneIndex(myPet, 12844), 0.28, 0.01, -0.07, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            hasBall = true
        end
        local distance2 = #(GetEntityCoords(myPet) - GetEntityCoords(PlayerPedId()))
        if distance2 < 2.0 and hasBall then
            DetachEntity(ballObj)
            Wait(2000)
            DeleteEntity(ballObj)
            hasBall = false
            TriggerServerEvent('gl-pets:giveBallBack')
            break
        end
    end
end

local function petRest()
    if not resting then
        resting = true
        restTime = GetGameTimer()
        for k, v in pairs(Config.PetAnimations) do
            if v.model == GetEntityModel(myPet) then
                QBCore.Functions.RequestAnimDict(v.SleepDict)
                TaskPlayAnim(myPet, v.SleepDict, v.SleepAnim, 8.0, -8, -1, 1, 0, false, false, false)
            end
        end
    end
end

local function changePetState(state)
    local someChance = math.random(petLoyalty,110)
    petState = state
    if petHunger < 5 then
        petLoyalty = petLoyalty - 2
        QBCore.Functions.Notify('Your Pet is extremely hungry.', 'error', 8000)
        for k, v in pairs(Config.PetAnimations) do
            if v.model == GetEntityModel(myPet) then
                QBCore.Functions.RequestAnimDict(v.BarkDict)
                TaskPlayAnim(myPet, v.BarkDict,v.BarkAnim  ,8.0, -8, -1, 1, 0, false, false, false)
                Wait(5000)
                ClearPedTasks(myPet)
            end
        end
    else
        if petState == 'sit' then
            if someChance > 70 then
                for k, v in pairs(Config.PetAnimations) do
                    if v.model == GetEntityModel(myPet) then
                        QBCore.Functions.RequestAnimDict(v.SitDict)
                        TaskPlayAnim(myPet, v.SitDict,v.SitAnim  ,8.0, -8, -1, 1, 0, false, false, false)
                    end
                end
            else
                petLoyalty = petLoyalty - 1
            end
        elseif petState == 'follow' then
            if someChance > 70 then
            TaskGoToEntity(myPet, PlayerPedId(), -1, 0.1, petSpeed, 1073741824.0, 0)
            SetPedKeepTask(myPet,true)            
            else
                petLoyalty = petLoyalty - 1
            end
        elseif petState == 'laydown' then
            if someChance > 70 then
                for k, v in pairs(Config.PetAnimations) do
                    if v.model == GetEntityModel(myPet) then
                        QBCore.Functions.RequestAnimDict(v.SleepDict)
                        TaskPlayAnim(myPet, v.SleepDict,v.SleepAnim  ,8.0, -8, -1, 1, 0, false, false, false)
                    end
                end
            else
                petLoyalty = petLoyalty - 1
            end
        elseif petState == 'beg' then
            if someChance > 70 then
                for k, v in pairs(Config.PetAnimations) do
                    if v.model == GetEntityModel(myPet) then
                        QBCore.Functions.RequestAnimDict(v.BegDict)
                        TaskPlayAnim(myPet, v.BegDict,v.BegAnim  ,8.0, -8, -1, 1, 0, false, false, false)
                    end
                end
            else
                petLoyalty = petLoyalty - 1
            end
        elseif petState == 'paw' then
            if someChance > 70 then
                for k, v in pairs(Config.PetAnimations) do
                    if v.model == GetEntityModel(myPet) then
                        QBCore.Functions.RequestAnimDict(v.PawDict)
                        TaskPlayAnim(myPet, v.PawDict,v.PawAnim  ,8.0, -8, -1, 1, 0, false, false, false)
                    end
                end
            else
                petLoyalty = petLoyalty - 1
            end            
        elseif petState == 'stay' then
            if someChance > 70 then
                ClearPedTasks(myPet)
            else
                petLoyalty = petLoyalty - 1
            end
        elseif petState == 'incar' then
            if IsPedInAnyVehicle(PlayerPedId(),false) then
                local veh = GetVehiclePedIsIn(PlayerPedId())
                TaskWarpPedIntoVehicle(myPet,veh,-2)
                Wait(50)
                for k, v in pairs(Config.PetAnimations) do
                    if v.model == GetEntityModel(myPet) then
                        QBCore.Functions.RequestAnimDict(v.SitDict)
                        TaskPlayAnim(myPet, v.SitDict,v.SitAnim  ,8.0, -8, -1, 1, 0, false, false, false)
                    end
                end
            end
    
        elseif petState == 'outcar' then
            local veh = GetVehiclePedIsIn(myPet,false)
            TaskLeaveVehicle(myPet,veh,16)
            local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(myPet,1.5,0.0,-1.0))
            SetEntityCoords(myPet,x,y,z)
        end
    end
end

local function carryPet()
    carrying = true
    ClearPedTasks(myPet)
    local ped = PlayerPedId()
    QBCore.Functions.RequestAnimDict("anim@heists@box_carry@")
    AttachEntityToEntity(myPet, ped, GetPedBoneIndex(ped, 57005), 0.28, 0.12, -0.30, -100.0, 0.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, 'anim@heists@box_carry@','idle' ,8.0, -8, -1, 51, 0, false, false, false)
    QBCore.Functions.Notify('Pressing [X] will drop your pet.', 'primary', 5000)
    if not IsEntityPlayingAnim(ped,"anim@heists@box_carry@","idle",3) then
        TaskPlayAnim(ped, 'anim@heists@box_carry@','idle' ,8.0, -8, -1, 51, 0, false, false, false)
    end
end

local function DropPet()
    if carrying then
        DetachEntity(myPet)
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
        SetEntityCoords(myPet,x,y,z)
        carrying = false
        StopAnimTask(PlayerPedId(), "anim@heists@box_carry@", "idle", 1.0)
        changePetState('follow')
    end
end

local function createPetZone()
    local petsModel = GetEntityModel(myPet)
    Wait(50)
    local petTable = {
        petsModel
    }

    exports['qb-target']:AddTargetModel(petTable, {
        options = {
            {
                event = "gl-pets:petPet",
                icon = "fas fa-hand-paper",
                label = 'Pet',
            },
            {
                event = "gl-pets:giveTreat",
                icon = "fas fa-bone",
                label = 'Give Treat',
            },
            {
                event = "gl-pets:carryPet",
                icon = "fas fa-hand-paper",
                label = 'Carry',
            },
            {
                event = "gl-pets:dismissPet",
                icon = "fas fa-hand-paper",
                label = 'Dismiss',
            },
        },
        distance = 2.5
    })
end
-- [[ End Ped Actions ]]

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

--[[ HotKeys -- Change these before starting script]]
CreateThread(function()
    RegisterKeyMapping("PetMenu", "Pet Menu", "keyboard", "HOME") 
    RegisterCommand('PetMenu', PetMenu, false)
    TriggerEvent("chat:removeSuggestion", "/PetMenu")
    RegisterKeyMapping("PetAttack", "Pet Attack", "keyboard", "G") 
    RegisterCommand('PetAttack', k9Attack, false)
    TriggerEvent("chat:removeSuggestion", "/PetAttack")
    RegisterKeyMapping("DropPet", "Drop Pet", "keyboard", "X") 
    RegisterCommand('DropPet', DropPet, false)
    TriggerEvent("chat:removeSuggestion", "/DropPet")     
    RegisterKeyMapping("PetSearch", "Pet Search", "keyboard", "H") 
    RegisterCommand('PetSearch', k9Search, false)
    TriggerEvent("chat:removeSuggestion", "/PetSearch")          
end)

-- [[Pet Shop Stuff]]
CreateThread(function()
    local petShopLocation = CircleZone:Create(vector3(562.75,2748.91,42.88), 20, {
        name = "petshoplocation",
        debugPoly = false,
    })

    petShopLocation:onPlayerInOut(function(isPointInside)
        if isPointInside then
            spawnShopNPC()
        else
            DeleteEntity(petShopNPC)
        end
    end)
end)

RegisterNetEvent('gl-pets:getPetMenu',function()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    exports['qb-menu']:openMenu({
        {
            header = "Pet Shop",
            txt = "Choose Category",
            isMenuHeader = true,
        },
        {
            header = "Dogs",
            txt = "Purchase a Dog",
            params = {
                event = "gl-pets:shopMenu",
                args = {
                    type = 'Dogs',
                },
            }
        },  
        {
            header = "Other",
            txt = "Purchase a Misc. Pet",
            params = {
                event = "gl-pets:shopMenu",
                args = {
                    type = 'Other',
                },
            }
        },       
        {
            header = "Accessories",
            txt = "Buy Pet Accessories",
            params = {
                event = "gl-pets:itemMenu",
            }
        }
    })
end)

RegisterNetEvent('gl-pets:itemMenu',function(hash, cost)
    local model = hash
    local price = cost

    exports['qb-menu']:openMenu({
        {
            header = "Tennisball",
            txt = "To play with",
            params = {
                event = "gl-pets:tryBuyItem",
                args = {
                    item = 'tennisball',
                    price = Config.TennisBallPrice,
                },
            }
        },  
        {
            header = "Frisbee",
            txt = "To play with",
            params = {
                event = "gl-pets:tryBuyItem",
                args = {
                    item = 'frisbee',
                    price = Config.FrisbeePrice,
                },
            }
        },  
        {
            header = "Pet Food",
            txt = "To feed your pet...",
            params = {
                event = "gl-pets:tryBuyItem",
                args = {
                    item = 'petfood',
                    price = Config.PetfoodPrice,
                },
            }
        },          
        {
            header = "Doghouse",
            txt = "Let your pet rest here...",
            params = {
                event = "gl-pets:tryBuyItem",
                args = {
                    item = 'doghouse',
                    price = Config.DoghousePrice,
                },
            }
        }
    })
end)

RegisterNetEvent('gl-pets:tryBuyItem',function(data)
    TriggerServerEvent('gl-pets:buyItem',data.item,data.price)
end)

RegisterNetEvent('gl-pets:shopMenu',function(data)
    petList = {}
    for k, v in pairs(Config.Pets) do
        if v.type == data.type then
            petList[#petList+1] = {
                header = v.label,  
                txt = "Price: $" .. v.price,
                params = {
                    event = "gl-pets:displayPet",
                    args = {
                        hash = v.model,
                        price = v.price,
                        variation = v.variations
                    },
                }
            }
        end
    end
    exports['qb-menu']:openMenu(petList)
end)

RegisterNetEvent('gl-pets:displayPet',function(data)
    if DoesEntityExist(displayPet) then
        DeleteEntity(displayPet)
    end
    local hash = GetHashKey(data.hash)
    local coords = vector3(566.49,2745.15,43.0)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    displayPet = CreatePed(28,hash,coords,true,false)
    SetEntityHeading(displayPet,97.06)
    SetBlockingOfNonTemporaryEvents(displayPet,true)
    FreezeEntityPosition(displayPet,true)
    SetPedComponentVariation(displayPet,4,0,0,0)
    totalVariation = data.variation -1
    displayModel = data.hash
    displayPrice = data.price
    if totalVariation > 0 then
        TriggerEvent('gl-pets:variationMenu')
    else
        TriggerEvent('gl-pets:purchasePet')
    end
    local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
    Wait(50)
    AttachCamToEntity(cam, displayPet, 0.0, 3.0, 0.0, true)
    Wait(50)
    SetCamRot(cam, 0.0, 0.0, -80.0,2)
    RenderScriptCams(true, false, 0, 1, 0)
    Wait(10000)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end)

RegisterNetEvent('gl-pets:variationMenu',function(hash,cost)
    local model = hash
    local price = cost
    exports['qb-menu']:openMenu({
        {
            header = "Pet Variations",
            txt = "Choose Color",
            isMenuHeader = true,
        },
        {
            header = "Next Variation",
            txt = "Next Pet Color",
            params = {
                event = "gl-pets:nextVariation",
            }
        },  
        {
            header = "Previous Variation",
            txt = "Previous Pet Color",
            params = {
                event = "gl-pets:previousVariation",
            }
        },          
        {
            header = "Purchase Variation",
            txt = "Purchase THIS Pet",
            params = {
                event = "gl-pets:purchasePet",
            }
        },  
        {
            header = "Back",
            txt = "<<<<<<",
            params = {
                event = "gl-pets:getPetMenu",
            }
        }
    })     
end)

RegisterNetEvent('gl-pets:purchasePet',function()
    exports['qb-menu']:openMenu({
        {
            header = "Purchase Pet?",
            txt = "Purchase Pet?",
            isMenuHeader = true,
        },
        {
            header = "I'd like to purchase this Pet.",
            txt = "Yes",
            params = {
                event = "gl-pets:tryPurchasePet",
            }
        },  
        {
            header = "I've changed my mind.",
            txt = "No",
            params = {
                event = "gl-pets:",
            }
        },          
        {
            header = "Back",
            txt = "<<<<<<",
            params = {
                event = "gl-pets:getPetMenu",
            }
        }
    })
end)

RegisterNetEvent('gl-pets:tryPurchasePet',function(data)
    local keyboard = exports['qb-input']:ShowInput({
        header = "Name Your Pet", 
        submitText = "Purchase",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'name',
                text = 'Name'
            }
        }
    })

    if keyboard ~= nil then
        TriggerServerEvent('gl-pets:buyPet',displayPrice,displayModel,displayVariation,keyboard.name)
    end
    
end)

RegisterNetEvent('gl-pets:nextVariation',function(data)
    if displayVariation >= totalVariation then
        displayVariation = 0
        SetPedComponentVariation(displayPet,4,0,displayVariation,0)
    else
        displayVariation = displayVariation + 1
        SetPedComponentVariation(displayPet,4,0,displayVariation,0)        
    end
    TriggerEvent('gl-pets:variationMenu')
end)

RegisterNetEvent('gl-pets:previousVariation',function(data)
    if displayVariation < 1 then
        displayVariation = totalVariation
        SetPedComponentVariation(displayPet,4,0,displayVariation,0)
    else
        displayVariation = displayVariation - 1
        SetPedComponentVariation(displayPet,4,0,displayVariation,0)
    end
    TriggerEvent('gl-pets:variationMenu')
end)
-- [[End Shop Stuff]]


--[[Pet Action]]
RegisterNetEvent('gl-pets:viewPet',function()
    exports['qb-menu']:openMenu({
        {
            header = "Pet Menu",
            txt = "Choose an option",
            isMenuHeader = true,
        },
        {
            header = "View Pets",
            txt = "Displays All Pets",
            params = {
                event = "gl-pets:getPets",
            }
        },  
        {
            header = "Pet Actions",
            txt = "Follow / Sit / Stay / Etc.",
            params = {
                event = "gl-pets:petActions",
            }
        },  
        {
            header = "Dismiss Pet",
            txt = "Sends Current Pet Home",
            params = {
                event = "gl-pets:dismissPet",
            }
        },      
        {
            header = "Inspect Pet",
            txt = "View Updated Pets Stats",
            params = {
                event = "gl-pets:inspectPet",
            }
        },
    })
end)

RegisterNetEvent('gl-pets:petActions',function()
    exports['qb-menu']:openMenu({
        {
            header = "Pet Menu",
            txt = "Choose an option",
            isMenuHeader = true,
        },
        {
            header = "Follow",
            txt = "Makes Pet Follow",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'follow'
                }
            }
        },  
        {
            header = "Sit",
            txt = "Makes Pet Sit",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'sit'
                }
            }
        },  
        {
            header = "Stay",
            txt = "Makes Pet Stay",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'stay'
                }
            }
        },      
        {
            header = "Lay Down",
            txt = "Makes Pet Lay Down",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'laydown'
                }
            }
        },  
        {
            header = "Beg",
            txt = "Makes Pet Beg",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'beg'
                }
            }
        },    
        {
            header = "Paw",
            txt = "Makes Pet Give Paw",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'paw'
                }
            }
        },                  
        {
            header = "Get In Car",
            txt = "Places Pet In Car",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'incar'
                }
            }
        },  
        {
            header = "Get Out Car",
            txt = "Places Pet Outside Car",
            params = {
                event = "gl-pets:petDoAction",
                args = {
                    action = 'outcar'
                }
            }
        },          
        {
            header = "Back",
            txt = "<<<<<<",
            params = {
                event = "gl-pets:viewPet",
            }
        }, 
    })
        TriggerEvent('nh-context:sendMenu', {
         
    })
end)

RegisterNetEvent('gl-pets:petDoAction',function(data)
    changePetState(data.action)
end)

RegisterNetEvent('gl-pets:getPets',function()
    QBCore.Functions.TriggerCallback("gl-pets:getAllPets", function(cb)
        local petMenu = {}
        if next(cb) ~= nil then
            for k, v in pairs(cb) do
                petMenu[k] = 
                {
                    header = "Pet: " .. v.name,
                    txt = "Stamina: " .. json.decode(v.stats).stam  .. " Obedience: " .. json.decode(v.stats).loyalty,
                    params = {
                        event = "gl-pets:callPet",
                        args = {
                            petID = v.id,
                            petName = v.name,
                            petModel = v.model,
                            petStam = json.decode(v.stats).stam,
                            petLoyalty = json.decode(v.stats).loyalty,
                            petHunger = json.decode(v.stats).hunger,
                            variation = v.variation
                        }
                    }
                }
            end
            exports['qb-menu']:openMenu(petMenu)
        end
    end)
end)

RegisterNetEvent('gl-pets:dismissPet',function()
    if DoesEntityExist(myPet) then
        local petsModel = GetEntityModel(myPet)
        local petTable = {petsModel}
        dismissedPettime = GetGameTimer()
        TaskWanderStandard(myPet,10.0,10)
        Wait(3000)
        DeleteEntity(myPet)
        local time = dismissedPettime - calledPetTime
        if petStam > 0 then
            time = time / 50000
            local minusHunger = time / 60000
            petStam = math.floor(petStam - time)
            petHunger = math.floor(petHunger - minusHunger)
            if petStam < 0 then
                petStam = 0
            end
        end
        local petStats = {loyalty = petLoyalty, stam = petStam, hunger = petHunger}
        TriggerServerEvent('gl-pets:updatePetStats',petStats,petID)
        exports['qb-target']:RemoveTargetModel(petTable, {'', '', '', ''})
    end
end)

RegisterNetEvent('gl-pets:callPet',function(data)
    petName = data.petName
    petStam = data.petStam
    petLoyalty = data.petLoyalty
    petHunger = data.petHunger
    petID = data.petID
    if petStam > 80 then
        petSpeed = 8.0
    elseif petStam > 40 and petStam < 79 then
        petSpeed = 5.0
    elseif petStam > 0 and petStam < 39 then
        petSpeed = 2.0
    end
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,-0.5))
    if not DoesEntityExist(myPet) then
        local hash = GetHashKey(data.petModel)
        QBCore.Functions.LoadModel(hash)
        QBCore.Functions.RequestAnimDict('taxi_hail')
        TaskPlayAnim(PlayerPedId(), 'taxi_hail','hail_taxi' ,8.0, -8, 1500, 16, 0, false, false, false)
        Wait(1500)
        myPet = CreatePed(28,hash,x, y, z,0,true,false)
        SetPedComponentVariation(myPet,4,0,tonumber(data.variation),0)
        changePetState('follow')
        calledPetTime = GetGameTimer()
        AddRelationshipGroup('Friendly')
        SetPedRelationshipGroupHash(myPet, GetHashKey('Friendly'))
        SetRelationshipBetweenGroups(0, GetHashKey('Friendly'),  GetHashKey('PLAYER'))  
        createPetZone()
    end

end)

RegisterNetEvent('gl-pets:k9ItemCheck',function(ItemCheck)
    local found = ItemCheck
    if found then
        QBCore.Functions.Notify('Your K9 has hit on something.', 'success', 5000)
        for k, v in pairs(Config.PetAnimations) do
            if v.model == GetEntityModel(myPet) then
                QBCore.Functions.RequestAnimDict(v.BarkDict)
                TaskPlayAnim(myPet, v.BarkDict,v.BarkAnim  ,8.0, -8, -1, 1, 0, false, false, false)
                Wait(5000)
                ClearPedTasks(myPet)
            end
        end
    else
        QBCore.Functions.Notify('Your K9 is not getting any hits.', 'error', 5000)
        TaskGoToEntity(myPet, PlayerPedId(), -1, 0.1, petSpeed, 1073741824.0, 0)
        SetPedKeepTask(myPet,true) 
    end
end)

RegisterNetEvent('gl-pets:playFetch',function()
    if DoesEntityExist(myPet) and not DoesEntityExist(ballObj) then
        ClearPedTasks(myPet)
        local ped = PlayerPedId()
        local hash = 'prop_tennis_ball'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,-1.0))
        QBCore.Functions.LoadModel(hash)
        ballObj = CreateObjectNoOffset(hash, x, y, z, true, false)
        SetModelAsNoLongerNeeded(hash)
        AttachEntityToEntity(ballObj, ped, GetPedBoneIndex(ped, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
        local forwardVector = GetEntityForwardVector(ped)
        local force = 50.0
        local animDict = "melee@unarmed@streamed_variations"
        local anim = "plyr_takedown_front_slap"
        ClearPedTasks(ped)
        QBCore.Functions.RequestAnimDict(animDict)
        TaskPlayAnim(ped, animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        Wait(500)
        DetachEntity(ballObj)
        ApplyForceToEntity(ballObj,1,forwardVector.x*force,forwardVector.y*force + 5.0,forwardVector.z,0,0,0,0,false,true,true,false,true)
        ballID = ObjToNet(ballObj)
        SetNetworkIdExistsOnAllMachines(ballObj,true)
        curPet = GetGameTimer()
        local doSomeMath = lastPet - curPet + 120000
        if lastPet == 0 or doSomeMath < 0 then
            lastPet = GetGameTimer()
            petLoyalty = petLoyalty + math.random(1,3)
        end
        playFetch()
    end
end)

RegisterNetEvent('gl-pets:playFrisbee',function()
    if DoesEntityExist(myPet) and not DoesEntityExist(ballObj) then
        ClearPedTasks(myPet)
        local ped = PlayerPedId()
        local hash = 'p_ld_frisbee_01'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,-1.0))
        QBCore.Functions.LoadModel(hash)
        ballObj = CreateObjectNoOffset(hash, x, y, z, true, false)
        SetModelAsNoLongerNeeded(hash)
        AttachEntityToEntity(ballObj, ped, GetPedBoneIndex(ped, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
        local forwardVector = GetEntityForwardVector(ped)
        local force = 150.0
        local animDict = "melee@unarmed@streamed_variations"
        local anim = "plyr_takedown_front_slap"
        ClearPedTasks(ped)
        QBCore.Functions.RequestAnimDict(animDict)
        TaskPlayAnim(ped, animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        Wait(500)
        DetachEntity(ballObj)
        ApplyForceToEntity(ballObj,1,forwardVector.x*force,forwardVector.y*force + 5.0,forwardVector.z,0,0,0,0,false,true,true,false,true)
        ballID = ObjToNet(ballObj)
        SetNetworkIdExistsOnAllMachines(ballObj,true)
        curPet = GetGameTimer()
        local doSomeMath = lastPet - curPet + 120000
        if lastPet == 0 or doSomeMath < 0 then
            lastPet = GetGameTimer()
            petLoyalty = petLoyalty + math.random(1,3)
        end
        playFetch()
    end
end)

RegisterNetEvent('gl-pets:placeDoghouse',function()
    if not DoesEntityExist(dogHouse) then
        local ped = PlayerPedId()
        local hash = GetHashKey('prop_doghouse_01')
        QBCore.Functions.LoadModel(hash)
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,1.0))
        QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
        TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        QBCore.Functions.Progressbar("place_doghouse", "Placing Dog House", 5000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@gangops@facility@servers@bodysearch@",
            anim = "player_search",
            flags = 48,
        }, {}, {}, function() 
            StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
            StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
            dogHouse = CreateObject(hash,x,y,z,true,false)
            PlaceObjectOnGroundProperly(dogHouse)
            Wait(50)
            exports['qb-target']:AddTargetEntity(dogHouse, {
                options = {
                    {
                        event = "gl-pets:pickUpHouse",
                        icon = "fas fa-hand-paper",
                        label = 'Pack Up',
                    },
                    {
                        event = "gl-pets:makePetRest",
                        icon = "fas fa-hand-paper",
                        label = 'Make Pet Rest',
                    },     
                    {
                        event = "gl-pets:finishResting",
                        icon = "fas fa-hand-paper",
                        label = 'Call Pet Out',
                    },              
                },
                distance = 1.5
            })
        end) 
    end
end)

RegisterNetEvent('gl-pets:pickUpHouse',function()
    local ped = PlayerPedId()
    QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false)
    QBCore.Functions.Progressbar("pickup_doghouse", "Picking Up Dog House", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@gangops@facility@servers@bodysearch@",
        anim = "player_search",
        flags = 48,
    }, {}, {}, function() 
        StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
        StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
        DeleteEntity(dogHouse)
    end) 
end)

RegisterNetEvent('gl-pets:makePetRest',function()
    if DoesEntityExist(myPet) then
        local petCoords = GetEntityCoords(myPet)
        local dHouse = GetEntityCoords(dogHouse)
        local dst = #(petCoords - dHouse)
        if dst < 3.0 then
            ClearPedTasks(myPet)
            FreezeEntityPosition(myPet,true)
            SetEntityCoords(myPet,dHouse.x - 0.20,dHouse.y - 0.10,dHouse.z)
            SetEntityHeading(myPet,99.91)
            petRest()
        end
    end
end)

RegisterNetEvent('gl-pets:finishResting',function()
    resting = false
    ClearPedTasks(myPet)
    FreezeEntityPosition(myPet,false)
    Wait(50)
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(myPet,0.0,1.0,0.0))
    SetEntityCoords(myPet,x,y,z)
    local finishTime = GetGameTimer()
    local dumbBoiMath = finishTime - restTime
    local time = dumbBoiMath / 15000
    petStam = math.floor(petStam + time)
    local petStats = {loyalty = petLoyalty, stam = petStam, hunger = petHunger}
    TriggerServerEvent('gl-pets:updatePetStats',petStats,petID)
end)

RegisterNetEvent('gl-pets:petPet',function()
    QBCore.Functions.Progressbar("petting", "Petting...", 3500, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "creatures@rottweiler@tricks@",
        anim = "petting_franklin",
        flags = 48,
    }, {}, {}, function() 
        StopAnimTask(PlayerPedId(), "creatures@rottweiler@tricks@", "petting_franklin", 1.0)
        curPet = GetGameTimer()
        local doSomeMath = lastPet - curPet + 120000
        if lastPet == 0 or doSomeMath < 0 then
            lastPet = GetGameTimer()
            petLoyalty = petLoyalty + math.random(1,3)
        end
    end)
end)

RegisterNetEvent('gl-pets:inspectPet',function()
    local curPetTime = GetGameTimer()
        
    local time = curPetTime - calledPetTime
    local minusHunger = time / 60000
    time = time / 50000
    if petStam > 0 and time > 2 then
    petStam = math.floor(petStam - time)
        if petStam < 0 then
            petStam = 0
        end
    end
    if petHunger > 0 and minusHunger > 2 then
        petHunger = math.floor(petHunger - minusHunger)
        if petHunger < 0 then
            petHunger = 0
        end
    end
    calledPetTime = GetGameTimer()
    
    exports['qb-menu']:openMenu({
        {
            header = petName,
            txt = "Current Status",
            isMenuHeader = true,
        },
        {
            header = "Stamina",
            txt = "Current Stamina: " .. petStam,
        },  
        {
            header = "Obedience",
            txt = "Current Obedience: " .. petLoyalty,
        },  
        {
            header = "Hunger",
            txt = "Current Hunger: " .. petHunger,
        },      
        {
            header = "Back",
            txt = "<<<<<<",
            params = {
                event = "gl-pets:viewPet",
            }
        }
    })
end)

RegisterNetEvent('gl-pets:giveTreat',function()
    local closest, closestC = GetNearbyPet()
    if GetEntityModel(closest) == GetEntityModel(myPet) and closestC < 2 then
        local ped = PlayerPedId()
        QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
        TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false)
        QBCore.Functions.Progressbar("giving_treat", "Giving A Treat...", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@nightclub@djs@dixon@",
            anim = "dixn_dance_cntr_open_dix",
            flags = 48,
        }, {}, {}, function() 
            StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
            StopAnimTask(ped, "anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", 1.0)
            local hash = 'prop_turkey_leg_01'
            local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0,1.0,-1.0))
            QBCore.Functions.LoadModel(hash)
            local dogTreat = CreateObjectNoOffset(hash, x, y, z, true, false)
            AttachEntityToEntity(dogTreat, myPet, GetPedBoneIndex(myPet, 12844), 0.28, -0.05, -0.07, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            for k, v in pairs(Config.PetAnimations) do
                if v.model == GetEntityModel(myPet) then
                    QBCore.Functions.RequestAnimDict(v.BarkDict)
                    TaskPlayAnim(myPet, v.BarkDict,v.BarkAnim ,8.0, -8, -1, 1, 0, false, false, false)
                end
            end
            Wait(2500)
            DeleteEntity(dogTreat)
            ClearPedTasks(myPet)
        end)   
    end
end)

RegisterNetEvent('gl-pets:feedPet',function()
    if not DoesEntityExist(bowlObj) and DoesEntityExist(myPet) then
        local ped = PlayerPedId()
        QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
        TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false)
        QBCore.Functions.Progressbar("feed", "Feeding...", 5000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@gangops@facility@servers@bodysearch@",
            anim = "player_search",
            flags = 48,
        }, {}, {}, function() 
            StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
            StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
            local hash = 'prop_bowl_crisps'
            local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
            QBCore.Functions.LoadModel(hash)
            bowlObj = CreateObjectNoOffset(hash, x, y, z, true, false)
            PlaceObjectOnGroundProperly(bowlObj)
            SetModelAsNoLongerNeeded(hash)
            TaskGoToEntity(myPet, bowlObj, -1, 1.0, petSpeed, 1073741824.0, 0)
            Wait(5000)
            DeleteEntity(bowlObj)
            petHunger = petHunger + 50
            if petHunger > 100 then
                petHunger = 100
            end
            local petStats = {loyalty = petLoyalty, stam = petStam, hunger = petHunger}
            TriggerServerEvent('gl-pets:updatePetStats',petStats,petID)
        end)  
    end
end)

RegisterNetEvent('gl-pets:carryPet',function()
    local closest, closestC = GetNearbyPet()
    if GetEntityModel(closest) == GetEntityModel(myPet) and closestC < 2 then
        carryPet()
    end
end)
--[[End Pet Actions]]