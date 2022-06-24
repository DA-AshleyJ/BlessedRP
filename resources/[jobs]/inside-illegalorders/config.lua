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

Config.PayoutForFirstOrder = 100
Config.PayoutForSecondOrder = 200
Config.PayoutForThirdOrder = 400
Config.PayoutForFourthOrder = 500
Config.PayoutForFifthOrder = 700
Config.PayoutForSixthOrder = 900
Config.PayoutForSeventhOrder = 1000

Config.illegalorders = {
	['BossSpawn'] = { --the place where you start and finish your work
		Pos = {1272.04, -1711.91, 54.77, 259.32},
		Type  = 'cs_lestercrest',
	},
}

Config.Orders = {
    {name = 'first'},
    {name = 'second'},
    {name = 'third'},
    {name = 'fourth'},
    {name = 'fifth'},
    {name = 'sixth'},
    {name = 'seventh'},
}

Config.FirstOrder = {
    ['CarSpawn'] = {
        [1] = {         
            Pos = {x = 607.47, y = -426.97, z = 24.2, h = 30.99},
            Type  = 'windsor2',
            Peds = {['Peds'] = {
                [1]={x=605.74,y=-427.13,z=24.74,h=58.0,ped},
                [2]={x=608.63,y=-425.56,z=24.74,h=7.01,ped},
                [3]={x=608.75,y=-430.42,z=24.74,h=162.97,ped}, 
            }},
        },
        [2] = {         
            Pos = {x = -1791.63, y = 459.05, z = 127.76, h = 91.02},
            Type  = 'windsor',
            Peds = {['Peds'] = {
                [1]={x=-1792.31,y=457.26,z=128.31,h=140.97,ped},
                [2]={x=-1793.13,y=460.73,z=128.31,h=66.51,ped},
                [3]={x=-1789.01,y=457.83,z=128.31,h=167.46,ped},
            }},
        },
        [3] = {         
            Pos = {x = 702.87, y = -1377.14, z = 25.66, h = 281.35},
            Type  = 'cogcabrio',
            Peds = {['Peds'] = {
                [1]={x=-1792.31,y=457.26,z=-128.31,h=140.97,ped},--no peds in this order
            }},
        },
    },
    ['BackCar'] = {
        Pos = {x = 978.13, y = -144.52, z = 73.69, h = 242.26},
    }
}

Config.SecondOrder = {
    ['PedSpawn'] = {
        [1] = {         
            Pos = {x = 1153.36, y = -427.85, z = 66.14, h = 71.78},
            Type  = 's_m_y_dealer_01',
        },
        [2] = {         
            Pos = {x = 726.23, y = -828.4, z = 23.78, h = 94.97},
            Type  = 's_m_y_dealer_01',
        },
        [3] = {         
            Pos = {x = 210.97, y = -932.22, z = 29.69, h = 81.04},
            Type  = 's_m_y_dealer_01',
        },
        [4] = {         
            Pos = {x = -21.2, y = -1494.14, z = 30.36, h = 102.96},
            Type  = 's_m_y_dealer_01',
        },
    },
}

Config.ThirdOrder = {
    ['PedSpawn'] = {
        [1] = {         
            Pos = {x = 1374.11, y = -580.0, z = 73.85, h = 89.98},
            Type = 'ig_fbisuit_01',
            Car = 'f620',     
        },
        [2] = {         
            Pos = {x = 230.8, y = -1535.95, z = 28.74, h = 307.87},
            Type = 'ig_fbisuit_01',
            Car = 'dominator3',     
        },
        [3] = {         
            Pos = {x = -1320.34, y = -458.11, z = 32.79, h = 40.74},
            Type = 'ig_fbisuit_01',
            Car = 'hermes',     
        },
        [4] = {         
            Pos = {x = 354.73, y = 2627.72, z = 44.0, h = 29.79},
            Type = 'ig_fbisuit_01',
            Car = 'hustler',     
        },
    },
}

