local QBCore = exports['qb-core']:GetCoreObject()

-- Ballas, Families, Vagos (Prison Gangs for DB)
QBCore.Functions.CreateCallback("gl-prison:getGangAffil", function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    	exports.oxmysql:execute('SELECT * FROM gl_pgangs WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
	}, function (result)
		cb(result)
	end)
end)

RegisterServerEvent('gl-prison:joinPrisonGang', function(gang)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	exports.oxmysql:execute('SELECT * FROM gl_pgangs WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
	}, function (result)
		local ifOwner = table.unpack(result)
		if ifOwner ~= nil then
			print('You are in another gang') -- Add notification here
			TriggerClientEvent('QBCore:Notify', _source, 'You are in another gang', 'error')
		else
			print('You joined a gang!') -- Add notification here
			TriggerClientEvent('QBCore:Notify', _source, 'You joined a gang!', 'primary')
			exports.oxmysql:execute('INSERT INTO gl_pgangs (identifier, gang) VALUES (@identifier, @gang)',
			{
				['@identifier']   = xPlayer.PlayerData.citizenid,
				['@gang']   = gang,
			}, function (rowsChanged)
			end)
		end
	end)
end)

RegisterServerEvent('gl-prison:updatePrisonRep',function(reputation,sSource)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer == nil then
    	xPlayer = QBCore.Functions.GetPlayer(sSource)
    exports.oxmysql:execute('UPDATE gl_pgangs SET reputation = @reputation WHERE identifier = @identifier', {
		['@reputation'] = reputation,		
		['@identifier']   = xPlayer.PlayerData.citizenid,
	}, function(rowsChanged)

	end)
    end
	exports.oxmysql:execute('UPDATE gl_pgangs SET reputation = @reputation WHERE identifier = @identifier', {
		['@reputation'] = reputation,		
		['@identifier']   = xPlayer.PlayerData.citizenid,
	}, function(rowsChanged)

	end)
end)



-- Drug Stuff

RegisterServerEvent('gl-prison:checkDrugIngredients',function()
local xPlayer = QBCore.Functions.GetPlayer(source)
local canMix = true

	for k, v in pairs(Config.DrugIngredients) do
		if xPlayer.Functions.GetItemByName(k).count < v then
			canMix = false
		end
	end
		if canMix then
			for k, v in pairs(Config.DrugIngredients) do
				xPlayer.Functions.RemoveItem(k, v)

			end
			TriggerClientEvent('gl-prison:doTheMixing',source)
			Wait(30000)
			xPlayer.Functions.AddItem(Config.UnprocessedName,1)
		end
end)

RegisterServerEvent('gl-prison:bakeDrugs',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local drugItem = xPlayer.Functions.GetItemByName(Config.UnprocessedName).count
	if drugItem > 0 then
		xPlayer.Functions.RemoveItem(Config.UnprocessedName,1)
		TriggerClientEvent('gl-prison:doTheBaking',source)
	end
end)

RegisterServerEvent('gl-prison:drugReady',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.AddItem(Config.DrugName,Config.ProcessedAmount)
end)



-- Not Gang Stuff


RegisterServerEvent('gl-prison:checkCanCook',function(item,time,cost)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local itemC = xPlayer.Functions.GetItemByName('ingredients').count
	if itemC >= cost then
		xPlayer.Functions.RemoveItem('ingredients',cost)
		TriggerClientEvent('gl-prison:beginCookFood',source,time, cost)
		Wait(time)
		xPlayer.Functions.AddItem(item,1)
	end

end)

RegisterServerEvent('gl-prison:checkIngredients',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local itemC = xPlayer.Functions.GetItemByName('ingredients').count
	if itemC < 20 then
		local doSomeMath = 20 - itemC
		xPlayer.Functions.AddItem('ingredients',doSomeMath)
	end
end)


