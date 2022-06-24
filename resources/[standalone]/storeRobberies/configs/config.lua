Config = {}

--IMPORTANT STUFF--
Config.CheckVersion =  true -- Enable/Disable version checker. Prints on serverside console.
Config.Language = 'en' --Default language, make your own language under the languages section.
Config.Framework = "QBUS" --Set this between "ESX" or "QBUS" or "VRP" or "NONE"
Config.UseCopJob = true --Use police check to see if the player can rob the place.\
Config.UsingSurveillanceSystem = true --Enable this if you are using SurveillanceSystem by Voxit. Check it out here: https://store.voxit.xyz/
Config.CopJobs = { --Set your police job names here. IF YOU ARE USING VRP SET YOUR GROUP NAMES HERE
    "police",
}

Config.NoRobPolice = true --If set to true, policemen cannot start the robbery by aiming.

Config.vRP_Permissions = { --IF YOU ARE USING VRP SET THE PERMISSIONS HERE FOR COPS.
    "police.service",
    "police.service2"
}
Config.ShopkeeperResetTime = 1000 * 60 * 30 --ShopKeeper reset timer. Default is 30 minutes, so every 30 minutes the shopkeeper at every shop changes. Just to make it look unique.
Config.UseBlips = true --Set to true if you want to have store blips.
Config.PoliceCall = true --Set to true if you want to have robbery blips.
Config.PoliceCallTimer = 300 -- Police robbery timer in seconds.
Config.PoliceCallSpamPrevention = 30 -- Police robbery timer in seconds.
Config.UseMeleeRobbing = true
Config.UseItems = false --Enable this to enable items checking. "advancedlockpick".
Config.GlobalCooldownShop = true -- Set this to true if you want a global cooldown at the shops on one robbery.
--IMPORTANT STUFF--


--CONTROLS--
Config.EmptyRegisterButton = 46 --Default is 46 (E).
Config.DisableCamerasButton = 74 --Default is 74 (H).
Config.LockpickRegisterButton = 46 --Default is 46 (E).
Config.SafeButton = 46 --Default is 46 (E).
--CONTROLS--


