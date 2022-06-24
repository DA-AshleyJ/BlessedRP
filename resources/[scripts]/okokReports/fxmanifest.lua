fx_version 'cerulean'

game 'gta5'

author 'okok#3488'
description 'okokReportsV2'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_script 'config.lua'

client_scripts {
	'cl_utils.lua',
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_utils.lua',
	'server.lua'	
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'cl_utils.lua',
	'sv_utils.lua'
}
dependency '/assetpacks'