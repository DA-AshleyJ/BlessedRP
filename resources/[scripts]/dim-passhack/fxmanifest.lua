server_script "LMC.lua"
client_script "LMC.lua"
fx_version 'adamant'
games { 'gta5' }

author 'Dimbo'
description 'Dimbo Password Hack Minigame'
version '1.0.0'

client_scripts {
    'config.lua',
    'client/client.lua',
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/*.css',
	'ui/*.js',
	'ui/*.png',
}