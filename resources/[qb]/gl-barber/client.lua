QBCore = exports['qb-core']:GetCoreObject()

local oldHair, hair, woop, patron = 0, 0, 0, 0
local isBarber, npcSpawned, onDutyBarber = false, false, false
local NPC
PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

CreateThread(function()
        
        blip = AddBlipForCoord(-814.3, -183.8, 36.6)
        SetBlipSprite(blip, 71)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Soul Glo Salon")
        EndTextCommandSetBlipName(blip)
        
        
        exports['qb-target']:AddTargetModel('v_ilev_hd_chair', {
            options = {
                {
                    event = "gl-barber:sitChair",
                    icon = "fas fa-chair",
                    label = "Sit In Chair",
                },
                {
                    event = "gl-barber:getPatron",
                    icon = "fas fa-cut",
                    label = "Cut Hair (Barber)",
                    job = "barber",
                },
            
            },
            distance = 2.5
        })
        
        while true do
            Wait(1000)
            local simCoords = vector3(-822.75, -183.81, 36.57)
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dst = #(simCoords - pedCoords)
            if dst < 200 and npcSpawned == false then
                TriggerEvent('gl-barber:spawnNPC', simCoords, 211.73)
                npcSpawned = true
            end
            if dst >= 201 then
                npcSpawned = false
                DeleteEntity(NPC)
            end
        
        end
end)

