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

Config.MinExpDrop = 5 -- Base Exp
Config.MaxExpDrop = 9

Config.Salary = {
    min = 10,
    max = 50
}

Config.CompanyVehicle = "speedo"

Config.DepositPrice = 500

Config.Peds = {
    ['Peds'] = {
        [1] = {ped = 's_m_m_gaffer_01'},
    },
}

Config.Electrician = {
    Base = {
        Pos = {x = -553.43, y = -1801.92, z = 22.51},
        Size = {x = 1.2, y = 1.2, z = 1.0},
        Color = {r = 78, g = 2453, b = 175},
        Type = 27,
        BlipSprite = 140,
        BlipLabel = '[City Electrician] Base',
        BlipColour = 29,
        BlipScale = 0.7,
    },
    Garage = {
        Pos = {x = -557.62, y = -1797.87, z = 22.6},
        Size = {x = 1.2, y = 1.2, z = 1.0},
        Color = {r = 78, g = 2453, b = 175},
        Type = 27,
        BlipSprite = 140,
        BlipLabel = '[City Electrician] Garage',
        BlipColour = 29,
        BlipScale = 0.7,
    },
    GarageSpawnPoint = {
        Pos1 = {x=-548.35,y=-1801.53,z=22.07,h=58.64}
    },
    DefaultMarker = {
		Size  = {x = 1.2, y = 1.2, z = 1.0},
        Color = {r = 78, g = 2453, b = 175},
        Type  = 27,
    },
}


-- Please Check your Clothes and change these accordingl
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

Config.CityWork = {
    {Assignment = "Street Lights"},
    {Assignment = "Pillbox"}
}

Config.BrokenLights = {
    {x=-272.95, y=-1524.61, z=28.49, fixed=false, blip},
    {x=-277.01, y=-1472.56, z=30.98, fixed=false, blip},
    {x=-246.04, y=-1429.82, z=31.63, fixed=false, blip},
    {x=-194.39, y=-1485.81, z=33.28, fixed=false, blip},
    {x=-504.16, y=-1769.65, z=21.25, fixed=false, blip},
    {x=-440.75, y=-1765.69, z=20.58, fixed=false, blip},
    {x=-306.47, y=-1797.5, z=21.64, fixed=false, blip},
    {x=-193.42, y=-1486.82, z=31.85, fixed=false, blip},
    {x=-143.27, y=-1528.84, z=34.35, fixed=false, blip},
    {x=-71.43, y=-1549.19, z=32.02, fixed=false, blip},
    {x=-120.14, y=-1507.31, z=33.93, fixed=false, blip},
    {x=-108.54, y=-1340.68, z=29.22, fixed=false, blip}
}

Config.PillboxHospital = {
    {x=303.11, y=-569.44, z=43.28, checked=false, fixed=false, blip, job = "fuse"},
    {x=308.24, y=-566.48, z=43.28, checked=false, fixed=false, blip, job = "lights"},
    {x=327.77, y=-577.2, z=43.28, checked=false, fixed=false, blip, job = "plug"},
    {x=311.99, y=-568.38, z=43.28, checked=false, fixed=false, blip, job = "fuse"},
    {x=321.14, y=-564.74, z=43.28, checked=false, fixed=false, blip, job = "plug"},
    {x=323.82, y=-568.6, z=43.28, checked=false, fixed=false, blip, job = "plug"},
    {x=327.32, y=-575.78, z=43.28, checked=false, fixed=false, blip, job = "fuse"},
}