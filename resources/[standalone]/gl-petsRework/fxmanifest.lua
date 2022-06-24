fx_version 'cerulean'
game 'gta5'

author 'Kallock - The Goodlife RP Server, edited manifest to APPEASE OVERLORD KAKAROT'
version '1.0.0'

dependencies "qb-target"

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client.lua'
}


server_script {
    'server.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_script 'shared.lua'
