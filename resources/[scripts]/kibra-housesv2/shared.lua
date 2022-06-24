Config = {}
Cfg = {}

Config.Locale = 'en'

Config.UIDrawText = true

Config.MetaData = true

Cfg.HouseBillLabel = "HouseBill"

Config.HomeSalePriceRatio = 2 
-- This figure is the house sale price ratio. As an example, it divides the house you bought for $150,000 by the price written in this variable, and the resulting result is the sale price of the house.

Config.ReplacementKeyRemovalFee = 50 -- $

Config.MultipleHomePurchases = true

Config.ReplacementKeyRemovalFeePaymentMethod = "bank" -- or cash

Config.SaveInventoryStashName = "HouseStash"

Config.HouseKeyItem = "housekeys"

Config.DoorLockItem = "doorlock"

Config.MyHouseCreateBlipCommand = "myhouse"

Config.DoorLockReplacementTime = 5

Config.QBPhoneMailEvent = "qb-phone:server:sendNewMailToOffline"

Config.BillingPeriod = 50 -- second 

Config.RentTime = 1 -- Rental Period of Houses 

Config.BuyHousePaymentMethod = "bank" -- or cash

Config.RentHousePaymentMethod = "bank" -- or cash

Config.MarkerColor = {r = 57, g = 125, b = 199, a = 0.9}

Config.Controls = {
    OpenHouseBuyMenuControl = 38,
    OpenStashControl = 38,
    OpenWardrobeControl = 38,
    GarageControlKey = 38,
    ManagementMenuOpenControl = 38,
    DoorLockControlKey = 38,
    OpenStashLockControl = 182
}

Config.UIControls = {
    OpenHouseBuyMenuControl = "[E]",
    OpenWardrobeControl = "[E]",
    GarageControlKey = "[E]",
    ManagementMenuOpenControl = "[E]",
    OpenStashLockControl = "[L]",
    OpenDoorLockControl = "[E]"
}

Config.Wardrobe = {
    EventType = "client", -- client or server
    EventName = "qb-clothing:client:openOutfitMenu", -- Clothing Menu Event Name
}

Config.InvoiceControlDate = {Hour = 12, Minute = 00}

Config.HouseBlip = {
    BlipId = 492,
    Color = 1,
    Scale = 1.0,
    BlipText = "My Home"
}

