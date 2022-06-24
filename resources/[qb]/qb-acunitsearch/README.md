AirconSearching script for QBcore

Creator: LuckyRp


Working airconsearch script for QBcore. Script uses QB-Target.. Will not work without qb-target qb-target can be found in the next link!
https://github.com/BerkieBb/qb-target

Paste this in qb-target Inti.lua

```
Config.TargetModels = {
	["acunitsearch"] = {
        models = {
			1709954128,
			-1625667924,
			1131941737,


        },
        options = {
            {
                type = "client",
                event = "qb-acunitsearch:client:searchaircon",
                icon = "fas fa-pencil-ruler",
                label = "Search Aircon",
            },
        },
        distance = 2.1
    },
    
    Thank you for using my scripts!
    
    You can mess with the timer settings untll you can search aircon again.. server.lua
