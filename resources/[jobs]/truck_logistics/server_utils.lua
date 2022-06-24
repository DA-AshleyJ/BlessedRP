-- Framework init
QBCore = exports['qb-core']:GetCoreObject()

function beforeBuyTruck(source,truck_name,price,user_id)
	-- Here you can do any verification when a player is buying an truck, like if player has driver license or anything else you want to check before buy the truck. return true or false
	return true
end

function beforeBuyLocation(source,user_id)
	-- Here you can do any verification when a player is opening the trucker UI for the first time, like if player has the permission or money to that or anything else you want to check. return true or false
	return true
end

-- Change the mysql driver there. Remove the mysql-async from fxmanifest
function MySQL_Sync_execute(sql,params)
	MySQL.Sync.execute(sql, params)
	-- exports['ghmattimysql']:executeSync(sql, params)
end

function MySQL_Sync_fetchAll(sql,params)
	return MySQL.Sync.fetchAll(sql, params)
	-- return exports['ghmattimysql']:executeSync(sql, params)
end

function getTopTruckers()
	local sql = [[SELECT U.name, T.user_id, T.exp, T.traveled_distance 
		FROM trucker_users T 
		INNER JOIN players U ON (T.user_id = U.citizenid)
		WHERE traveled_distance > 0 ORDER BY traveled_distance DESC LIMIT 10]];
	return MySQL_Sync_fetchAll(sql,{});
end

function hasTruckerJob(source, xPlayer)
	local PlayerJob = xPlayer.PlayerData.job
	if Config.debugJob then
		print("Job name: "..PlayerJob.name)
		print(PlayerJob.onduty)
	end
	if PlayerJob.onduty and PlayerJob.name == Config.job then
		return true
	else
		return false
	end
end