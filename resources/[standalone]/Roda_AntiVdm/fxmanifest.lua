server_script "5Q.lua"
client_script "5Q.lua"
fx_version 'cerulean'

game 'gta5'

author 'Roderic#0614'
description 'Example'

--Client Scripts-- 
client_scripts {
 'Client/*.lua'
}

--Server Scripts-- 
server_scripts {
     'Server/*.lua'
}

shared_scripts {
    'Config.lua'
}

