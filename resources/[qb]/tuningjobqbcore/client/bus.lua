QBCore = exports['qb-core']:GetCoreObject()
local ESXMenu = exports['esx_menu_default']:GetMenu()

local opened = 0
local spawnRadius = 160
local timer = 0
local zrespione = 0
local wybieranie = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

function GuyIsComing()
  QBCore.Functions.Notify('I am coming!', 'success', 5000)
  player = PlayerPedId()
  playerPos = GetEntityCoords(player)
  local a = GetHashKey(Config.PedDriver)
  RequestModel(a)
  local b = GetHashKey(Config.DeliveryVehicle)
  RequestModel(b)
  while not HasModelLoaded(a) and RequestModel(a) or not HasModelLoaded(b) and RequestModel(b) do 
    RequestModel(a)
    RequestModel(b)
    Citizen.Wait(0)
  end

  SpawnTowTruck(playerPos.x, playerPos.y, playerPos.x, b, a)
  -- GoToTarget(towTruck, towTruckDriver, b)
  GoToTarget(playerPos.x, playerPos.y, playerPos.z, towTruck, towTruckDriver, b, targetVeh)

end

Citizen.CreateThread(function()
    while true do 
      Citizen.Wait(500)
  

      if timer >= 1 then 
        if zrespione == 1 then 
          timer = timer - 0.5
          if timer <= 1 then
             wybieranie = false
             zrespione = 0
             TaskVehicleDriveWander(towTruckDriver, towTruck, 50.0, 786603)
             ESXMenu.UI.Menu.CloseAll()
             SetVehicleDoorShut(towTruck, 2, false)
             SetVehicleDoorShut(towTruck, 3, false)
             timer = 0
             QBCore.Functions.Notify('I am going to work', 'success', 5000)
             Citizen.Wait(20000)
             DeleteTowTruck(towTruck, towTruckDriver)
            end 
          end 
        end 
      end 
    end)

function SpawnTowTruck(a,b,c,d,e)
    local f, g, h = GetClosestVehicleNodeWithHeading(a+math.random(-160,160),b+math.random(-160,160),c,0,3,0)
  
    if f and HasModelLoaded(d) and HasModelLoaded(d) then
       zrespione = 1
       towTruck = CreateVehicle(d, g, h, true, false)
       ClearAreaOfVehicles(GetEntityCoords(towTruck), 5000, false, false, false, false, false)
       SetVehicleOnGroundProperly(towTruck)
       SetVehicleColours(towTruck, 111, 111)
       towTruckDriver = CreatePedInsideVehicle(towTruck, 26, e, -1, true, false)
       SetBlockingOfNonTemporaryEvents(towTruckDriver, true)
       towTruckBlip = AddBlipForEntity(towTruck)
       SetBlipFlashes(towTruckBlip, true)
       SetBlipColour(towTruckBlip, 47)
	     SetBlipSprite(towTruckBlip, 478)
       BeginTextCommandSetBlipName("STRING")
       AddTextComponentString('Delivery Guy')
       EndTextCommandSetBlipName(towTruckBlip)
    end
end
    
function DeleteTowTruck(a,b)
    SetEntityAsMissionEntity(a,false,false)
    DeleteEntity(a)
    SetEntityAsMissionEntity(b,false,false)
    DeleteEntity(b)
    RemoveBlip(towTruckBlip)
end

function GoToTarget(a,b,c,d,e,f)
	TaskVehicleDriveToCoord(e,d, Config.Locations["deliveryPoint"].x,Config.Locations["deliveryPoint"].y,Config.Locations["deliveryPoint"].z,17.0,0,f,786603,1,true)
	enroute = true
	while enroute == true do 
	  Citizen.Wait(500)
	  dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(d))
    if dist < 8 then
		 StartVehicleHorn(d,5000,GetHashKey("HELDDDOWN"),false)
		 TaskVehicleTempAction(e,d,27,-1)
		 SetVehicleDoorOpen(d,2,false,false)
		 SetVehicleDoorOpen(d,3,false,false)
		 RemoveBlip(towTruckBlip)
		 timer = Config.Timer
		 enroute = false
         QBCore.Functions.Notify('You have ' ..math.floor(timer)..' seconds, after that i am going to work', 'success', 5000)
		 LastOptions()
		elseif dist < 20 then 
		  Citizen.Wait(2000)
		end 
	end 
