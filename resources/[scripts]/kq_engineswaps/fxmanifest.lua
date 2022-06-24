fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Engine Swaps by KuzQuality'
version '1.0.7'

ui_page 'html/index.html'

--
-- Files
--

files {
    'html/js/jquery.js',
    'html/fonts/FjallaOne.ttf',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/img/engines/*.png',
    'html/index.html',
    'html/snake.html',
}

--
-- Server
--

server_scripts {
    -- '@qb-core/import.lua',
    'config.lua',
    'server/head.lua',
    'server/server.lua',
    'server/editable.lua',
    'locale/locale.lua',
}

--
-- Client
--

client_scripts {
    -- '@qb-core/import.lua',
    'config.lua',
    'client/head.lua',
    'client/client.lua',
    'client/functions.lua',
    'client/handling.lua',
    'client/order.lua',
    'client/editable.lua',
    'locale/locale.lua',
}

escrow_ignore {
    'config.lua',
    'client/head.lua',
    'client/editable.lua',
    'locale/locale.lua',
    'server/head.lua',
    'server/editable.lua',
}

dependency '/assetpacks'