Config.Houses = {

    -- 1th House
    {
        Owner = nil,
        KeyData = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1301.5, -574.45, 71.73),
        HouseManagementMenuCoord = vector3(1296.62, -577.8, 71.74),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 1, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1296.63, -577.38, 75.06),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1301.01, -574.51, 71.73)},
            {DoorHash = 964838196, DoorCoord = vector3(1296.03, -590.19, 71.73)}
        },
        HouseStash = {
            {StashCoord = vector3(1300.12, -586.04, 75.11), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(1290.96, -581.99, 71.74, 5.7),
            GarageCarSpawnCoord = vector4(1295.04, -568.5, 70.84, 344.97),
            GarageDist = 10.0
        }
    },

    -- 2th House
    {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1323.37, -583.21, 73.25),
        HouseManagementMenuCoord = vector3(1318.37, -586.28, 73.25),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 1, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1318.33, -585.7, 76.58),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1323.41, -583.14, 73.25)},
            {DoorHash = 964838196, DoorCoord = vector3(1316.24, -597.99, 73.25)}
        },
        HouseStash = {
            {StashCoord = vector3(1320.9, -594.83, 76.62), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(1311.67, -590.97, 72.93, 335.64),
            GarageCarSpawnCoord = vector4(1318.81, -576.41, 73.02, 335.68),
            GarageDist = 10.0
        }
    },

    -- 3th House
    {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1367.38, -607.26, 74.72),
        HouseManagementMenuCoord = vector3(1364.09, -611.41, 74.72),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 1, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1363.81, -611.1, 78.04),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1367.38, -607.26, 74.72)},
            {DoorHash = 964838196, DoorCoord = vector3(1366.94, -622.45, 74.72)}
        },
        HouseStash = {
            {StashCoord = vector3(1369.81, -618.14, 78.09), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(1359.83, -618.12, 74.34, 184.95),
            GarageCarSpawnCoord = vector4(1360.02, -602.97, 74.34, 0.18),
            GarageDist = 10.0
        }
    },

    -- 4th House
    {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1386.25, -593.54, 74.52),
        HouseManagementMenuCoord = vector3(1388.05, -598.93, 74.49),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 1, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1387.57, -598.93, 77.82),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1386.25, -593.54, 74.52)},
            {DoorHash = 964838196, DoorCoord = vector3(1398.88, -603.55, 74.49)}
        },
        HouseStash = {
            {StashCoord = vector3(1396.87, -598.3, 77.86), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(1389.64, -605.16, 74.34, 226.74),
            GarageCarSpawnCoord = vector4(1379.45, -597.54, 74.34, 53.2),
            GarageDist = 10.0
        }
    },

    -- 5th House
    {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1389.09, -569.4, 74.5),
        HouseManagementMenuCoord = vector3(1394.69, -570.59, 74.51),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 1, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1394.49, -571.0, 77.83),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1389.09, -569.4, 74.5)},
            {DoorHash = 964838196, DoorCoord = vector3(1398.88, -603.55, 74.49)}
        },
        HouseStash = {
            {StashCoord = vector3(1398.61, -562.61, 77.88), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(1401.57, -572.27, 74.34, 295.0),
            GarageCarSpawnCoord = vector4(1388.52, -577.21, 74.34, 109.3),
            GarageDist = 10.0
        }
    },

    -- 6th House
    {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1348.39, -546.81, 73.89),
        HouseManagementMenuCoord = vector3(1353.18, -543.8, 73.89),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 1, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1353.26, -544.08, 77.22),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1348.39, -546.81, 73.89)},
            {DoorHash = 964838196, DoorCoord = vector3(1398.88, -603.55, 74.49)}
        },
        HouseStash = {
            {StashCoord = vector3(1350.39, -535.42, 77.26), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(1359.19, -539.4, 73.77, 246.4),
            GarageCarSpawnCoord = vector4(1354.08, -551.8, 73.89, 156.18),
            GarageDist = 10.0
        }
    },

     -- 7th House
     {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1303.13, -527.28, 71.48),
        HouseManagementMenuCoord = vector3(1307.84, -523.84, 71.47),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 1, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1307.87, -524.59, 74.79),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1303.13, -527.28, 71.48)},
            {DoorHash = 964838196, DoorCoord = vector3(1398.88, -603.55, 74.49)}
        },
        HouseStash = {
            {StashCoord = vector3(1304.78, -515.56, 74.72), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(1313.9, -519.4, 71.31, 338.51),
            GarageCarSpawnCoord = vector4(1308.33, -534.52, 71.31, 156.46),
            GarageDist = 10.0
        }
    },

    -- 8th House
    {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(919.96, -569.64, 58.38),
        HouseManagementMenuCoord = vector3(920.5, -563.93, 58.37),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 0, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(920.92, -563.95, 61.7),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(919.96, -569.64, 58.38)},
            {DoorHash = 964838196, DoorCoord = vector3(912.77, -555.02, 58.37)}
        },
        HouseStash = {
            {StashCoord = vector3(912.32, -560.4, 61.74), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 0,
            GarageCoord = vector4(1313.9, -519.4, 71.31, 338.51),
            GarageCarSpawnCoord = vector4(1308.33, -534.52, 71.31, 156.46),
            GarageDist = 10.0
        }
    },

    -- 9th House
    {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(959.87, -669.99, 58.45),
        HouseManagementMenuCoord = vector3(954.18, -669.45, 58.46),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 0, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(954.66, -668.87, 61.78),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(959.87, -669.99, 58.45)},
            {DoorHash = 964838196, DoorCoord = vector3(945.96, -677.38, 58.46)}
        },
        HouseStash = {
            {StashCoord = vector3(951.03, -677.85, 61.83), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 2,
            GarageCoord = vector4(942.45, -670.57, 58.01, 114.8),
            GarageCarSpawnCoord = vector4(958.61, -662.39, 58.01, 301.83),
            GarageDist = 10.0
        }
    },

     -- 10th House
     {
        Owner = nil,
        KeyData = nil,
        Date = nil,
        Rentable = true, -- Sets whether the house is rentable
        Purchasable = true, -- Sets whether the house is Purchasable.
        AutoLock = true, -- Puts Automatic Lock On The Door.
        HouseCenterCoord = vector3(1101.11, -411.25, 67.56),
        HouseManagementMenuCoord = vector3(1105.24, -414.97, 67.56),
        RentPrice = 100, -- Rental Price of the House
        HousePrice = 100000, -- Sale Price of the House
        Features = { -- House Features
            SwimmingPool = 0, -- Number of Swimming Pools
            Garage = 0, -- If the garage system is open, the number of garages
            Floor = 1, -- How Many Storey House
            NumberRoom = 2 -- Number of Rooms in the House
        },
        ClotheWardrobe = vector3(1105.42, -415.29, 70.89),
        HouseDoors = {
            {DoorHash = 520341586, DoorCoord = vector3(1101.11, -411.25, 67.56)},
            {DoorHash = 964838196, DoorCoord = vector3(1116.57, -412.91, 67.56)}
        },
        HouseStash = {
            {StashCoord = vector3(1112.75, -409.75, 70.94), StashLock = true}
        },
        Garages = {
            MaxSlotCar = 0,
            GarageCoord = vector4(942.45, -670.57, 58.01, 114.8),
            GarageCarSpawnCoord = vector4(958.61, -662.39, 58.01, 301.83),
            GarageDist = 10.0
        }
    },
}