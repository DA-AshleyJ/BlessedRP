local players = {}

exports('Message', function(background, color, icon, title, playername, message, target, image)
	TriggerServerEvent('okokChat:ServerMessage', background, color, icon, title, playername, message, target, image)
end)

RegisterNetEvent("okokChat:checkDeathStatus")
AddEventHandler("okokChat:checkDeathStatus", function()
	local ped = GetPlayerPed(-1)
	TriggerServerEvent('okokChat:deathStatus', IsEntityDead(ped))
end)

RegisterNetEvent("okokChat:Notification")
AddEventHandler("okokChat:Notification", function(info, text)
	exports['okokNotify']:Alert(info.title, text, info.time, info.type)
end)

Citizen.CreateThread(function()

	if Config.JobChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.JobCommand, 'JOB message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableOOC then
		TriggerEvent('chat:addSuggestion', '/'..Config.OOCCommand, 'OOC message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.AllowPlayersToClearTheirChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.ClearChatCommand, 'Clear chat', {})
	end

	if Config.EnableHideChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.HideChatCommand, 'Hide chat', {})
	end

	if Config.EnableStaffCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.StaffCommand, 'Send a message as staff', {
			{ name="message", help="message to send" },
		})
	end

	if Config.AllowStaffsToClearEveryonesChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.ClearEveryonesChatCommand, "Clear everyone's chat", {})
	end

	if Config.EnableStaffOnlyCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.StaffOnlyCommand, 'Staff only chat', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableAdvertisementCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AdvertisementCommand, 'Make an advertisement', {
			{ name="ad", help="advertisement message" },
		})
	end

	if Config.EnableAnonymousCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AnonymousCommand, 'Send an anonymous message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableTwitchCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.TwitchCommand, 'Twitch message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableYoutubeCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.YoutubeCommand, 'YouTube message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableTwitterCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.TwitterCommand, 'Twitter message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnablePoliceCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.PoliceCommand, 'Police message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableAmbulanceCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AmbulanceCommand, 'Ambulance message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.TimeOutPlayers then
		TriggerEvent('chat:addSuggestion', '/'..Config.TimeOutCommand, 'Mute player', {
			{ name="id", help="id of the player to mute" },
			{ name="time", help="time in minutes" }
		})

		TriggerEvent('chat:addSuggestion', '/'..Config.RemoveTimeOutCommand, 'Unmute player', {
			{ name="id", help="id of the player to unmute" }
		})
	end

	if Config.EnableMe then
		TriggerEvent('chat:addSuggestion', '/'..Config.MeCommand, 'Send a me message', {
			{ name="action", help="me action" }
		})
	end

	if Config.EnableTry then
		TriggerEvent('chat:addSuggestion', '/'..Config.TryCommand, 'Send a try message', {
			{ name="action", help="try action" }
		})
	end

	if Config.EnableDo then
		TriggerEvent('chat:addSuggestion', '/'..Config.DoCommand, 'Send a do message', {
			{ name="action", help="do action" }
		})
	end
end)