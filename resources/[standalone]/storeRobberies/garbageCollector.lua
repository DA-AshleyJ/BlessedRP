Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        collectgarbage("collect")
    end 
end)

Citizen.CreateThread(function()
    while true do
        globalPlayerPedId = PlayerPedId()
        globalPlayerPed = GetPlayerPed(-1)
        globalPlayerId = PlayerId()
        Citizen.Wait(3000)
    end
end)
Citizen.CreateThread(function()
    while true do
        globalIsPedArmed = IsPedArmed(globalPlayerPedId, 7)
        globalIsPedMeleeArmed = IsPedArmed(globalPlayerPedId, 1)
        globalIsPlayerFreeAiming = IsPlayerFreeAiming(globalPlayerId)
        globalPlayerCoords = GetEntityCoords(globalPlayerPed)
        Citizen.Wait(250)
    end
end)