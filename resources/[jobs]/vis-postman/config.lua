Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

Config.MinExpDrop = 125
Config.MaxExpDrop = 275

Config.CompanyVehicle = "boxville2"

Config.DepositPrice = 500

Config.Peds = {
    ['Peds'] = {
        [1] = {ped = 's_m_m_postal_01'},
    },
}

Config.Postman = {
    Base = {
        Pos = {x = -420.37, y = -2786.19, z = 6.0},
        Size = {x = 1.2, y = 1.2, z = 1.0},
        Color = {r = 78, g = 2453, b = 175},
        Type = 27,
        BlipSprite = 140,
        BlipLabel = '[Postman] Base',
        BlipColour = 29,
        BlipScale = 0.7,
    },
    Garage = {
        Pos = {x = -413.39, y = -2793.99, z = 6.0},
        Size = {x=1.2,y=1.2,z=1.0},
        Color = {r=78,g=2453,b=175},
        Type = 27,
        BlipSprite = 357,
        BlipLabel = '[Postman] Garage',
        BlipColor = 29,
        BlipScale = 0.7,
    },
    GarageSpawnPoint = {
		Pos1   = {x=-407.59,y=-2799.2,z=6.0,h=321.74},
	},
    DefaultMarker = {
		Size  = {x = 1.2, y = 1.2, z = 1.0},
        Color = {r = 78, g = 2453, b = 175},
        Type  = 27,
	},
}

Config.Clothes = {
    male = {
        ['tshirt_1'] = 17,  ['tshirt_2'] = 0,
        ['torso_1'] = 533,   ['torso_2'] = 7,
        ['arms'] = 1,
        ['neck_1'] = 213, ['neck_2'] = 2,
        ['pants_1'] = 10,   ['pants_2'] = 0,
        ['shoes_1'] = 3,   ['shoes_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 17,  ['tshirt_2'] = 0,
        ['torso_1'] = 533,   ['torso_2'] = 7,
        ['arms'] = 1,
        ['neck_1'] = 213, ['neck_2'] = 2,
        ['pants_1'] = 10,   ['pants_2'] = 0,
        ['shoes_1'] = 3,   ['shoes_2'] = 0,
    }
}

-- Only change coordinates from this point on

Config.Postal = {
    {District = "Westminster"},
    {District = "Canning Town"},
    {District = "Ruislip"},
    --{District = "Isle of Dogs"}, Need to decide how to use this area
    --{District = "Harrow"}, Need to decide how to use this area
    {District = "Chelsea"},
    --{District = "Royal Docks"}, Need to decide how to use this area
    --{District = "Canary Wharf"} Too lazy to check if there are post boxes right now, might make this is mixed are
}


Config.Westminster = {
    {x = 230.7,
    y = -1107.4,
    z = 29.3,
    h = 80.58,
    blip, 
    ped}
}

Config.WestminsterWork = {
    {x = 225.35, y = -1117.54, z=29.29, taked = false, blip},
    {x = 264.48, y = -966.99, z=29.29, taked = false, blip},
    {x = 290.98, y = -892.62, z=29.01, taked = false, blip},
    {x = 295.4, y = -807.95, z=29.35, taked = false, blip},
    {x = 379.98, y = -683.11, z=29.3, taked = false, blip},
    {x = 178.22, y = -592.7, z=43.58, taked = false, blip},
    {x = 67.29, y = -723.29, z=44.06, taked = false, blip},
    {x = 295.3, y = -807.96, z=29.18, taked = false, blip},
}

Config.CanningTown = {
    {x = 298.15,
    y = -2103.54,
    z = 17.12,
    h = 112.92,
    blip, 
    ped
    }
}

Config.CanningTownWork = {
    {x=-202.66,y=-1489.21,z=31.37,taked=false,blip},
    {x=-189.65,y=-1425.52,z=31.6,taked=false,blip},
    {x=-38.36,y=-1379.27,z=29.65,taked=false,blip},
    {x=88.13,y=-1307.17,z=29.06,taked=false,blip},
    {x=47.85,y=-1483.96,z=29.33,taked=false,blip},
    {x=220.27,y=-1793.55,z=28.65,taked=false,blip},
    {x=173.79,y=-1346.44,z=28.97,taked=false,blip},
}

Config.Ruislip = {
    {x = -553.92,
    y = -1070.59,
    z = 22.49,
    h = 266.31,
    blip, 
    ped}
}

Config.RuislipWork = {
    {x=-318.12,y=-950.21,z=21.79,taked=false,blip},
    {x=-650.55,y=-942.02,z=22.01,taked=false,blip},
    {x=-660.78,y=-848.9,z=24.65,taked=false,blip},
    {x=-649.92,y=-753.42,z=26.44,taked=false,blip},
    {x=-649.86,y=-682.27,z=31.11,taked=false,blip},
    {x=-711.78,y=-669.63,z=30.57,taked=false,blip},
    {x=-1225.74,y=-1094.64,z=7.81,taked=false,blip}
}

Config.IsleOfDogs = {
    {x = 977.61,
    y = -1711.45,
    z = 30.21,
    h = 100.56,
    blip, 
    ped
    }
}

Config.Harrow = {
    {x = -502.5,
    y = -1765.13,
    z = 21.16,
    h = 155.3,
    blip, 
    ped
    }
}

Config.Chelsea = {
    {x = -588.52,
    y = -351.76,
    z = 35.02,
    h = 198.61,
    blip, 
    ped}
}

Config.ChelseaWork = {
    {x=-1237.67,y=-555.77,z=28.62,taked=false,blip},
    {x=-1350.6,y=-411.45,z=36.33,taked=false,blip},
    {x=-1340.96,y=-306.96,z=39.03,taked=false,blip},
    {x=-1270.29,y=-346.57,z=36.68,taked=false,blip},
    {x=-1188.32,y=-304.37,z=37.87,taked=false,blip},
    {x=-1016.96,y=-248.37,z=37.43,taked=false,blip},
    {x=-848.66,y=-143.15,z=38.1,taked=false,blip},
    {x=-606.95,y=-339.47,z=35.14,taked=false,blip}
}

Config.RoyalDocks = {    
    {x = -406.58,
    y = -2765.22,
    z = 6.0,
    h = 183.44,
    blip, 
    ped
    }
}

Config.CanaryWharf = {
    {x = -102.19,
    y = -328.53,
    z = 45.81,
    h = 342.77,
    blip, 
    ped
    }
}