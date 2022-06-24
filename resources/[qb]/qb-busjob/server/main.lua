local QBCore = exports['qb-core']:GetCoreObject()

function NearBus(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.NPCLocations.Locations) do
        local dist = #(coords - vector3(v.x,v.y,v.z))
        if dist < 20 then
            return true
        end
    end
end
QBCore.Commands.Add("sendmoney", "Send A Player Cash", { { name = "id", help = "Player ID" }, { name = "amount", help = "Amount of money" } }, true, function(source, args)
	local src = source
	local target = tonumber(args[1])
	local amount = tonumber(args[2])
	local Player = QBCore.Functions.GetPlayer(src)
	local Target = QBCore.Functions.GetPlayer(target)
	if target and amount then
		if Target then
			if amount > 0 then
				if Player.PlayerData.money.cash > amount then
					Player.Functions.RemoveMoney("cash", amount)
					Target.Functions.AddMoney("cash", amount)
					TriggerClientEvent("QBCore:Notify", src, ("You sent $%s to %s %s"):format(amount, Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname), "primary")
					TriggerClientEvent("QBCore:Notify", Target.source, ("You received $%s from %s %s"):format(amount, Target.PlayerData.charinfo.firstname, Target.PlayerData.charinfo.lastname), "primary")
				else
					TriggerClientEvent("QBCore:Notify", src, ("You don't have $%s in your bank"):format(amount), "error")
				end
			else
				TriggerClientEvent("QBCore:Notify", src, "Amount must be greater than 0", "error")
			end
		else
			TriggerClientEvent("QBCore:Notify", src, ("Player %s is not online"):format(target), "error")
		end
	else
		TriggerClientEvent("QBCore:Notify", src, "Incorrect usage! Try /sendmoney [id] [amount]", "error")
	end
end, "user")

RegisterNetEvent('qb-busjob:server:NpcPay', function(Payment)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "bus" then
        if NearBus(src) then
            local randomAmount = math.random(1, 5)
            local r1, r2 = math.random(1, 5), math.random(1, 5)
            if randomAmount == r1 or randomAmount == r2 then Payment = Payment + math.random(10, 20) end
            Player.Functions.AddMoney('cash', Payment)
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)
