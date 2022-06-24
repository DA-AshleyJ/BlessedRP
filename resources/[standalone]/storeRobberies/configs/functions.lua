function round(number, decimals) --Used to round distances. Was taken from stack overflow for ease.
    local power = 10^decimals
    return math.floor(number * power) / power
end

function randomFloat(lower, greater) --Used to make float randoms. Was taken from stack overflow for ease.
    return lower + math.random()  * (greater - lower);
end


loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function DrawText3D(x,y,z, text) --Just a simple generic 3d text function. Copy pasted from my own core. Feel free to change the 3d text here. You got x,y,z and text.
    globalWait = 10
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
      end
end

function takeAnim() --This function is used to do the take animation when cracking the register or safebox.
    local ped = GetPlayerPed(-1)
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(100)

    Citizen.CreateThread(function()
        while (IsEntityPlayingAnim(globalPlayerPed, "amb@prop_human_bum_bin@idle_b", "idle_d", 3)) do
            DisableAllControlActions(0)
            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
    RemoveAnimDict("amb@prop_human_bum_bin@idle_b")
end

function LockpickAnim() --This function is used to do the lockpicking animation while cracking the register.
    loadDict("veh@break_in@0h@p_m_one@")
    Citizen.CreateThread(function()
        while lockpicking and not registering do
            if(not IsEntityPlayingAnim(globalPlayerPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3))then
                TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            end
            Citizen.Wait(100)
        end
        StopAnimTask(GetPlayerPed(-1), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
    end)
end

function _CreatePed(hash, coords, heading) --This function is used to spawn the ped.
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedDropsWeaponsWhenDead(ped, false)
    FreezeEntityPosition(ped, false)
    return ped
end

function fightBack_function(i, safe)

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

    copsCalled = true

    if(safe == nil)then
        safe = false
    end

    TriggerServerEvent("storeRobberies:server:fightBack", currentStore, safe, GetPlayerServerId(globalPlayerId))
end

function pedTalk()
    SetFacialIdleAnimOverride(ped, "mood_angry_1")
    PlayAmbientSpeech1(ped, "Chat_State", "Speech_Params_Force")
end

function lockpick(bool)
    lockpicking = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
    uiOpen = bool
end