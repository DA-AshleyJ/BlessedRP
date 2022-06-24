local QBCore = exports["qb-core"]:GetCoreObject()

local Webhook = '' -- PUT YOUR WEBHOOK LINK HERE

local adsList = {}
local anonymousList = {}
local chatsHidden = {}
local mutedList = {}
local isDead = false
local checkedDeathStatus = false

function interp(s, tab)
	return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

exports.chat:registerMessageHook(function(source, outMessage, hookRef)
    local msg = outMessage.args[2]
	if string.sub(msg, 1, 1) ~= "/" then
    	hookRef.cancel()
    	if Config.OOCMessageWithoutCommand then
    		OOC(source, msg)
    	end
    end
end)

RegisterServerEvent("okokChat:ServerMessage")
AddEventHandler("okokChat:ServerMessage", function(background, color, icon, title, playername, message, target, image)
	local time = os.date(Config.DateFormat)
	if image == nil or image:gsub("%s+", "") == "" then
		TriggerClientEvent('chat:addMessage', target, {
			template = '<div class="chat-message" style="background: {0};"><i class="{2}" style="color: #fff; background-color: {1}; padding: 0.3125rem; border-radius: 0.3125rem; vertical-align: middle;"></i> <b><span style="color: {1}">[{3}]{4}</span>&nbsp;<span class="time">{6}</span></b><div class="message">'..message..'</div></div>',
			args = { background, color, icon, title, playername, message, time }
		})
	else
		TriggerClientEvent('chat:addMessage', target, {
			template = '<div class="chat-message" style="background: {0};"><i class="{2}" style="color: #fff; background-color: {1}; padding: 0.3125rem; border-radius: 0.3125rem; vertical-align: middle;"></i> <b><span style="color: {1}">[{3}]{4}</span>&nbsp;<span class="time">{6}</span></b><div class="message">'..message..'<br><img src="'..image..'" width="100%"></img></div></div>',
			args = { background, color, icon, title, playername, message, time }
		})
	end
end)

RegisterServerEvent("okokChat:deathStatus")
AddEventHandler("okokChat:deathStatus", function(isPlayerDead)
	isDead = isPlayerDead
	checkedDeathStatus = true
end)

-------------------------
-- [Me]

if Config.EnableMeCommand then
	RegisterCommand(Config.MeCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmin = playerName.." ["..source.."]"
		local length = string.len(Config.OOCCommand)
		local message = rawCommand:sub(length + 1)
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end
		
		if chatsHidden[source] == nil then
			showToClosePlayers(xPlayer, function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message me"><i class="'..Config.MeIcon..'"></i> <b><span style="color: #79b8fa">['..Config.MeMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)

			if Config.ShowIDOnMessage then
				showToClosePlayersAdmins(xPlayer, function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message me"><i class="'..Config.MeIcon..'"></i> <b><span style="color: #79b8fa">['..Config.MeMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerNameAdmin, message, time }
					})
				end)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
				local data = {
					playerid = xPlayer.PlayerData.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = Config.WebhookText['me'],
					message = message,
				}
				discordWebhook(data)
			end
		end
	end)
end

-------------------------
-- [Do]

if Config.EnableDoCommand then
	RegisterCommand(Config.DoCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmin = playerName.." ["..source.."]"
		local length = string.len(Config.OOCCommand)
		local message = rawCommand:sub(length + 1)
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end
		
		if chatsHidden[source] == nil then
			showToClosePlayers(xPlayer, function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message do"><i class="'..Config.DoIcon..'"></i> <b><span style="color: #79faa4">['..Config.DoMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)

			if Config.ShowIDOnMessage then
				showToClosePlayersAdmins(xPlayer, function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message do"><i class="'..Config.DoIcon..'"></i> <b><span style="color: #79faa4">['..Config.DoMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerNameAdmin, message, time }
					})
				end)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
				local data = {
					playerid = xPlayer.PlayerData.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = Config.WebhookText['do'],
					message = message,
				}
				discordWebhook(data)
			end
		end
	end)
end

-------------------------
-- [Try]

