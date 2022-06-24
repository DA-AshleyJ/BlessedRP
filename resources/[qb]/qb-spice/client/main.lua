local QBCore = exports['qb-core']:GetCoreObject()

local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local spicepicking = false
local spiceprocess = false
local nearDealer = false

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance = #(PlayerPos - vector3(2466.19, 3784.87, 41.66))
        
        if distance < 6 then
            inRange = true

            if distance < 2 then
                DrawText3Ds(2466.19, 3784.87, 41.66, "[G] Process spice Leaf")
                if IsControlJustPressed(0, 47) then
                    TriggerServerEvent("qb-spice:server:grindleaves")

                end
            end
            
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance1 = #(PlayerPos - vector3(2976.82, 3970.32, 56.05))
        local distance2 = #(PlayerPos - vector3(2982.95, 3972.83, 56.49))
        local distance3 = #(PlayerPos - vector3(2987.94, 3985.09, 55.24))
        
        if distance1 < 15 then
            inRange = true

            if distance1 < 2 then
                DrawText3Ds(2976.82, 3970.32, 56.05, "[G] Start Picking")
                if IsControlJustPressed(0, 47) then
                    PrepareAnim()
                    PickMinigame()
                end
            end

            if distance2 < 2 then
                DrawText3Ds(2982.95, 3972.83, 56.49, "[G] Start Picking")
                if IsControlJustPressed(0, 47) then
                    PrepareAnim()
                    PickMinigame()
                end
            end

            if distance3 < 2 then
                DrawText3Ds(2987.94, 3985.09, 55.24, "[G] Start Picking")
                if IsControlJustPressed(0, 47) then
                    PrepareAnim()
                    PickMinigame()
                end
            end
            
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

RegisterNetEvent('qb-spice:client:grindleavesMinigame')
AddEventHandler('qb-spice:client:grindleavesMinigame', function(source)
    PrepareProcessAnim()
    ProcessMinigame(source)
end)

RegisterNetEvent('qb-spice:client:processCrack')
AddEventHandler('qb-spice:client:processCrack', function(source)
    ProcessCrackMinigame(source)
end)

function pickProcess()
    QBCore.Functions.Progressbar("grind_spice", "Picking spice Leaves ..", math.random(20000,30000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("qb-spice:server:getleaf")
        ClearPedTasks(PlayerPedId())
        spicepicking = false
    end, function() -- Cancel
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
    end)
end

function spiceProcess()
    QBCore.Functions.Progressbar("grind_spice", "Process spice Leaves ..", math.random(10000, 12000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("qb-spice:server:getspice")
        ClearPedTasks(PlayerPedId())
        spicepicking = false
    end, function() -- Cancel
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
    end)
end

function PickMinigame()
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
        -- NeededAttempts = 1
    end

    local maxwidth = 30
    local maxduration = 3500

    Skillbar.Start({
        duration = math.random(1000, 3000),
        pos = math.random(10, 30),
        width = math.random(10, 20),
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then
            pickProcess()
            QBCore.Functions.Notify("You picked a spice leaf", "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1000, 3000),
                pos = math.random(10, 30),
                width = math.random(10, 20),
            })
        end
                
        
	end, function()

            QBCore.Functions.Notify("You messed up the spice leaf!", "error")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            spicepicking = false
       
    end)
end

function ProcessMinigame(source)
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
        -- NeededAttempts = 1
    end

    local maxwidth = 30
    local maxduration = 3000

    Skillbar.Start({
        duration = math.random(1000, 3000),
        pos = math.random(10, 30),
        width = math.random(15, 25),
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then
            spiceProcess()
            QBCore.Functions.Notify("You make some spice!", "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(1000, 3000),
                pos = math.random(10, 30),
                width = math.random(10, 20),
            })
        end
                
        
	end, function()

            QBCore.Functions.Notify("You messed up the process!", "error")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            spiceprocess = false
       
    end)
end

function PrepareProcessAnim()
    local ped = PlayerPedId()
    LoadAnim('mini@repair')
    TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    -- TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    PreparingProcessAnimCheck()
end

function PreparingProcessAnimCheck()
    spiceprocess = true
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if spiceprocess then
                -- if not TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true) then
                --     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                -- end
            else
                ClearPedTasksImmediately(ped)
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function PrepareAnim()
    local ped = PlayerPedId()
    -- LoadAnim('amb@prop_human_bbq@male@idle_a')
    -- TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    PreparingAnimCheck()
end

function ProcessPrepareAnim()
    local ped = PlayerPedId()
    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    -- TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    PreparingAnimCheck()
end

function PreparingAnimCheck()
    spicepicking = true
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if spicepicking then
                -- if not TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true) then
                --     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                -- end
            else
                ClearPedTasksImmediately(ped)
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function knockDealerDoor()
    local hours = GetClockHours()
    local min = 9
    local max = 21

    if hours >= min and hours <= max then
        knockDoorAnim(true)
    else
        knockDoorAnim(false)
    end
end

function knockDoorAnim(home)
    local knockAnimLib = "timetable@jimmy@doorknock@"
    local knockAnim = "knockdoor_idle"
    local PlayerPed = PlayerPedId()
    local myData = QBCore.Functions.GetPlayerData()

    if home then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Citizen.Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Citizen.Wait(100)
        end
        knockingDoor = true
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Citizen.Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        knockingDoor = false
        Citizen.Wait(1000)
        dealerIsHome = true
        -- TriggerEvent("chatMessage", "Dealer Johnny", "normal", 'Yo '..myData.charinfo.firstname..', damn you got ')
        TriggerServerEvent("qb-spice:server:spicesell")

        -- knockTimeout()
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Citizen.Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Citizen.Wait(100)
        end
        knockingDoor = true
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Citizen.Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        knockingDoor = false
        Citizen.Wait(1000)
        QBCore.Functions.Notify('It seems that no one is home..', 'error', 3500)
    end
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end