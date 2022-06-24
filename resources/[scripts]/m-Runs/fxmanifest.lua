fx_version 'cerulean'
author 'marcinhu#0001'
Description 'm-Runs'
game 'gta5'

shared_scripts { 
    "config/**",
}

server_script { 
    "server/**.lua",
}

client_script {
    "client/**.lua",
}

escrow_ignore {
    "images/**",
    "config/**",
    "README.lua",
}

lua54 'yes'
dependency '/assetpacks'
dependency '/assetpacks'