if Config.EnableTryCommand then
	RegisterCommand(Config.TryCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmin = playerName.." ["..source.."]"
		local length = string.len(Config.OOCCommand)
		local message = rawCommand:sub(length + 1)
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end
		
		if math.random(0, 1) == 0 then return end

		if chatsHidden[source] == nil then
			showToClosePlayers(xPlayer, function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message try"><i class="'..Config.TryIcon..'"></i> <b><span style="color: #f34971">['..Config.TryMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)

			if Config.ShowIDOnMessage then
				showToClosePlayersAdmins(xPlayer, function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message try"><i class="'..Config.TryIcon..'"></i> <b><span style="color: #f34971">['..Config.TryMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerNameAdmin, message, time }
					})
				end)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
				local data = {
					playerid = xPlayer.PlayerData.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = Config.WebhookText['try'],
					message = message,
				}
				discordWebhook(data)
			end
		end
	end)
end

-------------------------
-- [Auto Message]
local id = 1
Citizen.CreateThread(function()
    while Config.EnableAutoMessage do
		Citizen.Wait(Config.AutoMessageTime*60000)
		local time = os.date(Config.DateFormat)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message server-msg"><i class="'..Config.AnnouncementIcon..'"></i> <b><span style="color: #cc3d3d;">['..Config.AnnouncementMessageTitle..']</span>&nbsp;<span class="time">{1}</span></b><div class="message">{0}</div></div>',
			args = { Config.AutoMessages[id], time }
		})
		if Config.AutoMessages[id+1] ~= nil then
			id = id + 1
		else
			id = 1
		end
	end
end)

-------------------------
-- [Clear Chat]

if Config.AllowPlayersToClearTheirChat then
	RegisterCommand(Config.ClearChatCommand, function(source, args, rawCommand)
		TriggerClientEvent('chat:clear', source)
	end)
end

if Config.AllowStaffsToClearEveryonesChat then
	RegisterCommand(Config.ClearEveryonesChatCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local time = os.date(Config.DateFormat)

		if isAdmin(xPlayer) then
			TriggerClientEvent('chat:clear', -1)
			showAll(function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">'..Config.ClearChatMessageTitle..'</span>&nbsp;<span class="time">{0}</span></b><div class="message">'..Config.ClearChatMessage..'</div></div>',
					args = { time }
				})
			end)

			if Config.ShowIDOnMessage then
				showOnlyForAdmins(function(admins)
					TriggerClientEvent('chat:addMessage', admins, {
						template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">'..Config.ClearChatMessageTitle..'</span>&nbsp;<span class="time">{0}</span></b><div class="message">'..Config.ClearChatMessage..'</div></div>',
						args = { time }
					})
				end)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
				local data = {
					playerid = xPlayer.PlayerData.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = Config.WebhookText['clear_all'],
					message = Config.ClearEveryonesChatCommand,
				}
				discordWebhook(data)
			end
		end
	end)
end

-------------------------
-- [Hide Chat]

if Config.EnableHideChat then
	RegisterCommand(Config.HideChatCommand, function(source, args, rawCommand)
		if chatsHidden[source] == nil then
			chatsHidden[source] = true
			TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['disable_chat'], Config.NotificationsText['disable_chat'].message)
		else
			chatsHidden[source] = nil
			TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['enable_chat'], Config.NotificationsText['enable_chat'].message)
		end
	end)
end

-------------------------
-- [Staff]

if Config.EnableStaffCommand then
	RegisterCommand(Config.StaffCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.StaffCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname

		if Config.StaffSteamName then
			playerName = xPlayer.PlayerData.name
		end

		if message:gsub("%s+", "") ~= "" then
			if isAdmin(xPlayer) then
				showToEveryoneNotHidden(function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message staff"><i class="'..Config.StaffIcon..'"></i> <b><span style="color: #1ebc62;">['..Config.StaffMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerName, message, time }
					})
				end)
				
				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
					local data = {
						playerid = xPlayer.PlayerData.source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = Config.WebhookText['staff_msg'],
						message = message,
					}
					discordWebhook(data)
				end
			end
		end
	end)
end

-------------------------
-- [Staff Only]

