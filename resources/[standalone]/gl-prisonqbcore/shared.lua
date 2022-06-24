Config = {}

-- For Jailing --
Config.UseJail = true

Config.TimeReduction = 5
Config.PrisonReward = 'cigarett'
Config.RepGains = 10
Config.RepCostForTask = 5 --(SO you gain 5 rep per completed task, can go negative rep)
Config.IllegalCooldown = 30 * 60000 --(30 Minutes)

Config.GiveMoney = true-- ONLY FOR THE LEGAL JOBS
Config.MoneyReward = 20-- ONLY FOR THE LEGAL JOBS
Config.GiveItem = false-- ONLY FOR THE LEGAL JOBS
Config.ItemReward = 'cigarett'-- ONLY FOR THE LEGAL JOBS
Config.ItemAmount = 5-- ONLY FOR THE LEGAL JOBS

Config.MugshotTP = vector3(1844.21,2594.36,45.02)
Config.MugshotH = 91.66
Config.CellLocation = vector3(1774.09,2481.72,49.69)
Config.CellHeading = 27.36
Config.SetFreeLoc = vector3(1838.51,2582.58,46.01)

-- Prison Storage
Config.StashEvent = 'gl-prison:openStash'

-- For Drug Making Stuff --
Config.DrugName = 'mud' -- Database name of the drug
Config.ProcessedAmount = 20
Config.UnprocessedName = 'wetmed'
Config.DrugIngredients = {rottenapple = 1, water = 3, steroid = 1, bleech = 1} -- Database names of Ingredients

Config.RandomTrashReward = {'rottenapple','emptybottle'} -- add items to randomly find in trash can job here
Config.RandomTrashChance = 20 -- Out of 100 (% Chance)

Config.SteroidChance = 10 -- Out of 100 (% Chance)

Config.TinfoilChance = 15 -- Out of 100 (% Chance)


Config.DryTime = 2 -- IN HOURS
Config.NPCLocations = {


['Cleaner'] = {
	coords =vector3(1771.72,2568.38,44.73),
	heading = 92.06,
	event = 'gl-prison:beginClean',
	label = 'Begin Cleaning Work',
	model = 's_m_m_janitor',
	icon = 'fas fa-clipboard-list'
},

['Cook'] = {
	coords =vector3(1781.16,2561.0,44.67),
	heading = 178.71,
	event = 'gl-prison:beginCook',
	label = 'Begin Cooking Work',
	model = 's_m_y_chef_01',
	icon = 'fas fa-clipboard-list'
},

['Electrical'] = {
	coords =vector3(1760.12,2519.22,44.57),
	heading =251.62,
	event = 'gl-prison:beginElectrical',
	label = 'Begin Electrical Work',
	model = 's_m_y_construct_02',
	scenario = 'WORLD_HUMAN_WELDING',
	icon = 'fas fa-clipboard-list'
},

['Trash'] = {
	coords =vector3(1720.16,2566.8,44.57),
	heading =140.98,
	event = 'gl-prison:beginTrash',
	label = 'Begin Garbage Work',
	model = 's_m_y_garbage',
	scenario = 'WORLD_HUMAN_CLIPBOARD',
	icon = 'fas fa-clipboard-list'
},

['Toilets'] = {
	coords =vector3(1774.0,2492.91,44.74),
	heading =120.51,
	event = 'gl-prison:beginToilet',
	label = 'Begin Toilet Cleaning',
	model = 's_m_y_dwservice_01',
	scenario = 'WORLD_HUMAN_JANITOR',
	icon = 'fas fa-clipboard-list'
},

['Doctor'] = {
	coords =vector3(1765.23,2598.29,44.73),
	heading =183.49,
	event = 'gl-prison:useDoctor',
	label = 'Get Treated',
	model = 's_m_m_doctor_01',
	scenario = 'WORLD_HUMAN_CLIPBOARD',
	icon = 'fas fa-clipboard-list'
},

['BallerPed'] = {
	coords =vector3(1758.12,2483.82,44.25),
	heading =127.03,
	event = 'gl-prison:prisonerTasks',
	label = 'Do Some "Work"',
	model = 's_m_y_prisoner_01',
	scenario = 'PROP_HUMAN_SEAT_CHAIR',
	icon = 'fas fa-clipboard-list',
	event2 = 'gl-prison:openGangShop',
	label2 = 'Trade',
	gang = 'Ballas',
	headVar = 0,
},

['FamiliesPed'] = {
	coords =vector3(1747.09,2534.8,42.11),
	heading =31.64,
	event = 'gl-prison:prisonerTasks',
	label = 'Do Some "Work"',
	model = 's_m_y_prisoner_01',
	scenario = 'PROP_HUMAN_SEAT_CHAIR',
	icon = 'fas fa-clipboard-list',
	event2 = 'gl-prison:openGangShop',
	label2 = 'Trade',
	gang = 'Families',
	headVar = 1,
},

['VagosPed'] = {
	coords =vector3(1706.49,2550.89,44.01),
	heading =357.17,
	event = 'gl-prison:prisonerTasks',
	label = 'Do Some "Work"',
	model = 's_m_y_prisoner_01',
	scenario = 'PROP_HUMAN_SEAT_CHAIR',
	icon = 'fas fa-clipboard-list',
	event2 = 'gl-prison:openGangShop',
	label2 = 'Trade',
	gang = 'Vagos',
	headVar = 2,
},

['RecPed1'] = {
	coords =vector3(1698.87,2534.47,44.56),
	heading =290.66,
	event = 'gl-prison:teachRec',
	label = 'How To Play',
	model = 'u_m_y_prisoner_01',
	scenario = 'WORLD_HUMAN_LEANING',
	icon = 'fas fa-clipboard-list'
},

['CommissaryPed'] = {
	coords =vector3(1780.27,2548.26,44.18),
	heading =354.03,
	event = 'gl-prison:openCommissary',
	label = 'Browse Stock',
	model = 's_m_y_prisoner_01',
	scenario = 'PROP_HUMAN_SEAT_CHAIR',
	icon = 'fas fa-shopping-cart',
},

}

