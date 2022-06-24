Config = {}

--IMPORTANT STUFF--
Config.CheckVersion = true
Config.Language = 'en' --Default language, make your own language under the languages section.
Config.Framework = "QBUS" --Set this to your framework. "ESX" - "QBUS" - "VRP"
Config.UseCopJob = true --Use police check to see if the player can rob the place.\
Config.UsingSurveillanceSystem = true --Enable this if you are using SurveillanceSystem by Voxit. Check it out here: https://store.voxit.xyz/
Config.CopJobs = { --Set your police job names here. IF YOU ARE USING VRP SET YOUR GROUP NAMES HERE
    "police",
    "police2"
}
Config.vRP_Permissions = { --IF YOU ARE USING VRP SET THE PERMISSIONS HERE FOR COPS.
    "police.service",
    "police.service2"
}
Config.PedsResetTime = 1000 * 60 * 30 --ShopKeeper reset timer. Default is 30 minutes, so every 30 minutes the shopkeeper at every shop changes. Just to make it look unique.
Config.UseBlips = true --Set to true if you want to have store blips.
Config.PoliceCall = true --Set to true if you want to have robbery blips.
Config.PoliceCallTimer = 300 -- Police robbery timer in seconds.
Config.UseAlarmSound = true --Set to true for the interact sound alarm ogg.
Config.UseLasers = true
Config.UseItems = true --Enable this to enable items checking. YOU NEED 3 ITEMS. "advancedlockpick", "thermite", "oxycutter".
Config.TriggerOnArmed = true
--IMPORTANT STUFF--


--CONTROLS--

    --RECEPTION--
    Config.SendReceptionToUnlockButton = 46 --Default is 46 (E).
    Config.DisableCamerasButton = 74 --Default is 74 (H).
    --RECEPTION--

    --GENERAL BUTTONS--
    Config.EmptyLockerButton = 46 --Default is 46 (E).
    Config.AlarmButton = 46 --Default is 46 (E).
    Config.DoorButton = 46 --Default is 46 (E).
    Config.CrackSafeButton = 46 --Default is 46 (E).
    Config.BreakLockerButton = 46 --Default is 46 (E).
    Config.CancelLocker = 73 --Default is 73 (X)
    Config.PlantBombButton = 46 --Default is 46 (E).
    Config.HackPanelButton = 46 --Default is 46 (E).
    Config.StealCashButton = 46 --Default is 46 (E).
    Config.ResetButton = 46 --Default is 46 (E).
    --GENERAL BUTTONS--

--CONTROLS--