--Shops--
Config.Shops = {
    [1] = {
        name = "Limited Ltd Grove St", --Name of the shop
        blip = vector3(-46.62, -1758.12, 29.42),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-46.62, -1758.12, 29.42), --The shopkeeper's coords.
        shopKeeperHeading = 49.53, --Shopkeeper's heading.
        shopKeeperState = false, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-47.08, -1757.73, 29.42), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-43.92, -1748.08, 29.42),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {4}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [2] = {
        name = "Rob's Liqour Prosperity St", --Name of the shop
        blip = vector3(-1486.2, -377.96, 40.42),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-1486.2, -377.96, 40.42), --The shopkeeper's coords.
        shopKeeperHeading = 131.43, --Shopkeeper's heading.
        shopKeeperState = false, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-1486.72, -378.52, 40.42), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-1478.61, -375.75, 39.38),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "padlock", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {5}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [3] = {
        name = "Rob's Liqour San Andreas Ave", --Name of the shop
        blip = vector3(-1221.93, -908.53, 12.57),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-1221.93, -908.53, 12.57), --The shopkeeper's coords.
        shopKeeperHeading = 32.08, --Shopkeeper's heading.
        shopKeeperState = false, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-1222.36, -907.92, 12.57), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-1221.11, -916.28, 11.38),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "padlock", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {5}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [4] = {
        name = "Limited Ltd Ginger St", --Name of the shop
        blip = vector3(-705.99, -913.71, 19.28),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-705.99, -913.71, 19.28), --The shopkeeper's coords.
        shopKeeperHeading = 88.93, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-706.59, -913.71, 19.28), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-710.21, -904.12, 19.28),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {7}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    }, 
    [5] = {
        name = "24/7 Supermarkt Innocence Blvd", --Name of the shop
        blip = vector3(24.35, -1347.24, 29.52),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(24.35, -1347.24, 29.52), --The shopkeeper's coords.
        shopKeeperHeading = 271.4, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(24.95, -1347.24, 29.52), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(28.24, -1338.81, 29.52),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {8}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    }, 
    [6] = {
        name = "Rob's Liqour El Rancho Blvd", --Name of the shop
        blip = vector3(1134.25, -982.44, 46.37),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(1134.25, -982.44, 46.37), --The shopkeeper's coords.
        shopKeeperHeading = 277.42, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(1134.7, -982.38, 46.37), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(1126.79, -979.69, 45.42),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "padlock", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {9}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    }, 
    [7] = {
        name = "Limited Ltd West Mirror Drive", --Name of the shop
        blip = vector3(1164.78, -322.77, 69.29),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(1164.78, -322.77, 69.29), --The shopkeeper's coords.
        shopKeeperHeading = 99.78, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(1164.19, -322.88, 69.29), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(1158.9, -314.18, 69.29),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {10}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [8] = {
        name = "24/7 Supermarkt Clinton Ave", --Name of the shop
        blip = vector3(372.25, 326.58, 103.64),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(372.25, 326.58, 103.64), --The shopkeeper's coords.
        shopKeeperHeading = 253.58, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(372.97, 326.38, 103.64), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(378.22, 333.77, 103.64),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {11}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
        },
    [9] = {
        name = "Limited Ltd Banham Canyon Dr", --Name of the shop
        blip = vector3(-1819.93, 794.31, 138.05),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-1819.93, 794.31, 138.05), --The shopkeeper's coords.
        shopKeeperHeading = 131.68, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-1820.4, 793.93, 138.05), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-1829.68, 798.21, 138.05),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {12}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [10] = {
        name = "Rob's Liqour Great Ocean Hwy", --Name of the shop
        blip = vector3(-2966.14, 390.81, 15.18),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-2966.14, 390.81, 15.18), --The shopkeeper's coords.
        shopKeeperHeading = 84.82, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-2967.02, 390.95, 15.18), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-2959.69, 386.63, 13.92),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "padlock", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {13}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [11] = {
        name = "24/7 Supermarkt Ineseno Road", --Name of the shop
        blip = vector3(-3038.94, 584.26, 7.53),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-3038.94, 584.26, 7.53), --The shopkeeper's coords.
        shopKeeperHeading = 7.72, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-3039.04, 585.0, 7.53), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-3048.39, 585.4, 7.53),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {14}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [12] = {
        name = "24/7 Supermarkt Barbareno Rd", --Name of the shop
        blip = vector3(-3242.29, 999.78, 12.68),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(-3242.29, 999.78, 12.68), --The shopkeeper's coords.
        shopKeeperHeading = 354.44, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(-3242.22, 1000.53, 12.68), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(-3250.37, 1004.47, 12.81),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {15}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [13] = {
        name = "24/7 Supermarkt Route 68", --Name of the shop
        blip = vector3(548.96, 2671.27, 42.1),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(548.96, 2671.27, 42.1), --The shopkeeper's coords.
        shopKeeperHeading = 98.49, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(548.36, 2671.24, 42.1), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(546.45, 2662.35, 42.1),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {16}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [14] = {
        name = "Rob's Liqour Route 68", --Name of the shop
        blip = vector3(1165.91, 2711.01, 38.28),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(1165.91, 2711.01, 38.28), --The shopkeeper's coords.
        shopKeeperHeading = 180.74, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(1165.95, 2710.26, 38.28), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(1169.76, 2717.82, 37.43),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "padlock", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {17}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [15] = {
        name = "24/7 Supermarkt Senora Fwy", --Name of the shop
        blip = vector3(2677.91, 3279.15, 55.25),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(2677.91, 3279.15, 55.25), --The shopkeeper's coords.
        shopKeeperHeading = 332.0, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(2678.26, 3279.81, 55.25), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(2672.26, 3286.97, 55.25),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {18}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [16] = {
        name = "24/7 Supermarkt Alhambra Dr", --Name of the shop
        blip = vector3(1959.97, 3739.98, 32.28),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(1959.97, 3739.98, 32.28), --The shopkeeper's coords.
        shopKeeperHeading = 300.9, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(1960.48, 3740.28, 32.28), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(1959.0, 3749.42, 32.28),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {19}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
    [17] = {
        name = "24/7 Supermarkt Senora Fwy", --Name of the shop
        blip = vector3(1727.52, 6415.41, 35.2),
        copsNeeded = 1, --Cops needed to start the robbery
        shopKeeper = nil, --Don't touch.
        shopKeeperBusy = nil, --Don't touch.
        shopKeeperCoords = vector3(1727.52, 6415.41, 35.2), --The shopkeeper's coords.
        shopKeeperHeading = 242.78, --Shopkeeper's heading.
        shopKeeperState = nil, --Don't touch.
        shoperKeeperSpawned = false, --Don't touch.
        registerCoords = vector3(1728.2, 6415.1, 35.2), --The register's coords.
        registerMoney = {50, 400}, --The money you can get from the register, from low to high.
        safeCoords = vector3(1735.1, 6421.3, 34.79),
        safeMoney = {400, 2200}, --The money you can get from the safe, from low to high.
        safeType = "keypad", --Type of safe. 2 options: "keypad" and "padlock"
        safeCode = nil, --Don't touch.
        cooldown = {hour = 1, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {19}, --Example: {1,2,3} for multiple cameras.
        registerOpened = nil, --Don't touch.
        registerBusy = nil, --Don't touch.
        safeOpened = nil, --Don't touch.
        safeBusy = nil, --Don't touch.
        copsCalled = nil,  --Don't touch.
    },
}
--Shops--

--ShopKeepers--
Config.Shopkeepers ={ --https://docs.fivem.net/docs/game-references/ped-models/ to see the models.
                      --https://wiki.rage.mp/index.php?title=Weapons to see the weapons

   [1] =  {
        model = `a_m_y_yoga_01`,
        CallCopsEarlyChance = 70,
        FightBackChance = 15,
        GiveSafeCodeChance = 30,
        ScaredChance = 50,
        DisableCamerasFakeChance = 70,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
            [5] = `weapon_sawnoffshotgun`,
            [6] = `weapon_dbshotgun`,
        }
    },

   [2] = {
        model = `a_f_m_downtown_01`,
        CallCopsEarlyChance = 50,
        FightBackChance = 10,
        GiveSafeCodeChance = 20,
        ScaredChance = 80,
        DisableCamerasFakeChance = 20,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
        }
    },
   
   [3] = {
        model = `a_f_m_skidrow_01`,
        CallCopsEarlyChance = 80,
        FightBackChance = 50,
        GiveSafeCodeChance = 10,
        ScaredChance = 30,
        DisableCamerasFakeChance = 80,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
            [5] = `weapon_sawnoffshotgun`,
            [6] = `weapon_dbshotgun`,
        }
    },

   [4] = {
        model = `a_f_m_soucent_01`,
        CallCopsEarlyChance = 70,
        FightBackChance = 30,
        GiveSafeCodeChance = 40,
        ScaredChance = 70,
        DisableCamerasFakeChance = 70,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
        }
    },

   
   [5] = {
        model = `a_f_m_soucent_02`,
        CallCopsEarlyChance = 70,
        FightBackChance = 30,
        GiveSafeCodeChance = 40,
        ScaredChance = 70,
        DisableCamerasFakeChance = 30,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
        }
    },

   [6] = {
        model = `a_f_y_hipster_02`,
        CallCopsEarlyChance = 70,
        FightBackChance = 30,
        GiveSafeCodeChance = 40,
        ScaredChance = 60,
        DisableCamerasFakeChance = 40,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
        }
    },

   [7] = {
        model = `a_m_m_fatlatin_01`,
        CallCopsEarlyChance = 50,
        FightBackChance = 10,
        GiveSafeCodeChance = 50,
        ScaredChance = 90,
        DisableCamerasFakeChance = 10,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
            [5] = `weapon_sawnoffshotgun`,
            [6] = `weapon_dbshotgun`,
        }
    },

   [8] = {
        model = `cs_jimmyboston`,
        CallCopsEarlyChance = 90,
        FightBackChance = 75,
        GiveSafeCodeChance = 10,
        ScaredChance = 10,
        DisableCamerasFakeChance = 90,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
            [5] = `weapon_sawnoffshotgun`,
            [6] = `weapon_dbshotgun`,
        }
    },

   [9] = {
        model = `csb_chef`,
        CallCopsEarlyChance = 80,
        FightBackChance = 60,
        GiveSafeCodeChance = 20,
        ScaredChance = 40,
        DisableCamerasFakeChance = 60,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
            [5] = `weapon_sawnoffshotgun`,
            [6] = `weapon_dbshotgun`,
        }
    },

   [10] = {
        model = `csb_hao`,
        CallCopsEarlyChance = 70,
        FightBackChance = 40,
        GiveSafeCodeChance = 25,
        ScaredChance = 55,
        DisableCamerasFakeChance = 45,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
            [5] = `weapon_sawnoffshotgun`,
            [6] = `weapon_dbshotgun`,
        }
    },
    
   [11] = {
        model = `csb_customer`,
        CallCopsEarlyChance = 90    ,
        FightBackChance = 60,
        GiveSafeCodeChance = 10,
        ScaredChance = 30,
        DisableCamerasFakeChance = 70,
        Weapons = {
            [1] = `weapon_pistol`,
            [2] = `weapon_heavypistol`,
            [3] = `weapon_revolver`,
            [4] = `weapon_snspistol`,
            [5] = `weapon_sawnoffshotgun`,
            [6] = `weapon_dbshotgun`,
        }
    }

}
--ShopKeepers--