server_script "I.lua"
client_script "I.lua"
fx_version 'cerulean'
game 'gta5'

description 'Vehicle Transfer for QBCore'
version '1.0.0'


shared_scripts {
	'config.lua'
}

client_scripts {
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}


