fx_version 'cerulean'
game 'gta5'

author 'jaksam1074'

version '4.10.7'

client_scripts {
    -- Callbacks
    "utils/callbacks/cl_callbacks.lua",

    -- Miscellaneous
    "utils/miscellaneous/sh_miscellaneous.lua",
    "utils/miscellaneous/cl_miscellaneous.lua",

    -- Settings
    "utils/settings/cl_settings.lua",

    -- Framework
    'utils/framework/sh_framework.lua',
    'utils/framework/cl_framework.lua',

    -- Interaction points
    "client/interaction_points.lua",

    -- Integrations
    'integrations/sh_integrations.lua',
    'integrations/cl_integrations.lua',

    -- Locales
    'locales/*.lua',

    -- Script
    'client/main.lua',
    'client/fields.lua',
    'client/laboratories.lua',
    'client/crafting_recipes.lua',
    'client/harvestable_items.lua',
    'client/drugs_effects.lua',

    -- Script - Sellings
    'client/boat_selling.lua',
    'client/plane_selling.lua',
    'client/npc_selling.lua',
    'client/narcos.lua',
    'client/pushers.lua',
}

server_scripts{
    -- Callbacks
    "utils/callbacks/sv_callbacks.lua",
    
    -- Miscellaneous
    "utils/miscellaneous/sh_miscellaneous.lua",
    "utils/miscellaneous/sv_miscellaneous.lua",

    -- Settings
    "utils/settings/sv_settings.lua",

    -- Framework
    'utils/framework/sh_framework.lua',
    'utils/framework/sv_framework.lua',    

    -- Dependency
    '@mysql-async/lib/MySQL.lua',

    -- Integrations
    'integrations/sh_integrations.lua',
    'integrations/sv_integrations.lua',

    -- Locales
    'locales/*.lua',
    
    -- Database creation
    'utils/database/database.lua',
    
    -- Script
    'server/main.lua',
    'server/drugs_effects.lua',
    'server/police.lua',
    'server/harvestable_items.lua',
    'server/crafting_recipes.lua',
    'server/laboratories.lua',
    'server/fields.lua',

    -- Script - Sellings
    'server/plane_selling.lua',
    'server/boat_selling.lua',
    'server/npc_selling.lua',
    'server/narcos.lua',
    'server/pushers.lua',
}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/index.css",
    "html/index.js",
    "html/menu_translations/*.json"
}

lua54 "yes"

dependencies {
    '/server:4752',
    '/onesync'
}

escrow_ignore {
    "locales/*.lua",
    "integrations/*.lua",

    "client/drugs_effects.lua",

    "server/police.lua"
}
dependency '/assetpacks'