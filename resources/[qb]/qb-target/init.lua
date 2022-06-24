function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 7.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha. Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = true

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = false

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 238

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {

}

Config.PolyZones = {
	
}

Config.TargetBones = {
	["main"] = {
		bones = {
			"door_dside_f",
			"door_dside_r",
			"door_pside_f",
			"door_pside_r",
			"steering",
			"hbgrip_l",
			"hbgrip_r"
		},
		options = {
			{
				type = "client",
				event = "tuningjob:client:menu:Checkvehicle",
				icon = "fa fa-search",
				label = "Examine Vehicle",
				job = "redline"
			},
	  },
	}
}

Config.TargetModels = {
	["-2095296433"] = {
        models = {
            "-2095296433", 
        },
        options = {
            {
                type = "client",
                event = "tuningjob:client:menu:main",
                icon = "",
                label = "Open crafting Menu",
			
            },
        },
        distance = 2.5,
    },
    ["acunitsearch"] = {
        models = {
			1709954128,
			-1625667924,
			1131941737,
            -1625667924,


        },
        options = {
            {
                type = "client",
                event = "qb-acunitsearch:client:searchaircon",
                icon = "fas fa-pencil-ruler",
                label = "Search Aircon",
            },
        },
        distance = 2.1
    },
    ["materialsrob"] = {
        models = {
            1709954128,
			1131941737,
			-1625667924,
			-2007495856,
			-1620823304,
			-2008643115,
        },
        options = {
            {
                type = "client",
                event = "qb-materialrobbery:client:RoubarCobre",
                icon = "fas fa-mask",
                label = "Rob Materials",
            },
        },
        distance = 1.5,
    },
	["atm"] = {
        models = {
            "prop_fleeca_atm",
			"-870868698", 
			"-1364697528",
			"prop_atm_02", 
			"prop_atm_01", 
        },
        options = {
            {
                type = "client",
                event = "okokBanking:OpenATM",
                icon = "",
                label = "Open ATM",
			
            },
        },
        distance = 2.5,
    },
	["burgershotgarage"] = {
		models = {
			"ig_floyd"
		},
		options = {
			{
				type = "client",
				event = "garage:BurgerShotGarage",
				icon = "fas fa-car",
				label = "BurgerShot Garage",
				job = "burgershot",
			},
		},
		distance = 2.5,
	},
	["bus"] = {
		models = {
			"cs_floyd"
		},
		options = {
			{
				type = "client",
				event = "bus:spawn",
				icon = "fas fa-car",
				label = "spawn bus",
			},
		},
		distance = 2.5,
	},
	["bus2"] = {
		models = {
			"ig_floyd"
		},
		options = {
			{
				type = "client",
				event = "bus:spawnbase",
				icon = "fas fa-car",
				label = "spawn bus",
			},
		},
		distance = 2.5,
	},
	["bus3"] = {
		models = {
			"s_m_m_dockwork_01"
		},
		options = {
			{
				type = "client",
				event = "bus:spawnsandy",
				icon = "fas fa-car",
				label = "spawn bus",
			},
		},
		distance = 2.5,
	},
	["bus4"] = {
		models = {
			"cs_lestercrest"
		},
		options = {
			{
				type = "client",
				event = "bus:spawncity",
				icon = "fas fa-car",
				label = "spawn bus",
			},
		},
		distance = 2.5,
	},
	["bus5"] = {
		models = {
			"cs_lestercrest"
		},
		options = {
			{
				type = "client",
				event = "bus:spawncoach",
				icon = "fas fa-car",
				label = "spawn coach",
			},
		},
		distance = 2.5,
	},
    ["quarry"] = {
		models = {
			"s_m_y_construct_02"
		},
		options = {
			{
				type = "client",
				event = "quarry:spawn",
				icon = "fas fa-car",
				label = "Spawn Truck",
			},
		},
		distance = 2.5,
	},
	["Armoury-guy"] = {
        models = {
            "s_m_y_cop_01"
        },
        options = {
            {
                type = "client",
                event = "qb-police:client:openArmoury",
                label = "Open Police Armoury",
                job = "police",
            }
        },
        distance = 2.5,
    },
	["dumpsters_1"] = {
        models = {
            "prop_dumpster_4b",
            "prop_dumpster_4a",
			"prop_dumpster_3a",
			"prop_dumpster_02b",
			"prop_dumpster_02a",
			"prop_dumpster_01a",
			"prop_snow_dumpster_01",
        },
        options = {
            {
                event = "qb-dumpster:client:dumpsterdive",
                icon = "fas fa-dumpster",
                label = "Check Dumpster",
            },
        },
        distance = 2.0,
    },
	["duty-woman"] = {
        models = {
            "s_f_y_cop_01"
        },
        options = {
            {
                type = "client",
                event = "qb-policejob:ToggleDuty",
                icon = "", 
                label = "On duty / Off duty",
                job = "police",
            }
        },
        distance = 2.5,
    },
      ["policegarage"] = {
        models = {
            'ig_trafficwarden',
        },
        options = {
            {
                type = "client",
                event = "garage:menu",
                icon = "fas fa-car",
                label = "Police Garage",
                job = "police",
            },
        },
    distance = 3.5,
    },
	["ambulancegarage"] = {
        models = {
            's_m_m_paramedic_01',
        },
        options = {
            {
                type = "client",
                event = "garage1:menu",
                icon = "fas fa-car",
                label = "Ambulance Garage",
                job = "ambulance",
            },
        },
    distance = 3.5,
    },
    ["evidence-guy"] = {
        models = {
            "cs_andreas"
        },
        options = {
            {
                type = "client",
                event = "police:client:EvidenceStashDrawer",
                icon = "", 
                label = "Open Police Evidence",
                job = "police",
            }
        },
        distance = 3.5,
    },
    ["VehicleRental"] = {
        models = {
            `a_m_y_business_03`,
        },
        options = {
            {
                type = "client",
                event = "qb-rental:openMenu",
                icon = "fas fa-car",
                label = "Rent Vehicle",
            },
        },
        distance = 2.0
    },
	["BCSODuty"] = {
        models = {
            `s_m_y_sheriff_01`,
        },
        options = {
            {
                type = "client",
                event = "qb-bcso:ToggleDuty",
                icon = "",
                label = "On duty / Off duty",
				job = "bcso",
            },
        },
        distance = 3.5
    },
	["chickensell"] = {
        models = {
            "csb_chef", 
        },
        options = {
            {
                type = "client",
                event = "Chickens:sell",
                icon = "fas fa-archive",
                label = "Sell Chicken Box",
			
            },
        },
        distance = 2.5,
    },
	["bank1"] = {
        models = {
            "a_f_y_business_01", 
        },
        options = {
            {
                type = "client",
                event = "okokBanking:OpenBank",
                icon = "",
                label = "Open Bank",
            },
        },
        distance = 2.5,
    },

}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {

}

