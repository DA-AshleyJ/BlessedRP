-- You can edit the notification used in the script here.
AddEventHandler('mechanic:tablet:notification', function(message)
 TriggerEvent('chat:addMessage', {color = {255, 255, 255}, args = {"^8SYSTEM", message}})
end)
