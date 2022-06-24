RegisterNetEvent('okokReportsV2:Notification')
AddEventHandler('okokReportsV2:Notification', function(text, id)
    exports['okokNotify']:Alert(Config.Notifications[id].title, text, Config.Notifications[id].time, Config.Notifications[id].type)
end)