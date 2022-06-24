QBCore = nil
QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('inside-illegalordersType1:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForFirstOrder
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType2:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForSecondOrder
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType3:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForThirdOrder
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType4:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForFourthOrder
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType5:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForFifthOrder
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType6:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForSixthOrder
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType7:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForSeventhOrder
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

AddEventHandler('playerDropped', function()
    TriggerClientEvent('inside-illegalorders:removecars', source)
end)
