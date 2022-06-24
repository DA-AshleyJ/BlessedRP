fx_version 'cerulean'
game 'gta5'


client_scripts {
	'config.lua',
	'locale/locale.lua',
	'@PolyZone/client.lua',
	'client/*.lua',
	
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'locale/locale.lua',
	'config.lua',
	'server/*.lua',
}

escrow_ignore {
	'config.lua',  -- Only ignore one file
	'client/public.lua',
	'server/public.lua',
	'locale/locale.lua',
}

lua54 'yes'

dependencies {
    'qb-target',
    'qb-menu',
	'qb-input',
	'xsound',
}
