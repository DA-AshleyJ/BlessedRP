Config = {}

Config.QBPermissionsUpdate = false -- set it to true if you have the latest Permissions update

--------------------------------
-- [Discord Logs]

Config.EnableDiscordLogs = true

Config.IconURL = ""

Config.ServerName = "Blessed RP"

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.WebhookColor = "16741888"

--------------------------------
-- [Staff Groups]

Config.StaffGroups = { -- Groups that can access the different staff chats (/staff, /staffo, /sa)
	'god',
	'admin',
	'mod'
}

--------------------------------
-- [General]

Config.AllowPlayersToClearTheirChat = false

Config.ClearChatCommand = 'clear'

Config.EnableHideChat = true

Config.HideChatCommand = 'hide'

Config.ShowIDOnMessage = true -- Shows the player ID on every message that is sent

Config.ShowIDOnMessageForEveryone = false -- true: shows the player ID for everyone | false: shows it only for staffs

Config.ClearChatMessageTitle = 'SYSTEM'

Config.ClearChatMessage = 'The chat has been cleared!'

-- [Date Format]

Config.DateFormat = '%H:%M' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

--------------------------------
-- [Time Out]

Config.TimeOutPlayers = true

Config.TimeOutCommand = "mute"

Config.RemoveTimeOutCommand = "unmute"

Config.ShowTimeOutMessageForEveryone = true

Config.TimeOutIcon = 'fas fa-gavel'

Config.MessageTitle = 'SERVER'

Config.TimeOutMessages = {
	['muted_for'] = '<b>{3}</b> has been muted for <b>{1}</b> minutes',
	['you_muted_for'] = 'You muted <b>{3}</b> for <b>{1}</b> minutes',
	['been_muted_for'] = 'You have been muted for <b>{0}</b> minutes',

	['you_unmuted'] = 'You unmuted <b>{2}</b>',
	['been_unmuted'] = 'You have been unmuted',

	['muted_message'] = 'You are muted for <b>{0}</b>',
	['seconds'] = ' seconds',
	['minutes'] = ' minutes',
	['hours'] = ' hours',
}

--------------------------------
-- [Job]

Config.JobChat = true

Config.JobCommand = 'jobc'

Config.JobIcon = 'fas fa-briefcase'

--------------------------------
-- [Private Message]

Config.EnablePM = true

Config.PMCommand = 'pm'

Config.PMIcon = 'fas fa-comment pm-icon'

Config.PMMessageTitle = "PM"

--------------------------------
-- [OOC/Me/Do/Try]

Config.Distance = 20.0

--------------------------------
-- [OOC]

Config.EnableOOC = true

Config.OOCCommand = 'ooc'

Config.OOCIcon = 'fas fa-door-open'

Config.OOCMessageTitle = 'OOC'

Config.OOCMessageWithoutCommand = true -- true: sends OOC message without command (/ooc) | false: doesn't send any message without it being a command

--------------------------------
-- [Me]

Config.EnableMeCommand = false

Config.MeCommand = 'me'

Config.MeIcon = 'fas fa-comment me-icon'

Config.MeMessageTitle = 'ME'

--------------------------------
-- [Do]

Config.EnableDoCommand = false

Config.DoCommand = 'do'

Config.DoIcon = 'fas fa-comment do-icon'

Config.DoMessageTitle = 'DO'

--------------------------------
-- [Try]

Config.EnableTryCommand = false

Config.TryCommand = 'try'

Config.TryIcon = 'fas fa-comment try-icon'

Config.TryMessageTitle = 'TRY'

--------------------------------
-- [Staff]

Config.EnableStaffCommand = true

Config.StaffCommand = 'staff'

Config.StaffMessageTitle = 'STAFF'

Config.StaffIcon = 'fas fa-shield-alt'

Config.AllowStaffsToClearEveryonesChat = true

Config.ClearEveryonesChatCommand = 'clearall'

Config.StaffSteamName = false

-- [Staff Only]

Config.EnableStaffOnlyCommand = true

Config.StaffOnlyCommand = 'staffo'

Config.StaffOnlyMessageTitle = 'STAFF ONLY'

Config.StaffOnlyIcon = 'fas fa-eye-slash'

Config.StaffOnlySteamName = false

-- [Server Announcement]

Config.EnableServerAnnouncement = true

Config.ServerAnnouncementCommand = 'sa'

Config.AnnouncementIcon = 'fas fa-exclamation-circle'

Config.AnnouncementMessageTitle = 'SERVER'

--------------------------------
-- [Advertisements]

Config.EnableAdvertisementCommand = true

Config.AdvertisementCommand = 'ad'

Config.AdvertisementPrice = 1000

Config.AdvertisementCooldown = 5 -- in minutes

Config.AdvertisementIcon = 'fas fa-ad'

--------------------------------
-- [Anonymous/Dark]

Config.EnableAnonymousCommand = false

