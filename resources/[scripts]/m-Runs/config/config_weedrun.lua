--------------------------
-- WeedRun
--------------------------
WeedRun = {
    Peds = {
        {type = 4, hash= GetHashKey("s_m_y_dockwork_01"), x = 1223.5,  y = -3326.94,  z = 5.03, h = 178.48},
        {type = 4, hash= GetHashKey("s_m_y_dockwork_01"), x = 247.71,  y = -3316.37,  z = 4.79, h = 183.06},
    },
    Blip = {
        Start = { -- ( General Location )
            Enable = false,
            Zone = vector3(1223.5, -3326.94, 5.03),
            Sprite = 467,
            Display = 4,
            Colour = 25,
            Scale = 0.7,
            Name = "Weedruns",
        },
        TakeOrder = {
            Enable = false,
            Zone = vector3(286.6, 2843.83, 44.7),
            Sprite = 467,
            Display = 4,
            Colour = 25,
            Scale = 0.7,
            Name = "Boxes",
        },
    },
    Locations = { 
        Start = { -- This is for qb-targer location ( General Location )
            Zone = vector3(1223.5, -3326.94, 6.03),
            Lenght = 0.6,
            Width = 0.6,
            Heading = 300,
            Distance = 2.0,
        },
        TakeOrder = {
            Zone = vector3(247.71, -3316.37, 4.79),
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
