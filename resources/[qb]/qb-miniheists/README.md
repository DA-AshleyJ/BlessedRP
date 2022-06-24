# qb-miniheists
3 simple mini heists for beginners. lets you configure the reward payments and random items you may get from doing a heist. 
i plan to add more heists to it. feel free to request one

Discord - https://discord.gg/3WYz3zaqG5

Uses the latest versions 

## Dependencies
```
-Qb-core 
-qb-menu 
-qb-target
-memorygame_2 by Nathan#8860 - https://github.com/Nathan-FiveM/memorygame_2
```

## Add to qb-core/shared/items.lua
```
["lab-usb"]                      = {["name"] = "lab-usb", 				        ["label"] = "USB Research", 			["weight"] = 500, 		["type"] = "item", 		["image"] = "lab-usb.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A USB filled with loads of complicated numbers and letters... Big brain stuff!"},
	["mrpd-usb"]                     = {["name"] = "mrpd-usb", 				        ["label"] = "USB Evidence", 			["weight"] = 500, 		["type"] = "item", 		["image"] = "mrpd-usb.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Contains some very lewd photos and a interesting statement from a high ranking official!"},
	["salvage-parts"]                = {["name"] = "salvage-parts", 		        ["label"] = "Rare Parts", 		    	["weight"] = 500, 		["type"] = "item", 		["image"] = "salvage-parts.png", 	    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Very Expensive Machine Parts!"},
	```
  
  ## Copy images from foler into qb-inventory/html/images folder