-- Spawn Boss NPC
RegisterNetEvent('gl-barber:spawnNPC', function(coords, heading)
    local hash = GetHashKey('s_m_m_hairdress_01')
    QBCore.Functions.LoadModel(hash)
    NPC = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(NPC, true)
    SetEntityInvincible(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    SetModelAsNoLongerNeeded(hash)
    TaskStartScenarioInPlace(NPC, 'WORLD_HUMAN_HANG_OUT_STREET')
    exports['qb-target']:AddEntityZone('NPC', NPC, {
        name = "NPC",
        debugPoly = false,
        useZ = true
    }, {
        options = {
            {
                event = 'gl-barber:clockIn',
                icon = "fas fa-clipboard",
                label = "Clock In (Barber)",
                job = "barber",
            },
            {
                event = 'gl-barber:viewBarberList',
                icon = "fas fa-cut",
                label = "View Barbers",
            },
        },
        distance = 2.5
    })
end)

local activeBarber = {}
local id = 0
RegisterNetEvent('gl-barber:clockIn', function()
    if PlayerJob.name == "barber" then
        local barber = exports['qb-input']:ShowInput({
            header = "Enter name/Number",
            submitText = "Enter",
            inputs = {
                {
                    type = 'text',
                    isRequired = true,
                    name = 'name',
                    text = 'Name'
                },
                {
                    type = 'number',
                    isRequired = true,
                    name = 'phone',
                    text = 'Phone Number'
                }
            }
        })
        
        if barber then
            if not barber.name or not barber.phone then return end
            TriggerServerEvent('gl-barber:updateBarberListS', barber.name, barber.phone)
        end
    end
end)

RegisterNetEvent('gl-barber:updateBarberListC', function(name, number)
    onDutyBarber = true
    activeBarber[#activeBarber + 1] = {
        header = name,
        txt = 'Phone Number: ' .. number,
    }
end)

RegisterNetEvent('gl-barber:viewBarberList', function()
    if onDutyBarber then
        exports['qb-menu']:openMenu(activeBarber)
    else
        QBCore.Functions.Notify('No Barbers Clocked In', 'error')
    end
end)

RegisterNetEvent('gl-barber:getPatron', function()
    if PlayerJob.name == "barber" then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance <= 1.0 then
            SetPlayerCanUseCover(PlayerId(), false)
            isBarber = true
            TriggerServerEvent('gl-barber:sendPatron', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
        else
            QBCore.Functions.Notify('No Patron close by', 'error')
        end
    end
end)

local color, oldColor = 0, 0
local highlight, oldHighlight = 0, 0

RegisterNetEvent('gl-barber:sendPatronClient', function(patronID)
    patron = GetPlayerFromServerId(patronID)
    woop = GetPlayerPed(patron)
    oldHair = GetPedDrawableVariation(woop, 2)
    oldHighlight = GetPedHairHighlightColor(woop)
    oldColor = GetPedHairColor(woop)
    hair = oldHair
    highlight = oldHighlight
    color = oldColor
end)

RegisterNetEvent('gl-barber:changeHair', function(woop, hair, highlight, color)
    woop3 = NetToPed(woop)
    exports['fivem-appearance']:setPedHair(woop3, {style = hair, highlight = highlight, color = color})
end)

RegisterNetEvent('gl-barber:saveHair', function()
    local appearance = exports['fivem-appearance']:getPedAppearance(PlayerPedId())
    TriggerServerEvent('fivem-appearance:save', appearance)
end)

CreateThread(function()
    RegisterKeyMapping("BarberUp", "Up Cut", "keyboard", "UP")
    RegisterCommand('BarberUp', BarberUp, false)
    TriggerEvent("chat:removeSuggestion", "/BarberUp")
    RegisterKeyMapping("BarberDown", "BarberDown", "keyboard", "DOWN")
    RegisterCommand('BarberDown', BarberDown, false)
    TriggerEvent("chat:removeSuggestion", "/BarberDown")
    RegisterKeyMapping("FinishCut", "FinishCut", "keyboard", "RETURN")
    RegisterCommand('FinishCut', FinishCut, false)
    TriggerEvent("chat:removeSuggestion", "/FinishCut")
    RegisterKeyMapping("CancelCut", "CancelCut", "keyboard", "ESCAPE")
    RegisterCommand('CancelCut', CancelCut, false)
    TriggerEvent("chat:removeSuggestion", "/CancelCut")
    RegisterKeyMapping("GetOutChair", "GetOutChair", "keyboard", "X")
    RegisterCommand('GetOutChair', GetOutChair, false)
    TriggerEvent("chat:removeSuggestion", "/GetOutChair")
    RegisterKeyMapping("HighlightUp", "HighlightUp", "keyboard", "E")
    RegisterCommand('HighlightUp', HighlightUp, false)
    TriggerEvent("chat:removeSuggestion", "/HighlightUp")
    RegisterKeyMapping("HighlightDown", "HighlightDown", "keyboard", "Q")
    RegisterCommand('HighlightDown', HighlightDown, false)
    TriggerEvent("chat:removeSuggestion", "/HighlightDown")
    RegisterKeyMapping("ColorUp", "ColorUp", "keyboard", "RIGHT")
    RegisterCommand('ColorUp', ColorUp, false)
    TriggerEvent("chat:removeSuggestion", "/ColorUp")
    RegisterKeyMapping("ColorDown", "ColorDown", "keyboard", "LEFT")
    RegisterCommand('ColorDown', ColorDown, false)
    TriggerEvent("chat:removeSuggestion", "/ColorDown")
end)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    
    -- draw it once to set up layout
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)
    
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, 187, true))
    ButtonMessage("Previous Hairstyle")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, 188, true))-- The button to display
    ButtonMessage("Next Hairstyle")-- the message to display next to it
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(2, 153, true))
    ButtonMessage("Previous Hightlight Color")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, 152, true))
    ButtonMessage("Next Highlight Color")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, 189, true))
    ButtonMessage("Previous Hair Color")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    Button(GetControlInstructionalButton(2, 190, true))
    ButtonMessage("Next Hair Color")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(6)
    Button(GetControlInstructionalButton(2, 202, true))
    ButtonMessage("Cancel")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(7)
    Button(GetControlInstructionalButton(2, 201, true))
    ButtonMessage("Cut Hair")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    
    return scaleform
end

CreateThread(function()
    form = setupScaleform("instructional_buttons")
    while true do
        Citizen.Wait(0)
        if isBarber then
            DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
        end
    end
end)