if Config.EnableStaffOnlyCommand then
	RegisterCommand(Config.StaffOnlyCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.StaffOnlyCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname

		if Config.StaffSteamName then
			playerName = xPlayer.PlayerData.name
		end

		if message:gsub("%s+", "") ~= "" then
			if chatsHidden[source] == nil then
				if isAdmin(xPlayer) then
					showOnlyForAdmins(function(admins)
						TriggerClientEvent('chat:addMessage', admins, {
							template = '<div class="chat-message staffonly"><i class="'..Config.StaffOnlyIcon..'"></i> <b><span style="color: #1ebc62">['..Config.StaffOnlyMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
							args = { playerName, message, time }
						})
					end)

					if Webhook ~= '' then
						local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
						local data = {
							playerid = xPlayer.PlayerData.source,
							identifier = identifierlist.license:gsub("license2:", ""),
							discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
							type = Config.WebhookText['staff_chat_msg'],
							message = message,
						}
						discordWebhook(data)
					end
				end
			end
		end
	end)
end

-------------------------
-- [Server Announcement]

if Config.EnableServerAnnouncement then
	RegisterCommand(Config.ServerAnnouncementCommand, function(source, args, rawCommand)
		local xPlayer = nil
		local length = string.len(Config.ServerAnnouncementCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)

		if source > 0 then
			xPlayer = QBCore.Functions.GetPlayer(source)

			TriggerClientEvent('okokChat:checkDeathStatus', source)
			while not checkedDeathStatus do
				Citizen.Wait(5)
			end
			checkedDeathStatus = false
			if isDead then return end
		end

		if message:gsub("%s+", "") ~= "" then
			if source <= 0 then
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div class="chat-message server-msg"><i class="'..Config.AnnouncementIcon..'"></i> <b><span style="color: #cc3d3d;">['..Config.AnnouncementMessageTitle..']</span>&nbsp;<span class="time">{1}</span></b><div class="message">{0}</div></div>',
					args = { message, time }
				})
			elseif isAdmin(xPlayer) then
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div class="chat-message server-msg"><i class="'..Config.AnnouncementIcon..'"></i> <b><span style="color: #cc3d3d;">['..Config.AnnouncementMessageTitle..']</span>&nbsp;<span class="time">{1}</span></b><div class="message">{0}</div></div>',
					args = { message, time }
				})

				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
					local data = {
						playerid = xPlayer.PlayerData.source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = Config.WebhookText['sv_an'],
						message = message,
					}
					discordWebhook(data)
				end
			end
		end
	end)
end

-------------------------
-- [Advertisement]

if Config.EnableAdvertisementCommand then
	RegisterCommand(Config.AdvertisementCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.AdvertisementCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmins = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		local bankMoney = xPlayer.PlayerData.money.bank
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if chatsHidden[source] == nil then
			if adsList[source] == nil then
				if bankMoney >= Config.AdvertisementPrice then
					xPlayer.Functions.RemoveMoney('bank', Config.AdvertisementPrice)
					showAll(function(players)
						TriggerClientEvent('chat:addMessage', players, {
							template = '<div class="chat-message advertisement"><i class="'..Config.AdvertisementIcon..'"></i> <b><span style="color: #81db44">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
							args = { playerName, message, time }
						})
					end)

					if Webhook ~= '' then
						local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
						local data = {
							playerid = xPlayer.PlayerData.source,
							identifier = identifierlist.license:gsub("license2:", ""),
							discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
							type = Config.WebhookText['ad'],
							message = message,
						}
						discordWebhook(data)
					end

					if Config.ShowIDOnMessage then
						showOnlyForAdmins(function(admins)
							TriggerClientEvent('chat:addMessage', admins, {
								template = '<div class="chat-message advertisement"><i class="'..Config.AdvertisementIcon..'"></i> <b><span style="color: #81db44">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
								args = { playerNameAdmins, message, time }
							})
						end)
					end

					TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['ad_success'], interp(Config.NotificationsText['ad_success'].message, {price = Config.AdvertisementPrice}))
					adsList[source] = {
						time = Config.AdvertisementCooldown * 60,
						pastTime = 0,
						timeLeft = Config.AdvertisementCooldown * 60
					}

					while (adsList[source].time > adsList[source].pastTime) do
						Citizen.Wait(1000)
						adsList[source].pastTime = adsList[source].pastTime + 1
						adsList[source].timeLeft = adsList[source].time - adsList[source].pastTime
					end
					adsList[source] = nil
				else
					TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['ad_no_money'], Config.NotificationsText['ad_no_money'].message)
				end
			else
				TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['ad_too_quick'], Config.NotificationsText['ad_too_quick'].message)
			end
		end
	end)