Config.Peds = {
	
	{ 
        model = 'cs_floyd',
        coords = vector4(-357.07, 6063.25, 30.5, 30.06),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
    { 
        model = 's_m_y_construct_02',
        coords = vector4(2569.37, 2720.48, 42.97, 197.97),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(149.62, -1042.17, 28.37, 342.28),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(313.71, -280.68, 53.16, 337.9),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(-1211.97, -331.97, 36.78, 27.66),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(242.0, 226.94, 105.29, 155.12),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(247.15, 225.06, 105.29, 158.31),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(254.06, 222.61, 105.29, 167.77),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(1175.21, 2708.3, 37.09, 180.86),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'a_f_y_business_01',
        coords = vector4(-112.15, 6471.2, 30.63, 130.34),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 'cs_lestercrest',
        coords = vector4(451.73, -623.86, 27.55, 253.36),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 's_m_m_dockwork_01',
        coords = vector4(1968.42, 3778.25, 31.16, 123.97),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },

	{ 
        model = 'ig_floyd',
        coords = vector4(-2342.45, 3266.02, 31.83, 257.83),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	
    { 
        model = 's_m_y_cop_01',
        coords = vector4(480.41, -996.64, 29.69, 94.45),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
		model = `csb_chef`,
		coords = vector4(-1178.16, -891.61, 12.76, 304.99),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	}, 
	{ 
        model = 's_f_y_cop_01',
        coords = vector4(442.72, -981.92, 29.69, 76.58),
        gender = 'female',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
    { 
        model = 'cs_andreas',
        coords = vector4(472.7, -990.47, 25.2, 270.8),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
	{ 
        model = 's_m_y_sheriff_01',
        coords = vector4(-448.37, 6014.01, 31.29, 224.14),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
    },
    
}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function ItemCount() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('qb-core')
	if state ~= 'missing' then
		if state ~= 'started' then
			local timeout = 0
			repeat
				timeout += 1
				Wait(0)
			until GetResourceState('qb-core') == 'started' or timeout > 100
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCount = function(item)
			for _, v in pairs(PlayerData.items) do
				if v.name == item then
					return true
				end
			end
			return false
		end

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.item and not ItemCount(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end