function GetOutChair()
    if inChair then
        inChair = false
        local playerCoords = GetEntityCoords(PlayerPedId())
        SetEntityCollision(PlayerPedId(), true)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), playerCoords.x, playerCoords.y - 1, playerCoords.z)
        ClearPedTasks(PlayerPedId())
    end
end

SetEntityCollision(PlayerPedId(), true)
FreezeEntityPosition(PlayerPedId(), false)

function ColorUp()
    if isBarber then
        color = color + 1
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:changeCut', woop2, hair, highlight, color)
    --SetPedComponentVariation(woop, 2, hair, 0, 0)
    end
end

function ColorDown()
    if isBarber then
        color = color - 1
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:changeCut', woop2, hair, highlight, color)
    --SetPedComponentVariation(woop, 2, hair, 0, 0)
    end
end

function HighlightUp()
    if isBarber then
        highlight = highlight + 1
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:changeCut', woop2, hair, highlight, color)
    --SetPedComponentVariation(woop, 2, hair, 0, 0)
    end
end

function HighlightDown()
    if isBarber then
        highlight = highlight - 1
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:changeCut', woop2, hair, highlight, color)
    --SetPedComponentVariation(woop, 2, hair, 0, 0)
    end
end


function BarberUp()
    if isBarber then
        hair = hair + 1
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:changeCut', woop2, hair, highlight, color)
    --SetPedComponentVariation(woop, 2, hair, 0, 0)
    end
end

function BarberDown()
    if isBarber then
        hair = hair - 1
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:changeCut', woop2, hair, highlight, color)
    --SetPedComponentVariation(woop, 2, hair, 0, 0)
    end
end
function CancelCut()
    if isBarber then
        SetPlayerCanUseCover(PlayerId(), true)
        isBarber = false
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:changeCut', woop2, oldHair, oldHighlight, oldColor)
    end
end

function FinishCut()
    if isBarber then
        SetPlayerCanUseCover(PlayerId(), true)
        local player = PlayerPedId()
        propHash = 'prop_cs_scissors'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.5))
        QBCore.Functions.LoadModel(propHash)
        scissors = CreateObjectNoOffset(propHash, x, y, z, true, false)
        SetModelAsNoLongerNeeded(propHash)
        AttachEntityToEntity(scissors, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, 0.0, -0.02, 0, 0.0, 0.0, true, true, false, true, 1, true)-- object is attached to right hand
        
        QBCore.Functions.RequestAnimDict("misshair_shop@barbers")
        TaskPlayAnim(player, "misshair_shop@barbers", "keeper_idle_b", 8.0, 8.0, 15000, 16, 0, false, false, false)
        Wait(3000)
        
        isBarber = false
        woop2 = PedToNet(woop)
        TriggerServerEvent('gl-barber:finishCut', GetPlayerServerId(woop2))
        Wait(8000)
        DeleteEntity(scissors)
        propHash = 'ng_proc_brkbottle_02g'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.5, 0.5, 0.5))
        QBCore.Functions.LoadModel("propHash")
        hairOnGround = CreateObjectNoOffset(propHash, x, y, z, true, false)
        PlaceObjectOnGroundProperly(hairOnGround)
        SetModelAsNoLongerNeeded(propHash)
        Wait(10000)
        DeleteEntity(hairOnGround)
    end
end

RegisterNetEvent('gl-barber:sitChair', function()
    inChair = true
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey("v_ilev_hd_chair"), false)
    local objCoords = GetEntityCoords(closestObject)
    local objHeading = GetEntityHeading(closestObject)
    SetEntityHeading(PlayerPedId(), 29.36)
    SetEntityCoords(PlayerPedId(), objCoords.x, objCoords.y, objCoords.z - .4)
    SetEntityCollision(PlayerPedId(), false)
    
    FreezeEntityPosition(PlayerPedId(), true)
    TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER')
end)