Config.Commissary = {
['papers'] = {databasename = 'papers', label = 'Rolling Papers',cost = 10, currency = 'money'},
['burger'] = {databasename = 'burger', label = 'Premium Burger',cost = 20, currency = 'money'},
['lockpick'] = {databasename = 'lockpick', label = 'Definetly Not a Lockpick',cost = 50, currency = 'money'},
['bleach'] = {databasename = 'bleech', label = 'Bleach', cost = 100, currency = 'money'},
['drugbag'] = {databasename = 'drugbag', label = 'A Great Bag for.. Throwing', cost = 30, currency = 'money'},
['bandage'] = {databasename = 'bandage', label = 'Bandage', cost = 20, currency = 'money'},

}


Config.FoodStuffs = {
['sandwich'] = {databasename = 'moldysandwich', label = 'Disgusting Sandwich'},
}

Config.DrinkStuffs = {
['water'] = {databasename = 'water', label = 'Water'},
['coke'] = {databasename = 'cocacola', label = 'Coke'},
['coffee'] = {databasename = 'coffe', label = 'Coffee'},


}

Config.CookingStuff = { -- You do not get to keep stuff

['burger'] = {
	Label = 'Burger',
	IngredientCost = 5,
	Time = 60000,
	Product = 'prisonmeal'
},

['soup'] = {
	Label = 'Spit Soup',
	IngredientCost = 4,
	Time = 48000,
	Product = 'prisonmeal'
},

['homlsdurag'] = {
	Label = 'A Du Rag dipped in butter',
	IngredientCost = 3,
	Time = 32000,
	Product = 'prisonmeal'
},

['grilledcheese'] = {
	Label = 'Grilled Cheese',
	IngredientCost = 2,
	Time = 24000,
	Product = 'prisonmeal'
},

['bread'] = {
	Label = 'Plain Ass Bread',
	IngredientCost = 1,
	Time = 12000,
	Product = 'prisonmeal'
},

}


