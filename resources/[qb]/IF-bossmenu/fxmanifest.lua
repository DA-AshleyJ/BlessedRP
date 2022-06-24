fx_version 'cerulean'
game 'gta5'

description 'qb-BossMenu'
version '1.0.0'

client_scripts {
    '@menuv/menuv.lua',
    'config.lua',
    'client.lua'
}

server_script 'server.lua'

server_export 'GetAccount'

escrow_ignore {
    'config.lua',
    'client.lua',
    'server.lua'
}
lua54 'yes'
dependency '/assetpacks'