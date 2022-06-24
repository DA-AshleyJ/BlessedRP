
QBCore = exports['qb-core']:GetCoreObject()
Examcache = {}
Users = {}

Citizen.CreateThread(function()
    Citizen.Wait(500)
    LoadDatabase()
end)

function LoadDatabase()
	print("[qb-dmvschool] Fetching Database!")
	exports.oxmysql:execute("SELECT * FROM players WHERE 1",{},function(info)
        for _, v in ipairs(info) do
			if QBCore.Functions.GetPlayerByCitizenId(v.citizenid) then
				v.online = true
			else
				v.online = false
			end
			local metadata = json.decode(v.metadata)
			local playerlicense = metadata.licences
			if playerlicense["driverexam"] then
				v.name = json.decode(v.charinfo).firstname .. ' ' .. json.decode(v.charinfo).lastname
				Users[v.citizenid] = v
			end
		end	
	end)
	Citizen.SetTimeout(60000*5,function()
        LoadDatabase()
    end)
end

QBCore.Functions.CreateCallback('qb-dmvschool:GetLicensesData', function(source, cb)
	cb(Cachedata)
end)

RegisterNetEvent('qb-dmvschool:addLicense')
AddEventHandler('qb-dmvschool:addLicense', function(cid, type, state)
	if state then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		local xPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
		if xPlayer then
			local licenses = xPlayer.PlayerData.metadata["licences"]
			licenses[type] = true
			xPlayer.Functions.SetMetaData("licences", licenses)
			TriggerClientEvent('QBCore:Notify', xPlayer.PlayerData.source, "you passed! Pick up your driver's license at the town hall", "success", 10000)
			TriggerClientEvent('QBCore:Notify', source, "You issued driver's license..", "success")
		else
			exports.oxmysql:execute("SELECT * FROM `players` WHERE `citizenid` = '" .. cid .. "' LIMIT 1", function(result)
				for index, data in ipairs(result) do
					local metadata = json.decode(data.metadata)
					local playerlicense = metadata.licenses
					playerlicense[type] = true
					exports.ghmattimysql:execute("UPDATE `players` SET `metadata` = '"..json.encode(metadata).."' WHERE `citizenid` = '".. cid .."'")
				end
			end)
			TriggerClientEvent('QBCore:Notify', source, "You issued driver's license..", "success")
		end
	else
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		local xPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
		if xPlayer then
			TriggerClientEvent('QBCore:Notify', xPlayer.PlayerData.source, "your driver's license application has been declined try again after 24 hours", "error", 10000)
			TriggerClientEvent('QBCore:Notify', source, "You declined driver's license application..", "error")
		else
			TriggerClientEvent('QBCore:Notify', source, "You declined driver's license application..", "error")
		end
	end
end)

RegisterCommand("tes", function(source, args, rawCommand)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local licenses = Player.PlayerData.metadata["licences"]
	licenses = {}
	Player.Functions.SetMetaData("licences", licenses)

	print(json.encode(licenses))

end, false)


RegisterNetEvent('qb-dmvschool:server:completeexam')
AddEventHandler('qb-dmvschool:server:completeexam', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('QBCore:Notify', src, "You passed the test, congratulations!", "success")
	local licenses = Player.PlayerData.metadata["licences"]
	licenses["driverexam"] = true
	Player.Functions.SetMetaData("licences", licenses)
end)


RegisterNetEvent('qb-dmvschool:server:startexam')
AddEventHandler('qb-dmvschool:server:startexam', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Examcache[Player.PlayerData.citizenid] == nil then
		Examcache[Player.PlayerData.citizenid] = true
		if Player.Functions.RemoveMoney("cash", Config.Prices.exam) then
			TriggerClientEvent('QBCore:Notify', src, "You paid $"..Config.Prices.exam.." to the DMV School", "success")
			TriggerClientEvent("qb-dmvschool:client:startexam", src)
		else
			TriggerClientEvent('QBCore:Notify', src, "You don't have enough money to pay..", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "You need to wait 24 hours before give exam again..", "error")
	end
end)

RegisterNetEvent('qb-dmvschool:server:starttest')
AddEventHandler('qb-dmvschool:server:starttest', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local driverlicense = Player.PlayerData.metadata["licences"]["driverexam"]
	if driverlicense then
		if Player.Functions.RemoveMoney("cash", Config.Prices.test) then
			TriggerClientEvent('QBCore:Notify', src, "You paid $"..Config.Prices.test.." to the DMV School", "success")
			TriggerClientEvent("qb-dmvschool:client:starttest", src, data.dtype)
		else
			TriggerClientEvent('QBCore:Notify', src, "You don't have enough money to pay..", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "Please complete exam before give driving test..", "error")
	end
end)

RegisterNetEvent('qb-dmvschool:server:completetest')
AddEventHandler('qb-dmvschool:server:completetest', function(type)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local licenses = Player.PlayerData.metadata["licences"]
	licenses[type] = true
	Player.Functions.SetMetaData("licences", licenses)
end)


QBCore.Functions.CreateCallback("qb-dmvschool:updateInfo",function(source, cb)
    local Data = {}
	exports.oxmysql:execute("SELECT * FROM qb_dmv WHERE 1",{},function(applications)
		for _, g in ipairs(applications) do
			Data[g.id] = {
				citizenid = g.citizenid,
				type = g.type,
				created = g.created,
				mistakes = g.mistakes
			}
		end
		cb(Data)
	end)
end)

QBCore.Functions.CreateCallback("qb-dmvschool:getUsers",function(source, cb)
    cb(Users)
end)

RegisterServerEvent("qb-dmvschool:updatelicenses")
AddEventHandler("qb-dmvschool:updatelicenses",function(id)
	exports.oxmysql:execute('DELETE FROM qb_dmv WHERE id = ?', { id })
end)


RegisterServerEvent("qb-dmvschool:createapplication")
AddEventHandler("qb-dmvschool:createapplication",function(type, mistakes)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	exports.oxmysql:execute("INSERT INTO `qb_dmv`(`id`, `type`, `citizenid`, `mistakes`, `created`) VALUES (@id,@type,@citizenid,@mistakes, @created)",
		{
			["@id"] = type..GetNewID(type),
			["@type"] = type,
			["@citizenid"] = Player.PlayerData.citizenid,
			["@mistakes"] = mistakes,
			["@created"] = os.time()
		},
		function()
	end)
end)



function GetNewID(type)
    local count = 1
    local query = '%' .. type .. '%'
    local result = exports.oxmysql:executeSync('SELECT * FROM qb_dmv WHERE type LIKE ?', {query})
    if result[1] then
        for i = 1, #result, 1 do
            count = count + 1
        end
    end
    return count
end
