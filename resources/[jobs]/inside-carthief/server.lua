QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('inside-carthief:Payout')
AddEventHandler('inside-carthief:Payout', function(Payout, arg, CarLabel)	
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local Payment = Payout * arg
	
	xPlayer.Functions.AddMoney('cash', Payment)
    TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>John</b></br>You earned <b style='color: red;'>" ..Payment.. "$</b> Black Money for stealing <b style='color: #3bf5c3;'>" ..CarLabel.. "</b>!", timeout = 3000})
end)

-- QBCore.Functions.CreateCallback('inside-carthief:PoliceOnDuty', function(source, cb)
--     police = 0

-- 		for _, playerId in pairs(ESX.GetPlayers()) do
-- 			xPlayer = QBCore.Functions.GetPlayer(playerId)
-- 			if xPlayer.job.name == 'police' then
-- 				police = police + 1
-- 			end
-- 		end
--     cb(police)
-- end)