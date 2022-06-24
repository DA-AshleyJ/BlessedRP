--[[------------------------------------------------------------------------------
  -- File         : /server/server.lua
  -- Created Date : Monday April 28 2020
  -- Purpose      : Registers serverside events
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

RegisterServerEvent("ELS:UpdateStatus")

AddEventHandler("ELS:UpdateStatus", function(type, status)
    TriggerClientEvent("ELS:UpdateLights", -1, source, type, status)
end)

RegisterServerEvent("ELS:UpdateSiren")

AddEventHandler("ELS:UpdateSiren", function(status)
    TriggerClientEvent("ELS:UpdateSiren", -1, source, status)
end)

RegisterServerEvent("ELS:ToggleBullhorn")

AddEventHandler("ELS:ToggleBullhorn", function(status)
    TriggerClientEvent("ELS:ToggleBullHorn", -1, source, status)
end)

RegisterNetEvent("ELS:ToggleSpotlight")

AddEventHandler("ELS:ToggleSpotlight", function(status)
    TriggerClientEvent("ELS:ToggleSpotlight", -1, source, status)
end)

RegisterNetEvent("ELS:UpdateSpotlight")

AddEventHandler("ELS:UpdateSpotlight", function(newX, newY, newZ)
    TriggerClientEvent("ELS:UpdateSpotlight", -1, source, newX, newY, newZ)
end)

RegisterNetEvent("ELS:UpdateStage")

AddEventHandler("ELS:UpdateStage", function(stage)
    TriggerClientEvent("ELS:UpdateStage", -1, source, stage)
end)

RegisterNetEvent("ELS:UpdateIndicator")

AddEventHandler("ELS:UpdateIndicator", function(indicator, status)
    TriggerClientEvent("ELS:UpdateIndicator", -1, source, indicator, status)
end)