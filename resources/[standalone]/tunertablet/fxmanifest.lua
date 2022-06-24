fx_version 'cerulean'
game 'gta5'

description 'tunertablet'
version '2.5.2'

ui_page 'html/index.html'

client_scripts {
    'client/tablet.lua',
    'client/nitrous.lua',
    'client/print.lua',
    'client/purge.lua'
}

server_scripts {
    'server/main.lua'
}

files {
    'html/*',
}

shared_script 'config.lua'

lua54 'yes'