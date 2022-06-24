fx_version 'cerulean'
game 'gta5'

author 'Disabled Coding'
description 'A houses resource meant for MLOs and Ymaps'
version '1.2.0'
repository 'https://github.com/Disabled-Coding/dc-open-houses'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want
    'config.lua'
}

client_script 'client.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/commands.lua'
}

lua54 'yes'
