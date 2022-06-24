local QBCore = exports['qb-core']:GetCoreObject()
local playerTeam = nil
local isInMatch = false
local sex = 'men'
local mask, jacket, pants = 0,0,0
local tmask, tjacket, tpants = 0,0,0
local paintballNPC
local isPaintSpawned = false
local oldarena = nil
local newarena = nil

Citizen.CreateThread(function()
        blip = AddBlipForCoord(-769.22,5595.29,32.49)
        SetBlipSprite(blip, 366)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Paint Ball")
        EndTextCommandSetBlipName(blip)
    while true do
        Citizen.Wait(1000)
        local paintballNPCCoords = vector3(-769.22,5595.29,32.49)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dst = #(paintballNPCCoords - pedCoords)
        if dst < 200 and isPaintSpawned == false then
            TriggerEvent('gl-paintball:spawnNPC',paintballNPCCoords,171.85)
            isPaintSpawned = true
        end
        if dst >= 201  then
            isPaintSpawned = false
            DeleteEntity(paintballNPC)
        end
    end
end)

-- Spawn Boss NPC
RegisterNetEvent('gl-paintball:spawnNPC')
AddEventHandler('gl-paintball:spawnNPC',function(coords,heading)
    local hash = GetHashKey('s_m_m_hairdress_01')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    paintballNPC = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(paintballNPC, true)
    SetEntityInvincible(paintballNPC, true)
    SetBlockingOfNonTemporaryEvents(paintballNPC, true)
    SetModelAsNoLongerNeeded(hash)
    if DoesEntityExist(paintballNPC) then
        exports['qb-target']:AddEntityZone('paintballNPC', paintballNPC, {
        name="paintballNPC",
        debugPoly=false,
        useZ = true
        }, {
        options = {
            {
            event = 'gl-paintball:buyGun',
            icon = "fas fa-clipboard",
            label = "Buy Gun for " .. Config.GunPrice,
            },
            {
            event = 'gl-paintball:joinBlue',
            icon = "fas fa-clipboard",
            label = "Join Blue Team",
            },
            {
            event = 'gl-paintball:joinRed',
            icon = "fas fa-clipboard",
            label = "Join Red Team",
            },
            {
            event = 'gl-paintball:startGame',
            icon = "fas fa-clipboard",
            label = "Start Game",
            },
        },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('gl-paintball:buyGun',function()
    TriggerServerEvent('gl-paintball:buyGun')
end)

RegisterNetEvent('gl-paintball:tpToLocation',function(arena)
    TriggerEvent("swt_notifications:caption",'Starting!',"Game is starting in 10 seconds . . .",'top',10000,'blue-10','grey-1',true)
    newarena = arena
    Wait(10000)
    mask = GetPedDrawableVariation(PlayerPedId(),1)
    tmask = GetPedTextureVariation(PlayerPedId(),1)
    pants = GetPedDrawableVariation(PlayerPedId(),4)
    tpants = GetPedTextureVariation(PlayerPedId(),4)
    jacket = GetPedDrawableVariation(PlayerPedId(),11)
    tjacket = GetPedTextureVariation(PlayerPedId(),11)
    inMatch()
    isInMatch = true
    if IsPedModel(PlayerPedId(),GetHashKey('mp_m_freemode_01')) then
        sex = "men"
    elseif IsPedModel(PlayerPedId(),GetHashKey('mp_f_freemode_01')) then
        sex = "women"
    end
    if playerTeam == 'redteam' then
        if sex == 'men' then
            SetPedComponentVariation(PlayerPedId(),1,139,0)
            SetPedComponentVariation(PlayerPedId(),4,3,5)
            SetPedComponentVariation(PlayerPedId(),11,146,3)
        else
            SetPedComponentVariation(PlayerPedId(),1,127,0)
            SetPedComponentVariation(PlayerPedId(),4,55,7)
            SetPedComponentVariation(PlayerPedId(),11,148,3)
        end
        SetEntityCoords(PlayerPedId(),Config.RedTeamLoc)
        FreezeEntityPosition(PlayerPedId(),true)
        Wait(5000)
        FreezeEntityPosition(PlayerPedId(),false)
    else
        if sex == 'men' then
            SetPedComponentVariation(PlayerPedId(),1,139,2)
            SetPedComponentVariation(PlayerPedId(),4,3,3)
            SetPedComponentVariation(PlayerPedId(),11,146,4)
        else
            SetPedComponentVariation(PlayerPedId(),1,127,2)
            SetPedComponentVariation(PlayerPedId(),4,55,1)
            SetPedComponentVariation(PlayerPedId(),11,148,4)
        end
        SetEntityCoords(PlayerPedId(),Config.BlueTeamLoc)
        FreezeEntityPosition(PlayerPedId(),true)
        Wait(5000)
        FreezeEntityPosition(PlayerPedId(),false)
    end
end)


RegisterNetEvent('gl-paintball:joinedTeam',function(team)
    playerTeam = team
    QBCore.Functions.Notify('You joined the'..playerTeam, 'success')
end)

RegisterNetEvent('gl-paintball:startGame',function(team)
    TriggerServerEvent('gl-paintball:startGame')
end)

RegisterNetEvent('gl-paintball:joinRed',function()
    if playerTeam == nil then
        TriggerServerEvent('gl-paintball:register','redteam')
    else
        QBCore.Functions.Notify('Already on a team', 'error')
    end
end)

RegisterNetEvent('gl-paintball:joinBlue',function()
    TriggerServerEvent('gl-paintball:register','blueteam')
end)

RegisterNetEvent('gl-paintball:removeFromArena',function()
    playerTeam = nil
    SetEntityCoords(PlayerPedId(),Config.StartLoc)
    SetPedComponentVariation(PlayerPedId(),1,mask,tmask)
    SetPedComponentVariation(PlayerPedId(),4,pants,tpants)
    SetPedComponentVariation(PlayerPedId(),11,jacket,tjacket)
end)

---[[
RegisterCommand('joinr',function()
TriggerServerEvent('gl-paintball:register','redteam')

end)

RegisterCommand('joinb',function()
TriggerServerEvent('gl-paintball:register','blueteam')

end)

RegisterCommand('startGame',function()
    TriggerServerEvent('gl-paintball:startGame')
end)
--]]


function inMatch()
    CreateThread(function()
        -- New Arena : 2800.00 -3800.00 100.00
        RequestIpl("xs_arena_interior")
        DisableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), "Set_Dystopian_Scene")
        DisableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), 'Set_Dystopian_02')
        DisableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), 'Set_Dystopian_04')
        DisableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), 'Set_Dystopian_07')
        DisableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), oldarena)
        EnableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), "Set_Crowd_A")
        EnableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), "Set_Crowd_B")
        EnableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), "Set_Crowd_C")
        EnableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), "Set_Crowd_D")
        EnableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), "Set_Dystopian_Scene")
        EnableInteriorProp(GetInteriorAtCoords(2800.000, -3800.000, 100.000), newarena)
        print(oldarena)
        oldarena = newarena
        while isInMatch do
            Wait(0)
            if IsPedBeingStunned(PlayerPedId()) then
                isInMatch = false
                TriggerServerEvent('gl-paintball:gotShot',playerTeam)
            end
        end
    end)
end