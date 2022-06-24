local playersProcessingCocaLeaf = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:pickedUpCocaLeaf')
AddEventHandler('ps-drugprocessing:pickedUpCocaLeaf', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("coca_leaf", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["coca_leaf"], "add")
	TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coca_leaf"), "success")
end)

RegisterServerEvent('ps-drugprocessing:processCocaLeaf')
AddEventHandler('ps-drugprocessing:processCocaLeaf', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('coca_leaf', Config.CokeProcessing.CokeLeaf)
	Player.Functions.AddItem('coke', Config.CokeProcessing.ProcessCokeLeaf)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", Config.CokeProcessing.CokeLeaf)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "add", Config.CokeProcessing.ProcessCokeLeaf)
	TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke"), "success")
end)

RegisterServerEvent('ps-drugprocessing:processCocaPowder')
AddEventHandler('ps-drugprocessing:processCocaPowder', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('coke', Config.CokeProcessing.Coke)
	Player.Functions.RemoveItem('bakingsoda', Config.CokeProcessing.BakingSoda)
	Player.Functions.AddItem('coke_small_brick', Config.CokeProcessing.SmallCokeBrick)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "remove", Config.CokeProcessing.Coke)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", Config.CokeProcessing.BakingSoda)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_small_brick'], "add", Config.CokeProcessing.SmallCokeBrick)
	TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke_small_brick"), "success")
end)

RegisterServerEvent('ps-drugprocessing:processCocaBrick')
AddEventHandler('ps-drugprocessing:processCocaBrick', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('coke_small_brick', Config.CokeProcessing.SmallBrick)
	Player.Functions.AddItem('coke_brick', Config.CokeProcessing.LargeBrick)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_small_brick'], "remove", Config.CokeProcessing.SmallBrick)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_brick'], "add", Config.CokeProcessing.LargeBrick)
	TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke_brick"), "success")
end)

function CancelProcessing(playerId)
	if playersProcessingCocaLeaf[playerId] then
		ClearTimeout(playersProcessingCocaLeaf[playerId])
		playersProcessingCocaLeaf[playerId] = nil
	end
end

RegisterServerEvent('ps-drugprocessing:cancelProcessing')
AddEventHandler('ps-drugprocessing:cancelProcessing', function()
	CancelProcessing(source)
end)