end

-------------------------
-- [Twitch]

if Config.EnableTwitchCommand then
	RegisterCommand(Config.TwitchCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.TwitchCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmins = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		local twitch = twitchPermission(source)
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if chatsHidden[source] == nil then
			if twitch then
				showAll(function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message twitch"><i class="'..Config.TwitchIcon..'"></i> <b><span style="color: #9c70de">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerName, message, time }
					})
				end)

				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
					local data = {
						playerid = xPlayer.PlayerData.source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = Config.WebhookText['twitch'],
						message = message,
					}
					discordWebhook(data)
				end

				if Config.ShowIDOnMessage then
					showOnlyForAdmins(function(admins)
						TriggerClientEvent('chat:addMessage', admins, {
							template = '<div class="chat-message twitch"><i class="'..Config.TwitchIcon..'"></i> <b><span style="color: #9c70de">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
							args = { playerNameAdmins, message, time }
						})
					end)
				end
			end
		end
	end)
end

function twitchPermission(id)
	for i, a in ipairs(Config.TwitchList) do
		for x, b in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(b) == string.lower(a) then
				return true
			end
		end
	end
end

-------------------------
-- [Youtube]

if Config.EnableYoutubeCommand then
	RegisterCommand(Config.YoutubeCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.YoutubeCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmins = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		local youtube = youtubePermission(source)
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if chatsHidden[source] == nil then
			if youtube then
				showAll(function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message youtube"><i class="'..Config.YoutubeIcon..'"></i> <b><span style="color: #ff0000">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerName, message, time }
					})
				end)

				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
					local data = {
						playerid = xPlayer.PlayerData.source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = Config.WebhookText['youtube'],
						message = message,
					}
					discordWebhook(data)
				end

				if Config.ShowIDOnMessage then
					showOnlyForAdmins(function(admins)
						TriggerClientEvent('chat:addMessage', admins, {
							template = '<div class="chat-message youtube"><i class="'..Config.YoutubeIcon..'"></i> <b><span style="color: #ff0000">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
							args = { playerNameAdmins, message, time }
						})
					end)
				end
			end
		end
	end)
end

function youtubePermission(id)
	for i, a in ipairs(Config.YoutubeList) do
		for x, b in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(b) == string.lower(a) then
				return true
			end
		end
	end
end

-------------------------
-- [Twitter]

if Config.EnableTwitterCommand then
	RegisterCommand(Config.TwitterCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.TwitterCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmins = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">'..Config.TimeOutMessages['muted_message']..'</div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if chatsHidden[source] == nil then
			showAll(function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message twitter"><i class="'..Config.TwitterIcon..'"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
				local data = {
					playerid = xPlayer.PlayerData.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = Config.WebhookText['twitter'],
					message = message,
				}
				discordWebhook(data)
			end

			if Config.ShowIDOnMessage then
				showOnlyForAdmins(function(admins)
					TriggerClientEvent('chat:addMessage', admins, {
						template = '<div class="chat-message twitter"><i class="'..Config.TwitterIcon..'"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerNameAdmins, message, time }
					})
				end)
			end
		end
	end)
end

-------------------------
-- [Police]

if Config.EnablePoliceCommand then
	RegisterCommand(Config.PoliceCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.PoliceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmins = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		local job = xPlayer.PlayerData.job.name
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if chatsHidden[source] == nil then
			if job == Config.PoliceJobName then
				showAll(function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message police"><i class="'..Config.PoliceIcon..'"></i> <b><span style="color: #4a6cfd">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerName, message, time }
					})
				end)

				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
					local data = {
						playerid = xPlayer.PlayerData.source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = Config.WebhookText['police'],
						message = message,
					}
					discordWebhook(data)
				end

				if Config.ShowIDOnMessage then
					showOnlyForAdmins(function(admins)
						TriggerClientEvent('chat:addMessage', admins, {
							template = '<div class="chat-message police"><i class="'..Config.PoliceIcon..'"></i> <b><span style="color: #4a6cfd">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
							args = { playerNameAdmins, message, time }
						})
					end)
				end
			end
		end
	end)
end

-------------------------
-- [Ambulance]