--Shops--
Config.PacificBank = {
        name = "Central Pacific Bank", --Name of the shop
        blip = vector3(246.88, 219.49, 121.28),
        copsNeeded = 0, --Cops needed to start the robbery

        AlarmCoords = vector3(255.85, 222.02, 106.29), --The alarm coords.
        AlarmState = nil, --Don't touch.

        ResetBank = vector3(265.55, 220.34, 101.68),

        mainReceptionEmployee = nil, --Don't touch.
        mainReceptionEmployeeCoords = vector3(254.54, 222.38, 106.29), --Main Reception's employee coords.
        mainReceptionEmployeeHeading = 169.34, --Main Reception's employee Heading.
        mainReceptionEmployeeState = nil, --Don't touch.

        mainSecurityGuard = nil,--Don't touch.
        mainSecurityGuardWeapon = nil,--Don't touch.
        mainSecurityGuardCoords = vector3(259.86, 216.68, 106.29), --Main Reception's employee coords.
        mainSecurityGuardHeading = 71.00, --Main Reception's employee Heading.
        mainSecurityGuardState = nil, --Don't touch.

        secondSecurityGuard = nil,--Don't touch.
        secondSecurityGuardWeapon = nil,--Don't touch.
        secondSecurityGuardCoords = vector3(238.84, 221.8, 106.29), --Main Reception's employee coords.
        secondSecurityGuardHeading = 252.29, --Main Reception's employee Heading.
        secondSecurityGuardState = nil, --Don't touch.

        randomPeds = {
            [1] = {
                ped = nil,
                coords = vector3(253.39, 220.83, 106.29),
                heading = 339.47,
                animimation = nil,
                state = nil,
            },
            [2] = {
                ped = nil,
                coords = vector3(251.86, 218.88, 106.29),
                heading = 323.89,
                animimation = nil,
                state = nil,
            },
            [3] = {
                ped = nil,
                coords = vector3(251.14, 216.67, 106.29),
                heading = 331.85,
                animimation = nil,
                state = nil,
            },
            [4] = {
                ped = nil,
                coords = vector3(249.26, 215.06, 106.29),
                heading = 310.75,
                animimation = nil,
                state = nil,
            },
            [5] = {
                ped = nil,
                coords = vector3(252.2, 214.23, 106.29),
                heading = 18.29,
                animimation = nil,
                state = nil,
            },
        },

        lockers = {
            [1] = {
                lockerHeading = 343.60,
                lockerCoords = vector3(258.57, 218.36, 101.68),
                lockerMoney = {25000, 50000},
                opened = nil,
                busy = nil
            },
            [2] = {
                lockerHeading = 343.60,
                lockerCoords = vector3(260.82, 217.62, 101.68),
                lockerMoney = {25000, 50000},
                opened = nil,
                busy = nil
            },
            [3] = {
                lockerHeading = 163.17,
                lockerCoords = vector3(259.33, 213.76, 101.68),
                lockerMoney = {25000, 50000},
                opened = nil,
                busy = nil
            },
            [4] = {
                lockerHeading = 163.17,
                lockerCoords = vector3(257.09, 214.55, 101.68),
                lockerMoney = {25000, 50000},
                opened = nil,
                busy = nil
            },
            [5] = {
                lockerHeading = 343.60,
                lockerCoords = vector3(263.72, 216.48, 101.68),
                lockerMoney = {25000, 50000},
                opened = nil,
                busy = nil
            },
            [6] = {
                lockerHeading = 343.60,
                lockerCoords = vector3(265.81, 215.81, 101.68),
                lockerMoney = {25000, 50000},
                opened = nil,
                busy = nil
            },
            [7] = {
                lockerHeading = 250.55,
                lockerCoords = vector3(266.43, 214.37, 101.68),
                lockerMoney = {40000, 70000},
                opened = nil,
                busy = nil
            },
            [8] = {
                lockerHeading = 250.55,
                lockerCoords = vector3(265.71, 212.49, 101.68),
                lockerMoney = {40000, 70000},
                opened = nil,
                busy = nil
            },
            [9] = {
                lockerHeading = 163.17,
                lockerCoords = vector3(264.24, 211.92, 101.68),
                lockerMoney = {40000, 70000},
                opened = nil,
                busy = nil
            },
            [10] = {
                lockerHeading = 163.17,
                lockerCoords = vector3(262.21, 212.67, 101.68),
                lockerMoney = {40000, 70000},
                opened = nil,
                busy = nil
            },
        },

        safes = {
            [1] = {
                safeCoords = vector3(259.10, 204.23, 109.29),
                safeHeading = 160.00,
                safeMoney = {5000, 20000},
                opened = nil,
                busy = nil
            },
            [2] = {
                safeCoords = vector3(266.25, 214.39, 109.29),
                safeHeading = 74.18,
                safeMoney = {20000, 40000},
                opened = nil,
                busy = nil
            }
        },

        cash = {
            [1] = {
                cashCoords = vector3(263.67, 214.25, 100.68),
                cashRotation = 0.360,
                cashMoney = {100000, 200000},
                stolen = nil,
                busy = nil
            },
            [2] = {
                cashCoords = vector3(261.42, 213.81, 100.68),
                cashRotation = 0.0,
                cashMoney = {100000, 200000},
                stolen = nil,
                busy = nil
            },
            [3] = {
                cashCoords = vector3(262.41, 216.34, 100.68),
                casRotation = 0.0,
                cashMoney = {100000, 200000},
                stolen = nil,
                busy = nil
            },
        },

        doors = {

            --First Door next to reception--
            [1] = {
                objName = `hei_v_ilev_bk_gate_pris`,		
                objCoords  = vector3(257.41, 220.25, 106.4),
                locked = nil,
                destroyed = nil,
                type = "thermite",
                anim = { x = 257.40, y = 220.20, z = 106.35, h = 336.52, extra = 0},
                thermitefx = vector3(257.39, 221.20, 106.29)
            },

            --Second door next that leads downstiars--
            [2] = {
                objName = `hei_v_ilev_bk_gate2_pris`,
                objCoords  = vector3(261.83, 221.39, 106.41),
                locked = nil,
                destroyed = nil,
                type = "thermite",
                anim = { x = 261.67, y = 221.39, z = 106.33, h = 251.08, extra = 0},
                thermitefx = vector3(261.67, 222.39, 106.33)
            },

            --Door that leads to offices.--
            [3] = {
                objName = `v_ilev_bk_door`,
                objCoords  = vector3(265.19, 217.84, 110.28),
                locked = nil,
                destroyed = nil,
                type = "lockpick",
            },

            --Second Door downstairs from the left side.--
            [4] = {
                objName = `v_ilev_bk_door`,
                objCoords  = vector3(236.70, 228.28, 106.29),
                locked = nil,
                destroyed = nil,
                type = "lockpick",
            },       

            --Second Door upstairs from the left side.--
            [5] = {
                objName = `v_ilev_bk_door`,
                objCoords  = vector3(237.65, 227.89, 110.28),
                locked = nil,
                destroyed = nil,
                type = "lockpick",
            },       
            
            --Second Door that leads to upstairs from the left side.--
            [6] = {
                objName = `v_ilev_bk_door`,
                objCoords  = vector3(257.04, 207.24, 110.28),
                locked = nil,
                destroyed = nil,
                type = "lockpick",
            },    

            --First Office.--
            [7] = {
                objName = `v_ilev_bk_door2`,
                objCoords  = vector3(262.15, 213.91, 110.28),
                locked = nil,
                destroyed = nil,
                type = "lockpick",
            },  
    
            --Second Office.--
            [8] = {
                objName = `v_ilev_bk_door2`,
                objCoords  = vector3(260.51, 209.28, 110.28),
                locked = nil,
                destroyed = nil,
                type = "lockpick",
            },  
            
            --First Door inside vault.--
            [9] = {
                objName = `hei_v_ilev_bk_safegate_pris`,
                objCoords  = vector3(252.98, 220.65, 101.8),
                locked = nil,
                destroyed = nil,
                type = "thermite",
                anim = { x = 252.95, y = 220.70, z = 101.76, h = 160.08, extra = 0},
                thermitefx = vector3(252.985, 221.70, 101.72)
            },                 
            
            --Second Door inside vault.--
            [10] = {
                objName = `hei_v_ilev_bk_safegate_pris`,
                objCoords  = vector3(261.68, 215.62, 101.81),
                locked = nil,
                destroyed = nil,
                type = "thermite",
                anim = { x = 261.65, y = 215.60, z = 101.76, h = 252.08, extra = 0},
                thermitefx = vector3(261.68, 216.63, 101.75)
            },   

        },

        vaultDoor = {

            vaultCoords = vector3(255.90, 223.65, 101.88),
            vaultObject = 961976194,
            vaultHeading = {
                open = 70.00001,
                closed = 160.00001,
            },

            bombed = nil,
            bombLocation = {x = 255.90, y = 223.65 , z = 101.88, h = 152.41},
            
            hacked = nil,
            hackCoords = vector3(253.21, 228.42, 101.88),
            hackLocation = {x = 253.34, y = 228.25 , z = 101.39, h = 63.60},


        },


        cooldown = {hour = 3, minute = 0, second = 0}, --Cooldown till the shop resets.
        camera = {1,2,3}, --Example: {1,2,3} for multiple cameras.
        robbed = nil --Don't touch
}
--Shops--



