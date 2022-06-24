QBCore = exports['qb-core']:GetCoreObject()
local patronID = 0

RegisterNetEvent('gl-barber:sendPatron', function(ID, targetID)
	local src = source
	local Player = QBCore.Functions.GetPlayer(targetID)
	patronID = Player.PlayerData.source
	TriggerClientEvent('gl-barber:sendPatronClient', src, patronID)
end)

RegisterNetEvent('gl-barber:changeCut', function(woop, hair, highlight, color, save)
	TriggerClientEvent('gl-barber:changeHair', patronID,woop, hair, highlight, color,save)
end)

RegisterNetEvent('gl-barber:finishCut', function(woop)
	TriggerClientEvent('gl-barber:saveHair', patronID,woop)
end)

RegisterNetEvent('gl-barber:updateBarberListS', function(name,number)
	TriggerClientEvent('gl-barber:updateBarberListC', -1, name, number)
end)