if Config.EnableAmbulanceCommand then
	RegisterCommand(Config.AmbulanceCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.AmbulanceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmins = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		local job = xPlayer.PlayerData.job.name
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if chatsHidden[source] == nil then
			if job == Config.AmbulanceJobName then
				showAll(function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message ambulance"><i class="'..Config.AmbulanceIcon..'"></i> <b><span style="color: #e3a71b">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerName, message, time }
					})
				end)

				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
					local data = {
						playerid = xPlayer.PlayerData.source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = Config.WebhookText['ambulance'],
						message = message,
					}
					discordWebhook(data)
				end

				if Config.ShowIDOnMessage then
					showOnlyForAdmins(function(admins)
						TriggerClientEvent('chat:addMessage', admins, {
							template = '<div class="chat-message ambulance"><i class="'..Config.AmbulanceIcon..'"></i> <b><span style="color: #e3a71b">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
							args = { playerNameAdmins, message, time }
						})
					end)
				end
			end
		end
	end)
end

-------------------------
-- [Jobs]

if Config.JobChat then
	RegisterCommand(Config.JobCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.JobCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmin = playerName.." ["..source.."]"
		local job = xPlayer.PlayerData.job
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if chatsHidden[source] == nil then
			showForJob(job.name, function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message jobchat"><i class="'..Config.JobIcon..'"></i> <b><span style="color: #35dbc2">['..job.label..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)

			if Config.ShowIDOnMessage then
				showForJobAdmins(job.name, function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message jobchat"><i class="'..Config.JobIcon..'"></i> <b><span style="color: #35dbc2">['..job.label..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerNameAdmin, message, time }
					})
				end)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
				local data = {
					playerid = xPlayer.PlayerData.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = interp(Config.WebhookText['job_chat'], {job = job.label}),
					message = message,
				}
				discordWebhook(data)
			end
		end
	end)
end

-------------------------
-- [Private Messages]

if Config.EnablePM then
	RegisterCommand(Config.PMCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local message = table.concat(args, " ",2)
		local time = os.date(Config.DateFormat)
		local id = tonumber(args[1])
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end
		
		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end

		if id == source then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message) return end

		xTarget = QBCore.Functions.GetPlayer(id)

		if xTarget == nil then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message) return end

		xTargetName = xTarget.PlayerData.charinfo.firstname.." "..xTarget.PlayerData.charinfo.lastname

		if chatsHidden[id] ~= nil then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['is_muted'], Config.NotificationsText['is_muted'].message) return end

		TriggerClientEvent('chat:addMessage', source, {
			template = '<div class="chat-message pm"><i class="'..Config.PMIcon..'"></i> <b><span style="color: #916db0">['..Config.PMMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
			args = { playerName, message, time }
		})

		TriggerClientEvent('chat:addMessage', id, {
			template = '<div class="chat-message pm"><i class="'..Config.PMIcon..'"></i> <b><span style="color: #916db0">['..Config.PMMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
			args = { playerName, message, time }
		})

		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
			local data = {
				playerid = xPlayer.PlayerData.source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = interp(Config.WebhookText['pm_chat'], {name = xTargetName, id = id}),
				message = message,
			}
			discordWebhook(data)
		end
	end)
end

-------------------------
-- [OOC]

