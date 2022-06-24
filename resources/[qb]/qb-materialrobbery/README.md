# qb-materialrobbery

Simple Material robbery for QBCore

I used mt-stealcopper as the Base

[Me](https://github.com/Predator7158) 

[Marttins (Creator of mt-stealcopper)](https://github.com/Marttins011)

# Dependencies

[qb-core](https://github.com/qbcore-framework/qb-core) 

[qb-target](https://github.com/BerkieBb/qb-target) 

[qb-lock](https://github.com/M-Middy/qb-lock)

# Add this to qb-target init.lua

```
	["materialsrob"] = {
        models = {
            1709954128,
			1131941737,
			-1625667924,
			-2007495856,
			-1620823304,
			-2008643115,
        },
        options = {
            {
                type = "client",
                event = "qb-materialrobbery:client:RoubarCobre",
                icon = "fas fa-mask",
                label = "Rob Materials",
            },
        },
        distance = 1.5,
    },
```
