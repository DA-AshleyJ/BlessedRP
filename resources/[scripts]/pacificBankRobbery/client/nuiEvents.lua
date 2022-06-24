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

RegisterNUICallback('success', function()
    lockpick(false)
    TriggerServerEvent("pacificBankRobbery:server:breakDoor", globalClosestDoor)
end)

RegisterNUICallback('fail', function()
    lockpick(false)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('exit', function()
    lockpick(false)
    SetNuiFocus(false, false)
end) 