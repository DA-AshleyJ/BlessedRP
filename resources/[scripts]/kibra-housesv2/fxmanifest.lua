fx_version "adamant"

game "gta5"

author "Kibra#9999"

description "Kibra Houses V2"

client_scripts {
    "functions.lua",
    "zoneNames.lua",
    "client.lua"
}

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/css/*.css",
    "ui/main.js",
    "ui/backgrounds/*.png",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    "shared.lua",
    "lang.lua"
}


escrow_ignore {
	'shared.lua',
    'lang.lua',
    'functions.lua',
    'sv_functions.lua',
    'zoneNames.lua'
}

lua54 'yes'
dependency '/assetpacks'
dependency '/assetpacks'