Config.AnonymousCommand = 'anon'

Config.AnonymousPrice = 0

Config.AnonymousCooldown = 0 -- in minutes

Config.WhatJobsCantSeeAnonymousChat = {
	'police',
	'ambulance',
}

Config.AnonymousIcon = 'fas fa-mask'

--------------------------------
-- [Twitch]

Config.EnableTwitchCommand = false

Config.TwitchCommand = 'twitch'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.TwitchList = {
	'steam:110000118a12j8a', -- Example, change this
}

Config.TwitchIcon = 'fab fa-twitch'

--------------------------------
-- [Youtube]

Config.EnableYoutubeCommand = false

Config.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.YoutubeList = {
	'steam:110000118a12j8a', -- Example, change this
}

Config.YoutubeIcon = 'fab fa-youtube'

--------------------------------
-- [Twitter]

Config.EnableTwitterCommand = false

Config.TwitterCommand = 'twitter'

Config.TwitterIcon = 'fab fa-twitter'

--------------------------------
-- [Police]

Config.EnablePoliceCommand = true

Config.PoliceCommand = 'police'

Config.PoliceJobName = 'police'

Config.PoliceIcon = 'fas fa-bullhorn'

--------------------------------
-- [Ambulance]

Config.EnableAmbulanceCommand = true

Config.AmbulanceCommand = 'ambulance'

Config.AmbulanceJobName = 'ambulance'

Config.AmbulanceIcon = 'fas fa-ambulance'

--------------------------------
-- [Auto Message]

Config.EnableAutoMessage = true

Config.AutoMessageTime = 60 -- (in minutes) will send messages every x minutes 

Config.AutoMessages = {
	"Welcome to Blessed RP - Our discord is: discord.me/blessed-rp",
	"Have fun! We hope you enjoy our server.",
}

--------------------------------
-- [Notifications]

Config.NotificationsText = {
	['disable_chat'] = { title = 'SYSTEM', message = 'You disabled the chat', time = 5000, type = 'info'},
	['enable_chat'] = { title = 'SYSTEM', message = 'You enabled the chat', time = 5000, type = 'info'},
	['ad_success'] = { title = 'ADVERTISEMENT', message = 'Advertisement successfully made for ${price}€', time = 5000, type = 'success'},
	['ad_no_money'] = { title = 'ADVERTISEMENT', message = "You don't have enough money to make an advertisement", time = 5000, type = 'error'},
	['ad_too_quick'] = { title = 'ADVERTISEMENT', message = "You can't advertise so quickly", time = 5000, type = 'info'},
	['mute_not_adm'] = { title = 'SYSTEM', message = 'You are not an admin', time = 5000, type = 'error'},
	['mute_id_inv'] = { title = 'SYSTEM', message = 'The id is invalid', time = 5000, type = 'error'},
	['mute_time_inv'] = { title = 'SYSTEM', message = 'The mute time is invalid', time = 5000, type = 'error'},
	['alr_muted'] = { title = 'SYSTEM', message = 'This person is already muted', time = 5000, type = 'error'},
	['alr_unmuted'] = { title = 'SYSTEM', message = 'This person is already unmuted', time = 5000, type = 'error'},
	['an_success'] = { title = 'ANONYMOUS', message = 'Advertisement successfully made for price€', time = 5000, type = 'success'},
	['an_no_money'] = { title = 'ANONYMOUS', message = "You don't have enough money to make an advertisement", time = 5000, type = 'error'},
	['an_too_quick'] = { title = 'ANONYMOUS', message = "You can't advertise so quickly", time = 5000, type = 'error'},
	['an_not_allowed'] = { title = 'ANONYMOUS', message = "You are not allowed to send messages in the anonymous chat", time = 5000, type = 'error'},
	['is_muted'] = { title = 'ANONYMOUS', message = "This player is muted", time = 5000, type = 'error'},
}

Config.WebhookText = {
	['clear_all'] = 'Cleared all chats',
	['staff_msg'] = 'Staff message',
	['staff_chat_msg'] = 'Staff chat message',
	['sv_an'] = 'Server announcement',
	['ad'] = 'Advertisement',
	['twitch'] = 'Twitch',
	['youtube'] = 'Youtube',
	['twitter'] = 'Twitter',
	['police'] = 'Police',
	['ambulance'] = 'Ambulance',
	['job_chat'] = 'Job chat [${job}]',
	['pm_chat'] = 'Private Message to ${name} [${id}]',
	['ooc'] = 'OOC',
	['me'] = 'ME',
	['do'] = 'DO',
	['try'] = 'TRY',
	['muted'] = 'Muted [${id}]',
	['muted_for'] = 'For ${muteTime} minutes',
	['unmuted'] = 'Unmuted [${id}]',
	['p_unmuted'] = 'Player has been unmuted',
	['anon'] = 'Anonymous',
}