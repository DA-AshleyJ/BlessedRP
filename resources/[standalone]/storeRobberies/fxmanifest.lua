fx_version 'bodacious'
game 'gta5'

name "Store Robberies"
description "A store robbery system for FiveM."
author "SpecialStos"
version "1.2.4"
lua54 'yes'

client_scripts {
    'configs/config.lua',
    'configs/languages.lua',
    'client/nuiEvents.lua',
    'client/events.lua',
    'client/mainLoop.lua',
    'client/safeCracking.lua',
    'configs/functions.lua',
    'garbageCollector.lua',
}

server_scripts {
    'configs/config.lua',
    'server/storeRobberies.lua',
    'server/versionCheck.lua',
    'configs/functions.lua',
}

ui_page "client/html/index.html"

files {
    "client/html/index.html",
    "client/html/vue.min.js",
	"client/html/js/script.js",
    "client/html/css/reset.css",
    "client/html/css/style.css",
    "client/html/css/img/*.png",
}

escrow_ignore {
    --CLIENT--
    'configs/config.lua',
    'configs/languages.lua',
    'client/nuiEvents.lua',
    'client/events.lua',
    'client/mainLoop.lua',
    'client/safeCracking.lua',
    'configs/functions.lua',
    'garbageCollector.lua',

    --SERVER--
    'server/storeRobberies.lua',
    'server/versionCheck.lua',
    'configs/functions.lua',

    --EXTRA FILES--
    "client/html/index.html",
    "client/html/vue.min.js",
	"client/html/js/script.js",
    "client/html/css/reset.css",
    "client/html/css/style.css",
    "client/html/css/img/*.png",
  }

