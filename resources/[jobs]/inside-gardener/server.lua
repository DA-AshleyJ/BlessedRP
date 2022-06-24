QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('inside-gardener:checkMoney', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local name = QBCore.Functions.GetPlayer(source)

	if xPlayer.PlayerData.money.cash >= Config.DepositPrice then
        xPlayer.Functions.RemoveMoney('cash', Config.DepositPrice)
		cb(true)
    elseif xPlayer.PlayerData.money.bank >= Config.DepositPrice then
        xPlayer.Functions.RemoveMoney('bank', Config.DepositPrice)
        cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('inside-gardener:returnVehicle')
AddEventHandler('inside-gardener:returnVehicle', function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local Payout = Config.DepositPrice
	
	xPlayer.Functions.AddMoney("bank", Config.DepositPrice)
end)

RegisterServerEvent('inside-gardener:Payout')
AddEventHandler('inside-gardener:Payout', function(salary, arg)	
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local Payout = salary * arg
	
	xPlayer.Functions.AddMoney("cash", Payout)
end)