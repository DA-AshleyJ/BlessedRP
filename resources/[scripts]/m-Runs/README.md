# m-Runs script for QB-Core

| If you are intested in recieving updates join the community on **[Discord](https://discord.gg/svmzYehU8R)**! |

# About
- Optimized
- Many Features
- Full and easy customization
- 0.00ms

# Features
- 3 Runs: Weed Run , Coke Run , Guns Run.
- 3 Items: Weed box, Coke box, Guns box.
- Players can open crates and get rewards.
- Can enable/disable mask detection on player.
- Call the police with chance chosen by you.
- Level system.
- You can only block for one gang.
- You can only block for one job.


# Required
**qb-core/shared/items.lua**
```
	["weedbox"] 			= {["name"] = "weedbox", 		["label"] = "Weed Box", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "weedbox.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["cokebox"] 			= {["name"] = "cokebox", 		["label"] = "Coke Box", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "cokebox.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["gunsbox"] 			= {["name"] = "gunsbox", 		["label"] = "Guns Box", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "gunsbox.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},

```

**qb-core/server/player.lua**

PlayerData.metadata['runsxp'] = PlayerData.metadata['runsxp'] or 0

Like this : https://media.discordapp.net/attachments/833847269185814568/985646640377511947/unknown.png