Config.ElectricalBoxes = {
[0] = {coords =vector3(1737.28, 2504.12, 45.57), heading =345, icon = 'fas fa-bolt' },
[1] = {coords =vector3(1707.47, 2480.61, 45.56), heading =45, icon = 'fas fa-bolt' },
[2] = {coords =vector3(1700.58, 2474.36, 45.56), heading =45, icon = 'fas fa-bolt' },
[3] = {coords =vector3(1679.32, 2479.88, 45.56), heading =315, icon = 'fas fa-bolt' },
[4] = {coords =vector3(1643.95, 2490.21, 45.56), heading =5, icon = 'fas fa-bolt' },
[5] = {coords =vector3(1621.76, 2507.63, 45.56), heading =95, icon = 'fas fa-bolt' },
[6] = {coords =vector3(1609.42, 2539.23, 45.56), heading =315, icon = 'fas fa-bolt' },
[7] = {coords =vector3(1608.5, 2567.46, 45.56), heading =40, icon = 'fas fa-bolt' },
[8] = {coords =vector3(1629.76, 2564.96, 45.56), heading =355, icon = 'fas fa-bolt' },
[9] = {coords =vector3(1652.51, 2565.2, 45.56), heading =0, icon = 'fas fa-bolt' },
}

Config.Toilets = {
[0] = {coords =vector3(1776.93, 2481.57, 44.74), heading =0, icon = 'fas fa-toilet' },
[1] = {coords =vector3(1767.83, 2502.79, 44.74), heading =30, icon = 'fas fa-toilet' },
[2] = {coords =vector3(1764.67, 2501.03, 44.74), heading =30, icon = 'fas fa-toilet' },
[3] = {coords =vector3(1773.74, 2479.75, 44.74), heading =0, icon = 'fas fa-toilet' },
[4] = {coords =vector3(1761.51, 2499.17, 44.74), heading =30, icon = 'fas fa-toilet' },
[5] = {coords =vector3(1770.65, 2477.99, 44.74), heading =0, icon = 'fas fa-toilet' },
[6] = {coords =vector3(1767.43, 2476.06, 44.74), heading =0, icon = 'fas fa-toilet'},
[7] = {coords =vector3(1755.19, 2495.65, 44.74), heading =30, icon = 'fas fa-toilet' },
[8] = {coords =vector3(1752.07, 2493.72, 44.74), heading =30, icon = 'fas fa-toilet' },
[9] = {coords =vector3(1764.28, 2474.32, 44.74), heading =0, icon = 'fas fa-toilet' },
[10] = {coords =vector3(1749.0, 2491.94, 44.74), heading =30, icon = 'fas fa-toilet'},
[11] = {coords =vector3(1761.19, 2472.5, 44.74), heading =0, icon = 'fas fa-toilet' },
[12] = {coords =vector3(1758.13, 2470.47, 44.74), heading =30, icon = 'fas fa-toilet' },
}

Config.BedLocations = {
[0] = {coords =vector3(1775.21, 2482.43, 44.74), heading =30, icon = 'fas fa-bed' },
[1] = {coords =vector3(1762.58, 2475.19, 44.74), heading =30, icon = 'fas fa-bed' },
[2] = {coords =vector3(1747.48, 2489.18, 44.74), heading =30, icon = 'fas fa-bed' },
[3] = {coords =vector3(1760.12, 2496.52, 44.74), heading =30, icon = 'fas fa-bed' },
[4] = {coords =vector3(1765.59, 2476.9, 48.69), heading =30, icon = 'fas fa-bed' },
[5] = {coords =vector3(1747.48, 2489.2, 48.69), heading =30, icon = 'fas fa-bed' },
[6] = {coords =vector3(1763.44, 2498.3, 48.69), heading =30, icon = 'fas fa-bed'},


}

