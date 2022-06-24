fx_version 'cerulean'
game 'gta5'

author 'Kallock - The Goodlife RP Server'
version '1.0.0'

shared_script 'shared.lua'
client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
  'client.lua'
}

server_script 'server.lua'

dependencies {
    'qb-target',
    'qb-input'
}

lua54 'yes'