Config = {
    ------- Database Config Still a WIP -------
    ------- Config For Multi Item -------
    ['multi_nitrous_item'] = false, -- Enable Multi-Bottle Nitrous (true if you want to use the multi bottle nitrous system)
    ['nitrous_small'] = 'small-nitrous-bottle', -- Item for the small nitrous bottle
    ['nitrous_medium'] = 'medium-nitrous-bottle', -- Item for the medium nitrous bottle
    ['nitrous_large'] = 'large-nitrous-bottle', -- Item for the large nitrous bottle
    ['nitrous_large_extra'] = 'extra-large-nitrous-bottle', -- Item for the extra large nitrous bottle
    -------- Nos Config --------
    ['require_turbo'] = true, -- Enable Nitrous (true if you want to use nitrous boosting)
    ['enable_nitrous'] = true, -- Enable Nitrous (true if you want to use nitrous boosting)
    ['nitrous_sound'] = true,
    ['nitrous_effect_size'] = 0.75,
    ['nitrous_boost'] = 15.0, -- 0.0 - 100.0 (Nitrous boost amount) 
    ['nitrous_amount_use'] = 1.0, -- 0.0 - 1.0 (amount of nitrous used during a boost)
    ['nitrous_item'] = 'nitrous', -- Item for the nitrous bottle
    ['use_nitrous'] = 36, -- L Ctrl
    ------- Tablet Config -------
    ['enable_tablet'] = true, -- Enable Tuner Tablet (true if you want to use the tuner tablet)
    ['tablet_multiplier'] = 0.16, -- Enable Tuner Tablet (true if you want to use the tuner tablet)
    ['tablet_item'] = 'tunerlaptop', -- Item for the tuner tablet
    ------- Purge Key Binds and Config ------- https://docs.fivem.net/docs/game-references/controls/ -------
    ['enable_purge'] = true, -- Enable Purge (true if you want to enable nitrous purge)
    ['purge_amount_use'] = 0.25, -- 0.0 - 1.0 (amount of nitrous used during a purge)
    ['purge_fender_left'] = 124, -- NUMPAD 4
    ['purge_fender_both'] = 126, -- NUMPAD 5
    ['purge_fender_right'] = 125, -- NUMPAD 6
    ['purge_hood_left'] = 117, -- NUMPAD 7
    ['purge_hood_both'] = 127, -- NUMPAD 8
    ['purge_hood_right'] = 118, -- NUMPAD 9
    ------- Other -------
    ['enable_print'] = true, -- Enable Console Print (true if you want to print script settings to console)
    ['police_jobs'] = {  -- Change/ Add to the name of your police, can also be set to mechanics
        "police"
    },
    ------- Extras -------
    ['using_custom_mechanic'] = false -- Enable if Using custom mechanic jobs -- [Suggested] https://jimathy666.tebex.io/package/4821399 | 
    ---- remove ['qb-tunerchip',] from fmanifest dependencies
}

Strings = {
    ['Progress_bar'] = 'Connecting NOS...',
    ------- Notify -------
    ['wrong_seat_notify'] = 'You cannot do that from this seat!',
    ['invalid_vehicle_notify'] = 'Vehicle unable to use this modification!',
    ['no_turbo_notify'] = 'You need a Turbo to use NOS!',
    ['nos_already_active_notify'] = 'You Already Have NOS Active!',
    ['tuned_notify'] = 'Tuning Tablet v3: Vehicle Tuned!',
    ['reset_notify'] = 'Tuning Tablet v3: Vehicle has been reset!',
    ['connecting_notify'] = 'Tuning Tablet v3: Launching...',
    ------- Tune Status -------
    ['has_been_tuned'] = 'This Vehicle Has Been Tuned.',
    ['not_tuned'] = 'This Vehicle Has Not Been Tuned.',
    ['check_tune_command'] = 'checktune', -- command for police to check if vehicle is tuned
    ['check_tune_command_info'] = 'Check The Vehicle Tune Status.',
    ------- Nitrous Status -------
    ['has_nitrous'] = 'This Vehicle Has Nitrous Installed.',
    ['no_nitrous'] = 'This Vehicle Has No Nitrous Installed.',
    ['check_nitrous_command'] = 'checknitrous', -- command for police to check if vehicle is tuned
    ['check_nitrous_command_info'] = 'Check The Vehicle Nitrous Status.',
    ------- Other -------
    ['no_vehicle'] = 'No Vehicle Nearby.',
    ['not_in_vehicle'] = 'You Are Not In A Vehicle',
    ['not_on_duty'] = 'You Are Not On Duty',
    ['invalid_job'] = 'You Are Not A Cop.',
}

--[[ Extras (For Referance Only)

TriggerClientEvent("tunertablet:client:TuneStatus") -- Get Tune Status

TriggerClientEvent("tunertablet:client:NitrousStatus") -- Get Nitrous Status

]]