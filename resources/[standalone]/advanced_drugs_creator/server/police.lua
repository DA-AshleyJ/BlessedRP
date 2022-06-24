local policeMembers = {}
local onlinePolice = 0

function getPoliceMembers()
	return policeMembers
end

function isThereEnoughPolice(activity)
	if(activity == "plane_selling") then
		return onlinePolice >= config.planeSellingMinimumPolice
	elseif(activity == "boat_selling") then
		return onlinePolice >= config.boatSellingMinimumPolice
	elseif(activity == "npc_selling") then
		return onlinePolice >= config.npcSellingMinimumPolice
	elseif(activity == "pusher_selling") then
		return onlinePolice >= config.pushersSellingMinimumPolice
	elseif(activity == "narcos_selling") then
		return onlinePolice >= config.narcosSellingMinimumPolice
	elseif(activity == "harvestable_items") then
		return onlinePolice >= config.harvestingItemsMinimumPolice
	elseif(activity == "use_laboratory") then
		return onlinePolice >= config.useLaboratoryMinimumPolice
	elseif(activity == "harvest_field") then
		return onlinePolice >= config.harvestFieldMinimumPolice
	end
end
local function countPolice()
	policeMembers = {}
	onlinePolice = 0

	for k, playerId in pairs( GetPlayers() ) do
		local jobName = Framework.getPlayerJobName( tonumber(playerId) )

		if(POLICE_JOBS_NAMES[jobName] and Framework.isPlayerOnDuty(playerId) ) then
			onlinePolice = onlinePolice + 1
			policeMembers[playerId] = true
		end
	end
end
local function addPoliceMember(playerId)
	onlinePolice = onlinePolice + 1
	policeMembers[playerId] = true
end

local function removePoliceMember(playerId)
	policeMembers[playerId] = nil
	onlinePolice = onlinePolice - 1
end

RegisterNetEvent('esx:playerLoaded', function(playerId, xPlayer) 
	if(POLICE_JOBS_NAMES[xPlayer.job.name]) then
		addPoliceMember(playerId)
	end
	
end)
RegisterNetEvent("QBCore:Server:PlayerLoaded", function(xPlayer)
	local playerId = xPlayer.PlayerData.source
	local jobName = xPlayer.PlayerData.job.name

    if(POLICE_JOBS_NAMES[jobName] and Framework.isPlayerOnDuty(playerId)) then
		addPoliceMember(playerId)
	end
end)

RegisterNetEvent('playerDropped', function (reason)
	local playerId = source

	if(policeMembers[playerId]) then
		removePoliceMember(playerId)
	end
end)

RegisterNetEvent('esx:setJob', function(playerId, newJob, oldJob) 
	if(policeMembers[playerId]) then
		if(newJob.name ~= oldJob.name) then
			removePoliceMember(playerId)
		end
	elseif(POLICE_JOBS_NAMES[newJob.name]) then
		addPoliceMember(playerId)
	end
end)

-- Removes or adds the player to police list if the job is correct and the player is on duty
RegisterNetEvent("QBCore:ToggleDuty", function()
	local playerId = source

	Citizen.Wait(1000)

	local jobName = Framework.getPlayerJobName(playerId)

	if(POLICE_JOBS_NAMES[jobName]) then
		if(policeMembers[playerId] and not Framework.isPlayerOnDuty(playerId)) then
			removePoliceMember(playerId)
		elseif(not policeMembers[playerId] and Framework.isPlayerOnDuty(playerId)) then
			addPoliceMember(playerId)
		end
	end
end)

RegisterNetEvent(Utils.eventsPrefix .. ":framework:ready", function()
	countPolice()
end)