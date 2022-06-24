Config = {}

--------------------------
-- Utility
--------------------------
Config.Utility = {
    CoreName = "qb-core", -- Your core name
    Target = "qb-target",
    Mask = false,
    NeedJob = false, -- Enable job to acess?
    Job = "", -- Job name
    NeedGang = false, -- Enable gang to acess?
    Gang = "", -- Gang name
    CallPolice = true, -- Call cops?
    Chance = 50, -- % to call cops
    LevelSystem = {
        ["General"] = {
            Level1 = 0,     -- XP need to open the Level 1 - Only have weed run
            Level2 = 300,   -- XP need to open the Level 2 - Weed run and coke run
            Level3 = 500,   -- XP need to open the Level 3 - Weed run , coke run and gun run
        },
        ["WeedRun"] = {
            XPEarn = 25 -- XP earn each delivery
        },
        ["CokeRun"] = {
            XPEarn = 50 -- XP earn each delivery
        },
        ["GunsRun"] = {
            XPEarn = 75 -- XP earn each delivery
        },
    },
    Rewards = {
        ["WeedRun"] = {
            Min = 100, -- Minimum money you receive for delivery.
            Max = 200, -- Maximum money you receive for delivery.
            Type = "cash", -- Type of money, "cash" or "bank"
        },
        ["CokeRun"] = {
            Min = 100, -- Minimum money you receive for delivery.
            Max = 200, -- Maximum money you receive for delivery.
            Type = "cash", -- Type of money, "cash" or "bank"
        },
        ["GunsRun"] = {
            Min = 100, -- Minimum money you receive for delivery.
            Max = 200, -- Maximum money you receive for delivery.
            Type = "cash", -- Type of money, "cash" or "bank"
        },
    },
    Items = {
        ["WeedRun"] = {
            Open = true, -- If true, players will be able to open the boxes they receive in the mission, but when they open, they can't finish it (:
            Rewards = { -- Here are the rewards that will come out when you open the box.
                [1] = "weed-bad-ql",
                [2] = "weed-med-ql",
                [3] = "weed-max-ql",
            }
        },
        ["CokeRun"] = {
            Open = true, -- If true, players will be able to open the boxes they receive in the mission, but when they open, they can't finish it (:
            Rewards = { -- Here are the rewards that will come out when you open the box.
                [1] = "coke-bad-ql",
                [2] = "coke-med-ql",
                [3] = "coke-max-ql",
            }
        },
        ["GunsRun"] = {
            Open = true, -- If true, players will be able to open the boxes they receive in the mission, but when they open, they can't finish it (:
            Rewards = { -- Here are the rewards that will come out when you open the box.
                [1] = "weapon_pistol",
                [2] = "pistol_ammo",
                [3] = "smg_ammo",
            }
        },
    }
}
