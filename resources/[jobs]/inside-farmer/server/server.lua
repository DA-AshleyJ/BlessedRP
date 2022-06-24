QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('inside-farmer:payout')
AddEventHandler('inside-farmer:payout', function(AmountPayoutC, AmountPayoutL, AmountPayoutP)	
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local Payout = Config.PayoutC * AmountPayoutC
	Payout = Payout + Config.PayoutL *  AmountPayoutL
	Payout = Payout + Config.PayoutP *  AmountPayoutP
	xPlayer.Functions.AddMoney("cash", Payout)
	Payout = 0
end)
