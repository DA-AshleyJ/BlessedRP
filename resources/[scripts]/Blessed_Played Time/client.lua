function notification(msg)
exports['okokNotify']:Alert("Played Time", msg, 5000, info)
end

local firstSpawn = false

AddEventHandler('playerSpawned', function()
	if firstSpawn == false then
		TriggerServerEvent('Blessed_playtime:loggedIn', GetPlayerName(PlayerId()))
		firstSpawn = true
	end
end)

RegisterCommand('playtime', function(source)
	TriggerServerEvent('Blessed_playtime:loggedIn', GetPlayerName(PlayerId()))
end, false)

RegisterNetEvent('Blessed_playtime:notif')
AddEventHandler('Blessed_playtime:notif', function(msg)
    notification(msg)
end)