Config.IllegalStuff = {
	[1] = {
		message = 'Yo dawg get some ingredients from the kitchen and make me some Sangria in Cell 12.', 
		reward='cigarett',
		minAmount=4,
		maxAmount=10,
		requirement='sangria', -- Database name if an Item is required
		coords=vector3(1751.98, 2493.79, 48.69),-- Cell 12 Upper Floor
		boxW=.5,
		boxL=.5,
		heading=20,
		ingredient='ingredients',
		amount=20,
		icon= 'fas fa-toilet',
		--additionalEvent = nil,
		--killorwound = nil, -- If they need to be killed or wounded (kill, wound)
		--oppModel = nil,
		--spawnCoords = nil,
	},

	[2] = {
		message = 'I hid a shank in some boxes in the yard, get it for me.', 
		reward='cigarett',
		minAmount=8,
		maxAmount=14,
		requirement='WEAPON_SWITCHBLADE', -- Database name if an Item is required
		coords=vector3(1689.82, 2553.16, 45.56),-- Box in the Yard
		boxW=1,
		boxL=1,
		heading=0,
		ingredient=nil,
		amount=nil,
		icon = 'fas fa-box-open',
		--additionalEvent = nil,
		--killorwound = nil, -- If they need to be killed or wounded (kill, wound)
		--oppModel = nil,
		--spawnCoords = nil,
	},

	[3] = {
		message = 'Take out this loser for me near the basketball court.', 
		reward='cigarett',
		minAmount=9,
		maxAmount=18,
		requirement=nil, -- Database name if an Item is required
		coords=nil,-- Box in the Yard
		boxW=nil,
		boxL=nil,
		heading=nil,
		ingredient=nil,
		amount=nil,
		icon = 'fas fa-box-open',
		additionalEvent = 'gl-prison:spawnOpp',
		killorwound = 'kill', -- If they need to be killed or wounded (kill, wound)
		oppModel = 'u_m_y_prisoner_01',
		spawnCoords = vector3(1662.28,2517.72,44.56),
	},

	[4] = {
		message = 'Check out the bunks, someone from the gangs been hiding drugs.', 
		reward='cigarett',
		minAmount=8,
		maxAmount=16,
		requirement='weed', -- Database name if an Item is required
		coords=nil,-- Box in the Yard
		boxW=nil,
		boxL=nil,
		heading=nil,
		ingredient=nil,
		amount=10,
		icon = 'fas fa-box-open',
		additionalEvent = 'gl-prison:checkItemBed',
		killorwound = nil, -- If they need to be killed or wounded (kill, wound)
		oppModel = nil,
		spawnCoords = nil,
	},

	[5] = {
		message = 'Rough up this snitch for us, he has been hanging around the yard equipment.', 
		reward='cigarett',
		minAmount=4,
		maxAmount=13,
		requirement=nil, -- Database name if an Item is required
		coords=nil,-- Box in the Yard
		boxW=nil,
		boxL=nil,
		heading=nil,
		ingredient=nil,
		amount=nil,
		icon = 'fas fa-box-open',
		additionalEvent = 'gl-prison:spawnOpp', -- This event will take care of any kill/wound missions
		killorwound = 'wound', -- If they need to be killed or wounded (kill, wound)
		oppModel = 'u_m_y_prisoner_01',
		spawnCoords = vector3(1656.28,2538.71,44.56),
	},

}

Config.GangShops = {
['Ballas'] = { -- Change up items later
	{Item = 'bandage',Label = 'Bandage', Cost = 5, Currency = 'cigarett',Minrep = 0},
	{Item = 'medikit',Label = 'MedKit', Cost = 15, Currency = 'cigarett',Minrep = 50},
	{Item = 'bulletproof',Label = 'Bulletproof', Cost = 35, Currency = 'cigarett',Minrep = 150},
	{Item = 'WEAPON_SWITCHBLADE',Label = 'Switchblade', Cost = 50, Currency = 'cigarett',Minrep = 250},
	{Item = 'WEAPON_PISTOL',Label = 'Pistol', Cost = 350, Currency = 'cigarett',Minrep = 500},

},

['Families'] = { -- Change up items later
	{Item = 'burger',Label = 'Burger', Cost = 5, Currency = 'cigarett',Minrep = 0},
	{Item = 'medikit',Label = 'MedKit', Cost = 15, Currency = 'cigarett',Minrep = 50},
	{Item = 'bulletproof',Label = 'Bulletproof', Cost = 35, Currency = 'cigarett',Minrep = 150},
	{Item = 'WEAPON_SWITCHBLADE',Label = 'Switchblade', Cost = 50, Currency = 'cigarett',Minrep = 250},
	{Item = 'WEAPON_PISTOL',Label = 'Pistol', Cost = 350, Currency = 'cigarett',Minrep = 500},

},

['Vagos'] = { -- Change up items later
	{Item = 'taco',Label = 'Taco', Cost = 5, Currency = 'cigarett',Minrep = 0},
	{Item = 'medikit',Label = 'MedKit', Cost = 15, Currency = 'cigarett',Minrep = 50},
	{Item = 'bulletproof',Label = 'Bulletproof Vest', Cost = 35, Currency = 'cigarett',Minrep = 150},
	{Item = 'WEAPON_SWITCHBLADE',Label = 'Switchblade', Cost = 50, Currency = 'cigarett',Minrep = 250},
	{Item = 'WEAPON_PISTOL',Label = 'Pistol', Cost = 350, Currency = 'cigarett',Minrep = 500},

}

}