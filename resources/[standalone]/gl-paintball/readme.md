---------- For Using With Limited Ammo -----------

Add To Items

['weapon_paintgun']     = {['name'] = 'weapon_paintgun',         ['label'] = 'Paint Ball Gun',        ['weight'] = 1000,         ['type'] = 'weapon',     ['ammotype'] = 'AMMO_PAINT',            ['image'] = 'weapon_paintgun.png',    ['unique'] = true,     ['useable'] = true,     ['description'] = 'Weapon Paint Ball'},

['paint_ammo']			         = {['name'] = 'paint_ammo', 			  	    ['label'] = 'Paint Ammo', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'paint_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Ammo for Paintball'},

Add To Weapons
[`weapon_paintgun`]     = {['name'] = 'weapon_paintgun',    ['label'] = 'Paint Ball Gun',    ['ammotype'] = 'AMMO_PAINT',            ['damagereason'] = 'Painted'},

Add qb-weapons/server/main.lua

QBCore.Functions.CreateUseableItem('paint_ammo', function(source, item)
    TriggerClientEvent('weapon:client:AddAmmo', source, 'AMMO_PAINT', 8, item)
end)

---------- For Using With InfiniteAmmo -----------

Add To Items

['weapon_paintgun']     = {['name'] = 'weapon_paintgun',         ['label'] = 'Paint Ball Gun',        ['weight'] = 1000,         ['type'] = 'weapon',     ['ammotype'] = nil,            ['image'] = 'weapon_paintgun.png',    ['unique'] = true,     ['useable'] = true,     ['description'] = 'Weapon Paint Ball'},

Add To Weapons
[`weapon_paintgun`]     = {['name'] = 'weapon_paintgun',    ['label'] = 'Paint Ball Gun',    ['ammotype'] = nil,            ['damagereason'] = 'Painted'},