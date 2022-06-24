local QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false

local dealerpos = { x = -159.72, y = -966.09, z = 20.28, h = 336.39 }
Citizen.CreateThread(function()
    modelHash = GetHashKey("a_m_y_cyclist_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(10)
    end
    creategrannypos()
end)

function creategrannypos()
    created_ped = CreatePed(0, modelHash, dealerpos.x, dealerpos.y, dealerpos.z, dealerpos.h, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_COP_IDLES", 0, true)
end

local sellItemsSet = false
local sellPrice = 0
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(PlayerPedId())
		if #(pos - vector3(Config.SpiceLocation.x, Config.SpiceLocation.y, Config.SpiceLocation.z)) < 5.0 then
			inRange = true
			if #(pos - vector3(Config.SpiceLocation.x, Config.SpiceLocation.y, Config.SpiceLocation.z)) < 1.5 then
				if GetClockHours() >= 7 and GetClockHours() <= 17 then
					if not sellItemsSet then 
						sellPrice = GetSellingPrice()
						sellItemsSet = true
					elseif sellItemsSet and sellPrice ~= 0 then
						DrawText3D(Config.SpiceLocation.x, Config.SpiceLocation.y, Config.SpiceLocation.z, "Spice Dealer:- Do you have someting to sell? Press ~g~E~w~")
						if IsControlJustReleased(0, 38) then
							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                            QBCore.Functions.Progressbar("sell_spice_items", "Selling Items", math.random(45000,60000), false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(PlayerPedId())
								TriggerServerEvent("qb-spicedealer:server:sellspiceItems")
								sellItemsSet = false
								sellPrice = 0
                            end, function() -- Cancel
								ClearPedTasks(PlayerPedId())
								QBCore.Functions.Notify("Canceled..", "error")
							end)
						end
					else
						DrawText3D(Config.SpiceLocation.x, Config.SpiceLocation.y, Config.SpiceLocation.z, "Spice Dealer: You have nothing to sell, Fuck off!!!")
					end
				else
					DrawText3D(Config.SpiceLocation.x, Config.SpiceLocation.y, Config.SpiceLocation.z, "Spice Dealer: I don't know what are you talking, come after ~r~7:00")
				end
			end
		end
		if not inRange then
			sellPrice = 0
			sellItemsSet = false
			Citizen.Wait(2500)
		end
	end
end)


function GetSellingPrice()
	local price = 0
	QBCore.Functions.TriggerCallback('qb-spicedealer:server:getSellPrice', function(result)
		price = result
	end)
	Citizen.Wait(500)
	return price
end

function DrawText3D(x, y, z, text)
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