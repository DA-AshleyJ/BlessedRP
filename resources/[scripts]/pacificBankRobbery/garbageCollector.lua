Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        collectgarbage("collect")
    end 
end)

Citizen.CreateThread(function()

    globalPlayerPedId = PlayerPedId()
    globalPlayerPed = GetPlayerPed(-1)
    globalPlayerId = PlayerId()

    while true do
        if(inPoly)then
            globalPlayerPedId = PlayerPedId()
            globalPlayerId = PlayerId()
            Citizen.Wait(3000)
        else
            globalPlayerPed = GetPlayerPed(-1)
            Citizen.Wait(100)
        end
    end
end)
Citizen.CreateThread(function()

    globalIsPedArmed = IsPedArmed(globalPlayerPedId, 7)
    globalIsPedMeleeArmed = IsPedArmed(globalPlayerPedId, 1)
    globalIsPlayerFreeAiming = IsPlayerFreeAiming(globalPlayerId)
    globalPlayerCoords = GetEntityCoords(globalPlayerPed)

    while true do
        if(inPoly)then
            globalIsPedArmed = IsPedArmed(globalPlayerPedId, 7)
            globalIsPedMeleeArmed = IsPedArmed(globalPlayerPedId, 1)
            globalIsPlayerFreeAiming = IsPlayerFreeAiming(globalPlayerId)
            globalPlayerCoords = GetEntityCoords(globalPlayerPed)
            globalIsPedShooting = IsPedShooting(globalPlayerPed)
        else
            globalPlayerCoords = GetEntityCoords(globalPlayerPed)
        end
        Citizen.Wait(100)
    end

end)