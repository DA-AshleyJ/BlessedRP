Config = {}
Config.MinPolice = 1
Config.GuardsWeapon = 'WEAPON_MICROSMG'
Config.TimeForNewRob = 300000 -- in milisec

--Money Reward
Config.UseMoney = true -- !!! if you make it false it will not give you anything !!!
Config.Reward = math.random(50, 100)

-- Item Reward
Config.UseItem = false
Config.ItemAmount = math.random(1, 5)
Config.Items = {
    "gold",
    "goldwatch",
    "jewelry"
}

Config.StartLocations = {
    vector3(-112.56, -67.98, 42.89)
}

Config.Guards = {
    Loc1 = { 
	    {model = 's_m_y_blackops_01', coords = {-200.77, -1721.44, 32.66, 115.03}},
	    {model = 's_m_y_blackops_01', coords = {-197.89, -1721.25, 32.66, 101.32}},
	    {model = 's_m_y_blackops_01', coords = {-199.08, -1726.00, 32.66, 133.62}}
    },

    Loc2 = { 
	    {model = 's_m_y_blackops_01', coords = {1381.45, -736.45, 67.23, 92.79}},
	    {model = 's_m_y_blackops_01', coords = {1380.00, -747.57, 67.23, 63.27}},
	    {model = 's_m_y_blackops_01', coords = {1385.95, -745.02, 67.23, 81.26}}
    },

    Loc3 = { 
	    {model = 's_m_y_blackops_01', coords = {285.31, -3148.05, 5.82, 17.21}},
	    {model = 's_m_y_blackops_01', coords = {274.30, -3148.71, 5.82, 340.46}},
	    {model = 's_m_y_blackops_01', coords = {280.65, -3154.86, 5.82, 4.94}}
    }
} 

Config.Locations = {
    {vanmodel = 'speedo', pos = vector3(-201.50, -1724.24, 31.65), heading = 114.79, guards = Config.Guards.Loc1},
    {vanmodel = 'rumpo2', pos = vector3(1380.83, -739.78, 66.23), heading = 88.03, guards = Config.Guards.Loc2},
    {vanmodel = 'burrito2', pos = vector3(279.99, -3147.22, 4.79), heading = 9.49, guards = Config.Guards.Loc3}
}

Config.Locale = {
    ['tpe_room'] = "Press ~INPUT_TALK~ to enter in room",
    ['tpex_room'] = "Press ~INPUT_TALK~ to exit out room",
    ['get_info'] = "Press ~INPUT_TALK~ to get information",
    ['dy_van'] = "Press ~INPUT_TALK~ to delivery van",
    ['lockpick_van'] = "Press ~INPUT_DETONATE~ to lockpick van",
    ['dy_blip'] = "Delivery Van",
    ['van_blip'] = "Van",
    ['suc_hack'] = "You hacked the system. Go to the GPS location!",
    ['try'] = "You or someone else is already working. Try again later!",
    ['robbed'] = "Someone has worked recently. Please try again later!",
    ['fail_hack'] = "You failed the hack!",
    ['no_cops'] = "No cops in town. Min police: "..Config.MinPolice,
    ['pol_msg'] = "Van robbery marked on GPS!",
    ['maked_money'] = "You make ",
    ['black_money'] = "$ black money",
    ['cash'] = "$",
    ['get_item'] = "You get it ",
    ['item_count'] = "x ",
}