RegisterServerEvent('gl-prison:tryTakeItem',function(item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local itemC = xPlayer.Functions.GetItemByName(item).count
	if itemC < 3 then
		xPlayer.Functions.AddItem(item,1)
	end
end)

RegisterNetEvent('gl-prison:turnInJob',function(job)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if job == 'Cook' then
		local itemC = xPlayer.Functions.GetItemByName('prisonmeal').count
		xPlayer.Functions.RemoveItem('prisonmeal',itemC)
	end

	if Config.GiveMoney then
		xPlayer.Functions.AddMoney('cash', Config.MoneyReward)
	elseif Config.GiveItem then
		xPlayer.Functions.AddItem(Config.ItemReward,Config.ItemAmount)
	end
end)

RegisterServerEvent('gl-prison:prisonerJob',function(item,amount)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local _source = source
	if item == nil then
		TriggerClientEvent('gl-prison:prisonJobDoThing',_source)
	else	
		local itemC = xPlayer.Functions.GetItemByName(item).count
		if itemC >= amount then
			xPlayer.Functions.RemoveItem(item,amount)
			TriggerClientEvent('gl-prison:prisonJobDoThing',_source)
		end
	end
end)

RegisterServerEvent('gl-prison:checkPrisonerJob',function(item,min,max,reputation)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local doSomeMathG = math.random(min,max)
	local newSource = source
	local newRep = reputation + Config.RepGains
	if item ~= nil then
		local itemC = xPlayer.Functions.GetItemByName(item).count
		if itemC >= 1 then
			xPlayer.Functions.RemoveItem(item,1)
			TriggerClientEvent("swt_notifications:Negative",source,'Done','Yo thanks man, take this.','top',8000,true)
			xPlayer.Functions.AddItem(Config.PrisonReward,doSomeMathG)
			TriggerEvent('gl-prison:updatePrisonRep',newRep,newSource)
		end
	else
		xPlayer.Functions.AddItem(Config.PrisonReward,doSomeMathG)
		TriggerEvent('gl-prison:updatePrisonRep',newRep,newSource)
	end

end)

RegisterServerEvent('gl-prison:checkTrade',function(item,cost)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local itemC = xPlayer.Functions.GetItemByName(Config.PrisonReward).count
	if itemC >= cost then
		xPlayer.Functions.RemoveItem(Config.PrisonReward,cost)
		xPlayer.Functions.AddItem(item,1)
	end
end)

RegisterServerEvent('gl-prison:alarmSounded',function()
	TriggerClientEvent('gl-prison:breakOutAlarm',-1)
end)

-- Recreational Stuff

RegisterServerEvent('gl-prison:sendDeleteBall',function(ballID)
	TriggerClientEvent('gl-prison:deleteBall',-1,ballID)
end)

RegisterServerEvent('gl-prison:syncBall',function(ballID)
	TriggerClientEvent('gl-prison:syncBall',-1,ballID)
end)

RegisterServerEvent('gl-prison:sendDeleteBasketBall',function(ballBasketID)
	TriggerClientEvent('gl-prison:deleteBasketBall',-1,ballBasketID)
end)

RegisterServerEvent('gl-prison:syncBasketBall',function(ballBasketID)
	TriggerClientEvent('gl-prison:syncBasketBall',-1,ballBasketID)
end)

-- Sync Tossed Drugs
RegisterServerEvent('gl-prison:syncTossedDrug',function(drugID)
	TriggerClientEvent('gl-prison:syncTossedDrug',-1,drugID)
end)


-- Open Drug Bag
RegisterServerEvent('gl-prison:openedDrugBag',function(drugID)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.AddItem(Config.DrugName,40)
	TriggerClientEvent("gl-prison:deleteDrugBag", -1, drugID)
end)

-- Pack Drug Bag 
RegisterServerEvent('gl-prison:packDrugBag',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local bag = xPlayer.Functions.GetItemByName('drugbag').count
	local drug = xPlayer.Functions.GetItemByName(Config.DrugName).count
	if bag > 0 and drug >= 40 then
		xPlayer.Functions.AddItem('fullbag',1)
		xPlayer.Functions.RemoveItem(Config.DrugName,40)
		xPlayer.Functions.RemoveItem('drugbag',1)		
	end
end)



-- Commissary
RegisterServerEvent('gl-prison:buyFromCom',function(item,cost,curr)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if curr == 'money' then
		if xPlayer.PlayerData.money['cash'] >= cost then
			xPlayer.Functions.RemoveMoney('cash', cost)
			xPlayer.Functions.AddItem(item,1)
		else
			local itemC = xPlayer.Functions.GetItemByName(curr).count
			if itemC >= cost then
				xPlayer.Functions.RemoveItem(curr,cost)
				xPlayer.Functions.AddItem(item,1)
			end
		end
	end
end)


-- Jailing Stuff

-- QBCore.Functions.CreateCallback("gl-prison:getPlayerTimer", function(source, cb)
-- 	local xPlayer = QBCore.Functions.GetPlayer(source)
-- 
-- 	exports.oxmysql:execute('SELECT jail FROM users WHERE identifier = @identifier', {
-- 		['@identifier'] = xPlayer.PlayerData.citizenid,
-- 	}, function (result)
-- 		local timeLeft = tonumber(result[1].jail)
-- 		if timeLeft > 0 then
-- 			cb(true,timeLeft)
-- 		else
-- 			cb(false,0)
-- 		end
-- 	end)
-- end)

RegisterServerEvent('prison:server:SetJailStatus', function(jailTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("injail", jailTime)
    -- if jailTime > 0 then
    --     if Player.PlayerData.job.name ~= "unemployed" then
    --         Player.Functions.SetJob("unemployed")
    --         TriggerClientEvent('QBCore:Notify', src, "You're unemployed..")
    --     end
    -- end
end)

RegisterServerEvent('prison:server:SaveJailItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = 10
    if Player.PlayerData.metadata["jailitems"] == nil or next(Player.PlayerData.metadata["jailitems"]) == nil then 
        Player.Functions.SetMetaData("jailitems", Player.PlayerData.items)
        Player.Functions.AddMoney('cash', 80)
        Citizen.Wait(2000)
        Player.Functions.ClearInventory()
    end
end)

RegisterServerEvent('prison:server:GiveJailItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.ClearInventory()
    Citizen.Wait(1000)
    for k, v in pairs(Player.PlayerData.metadata["jailitems"]) do
        Player.Functions.AddItem(v.name, v.amount, false, v.info)
    end
    Citizen.Wait(1000)
    Player.Functions.SetMetaData("jailitems", {})
end)

RegisterServerEvent('gl-prison:foundBedItem',function(item,amount)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.AddItem(item,amount)
end)

-- Sangria

QBCore.Functions.CreateUseableItem('sangria', function(source)
        
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveItem('sangria', 1)

	TriggerClientEvent('gl-prison:onSangria', source)
end)

-- Tinfoil

QBCore.Functions.CreateUseableItem('tinfoil', function(source)
        
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveItem('tinfoil', 1)
	xPlayer.Functions.AddItem('foilpipe',1)


end)

-- Tinfoil Pipe (To smoke Mud)

QBCore.Functions.CreateUseableItem('foilpipe', function(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local mudCount = xPlayer.Functions.GetItemByName(Config.DrugName).count
	if mudCount > 0 then
		xPlayer.Functions.RemoveItem(Config.DrugName,1)
		TriggerClientEvent('gl-prison:onMud', source)
	end
end)


-- Add Throwing Drugs and Throwing Money

QBCore.Functions.CreateUseableItem('drugbag', function(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local mudCount = xPlayer.Functions.GetItemByName(Config.DrugName).count
	if mudCount > 0 then
		xPlayer.Functions.RemoveItem(Config.DrugName,40)
		xPlayer.Functions.RemoveItem('drugbag',1)
		xPlayer.Functions.AddItem('fullbag',1)
	end
end)

QBCore.Functions.CreateUseableItem('fullbag', function(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveItem('fullbag',1)
	TriggerClientEvent('gl-prison:throwFullBag',source)
end)