Config.FourthOrder = {
    ['CarSpawn'] = {
        [1] = {         
            Pos = {x = 1211.44, y = -1278.84, z = 35.46, h = 85.12},
            Car = 'mule', 
            DeliveryPos = {x = -1465.97, y = -925.88, z = 10.3, h = 121.74},     
        },
        [2] = {         
            Pos = {x = -850.48, y = -217.18, z = 37.79, h = 299.32},
            Car = 'mule', 
            DeliveryPos = {x = 1525.43, y = -2113.49, z = 76.88, h = 261.92},     
        },
        [3] = {         
            Pos = {x = -876.23, y = -2732.99, z = 14.09, h = 58.71},
            Car = 'mule', 
            DeliveryPos = {x = -374.46, y = -106.58, z = 38.92, h = 0.22},     
        },
        [4] = {         
            Pos = {x = 809.67, y = 2181.89, z = 52.55, h = 290.99},
            Car = 'mule', 
            DeliveryPos = {x = 3325.61, y = 5163.33, z = 18.68, h = 325.05},     
        },
        [5] = {         
            Pos = {x = 1180.11, y = -301.8, z = 69.3, h = 278.82},
            Car = 'mule', 
            DeliveryPos = {x = -3101.6, y = 718.43, z = 20.84, h = 178.48},     
        },
        [6] = {         
            Pos = {x = 86.17, y = -213.06, z = 54.72, h = 157.63},
            Car = 'mule', 
            DeliveryPos = {x = -1120.51, y = 2677.89, z = 18.63, h = 321.66},     
        },
        [7] = {         
            Pos = {x = 955.08, y = -132.73, z = 74.67, h = 239.67},
            Car = 'mule', 
            DeliveryPos = {x = 1735.77, y = 3690.41, z = 34.71, h = 20.03},     
        },
        [8] = {         
            Pos = {x = 108.09, y = -1079.29, z = 29.42, h = 339.07},
            Car = 'mule', 
            DeliveryPos = {x = -341.45, y = 6243.92, z = 31.72, h = 135.42},     
        },
    },
}

Config.FifthOrder = {
    ['PedSpawn'] = {
        [1] = {         
            Pos = {x = 127.57, y = -222.93, z = 53.80, h = 69.33},
            Type = 'ig_zimbor', 
            PosToRob = {x = 126.35, y = -225.92, z = 53.56, h = 71.25},
        }, 
        [2] = {         
            Pos = {x = -164.48, y = -301.37, z = 39.73, h = 253.51},
            Type = 'ig_zimbor', 
            PosToRob = {x = -165.05, y = -303.36, z = 39.73, h = 247.29},
        }, 
        [3] = {         
            Pos = {x = 427.0, y = -806.35, z = 29.0, h = 98.48},
            Type = 'ig_zimbor', 
            PosToRob = {x = 427.07, y = -807.11, z = 28.49, h = 83.1},
        },
        [4] = {         
            Pos = {x = 73.89, y = -1393.39, z = 28.90, h = 278.04},
            Type = 'ig_zimbor', 
            PosToRob = {x = 73.88, y = -1392.05, z = 28.38, h = 267.16},
        },
        [5] = {         
            Pos = {x = -823.54, y = -1072.49, z = 10.80, h = 216.74},
            Type = 'ig_zimbor', 
            PosToRob = {x = -822.4, y = -1071.8, z = 10.33, h = 205.88},
        },
        [6] = {         
            Pos = {x = -1194.74, y = -767.53, z = 16.90, h = 202.18},
            Type = 'ig_zimbor', 
            PosToRob = {x = -1192.5, y = -765.86, z = 16.32, h = 218.05},
        },
    },
}

Config.SixthOrder = {
    ['Place'] = {
        [1] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = 1173.22, y = -397.66, z = 66.74, h = 71.33},
        }, 
        [2] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = 818.12, y = -1040.54, z = 25.75, h = 183.11},
        }, 
        [3] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = 485.56, y = -1505.72, z = 28.29, h = 97.53},
        }, 
        [4] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = 415.85, y = -1902.5, z = 24.61, h = 224.0},
        },
        [5] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = -356.43, y = -1486.89, z = 29.15, h = 277.18},
        }, 
        [6] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = -143.74, y = 230.05, z = 94.94, h = 179.89},
        },  
        [7] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = -700.56, y = -1142.93, z = 9.81, h = 217.93},
        },   
        [8] = {         
            Pos = {x = 991.62, y = -102.77, z = 73.35, h = 41.18},
            PosFire = {x = -1177.33, y = -1184.28, z = 4.62, h = 101.05},
        },
    },
}

Config.SeventhOrder = {
    ['Place'] = {
        [1] = {         
            Pos = {x = 2822.87, y = 1518.84, z = 23.75, h = 164.96},
            PosTake = {x = 260.82, y = 205.0, z = 109.29, h = 350.07},
        }, 
        [2] = {         
            Pos = {x = 2819.37, y = 1515.29, z = 23.73, h = 341.79},
            PosTake = {x = 262.77, y = 209.29, z = 109.29, h = 336.13},
        }, 
        [3] = {         
            Pos = {x = 2814.29, y = 1521.15, z = 23.73, h = 166.67},
            PosTake = {x = 263.88, y = 211.4, z = 109.29, h = 330.79},
        },
    },
}
