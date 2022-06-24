fx_version 'cerulean'
author '! marcinhu.#6158'
Description 'Fishing'
game 'gta5'

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/**.lua',
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/**.lua',
}

escrow_ignore {
  "config.lua",
  "fxmanifest.lua",
  "README.lua",
  "Images/**",
}


lua54 'yes'

dependency '/assetpacks'