--Peds--
    --https://docs.fivem.net/docs/game-references/ped-models/ to see the models.
    --https://wiki.rage.mp/index.php?title=Weapons to see the weapons
Config.Reception ={
        [1] =  {
             model = `a_f_m_business_02`,
             disableCamerasFakeChance = 50,
         },
         [2] =  {
             model = `a_f_y_business_01`,
             disableCamerasFakeChance = 50,
         },
         [3] =  {
             model = `a_f_y_business_02`,
             disableCamerasFakeChance = 50,
         },
         [4] =  {
             model = `a_m_m_business_01`,
             disableCamerasFakeChance = 50,
         },

         [5] =  {
             model = `a_m_y_business_02`,
             disableCamerasFakeChance = 50,
         },
         [6] =  {
             model = `a_m_y_business_03`,
             disableCamerasFakeChance = 50,
         },
}


Config.SecurityPeds ={
   [1] =  {
        model = `s_m_m_security_01`,
        Weapons = {
            [1] = `WEAPON_COMBATPDW`,
            [2] = `WEAPON_CARBINERIFLE`,
            [3] = `WEAPON_SMG`,
            [4] = `WEAPON_ASSAULTSHOTGUN`,
        }
    },
    [2] =  {
        model = `mp_m_securoguard_01`,
        Weapons = {
            [1] = `WEAPON_COMBATPDW`,
            [2] = `WEAPON_CARBINERIFLE`,
            [3] = `WEAPON_SMG`,
            [4] = `WEAPON_ASSAULTSHOTGUN`,
        }
    },
    [3] =  {
        model = `s_m_m_prisguard_01`,
        Weapons = {
            [1] = `WEAPON_COMBATPDW`,
            [2] = `WEAPON_CARBINERIFLE`,
            [3] = `WEAPON_SMG`,
            [4] = `WEAPON_ASSAULTSHOTGUN`,
        }
    },
    [4] =  {
        model = `s_m_m_armoured_01`,
        Weapons = {
            [1] = `WEAPON_COMBATPDW`,
            [2] = `WEAPON_CARBINERIFLE`,
            [3] = `WEAPON_SMG`,
            [4] = `WEAPON_ASSAULTSHOTGUN`,
        }
    },
    [5] =  {
        model = `s_m_m_armoured_02`,
        Weapons = {
            [1] = `WEAPON_COMBATPDW`,
            [2] = `WEAPON_CARBINERIFLE`,
            [3] = `WEAPON_SMG`,
            [4] = `WEAPON_ASSAULTSHOTGUN`,
        }
    },
    [6] =  {
        model = `mp_s_m_armoured_01`,
        Weapons = {
            [1] = `WEAPON_COMBATPDW`,
            [2] = `WEAPON_CARBINERIFLE`,
            [3] = `WEAPON_SMG`,
            [4] = `WEAPON_ASSAULTSHOTGUN`,
        }
    },
}