end


function LastOptions()
	local a, b, c = table.unpack(GetOffsetFromEntityInWorldCoords(towTruck,0.0,-3.3,-1.0))
	wybieranie = true
	while wybieranie do 
	  Citizen.Wait(2)
	  local a, b, c = table.unpack(GetOffsetFromEntityInWorldCoords(towTruck, 0.0, -3.3, -1.0))
	  DrawMarker(1, a, b, c, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 50, 100, 1, 0, 0, 0)
	  local d = GetEntityCoords(PlayerPedId(), false)
	  local e = Vdist2(d.x, d.y, d.z, a, b, c)
		if e <= 1.5 then
      if Config.DrawTextUI then
        TriggerEvent('cd_drawtextui:ShowUI', 'show', '[E] to see inside [H] To Go')
      else
      QBCore.Functions.DrawText3D(a, b, c+1, 'Press ~y~[E]~w~ to see inside ~r~[H]~w~ To Go')
      end
      if IsControlJustPressed(0, 38) then
        ChooseItem()
      elseif IsControlJustPressed(0, 74) then
        ReadyToGo()
      end
    else
      TriggerEvent('cd_drawtextui:HideUI')
		end
	end
end

function ReadyToGo()
	wybieranie = false
	zrespione = 0
  TriggerEvent('cd_drawtextui:HideUI')
	TaskVehicleDriveWander(towTruckDriver, towTruck, 50.0, 786603)
	ESXMenu.UI.Menu.CloseAll()
	SetVehicleDoorShut(towTruck, 2, false)
	SetVehicleDoorShut(towTruck, 3, false)
	timer = 0
  QBCore.Functions.Notify('Okay, i hope i was usefull.', 'info', 3500)
	Citizen.Wait(20000)
	DeleteTowTruck(towTruck, towTruckDriver)
end


function ChooseItem()

	opened = 1
  
  ESXMenu.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'tuning_items',
			{
			title = 'What do you need?',
			align = 'center',
			elements = {
                {label = "Engine | $13,000", type = "slider", value = 1, min = 1, max = 10, price = 13000, itemname = "engine"},
                {label = 'Turbo  | $17,000', type = "slider", value = 1, min = 1, max = 10, price = 17000, itemname = "turbo"},
                {label = "NOS Bottle | $8,000", type = "slider", value = 1, min = 1, max = 10, price = 8000, itemname = "nos"},
                {label = "Suspension | $4,000", type = "slider", value = 1, min = 1, max = 10, price = 4000, itemname = "suspension"},
                {label = "Susp. Wrenches   | $4,000", type = "slider", value = 1, min = 1, max = 10, price = 4000, itemname = "suspension_wrenches"},
				        {label = 'Xenon Remote     | $1,000', type = "slider", value = 1, min = 1, max = 5, price = 1000, itemname = "hidc"},
				        {label = 'Xenon Headlights | $1,000', type = "slider", value = 1, min = 1, max = 5, price = 1000, itemname = "headlights"},
                
        }
		  },
			function(data, menu)
				local item = data.current.itemname
			    local amount = data.current.value
			    local money = data.current.value * data.current.price
        
          TriggerServerEvent('6scripts-tuning:server:buyItem', item, amount, money)
			  end,function(data, menu) 
				menu.close()
			end)
end

RegisterNetEvent('6scripts-tuning:client:GuyComing')
AddEventHandler('6scripts-tuning:client:GuyComing', function()
  GuyIsComing()
end)