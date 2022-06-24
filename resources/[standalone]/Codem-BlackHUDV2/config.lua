
-------------------------------------------- General --------------------------------------------
Config = {}
Config.Framework = "newqb" -- newqb, oldqb, esx
Config.Mysql = "oxmysql" -- mysql-async, ghmattimysql, oxmysql
Config.Voice = "pma" -- mumble, saltychat, pma
Config.DefaultHud = "radial" -- Default hud when player first login avaliable huds [radial, classic, text]
Config.EnableDynamicStatusFirstJoin = false -- Enable dynamic status first join
Config.DefaultSpeedUnit = "mph" -- Default speed unit when player first login avaliable speed units [kmh, mph]
Config.HudSettingsCommand = 'hudsettings' -- Command for open hud settings
Config.DisplayMapOnWalk = false -- true - Show map when walking | false - Hide map when walking
Config.DisplayRealTime = false -- if you set this to true will show the real time according to player local time | if false it will show the game time
Config.EnableSpamNotification = true -- Spam preventation for seatbelt, cruise etc.
Config.EnableDateDisplay = true -- Determines if display date or nor
Config.DefaultMap = "rectangle" -- rectangle, radial
Config.DefaultSpeedometerSize = 1.2 -- 0.5 - 1.3
Config.DefaultHudSize = 1.0 -- 0.5 - 1.3
Config.EnableAmmoHud = true -- Determines if display ammo hud or nor
Config.DefaultRefreshRate = 200 -- Refresh rate for vehicle hud
Config.EnableHealth = true
Config.EnableHunger = true
Config.EnableThirst = true
Config.EnableHud = true
Config.EnableArmor = true
Config.EnableStamina = true
Config.EnableSpeedometer = true
Config.EnableToggleMapButton = false -- true | enables the toggle minimap button from the hud settings menu | -- false | disables the toggle minimap button from the hud settings menu


Config.DefaultHudColors = {
    ["radial"] = {
        ["health"] = "#FF4848ac",
        ["armor"] = "#FFFFFFac",
        ["hunger"] = "#FFA048ac",
        ["thirst"] = "#4886FFac", 
        ["stress"] = "#48A7FFac",
        ["stamina"] = "#C4FF48ac",
        ["oxy"] = "#48A7FFac",
        ["parachute"] = "#48FFBDac", 
        ["nitro"] = "#AFFF48ac", 
        ["altitude"] = "#00FFF0ac", 
    },
    ["text"] = {
        ["health"] = "#FF4848ac",
        ["armor"] = "#FFFFFFac",
        ["hunger"] = "#FFA048ac",
        ["thirst"] = "#4886FFac", 
        ["stress"] = "#48A7FFac",
        ["stamina"] = "#C4FF48ac",
        ["parachute"] = "#48FFBDac", 
        ["oxy"] = "#48A7FFac",
        ["nitro"] = "#AFFF48ac", 
        ["altitude"] = "#00FFF0ac", 
    },    
    ["classic"] = {
        ["health"] = "#9F2929",
        ["armor"] = "#2E3893",
        ["hunger"] = "#B3743A",
        ["thirst"] = "#2F549C", 
        ["stress"] = "#AA35A6",
        ["oxy"] = "#48A7FFac",
        ["stamina"] = "#c4ff48",
        ["parachute"] = "#48ffde", 
        ["nitro"] = "#8eff48", 
        ["altitude"] = "#48deff", 
    },      
}


-------------------------------------------- Watermark hud --------------------------------------------
Config.DisableWaterMarkTextAndLogo = false -- true - Disable watermark text and logo 
Config.UseWaterMarkText = true -- if true text will be shown | if  false logo will be shown
Config.WaterMarkText1 = "Blessed" -- Top right server text
Config.WaterMarkText2 = "Roleplay"  -- Top right server text
Config.WaterMarkLogo = "https://cdn.discordapp.com/attachments/862018783391252500/967359920703942686/Frame_303.png" -- Logo url
Config.LogoWidth = "11.875rem"
Config.LogoHeight = "3.313rem"
Config.EnableId = true -- Determines if display server id or nor
Config.EnableWatermarkCash = true -- Determines if display cash or nor
Config.EnableWatermarkBankMoney = true -- Determines if display bank money or nor
Config.EnableWatermarkJob = true -- Determines if display job or nor
Config.EnableWatermarkWeaponImage = true -- Determines if display weapon image or nor
Config.EnableWaterMarkHud = true -- Determines if right-top hud is enabled or not

Config.Text1Style = {
    ["color"] = '#e960c7',
    ["text-shadow"] = "0px 0.38rem 2.566rem rgba(116, 5, 147, 0.55)",
}

Config.Text2Style = {
    ["color"] = "#ffffff",
}

-------------------------------------------- Keys --------------------------------------------
Config.DefaultCruiseControlKey = "b" -- Default control key for cruise. Players can change the key according to their desire 
Config.DefaultSeatbeltControlKey = "k" -- Default control key for seatbelt. Players can change the key according to their desire 
Config.VehicleEngineToggleKey = "G" -- Default control key for toggle engine. Players can change the key according to their desire 
Config.NitroKey = "X" -- Default control key for use nitro. Players can change the key according to their desire 

-------------------------------------------- Nitro --------------------------------------------
Config.RemoveNitroOnpress = 2 -- Determines of how much you want to remove nitro when player press nitro key
Config.NitroItem = "nitrous" -- item to install nitro to a vehicle
Config.EnableNitro = true -- Determines if nitro system is enabled or not
Config.NitroForce = 40.0 -- Nitro force when player using nitro