if Config.EnableOOC then
	function OOC(source, message)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local time = os.date(Config.DateFormat)
		local playerName = Config.ShowIDOnMessageForEveryone and xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]" or xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
		local playerNameAdmin = playerName.." ["..source.."]"
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if message:gsub("%s+", "") == "" then return end
		
		if chatsHidden[source] == nil then
			showToClosePlayers(xPlayer, function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message ooc"><i class="'..Config.OOCIcon..'"></i> <b><span style="color: #ababab">['..Config.OOCMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)

			if Config.ShowIDOnMessage then
				showToClosePlayersAdmins(xPlayer, function(players)
					TriggerClientEvent('chat:addMessage', players, {
						template = '<div class="chat-message ooc"><i class="'..Config.OOCIcon..'"></i> <b><span style="color: #ababab">['..Config.OOCMessageTitle..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
						args = { playerNameAdmin, message, time }
					})
				end)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
				local data = {
					playerid = xPlayer.PlayerData.source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = Config.WebhookText['ooc'],
					message = message,
				}
				discordWebhook(data)
			end
		end
	end

	RegisterCommand(Config.OOCCommand, function(source, args, rawCommand)
		local length = string.len(Config.OOCCommand)
		local message = rawCommand:sub(length + 1)
		OOC(source, message)
	end)
end

-------------------------
-- [Time out]

if Config.TimeOutPlayers then
	RegisterCommand(Config.TimeOutCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local id = tonumber(args[1])
		local muteTime = tonumber(args[2])
		local time = os.date(Config.DateFormat)
		local xTarget = nil
		local xTargetName = nil

		if not isAdmin(xPlayer) 	then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_not_adm'], Config.NotificationsText['mute_not_adm'].message)		return end
		if id == nil 				then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message)			return end
		if muteTime == nil 			then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_time_inv'], Config.NotificationsText['mute_time_inv'].message)		return end
		if id == source 			then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message)			return end

		xTarget = QBCore.Functions.GetPlayer(id)

		if xTarget == nil 			then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message)			return end

		xTargetName = xTarget.PlayerData.charinfo.firstname.." "..xTarget.PlayerData.charinfo.lastname

		if mutedList[id] ~= nil 	then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['alr_muted'], Config.NotificationsText['alr_muted'].message)				return end

		mutedList[id] = {
			time = muteTime * 60,
			pastTime = 0,
			timeLeft = muteTime * 60
		}

		if Config.ShowTimeOutMessageForEveryone then
			showMuteMessageToEveryone(id, function(players)
				TriggerClientEvent('chat:addMessage', players, {
					template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">'..Config.TimeOutMessages['muted_for']..'</div></div>',
					args = { Config.MessageTitle, muteTime, time, xTargetName }
				})
			end)
		else
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">'..Config.TimeOutMessages['you_muted_for']..'</div></div>',
				args = { Config.MessageTitle, muteTime, time, xTargetName }
			})
		end

		TriggerClientEvent('chat:addMessage', id, {
			template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">SERVER</span>&nbsp;<span class="time">{1}</span></b><div class="message">'..Config.TimeOutMessages['been_muted_for']..'</div></div>',
			args = { muteTime, time }
		})

		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
			local data = {
				playerid = xPlayer.PlayerData.source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = interp(Config.WebhookText['muted'], {id = id}),
				message = interp(Config.WebhookText['muted_for'], {muteTime = muteTime}),
			}
			discordWebhook(data)
		end

		while (mutedList[id].time > mutedList[id].pastTime) do
			Citizen.Wait(1000)
			mutedList[id].pastTime = mutedList[id].pastTime + 1
			mutedList[id].timeLeft = mutedList[id].time - mutedList[id].pastTime
		end
		mutedList[id] = nil

	end)

	RegisterCommand(Config.RemoveTimeOutCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local id = tonumber(args[1])
		local time = os.date(Config.DateFormat)
		local xTarget = nil
		local xTargetName = nil

		if not isAdmin(xPlayer) 	then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_not_adm'], Config.NotificationsText['mute_not_adm'].message)		return end
		if id == nil 				then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message)			return end
		if id == source 			then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message)			return end

		xTarget = QBCore.Functions.GetPlayer(id)

		if xTarget == nil 			then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['mute_id_inv'], Config.NotificationsText['mute_id_inv'].message)			return end

		xTargetName = xTarget.PlayerData.charinfo.firstname.." "..xTarget.PlayerData.charinfo.lastname

		if mutedList[id] == nil 	then TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['alr_unmuted'], Config.NotificationsText['alr_unmuted'].message)			return end

		TriggerClientEvent('chat:addMessage', source, {
			template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">{0}</span>&nbsp;<span class="time">{1}</span></b><div class="message">'..Config.TimeOutMessages['you_unmuted']..'</div></div>',
			args = { Config.MessageTitle, time, xTargetName }
		})

		TriggerClientEvent('chat:addMessage', id, {
			template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">{0}</span>&nbsp;<span class="time">{1}</span></b><div class="message">'..Config.TimeOutMessages['been_unmuted']..'</div></div>',
			args = { Config.MessageTitle, time }
		})

		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
			local data = {
				playerid = xPlayer.PlayerData.source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = interp(Config.WebhookText['unmuted'], {id = id}),
				message = Config.WebhookText['p_unmuted'],
			}
			discordWebhook(data)
		end

		mutedList[id] = nil

	end)
end

function SecondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00";
  else
  	local timeString = ""
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));

    timeString = hours..":"..mins..":"..secs..Config.TimeOutMessages['hours']

    if hours == "00" then timeString = mins..":"..secs..Config.TimeOutMessages['minutes'] end
    if hours == "00" and mins == "00" then timeString = math.floor(seconds)..Config.TimeOutMessages['seconds'] end
    
    return timeString
  end
end

-------------------------
-- [Anonymous]

if Config.EnableAnonymousCommand then
	RegisterCommand(Config.AnonymousCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.AnonymousCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local bankMoney = xPlayer.PlayerData.money.bank
		local playerName = "Anonymous"
		local playerNameAdmins = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname.." ["..source.."]"
		
		TriggerClientEvent('okokChat:checkDeathStatus', source)
		while not checkedDeathStatus do
			Citizen.Wait(5)
		end
		checkedDeathStatus = false
		if isDead then return end

		if mutedList[source] ~= nil then
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div class="chat-message muted"><i class="'..Config.TimeOutIcon..'"></i> <b><span style="color: #df7b00">'..Config.MessageTitle..'</span>&nbsp;<span class="time">{1}</span></b><div class="message">You are muted for <b>{0}</b></div></div>',
				args = { SecondsToClock(mutedList[source].timeLeft), time }
			})
			return
		end

		if chatsHidden[source] == nil then
			if message:gsub("%s+", "") ~= "" then	
				if not isAnonymousChatBlacklisted(xPlayer) then
					if anonymousList[source] == nil then
						if bankMoney >= Config.AnonymousPrice then
							xPlayer.Functions.RemoveMoney('bank', Config.AnonymousPrice)
							showOnlyForAnonymous(function(anonymous)
								TriggerClientEvent('chat:addMessage', anonymous, {
									template = '<div class="chat-message anonymous"><i class="'..Config.AnonymousIcon..'"></i> <b><span style="color: #2e874d">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
									args = { playerName, message, time }
								})
							end)

							if Webhook ~= '' then
								local identifierlist = ExtractIdentifiers(xPlayer.PlayerData.source)
								local data = {
									playerid = xPlayer.PlayerData.source,
									identifier = identifierlist.license:gsub("license2:", ""),
									discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
									type = Config.WebhookText['anon'],
									message = message,
								}
								discordWebhook(data)
							end

							if Config.ShowIDOnMessage then
								showOnlyForAdminsAnonymous(function(admins)
									TriggerClientEvent('chat:addMessage', admins, {
										template = '<div class="chat-message anonymous"><i class="'..Config.AnonymousIcon..'"></i> <b><span style="color: #2e874d">{0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
										args = { playerNameAdmins, message, time }
									})
								end)
							end

							TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['an_success'], Config.NotificationsText['an_success'].message)
							anonymousList[source] = {
								time = Config.AdvertisementCooldown * 2,
								pastTime = 0,
								timeLeft = Config.AdvertisementCooldown * 2
							}

							while (anonymousList[source].time > anonymousList[source].pastTime) do
								Citizen.Wait(1000)
								anonymousList[source].pastTime = anonymousList[source].pastTime + 1
								anonymousList[source].timeLeft = anonymousList[source].time - anonymousList[source].pastTime
							end
							anonymousList[source] = nil
						else
							TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['an_no_money'], Config.NotificationsText['an_no_money'].message)
						end
					else
						TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['an_too_quick'], Config.NotificationsText['an_too_quick'].message)
					end
				else
					TriggerClientEvent('okokChat:Notification', source, Config.NotificationsText['an_not_allowed'], Config.NotificationsText['an_not_allowed'].message)
				end
			end
		end
	end)
end

function isAnonymousChatBlacklisted(xPlayer)
	for k,v in ipairs(Config.WhatJobsCantSeeAnonymousChat) do
		if xPlayer.PlayerData.job.name == v then 
			return true 
		end
	end
	return false
end

function showOnlyForAnonymous(anonymous)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if not Config.ShowIDOnMessage and chatsHidden[xPlayer.PlayerData.source] == nil and not isAnonymousChatBlacklisted(xPlayer) then
			anonymous(v)
		elseif Config.ShowIDOnMessage and chatsHidden[xPlayer.PlayerData.source] == nil and not isAdmin(xPlayer) and not isAnonymousChatBlacklisted(xPlayer) then
			anonymous(v)
		end
	end
