--------------------------
-- CokeRun
--------------------------
CokeRun = {
    Peds = { -- Ped to take box's
        {type = 4, hash= GetHashKey("s_m_y_dockwork_0"), x = 1515.71,  y = -2137.74,  z = 75.75, h = 184.06},
    },
    Blip = {
        TakeOrder = {
            Enable = false,
            Zone = vector3(1515.71, -2137.74, 75.75),
            Sprite = 467,
            Display = 4,
            Colour = 25,
            Scale = 0.7,
            Name = "Boxes",
        },
    },
    Locations = { 
        TakeOrder = { -- This is for qb-target
            Zone = vector3(1515.71, -2137.74, 75.75),
            Lenght = 0.6,
            Width = 0.6,
            Heading = 300,
            Distance = 2.0,
        },
        Deliverys = { -- Locations to deliverys
            [1] = vector3(1221.5, -3003.26, 5.87),
            [2] = vector3(100.93, -1912.17, 21.41),
            [3] = vector3(126.72, -1930.01, 21.38),
            [4] = vector3(114.3, -1961.17, 21.33),
            [5] = vector3(86.03, -1959.62, 21.12),
            [6] = vector3(72.63, -1939.01, 21.35),
            [7] = vector3(54.49, -1873.12, 22.8),
            [8] = vector3(23.17, -1896.84, 22.97),
            [9] = vector3(335.88, -2021.93, 22.35),
            [10] = vector3(344.69, -2028.71, 22.35),
            [11] = vector3(371.33, -2057.3, 21.74),
            [12] = vector3(345.78, -2067.11, 20.95),
            [13] = vector3(-140.17, -1587.5, 34.24),
            [14] = vector3(-120.15, -1574.47, 34.18),
        },
    }
}
