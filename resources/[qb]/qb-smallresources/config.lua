Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.IdleCamera = true
Config.EnableProne = true
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- carwash
Config.DirtLevel = 0.1 --carwash dirt level

ConsumeablesEat = {
    ["sandwich"] = math.random(35, 54),
    ["tosti"] = math.random(40, 50),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
    ["burger-bleeder"] = math.random(35, 54),
    ["burger-moneyshot"] = math.random(35, 54),
    ["burger-torpedo"] = math.random(35, 54),
    ["burger-heartstopper"] = math.random(35, 54),
    ["burger-meatfree"] = math.random(35, 54),
    ["burger-fries"] = math.random(35, 54),
    ["combomeal"] = math.random(60, 70),
    ["bigmac"] = math.random(40, 50),
    ["mcpollo"] = math.random(40, 50),
    ["mcroyaldeluxe"] = math.random(40, 50),
    ["cbo"] = math.random(40, 50),
    ["cuartodelibra"] = math.random(40, 50),
    ["grandmcextreme"] = math.random(40, 50),
    ["bigchickensupreme"] = math.random(40, 50),
    ["bigcrispybbq"] = math.random(40, 50),
    ["bigdoublecheese"] = math.random(40, 50),
    ["hamburgesa"] = math.random(40, 50),
    ["hamburgesadepollo"] = math.random(40, 50),
    ["mcfish"] = math.random(40, 50),
    ["happymeal"] = math.random(40, 50),
    ["nuggets"] = math.random(40, 50),
    ["patatasfritas"] = math.random(40, 50),
    ["topfries"] = math.random(40, 50),
    ["bacalhaucozido"] = math.random(35, 50),
	["cavalacozida"] = math.random(35, 50),
	["salmaocozido"] = math.random(35, 50),
	["sardinhacozida"] = math.random(35, 50),
    ["mc_eggmcmuffin"] = math.random(20, 40),  
    ["mc_mcchicken"] = math.random(20, 40),  
    ["mc_cheeseburger"] = math.random(20, 40),  
    ["mc_quarterpounder_bacon"] = math.random(20, 40),  
    ["mc_quarterpounder"] = math.random(20, 40),  
    ["mc_mcdouble"] = math.random(20, 40),  
    ["mc_bigmac"] = math.random(20, 40),  
    ["mc_fries"] = math.random(20, 40),  
    ["mc_chickennuggets"] = math.random(20, 40),  
    }


ConsumeablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["kurkakola"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
    ["burger-softdrink"] = math.random(40, 50),
    ["burger-mshake"] = math.random(40, 50),
    ["cocacola"] = math.random(40, 50),
    ["nestea"] = math.random(40, 50),
    ["agua"] = math.random(40, 50),
    ["monsterenergy"] = math.random(40, 50),
    ["cerveza"] = math.random(40, 50),
    ["aquarius"] = math.random(40, 50),
    ["sprite"] = math.random(40, 50),
    ["colacao"] = math.random(40, 50),
    ["fanta"] = math.random(40, 50),
    ["mc_americano"] = math.random(20, 40),  
    ["mc_roastcoffee"] = math.random(20, 40), 
    ["mc_orangejuice"] = math.random(20, 40),  
    ["mc_icetea"] = math.random(20, 40), 
    ["mc_sprite"] = math.random(20, 40),  
    ["mc_cocacola"] = math.random(20, 40),
    ["mc_strawberrysmoothie"] = math.random(20, 40),  
    ["mc_vanillashake"] = math.random(20, 40), 
    ["mc_strawberryshake"] = math.random(20, 40),  
}

ConsumeablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
}

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

Config.Teleports = {
    --Elevator @ labs
    [1] = {
        [1] = {
            coords = vector4(3540.74, 3675.59, 20.99, 167.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Up'
        },
        [2] = {
            coords = vector4(3540.74, 3675.59, 28.11, 172.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Down'
        },

    },
    --Coke Processing Enter/Exit
    [2] = {
        [1] = {
            coords = vector4(909.49, -1589.22, 30.51, 92.24),
            ["AllowVehicle"] = false,
            drawText = '[E] Enter Coke Processing'
        },
        [2] = {
            coords = vector4(1088.81, -3187.57, -38.99, 181.7),
            ["AllowVehicle"] = false,
            drawText = '[E] Leave'
        },
    },
}

Config.CarWash = { -- carwash
    [1] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(25.29, -1391.96, 29.33),
    },
    [2] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(174.18, -1736.66, 29.35),
    },
    [3] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-74.56, 6427.87, 31.44),
    },
    [5] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(1363.22, 3592.7, 34.92),
    },
    [6] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-699.62, -932.7, 19.01),
    },
}