-------------------------------------------- Money commands --------------------------------------------
Config.EnableCashAndBankCommands = true -- Determines if money commands are enabled or not
Config.CashCommand = "cash"  -- command to see cash
Config.BankCommand = "bank" -- command to see bank money

-------------------------------------------- Engine Toggle --------------------------------------------
Config.EnableEngineToggle = true -- Determines if engine toggle is enabled or not

-------------------------------------------- Vehicle Functionality --------------------------------------------
Config.EnableCruise = true -- Determines if cruise mode is active
Config.EnableSeatbelt = true -- Determines if seatbelt is active

-------------------------------------------- Settings text --------------------------------------------
Config.SettingsLocale = { -- Settings texts
    ["text_hud_1"] = "text",
    ["text_hud_2"] = "hud",
    ["classic_hud_1"] = "classic",
    ["classic_hud_2"] = "hud",
    ["radial_hud_1"] = "radial",
    ["radial_hud_2"] = "hud",
    ["hide_hud"] = "Hide Hud",
    ["health"] = "Health",
    ["armor"] = "Armor",
    ["thirst"] = "Thirst",
    ["stress"] = "Stress",
    ["oxy"] = "Oxygen",
    ["hunger"] = "Hunger",
    ["show_hud"] = "Show Hud",
    ["stamina"] = "Stamina",
    ["nitro"] = "Nitro",
    ["Altitude"] = "Altitude",
    ["Parachute"] = "Parachute",
    ["enable_cinematicmode"] = "Cinematic Mode",
    ["disable_cinematicmode"] = "Disable Cinematic",
    ["exit_settings_1"] = "EXIT FROM",
    ["exit_settings_2"] = "SETTINGS",
    ["speedometer"] = "SPEEDOMETER",
    ["map"] = "MAP",
    ["show_compass"] = "Show Compass",
    ["hide_compass"] = "Hide Compass",
    ["rectangle"] = "Rectangle",
    ["radial"] = "Radial",
    ["dynamic"] = "DYNAMiC",
    ["status"] = "STATUS",
    ["enable"] = "Enable",
    ["hud_size"] = "Status size",
    ["disable"] = "Disable",
    ["hide_at"] = "Hide at",
    ["and_above"] = "and above",
    ["and_below"] = "and below",
    ["enable_edit_mode"] = "Drag HUD (One by one)",
    ["enable_edit_mode_2"] = "Drag HUD (All)",
    ["change_status_size"] = "Change status size",
    ["change_color"] = "Change color of selected hud ",
    ["disable_edit_mode"] = "Disable Edit Mode",
    ["reset_hud_positions"] = "Reset Hud Positions",
    ["info_text"] = "Be aware increasing refresh rate may decrease your in game perfomance!",
    ["speedometer_size"] = "Speedometer Size",
    ["refresh_rate"] = "Refresh Rate",
    ["esc_to_exit"] = "PRESS ESC TO EXIT EDIT MODE",
    ["toggle_minimap"] = "Toggle Minimap",
}

-------------------------------------------- Fuel --------------------------------------------
Config.UseLegacyFuel = true --Enable this if you use legacy fuel

Config.GetVehicleFuel = function(vehicle) -- you can change LegacyFuel export if you use another fuel system 
    if Config.UseLegacyFuel then
        return exports["LegacyFuel"]:GetFuel(vehicle)
    else
        return GetVehicleFuelLevel(vehicle)
    end
end

-------------------------------------------- Stress --------------------------------------------

Config.UseStress = true -- if you set this to false the stress hud will be removed
Config.StressWhitelistJobs = { -- Add here jobs you want to disable stress 
    'police', 'ambulance'
}

Config.WhitelistedWeaponStress = {
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`
}

Config.AddStress = {
    ["on_shoot"] = {
        min = 1,
        max = 3,
        enable = true,
    },
    ["on_fastdrive"] = {
        min = 1,
        max = 3,
        enable = true,
    },
}

Config.RemoveStress = { -- You can set here amounts by your desire
    ["on_eat"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_drink"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_swimming"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_running"] = {
        min = 5,
        max = 10,
        enable = true,
    },

}



-------------------------------------------- Notifications --------------------------------------------

Config.Notifications = { -- Notifications
    ["stress_gained"] = {
        message = 'Getting Stressed',
        type = "error",
    },
    ["stress_relive"] = {
        message =  'You Are Relaxing',
        type = "success",
    },
    ["took_off_seatbelt"] = {
        type = "error",
        message = "You took off seatbelt.",
    },
    ["took_seatbelt"] = {
        type = "success",
        message = "You took seatbelt.",
    },
    ["cruise_actived"] = {
        type = "success",
        message = "Cruise actived.",
    },
    ["cruise_disabled"] = {
        type = "error",
        message = "Cruise disabled.",
    },
    ["spam"] = {
        type = "error",
        message = "Please wait for a few seconds.",
    },
    ["engine_on"] = {
        type = "success",
        message = "Engine is on.",
    }, 
    ["engine_off"] = {
        type = "success",
        message = "Engine is off.",
    }, 
    ["cant_install_nitro"] = {
        type = "error",
        message = "You can't install nitro inside vehicle.",
    }, 
    ["no_veh_nearby"] = {
        type = "error",
        message = "No vehicle nearby.",
    }, 
    ["cash_display"] = {
        type = "success",
        message = "You have $%s in your pocket.",
    }, 
    ["bank_display"] = {
        type = "success",
        message = "You have $%s in your bank.",
    }, 
}

Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 1500)
        end
    end
end 