fx_version 'cerulean'
game 'gta5'
author 'Lucid#3604'


shared_scripts {
    'config.lua'
}


client_scripts {
	'GetFrameworkObject.lua',
    'client/client.lua',
    'client/nitro.lua',

    'client/stress.lua',
    'client/UpdateMoney.lua',
    'client/status.lua',
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua',
	'GetFrameworkObject.lua',
    'server/server.lua',
    'server/PlayerLoaded.lua',
    'server/stress.lua',
    'server/nitro.lua',
}

ui_page {
	'html/index.html',
}

files {
	'html/assets/fonts/*.otf',
	'html/assets/images/*.png',
	'html/assets/weapons/*.png',

	'html/lib/*.js',
	'html/script/*.js',
	'html/index.html',
	'html/*.ogg',
	'html/style/*.css',
}

lua54 'on'


escrow_ignore {
	'config.lua',
	'GetFrameworkObject.lua',
    'server/PlayerLoaded.lua',
    'server/stress.lua',
    'server/nitro.lua',
    'client/nitro.lua',
    'client/stress.lua',
    'client/UpdateMoney.lua',
    'client/status.lua'
}