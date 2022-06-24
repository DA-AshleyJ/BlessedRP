local QBCore = exports['qb-core']:GetCoreObject()
local blueteam = {}
local redteam = {}
local redteamR = 0
local blueteamR = 0
local maxTeam = Config.MaxTeam
local allplayers = {}
local gameStarted = false

RegisterServerEvent('gl-paintball:register',function(team)
	local _source = source
	local team = team
	local redteamR = (#redteam)
	local blueteamR = (#blueteam)
	if team == 'redteam' then
		if redteamR < maxTeam then
			table.insert(redteam,source)
			table.insert(allplayers,source)
			TriggerClientEvent('gl-paintball:joinedTeam',_source,team)
		else
			TriggerClientEvent('QBCore:Notify', source, 'Team is full', 'error')
		end
	else
		if blueteamR < maxTeam then
			table.insert(blueteam,source)
			table.insert(allplayers,source)
			TriggerClientEvent('gl-paintball:joinedTeam',_source,team)
		else
			TriggerClientEvent('QBCore:Notify', source, 'Team is full', 'error')
		end
	end
end)

RegisterServerEvent('gl-paintball:gotShot',function(team)
	local _source = source
	if team == 'redteam' then
		for k,v in pairs(redteam) do
			if v == source then
				table.remove(redteam,k)
			end
		end
	else
		for k,v in pairs(blueteam) do
			if v == source then
				table.remove(blueteam,k)
			end
		end

	end

	local redteamR = (#redteam)
	local blueteamR = (#blueteam)
	if redteamR <= 0 then
		for k, v in pairs(allplayers) do
			TriggerClientEvent('QBCore:Notify', source, 'Blue team won!')
			TriggerClientEvent('gl-paintball:removeFromArena',v)
		end
		Wait(10000)
		blueteam = {}
		redteam = {}
		allplayers = {}
		gameStarted = false
	elseif blueteamR <= 0 then
		for k, v in pairs(allplayers) do
			TriggerClientEvent('QBCore:Notify', source, 'Red team won!')
			TriggerClientEvent('gl-paintball:removeFromArena',v)
		end
		Wait(10000)
		blueteam = {}
		redteam = {}
		allplayers = {}
		gameStarted = false
	end
	TriggerClientEvent('gl-paintball:removeFromArena',_source)
end)

RegisterServerEvent('gl-paintball:startGame',function()
	if not gameStarted then
		gameStarted = true
		local arena = Config.Arenas[math.random(#Config.Arenas)]
		print(arena)
		for k, v in pairs(blueteam) do
			TriggerClientEvent('gl-paintball:tpToLocation',v,arena)
		end

		for k, v in pairs(redteam) do
			TriggerClientEvent('gl-paintball:tpToLocation',v,arena)
		end
	end
end)

RegisterServerEvent('gl-paintball:buyGun',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.money.cash > Config.GunPrice then
		xPlayer.Functions.RemoveMoney('cash', Config.GunPrice)
		if Config.AreWeaponsItems then
			xPlayer.Functions.AddItem('WEAPON_PAINTGUN', 1)
		else
			GiveWeaponToPed(source,GetHashKey('WEAPON_PAINTGUN'),999,false,false)
		end
	end
end)