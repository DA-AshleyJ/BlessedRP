fx_version 'bodacious'
game 'gta5'

lua54 'yes'
escrow_ignore {
 'config.lua', 
 'notification.lua'
}

client_script "client.lua"
client_script "notification.lua"

shared_script "config.lua"
server_script "server.lua"

ui_page('index.html')

files({
 'index.html',
 'css/*.css',
 'js/*.js',
 'js/*.js.map',
})

-- Comment this out if you are not using esx.
shared_script '@es_extended/imports.lua'
dependency '/assetpacks'