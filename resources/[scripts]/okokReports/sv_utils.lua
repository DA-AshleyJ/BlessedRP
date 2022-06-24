-- Don't change this --
ESX = nil
QBCore = nil

-- You can change this --
if Config.Framework == 'ESX' then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
elseif Config.Framework == 'QB' then
	QBCore = exports["qb-core"]:GetCoreObject()
end

-- WEBHOOKS --

playerReportWebhookLink = 'https://discord.com/api/webhooks/975390159816233011/M7gzL-2uy5fUh8OieGjirQag2eMhDnnjBvWHQK2AiXKH8H0incRoO1uLV_OE2PEIu4Vk' -- Player Report webhook

bugReportWebhookLink = 'https://discord.com/api/webhooks/975390159816233011/M7gzL-2uy5fUh8OieGjirQag2eMhDnnjBvWHQK2AiXKH8H0incRoO1uLV_OE2PEIu4Vk' -- Bug Report webhook

questionReportWebhookLink = 'https://discord.com/api/webhooks/975390159816233011/M7gzL-2uy5fUh8OieGjirQag2eMhDnnjBvWHQK2AiXKH8H0incRoO1uLV_OE2PEIu4Vk' -- Question webhook

adminWebhookLink = 'https://discord.com/api/webhooks/975390159816233011/M7gzL-2uy5fUh8OieGjirQag2eMhDnnjBvWHQK2AiXKH8H0incRoO1uLV_OE2PEIu4Vk' -- Admin related activities webhook (bring/go to/answer/conclude)

playerWebhookLink = 'https://discord.com/api/webhooks/975390159816233011/M7gzL-2uy5fUh8OieGjirQag2eMhDnnjBvWHQK2AiXKH8H0incRoO1uLV_OE2PEIu4Vk'-- Player related activities webhook (answer/cancel)

RegisterServerEvent('okokReportsV2:OnPlayerCancel')
AddEventHandler('okokReportsV2:OnPlayerCancel', function(source)
	
end)

RegisterServerEvent('okokReportsV2:OnConcluded')
AddEventHandler('okokReportsV2:OnConcluded', function(source, tagetSource)
	
end)

RegisterServerEvent('okokReportsV2:OnBring')
AddEventHandler('okokReportsV2:OnBring', function(source, tagetSource)
	
end)

RegisterServerEvent('okokReportsV2:OnGoTo')
AddEventHandler('okokReportsV2:OnGoTo', function(source, tagetSource)
	
end)

RegisterServerEvent('okokReportsV2:OnAnswer')
AddEventHandler('okokReportsV2:OnAnswer', function(source, tagetSource) -- tagetSource = nil if it's a player responding
	
end)

RegisterServerEvent('okokReportsV2:OnCreateReport')
AddEventHandler('okokReportsV2:OnCreateReport', function(source)
	
end)

function MySQLinsert(query, values, func)
	if Config.Database == 'mysql-async' then
		return MySQL.Async.insert(query, values, func)
	elseif Config.Database == 'oxmysql' then
		return MySQL.insert(query, values, func)
	elseif Config.Database == 'ghmattimysql' then
		return exports.ghmattimysql.execute(query, values, func)
	else
		print("[okokReportsV2] ERROR - no mysql callback! Please set a mysql callback in 'sv_utils.lua'")
	end
end

function getName(source)
	local name = nil
	
	if Config.UseSteamNames then
		name = GetPlayerName(source)
	elseif Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
		local identifier = xPlayer.identifier
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(db_name)
			if db_name[1] ~= nil then
				name = db_name[1].firstname.." "..db_name[1].lastname
			else
				name = ""
			end
		end)
		while name == nil do
			Citizen.Wait(2)
		end
	elseif Config.Framework == 'QB' then
		local xPlayer = QBCore.Functions.GetPlayer(source)
		name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
	else
		name = GetPlayerName(source)
	end
	return name
end