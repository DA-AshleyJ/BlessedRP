local currentID = nil
local callbackFunc

AddEventHandler("DimboPassHack:StartHack", function(diff, cb)
    if callbackFunc ~= nil then HVCore.Functions.Notify("Unable to start a password hack while already hacking!", "error") return end

    callbackFunc = cb

    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "show",
        diff = diff,
    })
end)

-- RegisterCommand("pass", function()
--     TriggerEvent("DimboPassHack:StartHack", 2, function(pass)
--         print(pass)
--     end)
-- end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
	cb('ok')
end)


RegisterNUICallback('passHack', function(data, cb)
	SetNuiFocus(false, false)
	cb('ok')

    callbackFunc(true)
    callbackFunc = nil
end)

RegisterNUICallback('failHack', function(data, cb)
	SetNuiFocus(false, false)
	cb('ok')

    callbackFunc(false)
    callbackFunc = nil
end)