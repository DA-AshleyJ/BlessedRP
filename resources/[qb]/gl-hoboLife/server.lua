local QBCore = exports['qb-core']:GetCoreObject()
local bucketMade = false
local owner, bucketTotal, betAmount = 0, 0, 0

RegisterServerEvent('gl-hoboLife:addItem', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = math.random(1,Config.MaxItemAmount)
	local item = Config.LootTable[math.random(#Config.LootTable)]
	if Config.SometimesFindNothing then
		local chance = math.random(1,5)
		if chance > 2 then
			Player.Functions.AddItem(item, amount)
        	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
		else
			TriggerClientEvent('QBCore:Notify', src, 'Nothing of value was inside.', 'error')
		end
	else
		Player.Functions.AddItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
	end
end)

RegisterServerEvent('gl-hoboLife:checkBet', function(amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetMoney("cash") >= amount then
		Player.Functions.RemoveMoney("cash", amount)
		betAmount = amount
		TriggerClientEvent('gl-hoboLife:betAccepted', src)
	end
end)

RegisterServerEvent('gl-hoboLife:checkItems', function(item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local itemCount = Player.Functions.GetItemByName(item)

	if not itemCount or itemCount.amount < 1 then
		Player.Functions.AddItem(item, 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", 1)
	end
end)

RegisterServerEvent('gl-hoboLife:choice', function(choice)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local npcChoice = math.random(1,3)

	if choice == npcChoice then
		TriggerClientEvent('QBCore:Notify', src, 'You.. You must of cheated.', 'success')
		Player.Functions.AddMoney("cash", betAmount * 2)
	else
		TriggerClientEvent('QBCore:Notify', src, 'Did you even have your eyes open? Haha.', 'error')
	end
end)

RegisterServerEvent('gl-hoboLife:takeTrash', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = math.random(Config.MinMoney,Config.MaxMoney)
	Player.Functions.AddMoney("cash", amount)
	TriggerClientEvent('QBCore:Notify', src, amount .. Config.MoneyMessage, 'error')
end)

RegisterServerEvent('gl-hoboLife:makeBucket',function()
	local src = source
	owner = src
	if bucketMade then
		TriggerClientEvent('QBCore:Notify', src, 'You should wait till the current begger is done.', 'error')
	else
		bucketMade = true
		TriggerClientEvent('gl-hoboLife:makeBucketZone',-1, owner)
		Wait(240000)
		bucketMade = false
	end
end)

RegisterServerEvent('gl-hoboLife:updateBucket', function()
	bucketMade = false	
end)

RegisterServerEvent('gl-hoboLife:donateMoney', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetMoney("cash") >= 5 then
		Player.Functions.RemoveMoney("cash", 5)
		bucketTotal = bucketTotal + 5
		TriggerClientEvent('QBCore:Notify', src, 'You added $5 to the bucket.', 'primary')
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough money to give', 'error')
	end
end)

RegisterServerEvent('gl-hoboLife:takeMoney', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if src == owner then
		if bucketTotal > 0 then
			Player.Functions.AddMoney("cash", bucketTotal)
			TriggerClientEvent('QBCore:Notify', src, 'You made a total of ' .. bucketTotal, 'success')
			bucketTotal = 0
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 'What kind of scum tries to steal from the homeless.', 'error')
	end
end)


RegisterServerEvent('gl-hoboLife:findFood', function(food)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if food > 0 then
		local item = Config.RatLoot[math.random(#Config.RatLoot)]
		Player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", 1)
	else
		TriggerClientEvent('QBCore:Notify', src, 'Your Rat has no food', 'error')
	end
end)

QBCore.Functions.CreateUseableItem("sign", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('sign') ~= nil then
        TriggerClientEvent('gl-hoboLife:useSign',source)
    end
end)

QBCore.Functions.CreateUseableItem("sleepingbag", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('sleepingbag') ~= nil then
        TriggerClientEvent('gl-hoboLife:placeBed',source)
    end
end)

QBCore.Functions.CreateUseableItem("cratechair", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('cratechair') ~= nil then
        TriggerClientEvent('gl-hoboLife:placeChair',source)
    end
end)

QBCore.Functions.CreateUseableItem("piccolo", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('piccolo') ~= nil then
        TriggerClientEvent('gl-hoboLife:piccoloOfRats',source)
    end
end)

QBCore.Functions.CreateUseableItem("bucket", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('bucket') ~= nil then
        TriggerClientEvent('gl-hoboLife:sendBucketServer',source)
    end
end)