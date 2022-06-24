fx_version 'bodacious'
game 'gta5'

name "Pacific Bank Robbery"
description "A pacific bank robbery script for FiveM."
author "SpecialStos"
version "1.0.9"
lua54 'yes'

dependencies {
    "PolyZone",
    "mka-lasers",
    "interact-sound"
}

client_scripts {
    '@mka-lasers/client/client.lua',
    "@PolyZone/client.lua",
    'configs/config.lua',
    'client/mainLoop.lua',
    'client/events.lua',
    'client/nuiEvents.lua',
    'configs/languages.lua',
    'client/safeCracking.lua',
    'configs/functions.lua',
    'garbageCollector.lua',
}

server_scripts {
    'configs/config.lua',
    'server/pacificBankRobbery.lua',
    'server/events.lua',
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
    'client/mainLoop.lua',
    'client/events.lua',
    'client/nuiEvents.lua',
    'configs/languages.lua',
    'client/safeCracking.lua',
    'configs/functions.lua',
    'garbageCollector.lua',

    --SERVER--
    'server/pacificBankRobbery.lua',
    'server/events.lua',
    'server/versionCheck.lua',
    'configs/functions.lua',

    --EXTRA FILES--
    "client/html/index.html",
    "client/html/vue.min.js",
	"client/html/js/script.js",
    "client/html/css/reset.css",
    "client/html/css/style.css",
    "client/html/css/img/*.png",

    --DEPENDENCIES ESCROW--
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/interact-sound/client/html/index.html',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/interact-sound/client/html/sounds/*.ogg',

    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/phone.png',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/snd/beep.ogg',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/snd/correct.ogg',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/snd/fail.ogg', 
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/snd/start.ogg',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/snd/finish.ogg',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/snd/wrong.ogg',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mhacking/hack.html',

    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mka-lasers/client/client.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mka-lasers/client/creation.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/mka-lasers/server/creation.lua',

    'DEPENDENCIES-YOU-NEED-TO-INSTALL/PolyZone/client.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/PolyZone/BoxZone.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/PolyZone/EntityZone.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/PolyZone/CircleZone.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/PolyZone/ComboZone.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/PolyZone/creation/*.lua',
    'DEPENDENCIES-YOU-NEED-TO-INSTALL/PolyZone/server.lua',
  }
