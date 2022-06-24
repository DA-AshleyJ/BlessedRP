local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('mt-dmv:client:AbrirMenu', function()
    exports['qb-menu']:openMenu({
      {
        header = "Driving School",
        isMenuHeader = true,
      },
      {
        header = "Start your Practical Car Test!",
        txt = "$"..Config.Amount['driving'].."",
        params = {
          event = 'mt-dmv:startdriver',
          args = {
            CurrentTest = 'drive'
          }
        }
      },
      {
        header = "Start your Practical Truck Test!",
        txt = "$"..Config.Amount['cdl'].."",
        params = {
          event = 'mt-dmv:startcdl'
        }
      },
      {
        header = "Start your Practical Bike Test!",
        txt = "$"..Config.Amount['bike'].."",
        params = {
          event = 'mt-dmv:startbike'
        }
      }
    })
end)

-- Event to put in qb-menu to start driving test
RegisterNetEvent('mt-dmv:startdriver', function()
    CurrentTest = 'drive'
    DriveErrors = 0
    LastCheckPoint = -1
    CurrentCheckPoint = 0
    IsAboveSpeedLimit = false
    CurrentZoneType = 'residence'
    local prevCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.SpawnVehicle(Config.VehicleModels.driver, function(veh)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        exports['LegacyFuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, 'DMV')
        SetEntityAsMissionEntity(veh, true, true)
        SetEntityHeading(veh, Config.Location['spawn'].w)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
        LastVehicleHealth = GetVehicleBodyHealth(veh)
        CurrentVehicle = veh
        QBCore.Functions.Notify('You are taking the driving test')
    end, Config.Location['spawn'], false)
end)

-- Event to put in qb-menu to start driving test
RegisterNetEvent('mt-dmv:startcdl', function()
    CurrentTest = 'drive'
    DriveErrors = 0
    LastCheckPoint = -1
    CurrentCheckPoint = 0
    IsAboveSpeedLimit = false
    CurrentZoneType = 'residence'
    local prevCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.SpawnVehicle(Config.VehicleModels.cdl, function(veh)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        exports['LegacyFuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, 'DMV')
        SetEntityAsMissionEntity(veh, true, true)
        SetEntityHeading(veh, Config.Location['spawn'].w)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
        LastVehicleHealth = GetVehicleBodyHealth(veh)
        CurrentVehicle = veh
        QBCore.Functions.Notify('You are taking the driving test')
    end, Config.Location['spawn'], false)
end)

-- Event to put in qb-menu to start driving test
RegisterNetEvent('mt-dmv:startbike', function()
    CurrentTest = 'drive'
    DriveErrors = 0
    LastCheckPoint = -1
    CurrentCheckPoint = 0
    IsAboveSpeedLimit = false
    CurrentZoneType = 'residence'
    local prevCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.SpawnVehicle(Config.VehicleModels.bike, function(veh)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        exports['LegacyFuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, 'DMV')
        SetEntityAsMissionEntity(veh, true, true)
        SetEntityHeading(veh, Config.Location['spawn'].w)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
        LastVehicleHealth = GetVehicleBodyHealth(veh)
        CurrentVehicle = veh
        QBCore.Functions.Notify('You are taking the driving test')
    end, Config.Location['spawn'], false)
end)

-- Stop Drive Test
function StopDriveTest(success)
    local playerPed = PlayerPedId()
    local veh = GetVehiclePedIsIn(playerPed)
    if success then
      TriggerServerEvent('mt-dmv:driverpaymentpassed')
      QBCore.Functions.Notify('You passed the test!')
      QBCore.Functions.DeleteVehicle(veh)
      CurrentTest = nil
    elseif success == false then
      TriggerServerEvent('mt-dmv:driverpaymentfailed')
      QBCore.Functions.Notify('You failed the test!')
      CurrentTest = nil
      RemoveBlip(CurrentBlip)
      QBCore.Functions.DeleteVehicle(veh)
      Wait(1000)
      SetEntityCoords(playerPed, Config.Location['marker'].x+1, Config.Location['marker'].y+1, Config.Location['marker'].z)
    end
  
    CurrentTest     = nil
    CurrentTestType = nil
  
  end

-- Drive test
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10)
      if CurrentTest == 'drive' then
        local marker = Config.Location['marker']
        local playerPed      = PlayerPedId()
        local coords         = GetEntityCoords(playerPed)
        local nextCheckPoint = CurrentCheckPoint + 1
        if Config.CheckPoints[nextCheckPoint] == nil then
          if DoesBlipExist(CurrentBlip) then
            RemoveBlip(CurrentBlip)
          end
          CurrentTest = nil
          StopDriveTest(true)
        else
          if CurrentCheckPoint ~= LastCheckPoint then
            if DoesBlipExist(CurrentBlip) then
              RemoveBlip(CurrentBlip)
            end
            CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
            SetBlipRoute(CurrentBlip, 1)
            LastCheckPoint = CurrentCheckPoint
          end
          local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)
          if distance <= 100.0 then
            DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
          end
          if distance <= 3.0 then
            Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
            CurrentCheckPoint = CurrentCheckPoint + 1
          end
        end
      end
    end
  end)

  -- Speed / Damage control
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10)
        if CurrentTest == 'drive' then
            local playerPed = PlayerPedId()
            if IsPedInAnyVehicle(playerPed,  false) then
                local vehicle      = GetVehiclePedIsIn(playerPed,  false)
                local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
                local tooMuchSpeed = false
                for k,v in pairs(Config.SpeedLimits) do
                    if CurrentZoneType == k and speed > v then
                    tooMuchSpeed = true
                        if not IsAboveSpeedLimit then
                            DriveErrors       = DriveErrors + 1
                            IsAboveSpeedLimit = true
                            QBCore.Functions.Notify('You are driving too Fast!',"error")
                            QBCore.Functions.Notify("Errors:"..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                        end
                    end
                end
                if not tooMuchSpeed then
                    IsAboveSpeedLimit = false
                end
                local health = GetVehicleBodyHealth(vehicle)
                if health < LastVehicleHealth then
                    DriveErrors = DriveErrors + 1
                    QBCore.Functions.Notify('Bates te o veiculo')
                    QBCore.Functions.Notify("Errors:"..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                    LastVehicleHealth = health
                end
                if DriveErrors >= Config.MaxErrors then
                  Wait(10)
                  StopDriveTest(false)
                end
            end
        end
    end
  end)

  --Blips
Citizen.CreateThread(function ()
    blip = AddBlipForCoord(Config.Location['marker'].x, Config.Location['marker'].y, Config.Location['marker'].z)
    SetBlipSprite(blip, Config.Blip.Sprite)
    SetBlipDisplay(blip, Config.Blip.Display)
    SetBlipColour(blip, Config.Blip.Color)
    SetBlipScale(blip, Config.Blip.Scale)
    SetBlipAsShortRange(blip, Config.Blip.ShortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.BlipName)
    EndTextCommandSetBlipName(blip)
end)

-----------------DrawText3Ds Function-------------------
DrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end

-----------------DrawMissionText Function-------------------
function DrawMissionText(msg, time)
    ClearPrints()
    SetTextEntry_2('STRING')
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end

-----------------SetCurrentZoneType Function-------------------
function SetCurrentZoneType(type)
    CurrentZoneType = type
end

-- Target
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("instrutor", vector3(218.75, -1391.87, 29.59), 1, 1, {
        name = "instrutor",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mt-dmv:client:AbrirMenu",
                icon = "fas fa-car",
                label = 'Talk to the instructor'
            },
        },
        distance = 2.5
    })
end)

-- Spawn Ped
local instrutorPed = {
	{218.75, -1391.87, 29.59,"Sr Zé",295.18,Config.PedHash,Config.Ped},
  
  }
  Citizen.CreateThread(function()
	  for _,v in pairs(instrutorPed) do
		  RequestModel(GetHashKey(v[7]))
		  while not HasModelLoaded(GetHashKey(v[7])) do
			  Wait(1)
		  end
		  CokeProcPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
		  SetEntityHeading(CokeProcPed, v[5])
		  FreezeEntityPosition(CokeProcPed, true)
		  SetEntityInvincible(CokeProcPed, true)
		  SetBlockingOfNonTemporaryEvents(CokeProcPed, true)
		  TaskStartScenarioInPlace(CokeProcPed, "WORLD_HUMAN_AA_SMOKE", 0, true) 
	  end
  end)