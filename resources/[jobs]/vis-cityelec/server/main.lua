local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('Elec:getexperience', function(source, cb)
	local PlayerData = QBCore.Functions.GetPlayer(source)
	local result = exports.oxmysql:executeSync('SELECT * FROM rev_jobs WHERE citizenid=@identifier', {['@identifier'] = PlayerData.PlayerData.citizenid})
	if result[1] ~= nil then
		cb(tonumber(result[1].elecexperience))
	else
		exports.oxmysql:execute('INSERT INTO rev_jobs (citizenid, elecexperience) VALUES (@identifier, @elecexperience)', {
			['@identifier'] = PlayerData.PlayerData.citizenid,
			['@elecexperience'] = 1,
		})
	end
end)

QBCore.Functions.CreateCallback('Elec:checkMoney', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)

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

RegisterServerEvent('Elec:returnVehicle')
AddEventHandler('Elec:returnVehicle', function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local Payout = Config.DepositPrice
	
	xPlayer.Functions.AddMoney("bank", Config.DepositPrice)
end)

RegisterServerEvent('Elec:Payout')
AddEventHandler('Elec:Payout', function(salary, arg)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local result = exports.oxmysql:executeSync('SELECT * FROM rev_jobs WHERE citizenid=@identifier', {['@identifier'] = xPlayer.PlayerData.citizenid})
	
	if result[1] ~= nil then
		exp = result[1].elecexperience
		experience = arg*math.random((math.ceil((1/(Config.MinExpDrop*math.ceil(exp/1000))))), arg*(math.ceil((1/(Config.MaxExpDrop*math.ceil(exp/1000))))))
		playerexp = result[1].elecexperience + experience
		exports.oxmysql:execute('UPDATE rev_jobs SET elecexperience=@experience WHERE citizenid=@identifier', {
			['@experience'] = playerexp,
			['@identifier'] = xPlayer.PlayerData.citizenid
		})
	else
		exports.oxmysql:execute('INSERT INTO rev_jobs (citizenid, elecexperience) VALUES (@identifier, @experience)', {
			['@experience'] = 1,
			['@identifier'] = xPlayer.PlayerData.citizenid
		})
	end
	local levelmodifier = math.ceil(experience/1000)/(2*(math.exp(1)))  -- Creates the modifier used to affect your pay, this means that your pay increases by about 20% each level
	local Payout = salary * arg * levelmodifier
	
	xPlayer.Functions.AddMoney("cash", Payout)
end)