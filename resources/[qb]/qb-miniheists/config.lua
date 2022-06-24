Config = {}

Config.MinimumPolice = 0   ---change this to whatever you like

Config.PaymentLab = 5000   -- amount you get back on completion
Config.LabRewards = {
    [1] = {
        ["item"] = "heavyarmor",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [2] = {
        ["item"] = "thermite",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [3] = {
        ["item"] = "cryptostick",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
}
Config.PaymentMRPD = 2500
Config.MRPDRewards = {
    [1] = {
        ["item"] = "cryptostick",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [2] = {
        ["item"] = "thermite",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [3] = {
        ["item"] = "advancedlockpick",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
}
Config.PaymentSalvage = 4000
Config.SalvageRewards = {
    [1] = {
        ["item"] = "toolkit",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [2] = {
        ["item"] = "moneybag",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [3] = {
        ["item"] = "markedbills",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
}

Config['labsecurity'] = {
    ['labpatrol'] = {
        { coords = vector3(3532.46, 3649.46, 27.52), heading = 63.5, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3537.36, 3645.83, 28.13), heading = 46.35, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3546.64, 3642.28, 28.12), heading = 96.74, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3550.22, 3654.24, 28.12), heading = 156.29, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3554.83, 3661.73, 28.12), heading = 21.64, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3557.54, 3674.59, 28.12), heading = 104.25, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3564.64, 3682.23, 28.12), heading = 48.35, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3594.74, 3686.06, 27.62), heading = 124.5, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3593.82, 3712.27, 29.69), heading = 139.73, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3608.93, 3729.39, 29.69), heading = 323.56, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3618.91, 3722.51, 29.69), heading = 85.71, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3596.07, 3703.44, 29.69), heading = 344.89, model = 's_m_m_fiboffice_02'},
    },
}

Config['mrpdsecurity'] = {
    ['mrpdpatrol'] = {
        { coords = vector3(450.73, -1005.09, 26.63), heading = 176.66, model = 'mp_s_m_armoured_01'},
        { coords = vector3(458.79, -1025.3, 28.35), heading = 16.46, model = 'mp_s_m_armoured_01'},
        { coords = vector3(416.6, -1024.03, 29.5), heading = 356.96, model = 'mp_s_m_armoured_01'},
        { coords = vector3(424.45, -998.75, 30.71), heading = 183.01, model = 'mp_s_m_armoured_01'},
    },
}

Config['salvageworkers'] = {
    ['salvagepatrol'] = {
        { coords = vector3(450.73, -1005.09, 26.63), heading = 176.66, model = 's_m_m_gaffer_01'},
        { coords = vector3(458.79, -1025.3, 28.35), heading = 16.46, model = 's_m_m_gaffer_01'},
        { coords = vector3(416.6, -1024.03, 29.5), heading = 356.96, model = 's_m_m_gaffer_01'},
        { coords = vector3(424.45, -998.75, 30.71), heading = 183.01, model = 's_m_m_gaffer_01'},
    },
}
