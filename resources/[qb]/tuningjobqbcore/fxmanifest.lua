fx_version 'cerulean'
game 'gta5'

version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'client/main.lua',
	'client/bus.lua',
	'client/tuning.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/tuning.lua'
}

lua54 'yes'