end

function showOnlyForAdminsAnonymous(admins)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if isAdmin(xPlayer) and chatsHidden[xPlayer.PlayerData.source] == nil and not isAnonymousChatBlacklisted(xPlayer) then
			admins(v)
		end
	end
end

-------------------------
-- [Functions]

function isAdmin(xPlayer)
	local playerGroup = QBCore.Functions.GetPermission(xPlayer.PlayerData.source)
	
	if Config.QBPermissionsUpdate then
		for group, value in pairs(playerGroup) do
			if value then
				for k,v in ipairs(Config.StaffGroups) do
					if group == v then
						return true
					end
				end
			end
		end
	else
		for k,v in ipairs(Config.StaffGroups) do
			if playerGroup == v then
				return true
			end
		end
	end

	return false
end

function showOnlyForAdmins(admins)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if isAdmin(xPlayer) and chatsHidden[xPlayer.PlayerData.source] == nil then
			admins(v)
		end
	end
end

function showAll(players)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if not Config.ShowIDOnMessage and chatsHidden[xPlayer.PlayerData.source] == nil then
			players(v)
		elseif Config.ShowIDOnMessage and chatsHidden[xPlayer.PlayerData.source] == nil and not isAdmin(xPlayer) then
			players(v)
		end
	end
end

function showToEveryoneNotHidden(players)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if chatsHidden[xPlayer.PlayerData.source] == nil then
			players(v)
		end
	end
end

function showMuteMessageToEveryone(id, players)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if chatsHidden[xPlayer.PlayerData.source] == nil and id ~= v then
			players(v)
		end
	end
end

function showForJob(job, players)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if not Config.ShowIDOnMessage and xPlayer.PlayerData.job.name == job and chatsHidden[xPlayer.PlayerData.source] == nil then
			players(v)
		elseif Config.ShowIDOnMessage and not isAdmin(xPlayer) and xPlayer.PlayerData.job.name == job and chatsHidden[xPlayer.PlayerData.source] == nil then
			players(v)
		end
	end
end

function showForJobAdmins(job, players)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(v)
		if xPlayer.PlayerData.job.name == job and chatsHidden[xPlayer.PlayerData.source] == nil and isAdmin(xPlayer) then
			players(v)
		end
	end
end

function showToClosePlayers(xPlayer, admins)
    local ped = GetPlayerPed(xPlayer.PlayerData.source)
    local playerCoords = GetEntityCoords(ped, false)
    for k,v in ipairs(QBCore.Functions.GetPlayers()) do
        local xTarget = QBCore.Functions.GetPlayer(v)
        if not Config.ShowIDOnMessage and chatsHidden[xTarget.source] == nil then
            local tped = GetPlayerPed(v)
            local targetCoords = GetEntityCoords(tped, false)
            if #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(targetCoords.x, targetCoords.y, targetCoords.z)) < Config.Distance then
                admins(v)
            end
        elseif Config.ShowIDOnMessage and not isAdmin(xTarget) and chatsHidden[xTarget.source] == nil then
            local tped = GetPlayerPed(v)
            local targetCoords = GetEntityCoords(tped, false)
            if #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(targetCoords.x, targetCoords.y, targetCoords.z)) < Config.Distance then
                admins(v)
            end
        end
    end
end

function showToClosePlayersAdmins(xPlayer, admins)
	local ped = GetPlayerPed(xPlayer.PlayerData.source)
	local playerCoords = GetEntityCoords(ped, false)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		local xTarget = QBCore.Functions.GetPlayer(v)
		if chatsHidden[xTarget.source] == nil and isAdmin(xTarget) then
			local tped = GetPlayerPed(v)
			local targetCoords = GetEntityCoords(tped, false)
			if #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(targetCoords.x, targetCoords.y, targetCoords.z)) < Config.Distance then
				admins(v)
			end
		end
	end
end

-------------------------- IDENTIFIERS

function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end

-------------------------- DISCORD WEBHOOK

function discordWebhook(data)
	
	local information = {
		{
			["color"] = Config.WebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'CHAT',
			["description"] = '**Type:** '..data.type..'\n**Message:** '..data.message..'\n\n**ID:** '..data.playerid..'\n**Identifier:** '..data.identifier..'\n**Discord:** '..data.discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}

	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end