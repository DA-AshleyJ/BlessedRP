RegisterNUICallback('success', function()
    if currentStore ~= 0 then
        lockpick(false)
        lockpicking = true
        registering = true
        takeAnim()
        PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
        TriggerServerEvent("storeRobberies:server:registerOpen", currentStore)
        TriggerServerEvent("storeRobberies:server:registerMoney", GetPlayerServerId(globalPlayerId), currentStore, serverKeyGen)
        Citizen.Wait(500)
        lockpicking = false
        registering = false
        Citizen.Wait(200)
        TriggerServerEvent("storeRobberies:server:registerBusy", currentStore, false)
    else
        lockpick(false)
        Citizen.Wait(500)
        TriggerServerEvent("storeRobberies:server:registerBusy", currentStore, false)
    end
end)

RegisterNUICallback('callcops', function()
end)

RegisterNUICallback('PadLockSuccess', function()
    Citizen.Wait(1000)
    safeboxing = false
    Citizen.Wait(200)
    TriggerServerEvent("storeRobberies:server:safeBusy", currentStore, false)
end)

RegisterNUICallback('PadLockClose', function()
    SetNuiFocus(false, false)
    Citizen.Wait(1000)
    safeboxing = false
    Citizen.Wait(200)
    TriggerServerEvent("storeRobberies:server:safeBusy", currentStore, false)
end)

RegisterNUICallback("CombinationFail", function(data, cb)
    Citizen.Wait(1000)
    safeboxing = false
    Citizen.Wait(200)
    TriggerServerEvent("storeRobberies:server:safeBusy", currentStore, false)
end)

RegisterNUICallback('fail', function()
    lockpick(false)
    SetNuiFocus(false, false)
    Citizen.Wait(500)
    TriggerServerEvent("storeRobberies:server:registerBusy", currentStore, false)
end)

RegisterNUICallback('exit', function()
    lockpick(false)
    SetNuiFocus(false, false)
    Citizen.Wait(500)
    TriggerServerEvent("storeRobberies:server:registerBusy", currentStore, false)
end)

RegisterNUICallback('TryCombination', function(data, cb)
        if tonumber(data.combination) ~= nil then
            if tonumber(data.combination) == Config.Shops[currentStore].safeCode then
                PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = false,
                })
                takeAnim()
                TriggerServerEvent("storeRobberies:server:safeMoney", GetPlayerServerId(globalPlayerId), currentStore, serverKeyGen)
                Citizen.Wait(200)
                TriggerServerEvent("storeRobberies:server:safeOpen", currentStore)
            else
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = true,
                })
            end
        end
        Citizen.Wait(1000)
        safeboxing = false
        Citizen.Wait(200)
        TriggerServerEvent("storeRobberies:server:safeBusy", currentStore, false)
end)    