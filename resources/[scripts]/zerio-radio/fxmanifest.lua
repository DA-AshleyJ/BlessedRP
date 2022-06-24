game "gta5"
fx_version "cerulean"

lua54 "yes"
escrow_ignore {
    "config.lua",
    "client/functions.lua",
    "server/functions.lua",

    "locale.lua",
    "locales/*.lua",
    "settings.json",

    "html/style.css",
    "html/script.js",
    "html/overlay.png",
    "html/theme.css",
    
    "html/libs/**/*.js",
    "html/libs/**/*.css",
    
    "html/sounds/*.ogg"
}

client_scripts {
    "config.lua",
    "locale.lua",
    "locales/*.lua",
    "client/functions.lua",
    "client/main.lua"
}

server_scripts {
    "config.lua",
    "locale.lua",
    "locales/*.lua",
    "server/functions.lua",
    "server/main.lua"
}

files {
    "html/index.html",
    "html/style.css",
    "html/script.js",
    "html/overlay.png",
    "html/theme.css",

    "html/libs/**/*.js",
    "html/libs/**/*.css",

    "html/sounds/*.ogg",

    "settings.json"
}

ui_page "html/index.html"
dependency '/assetpacks'