Config.RandomPeds ={
    [1] =  {
        model = `s_f_m_fembarber`,
        isUsed = false,
    },
    [2] =  {
        model = `csb_tonya`,
        isUsed = false,
    },
    [3] =  {
        model = `csb_djblamadon`,
        isUsed = false,
    },
    [4] =  {
        model = `csb_denise_friend`,
        isUsed = false,
    },
    [5] =  {
        model = `csb_anita`,
        isUsed = false,
    },
    [6] =  {
        model = `cs_patricia`,
        isUsed = false,
    },
    [7] =  {
        model = `cs_natalia`,
        isUsed = false,
    },
    [8] =  {
        model = `cs_denise`,
        isUsed = false,
    },
    [9] =  {
        model = `cs_beverly`,
        isUsed = false,
    },
    [10] =  {
        model = `cs_brad`,
        isUsed = false,
    },
    [11] =  {
        model = `cs_carbuyer`,
        isUsed = false,
    },
    [12] =  {
        model = `cs_drfriedlander`,
        isUsed = false,
    },
    [13] =  {
        model = `cs_manuel`,
        isUsed = false,
    },
    [14] =  {
        model = `cs_mrk`,
        isUsed = false,
    },
    [15] =  {
        model = `csb_car3guy2`,
        isUsed = false,
    },
}
--Peds--

--Animations--
Config.RandomAnimations = {
    [1] = {
        type = "phone",
        isUsed = false,
    },
    [2] = {
        type = "calling",
        isUsed = false,
    },
    [3] = {
        type = "crossarms-angry",
        isUsed = false,
    },
    [4] = {
        type = "crossarms",
        isUsed = false,
    },
    [5] = {
        type = "facepalm",
        isUsed = false,
    },
    [6] = {
        type = "fallasleep",
        isUsed = false,
    },
    [7] = {
        type = "guard",
        isUsed = false,
    },
    [8] = {
        type = "idle",
        isUsed = false,
    },
    [9] = {
        type = "idle2",
        isUsed = false,
    },
    [10] = {
        type = "idle3",
        isUsed = false,
    },
    [11] = {
        type = "inspect",
        isUsed = false,
    },
    [12] = {
        type = "knucklecrunch",
        isUsed = false,
    },
    [13] = {
        type = "lookout",
        isUsed = false,
    },
}
--Animations