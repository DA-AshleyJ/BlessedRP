fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author "KOKOROG#1041"

description "store.infinityrp.me"


ui_page 'html/index.html'

client_scripts { 
    "client.lua",
    "lang.lua"
}

server_scripts { 
    -- "@mysql-async/lib/MySQL.lua",
    "@oxmysql/lib/MySQL.lua",
    "server.lua",
    "webhook.lua",
    "lang.lua"
}

files {
    'html/*'
}

escrow_ignore {
    'config.lua',
    'webhook.lua',
    'lang.lua'
}

shared_script "config.lua"
lua54 'yes'
dependency '/assetpacks'