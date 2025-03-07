fx_version 'cerulean'
game 'gta5'

description 'QB-AmbulanceJob'
version '1.0.0'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/wounding.lua',
	'client/laststand.lua',
	'client/job.lua',
	'client/dead.lua',
	'client/chairs.lua',
	
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

escrow_ignore {
  'config.lua', 
  'locales/en.lua', 
}


lua54 'yes'
dependency '/assetpacks'