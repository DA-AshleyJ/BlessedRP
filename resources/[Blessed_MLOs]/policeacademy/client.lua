Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local myCoords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 434.63, -1095.16, 37.85, true ) < 80 then
      ClearAreaOfPeds(434.63, -1095.16, 37.85, 58.0, 0)
    end
  end
end)