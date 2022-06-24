Config = {}

Config.webhook = "https://discord.com/api/webhooks/975390159816233011/M7gzL-2uy5fUh8OieGjirQag2eMhDnnjBvWHQK2AiXKH8H0incRoO1uLV_OE2PEIu4Vk"						-- Webhook to send logs to discord
Config.lang = "en"								-- Set the file language [en/br]

Config.Framework = {							-- ESX/QB settings, if you are using vRP just ignore
	['account_dealership'] = 'bank',			-- Change here the account that should be used with dealership expenses
	['account_customers'] = 'bank',				-- Change here the account that the money should be debited when buying vehicles in the dealership
}

Config.format = {
	['currency'] = 'USD',						-- This is the currency format, so that your currency symbol appears correctly [Examples: BRL, USD]
	['location'] = 'en-US'						-- This is the location of your country, to format the decimal places according to your standard [Examples: pt-BR, en-US]
}
Config.default_stock = 100						-- Stock when the dealership has no owner (set as false to use the values from dealership_stock, if this is not false the dealership_stock table is useless)
Config.max_dealerships_per_player = 1			-- Maximum number of dealerships that each player can have
Config.PlateFormat = 'xxxxxxxx'					-- Plate generation format (n = number | l = letter | x = any)

Config.sell_vehicles = {
	['sell_without_owner'] = false,				-- true: will allow players to intantly sell vehicles to a dealership that has no owner | false: players will only be able to sell vehicle when has owner
	['percentage'] = 0.7						-- Percentage of the vehicle sell value (0.7 = 70%)
}

-- Here are the places where the person can open the dealership menu
-- You can add as many locations as you want, just use the location already created as an example
Config.dealership_locations = {
	["dealer_1"] = {															-- ID
		['buy_price'] = 12000000,												-- Price to buy this dealership
		['sell_price'] = 10000000,												-- Price to sell this dealership
		['coord'] = {114.08, -140.72, 54.87},									-- Coordinate to open the menu
		['truck_coord'] = {130.81,-120.32,54.84,67.11},							-- Garage coordinates, where the trucks will spawn (coordinates composed of x, y, z, h)
		['trailer_coord'] = {144.53,-124.46,54.83,68.99},						-- Garage coordinates, where the trailers will spawn (coordinates composed of x, y, z, h)
		['test_drive'] = {
			['teleport'] = true,												-- If set true, when starting a test drive you'll be teleported to the coord below. Else, the car will just be unfreezed
			['test_drive_coord'] = {124.06,-118.37,54.84,68.79},				-- Coordinates where player will teleport when start a test drive
			['test_drive_time'] = 60											-- Time in seconds the test drive will last
		},
		['truck_name'] = "hauler",												-- Truck spawn name
		['trailer'] = {															-- Trailers spawn name
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {102.39,-136.98,54.75,159.6},				-- Customers garage coordinates, where the bought vehicles will spawn (coordinates composed of x, y, z, h)
		['sell_blip_coords'] = {												-- The coordinates where customers will buy things on this dealership (coordinates composed of x, y, z)
			{
				['dealer'] = {129.0, -152.03, 54.87},
				['preview'] = {126.73,-157.67,53.79,40.76} 
			},
			{
				['dealer'] = {136.82, -155.04, 54.86},
				['preview'] = {134.09,-160.14,53.79,34.53} 
			},
			{
				['dealer'] = {144.76, -157.88, 54.86},
				['preview'] = {142.02,-163.57,53.79,43.88}
			}
		},
		['type'] = 'main_dealer',			 									-- Insert here the dealership type ID
		['account'] = {															-- Account settings for this dealership
			['vehicles'] = 'bank',												-- Account that the money should be debited when buying vehicle in the dealership
			['dealership'] = 'bank',											-- Account that should be used with dealership expenses (owner)
		}
	},
	["bike_dealer"] = {															-- ID
	['buy_price'] = 12000000,												-- Price to buy this dealership
	['sell_price'] = 10000000,												-- Price to sell this dealership
	['coord'] = {114.08, -140.72, 54.87},									-- Coordinate to open the menu
	['truck_coord'] = {130.81,-120.32,54.84,67.11},							-- Garage coordinates, where the trucks will spawn (coordinates composed of x, y, z, h)
	['trailer_coord'] = {144.53,-124.46,54.83,68.99},						-- Garage coordinates, where the trailers will spawn (coordinates composed of x, y, z, h)
	['test_drive'] = {
		['teleport'] = true,												-- If set true, when starting a test drive you'll be teleported to the coord below. Else, the car will just be unfreezed
		['test_drive_coord'] = {124.06,-118.37,54.84,68.79},				-- Coordinates where player will teleport when start a test drive
		['test_drive_time'] = 60											-- Time in seconds the test drive will last
	},
	['truck_name'] = "hauler",												-- Truck spawn name
	['trailer'] = {															-- Trailers spawn name
		['empty'] = "tr2",
		['full'] = "tr4",
	},
	['cutomers_garage_coord'] = {102.39,-136.98,54.75,159.6},				-- Customers garage coordinates, where the bought vehicles will spawn (coordinates composed of x, y, z, h)
	['sell_blip_coords'] = {												-- The coordinates where customers will buy things on this dealership (coordinates composed of x, y, z)
		{
			['dealer'] = {129.0, -152.03, 54.87},
			['preview'] = {126.73,-157.67,53.79,40.76} 
		},
		{
			['dealer'] = {136.82, -155.04, 54.86},
			['preview'] = {134.09,-160.14,53.79,34.53} 
		},
		{
			['dealer'] = {144.76, -157.88, 54.86},
			['preview'] = {142.02,-163.57,53.79,43.88}
		}
	},
	['type'] = 'bike_dealer',			 									-- Insert here the dealership type ID
	['account'] = {															-- Account settings for this dealership
		['vehicles'] = 'bank',												-- Account that the money should be debited when buying vehicle in the dealership
		['dealership'] = 'bank',											-- Account that should be used with dealership expenses (owner)
	}
},
	["redline"] = {															-- ID
		['buy_price'] = 12000000,												-- Price to buy this dealership
		['sell_price'] = 10000000,												-- Price to sell this dealership
		['coord'] = {-593.98, -923.84, 17.36},									-- Coordinate to open the menu
		['truck_coord'] = {-525.65, -886.74, 25.08, 147.64},							-- Garage coordinates, where the trucks will spawn (coordinates composed of x, y, z, h)
		['trailer_coord'] = {-551.33, -889.39, 25.12, 269.88},						-- Garage coordinates, where the trailers will spawn (coordinates composed of x, y, z, h)
		['test_drive'] = {
			['teleport'] = true,											-- If set true, when starting a test drive you'll be teleported to the coord below. Else, the car will just be unfreezed
			['test_drive_coord'] = {-539.03, -900.55, 23.86, 152.47},				-- Coordinates where player will teleport when start a test drive
			['test_drive_time'] = 60											-- Time in seconds the test drive will last
	},
	['truck_name'] = "bchauler",												-- Truck spawn name
	['trailer'] = {															-- Trailers spawn name
		['empty'] = "bcfl",
		['full'] = "bcfl",
	},
	['cutomers_garage_coord'] = {-532.63, -891.61, 24.59, 174.52},				-- Customers garage coordinates, where the bought vehicles will spawn (coordinates composed of x, y, z, h)
	['sell_blip_coords'] = {												-- The coordinates where customers will buy things on this dealership (coordinates composed of x, y, z)
		{
			['dealer'] = {-597.08, -921.34, 17.36},
			['preview'] = {-602.98, -922.91, 17.59, 260.19} 
		},
		{
			['dealer'] = {-590.79, -927.71, 17.36},
			['preview'] = {-593.51, -932.49, 17.59, 317.31} 
		},
		{
			['dealer'] = {-590.05, -921.61, 17.36},
			['preview'] = {-583.93, -923.2, 17.59, 357.91}
		}
	},
	['type'] = 'redline_dealer',			 									-- Insert here the dealership type ID
	['account'] = {															-- Account settings for this dealership
		['vehicles'] = 'bank',												-- Account that the money should be debited when buying vehicle in the dealership
		['dealership'] = 'bank',											-- Account that should be used with dealership expenses (owner)
	}
},
["dealer_2"] = {
		['buy_price'] = 8000000,
		['sell_price'] = 6000000,
		['coord'] = {1224.87, 2731.71, 37.98},
		['truck_coord'] = {1241.96,2705.5,38.01,181.3},
		['trailer_coord'] = {1248.68,2708.2,38.01,181.22},
		['test_drive'] = {
			['teleport'] = true,
			['test_drive_coord'] = {1249.53,2706.27,38.01,184.25},
			['test_drive_time'] = 60
		},
		['truck_name'] = "hauler",
		['trailer'] = {
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {1243.7,2715.81,38.01,187.22},
		['sell_blip_coords'] = {
			{
				['dealer'] = {1220.51, 2715.75, 38.01},
				['preview'] = {1216.21,2710.88,38.02,270.58}
			},
			{
				['dealer'] = {1230.6, 2715.54, 38.01},
				['preview'] = {1234.72,2711.05,38.02,90.73}
			}
		},
		['type'] = 'Rally_dealer',
		['account'] = {
			['vehicles'] = 'bank',
			['dealership'] = 'bank',
		}
	},
	["dealer_3"] = {
		['buy_price'] = 150000,
		['sell_price'] = 130000,
		['coord'] = {119.54, -125.52, 60.49}, --
		['truck_coord'] = {130.81,-120.32,54.84,67.11}, --
		['trailer_coord'] = {144.53,-124.46,54.83,68.99}, --
		['test_drive'] = {
			['teleport'] = true,
			['test_drive_coord'] = {123.19,-127.18,54.84,337.59}, --
			['test_drive_time'] = 60
		},
		['truck_name'] = "hauler",
		['trailer'] = {
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {105.6,-126.57,54.75,161.28}, --
		['sell_blip_coords'] = {
			{
				['dealer'] = {118.85, -144.01, 60.48}, --
				['preview'] = {113.48,-146.33,59.77,229.52} --
			},
			{
				['dealer'] = {121.41, -149.61, 60.49}, --
				['preview'] = {118.59,-154.77,59.77,32.36} --
			}
		},
		['type'] = 'Super_dealer',
		['account'] = {
			['vehicles'] = 'bank',
			['dealership'] = 'bank',
		}
	},
	["dealer_4"] = {
		['buy_price'] = 8000000,
		['sell_price'] = 6000000,
		['coord'] = {-31.08, -1097.57, 27.27},
		['truck_coord'] = {-23.12,-1115.04,26.69,159.07},
		['trailer_coord'] = {-15.6,-1109.44,26.68,159.6},
		['test_drive'] = {
			['teleport'] = false,
			['test_drive_coord'] = {-30.63,-1090.2,26.43,336.29},
			['test_drive_time'] = 60
		},
		['truck_name'] = "hauler",
		['trailer'] = {
			['empty'] = "tr2",
			['full'] = "tr4",
		},
		['cutomers_garage_coord'] = {-23.68, -1094.98, 27.31, 340.11},
		['sell_blip_coords'] = {
			{
				['dealer'] = {-51.29, -1087.49, 27.27},
				['preview'] = {-49.76, -1083.12, 27.3, 189.24}
			},
			{
				['dealer'] = {-51.24, -1094.69, 27.27},
				['preview'] = {-54.5, -1096.91, 27.3, 260.09}

			},
			{
				['dealer'] = {-46.86, -1095.91, 27.27},
				['preview'] = {-47.52, -1092.03, 27.3, 164.03}

			},
			{
				['dealer'] = {-38.57, -1100.04, 27.27},
				['preview'] = {-42.77, -1101.39, 27.3, 235.51}

			},
			{
				['dealer'] = {-40.72, -1094.71, 27.27},
				['preview'] = {-36.85, -1093.42, 27.3, 76.71}

			},
		},
		['type'] = 'main_dealer',
		['account'] = {
			['vehicles'] = 'bank',
			['dealership'] = 'bank',
		}
	},
}
-- Here you configure each type of dealership available to buy
Config.dealership_types = {
	['main_dealer'] = {								-- Dealership type ID
		['stock_capacity'] = 150,					-- Max stock capacity
		['max_employees'] = 5,						-- Max employees
		['vehicles'] = {							-- Here you configure the vehicles on this dealership
			['a6tfsi'] = {							-- The vehicle ID
				['name'] = "A6 TFSI Quattro S-Line",					-- The vehicle display name
				['price_to_customer'] = 32000,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/a6tfsi.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},
			['rs7'] = {							-- The vehicle ID
				['name'] = "RS7 Sportback",					-- The vehicle display name
				['price_to_customer'] = 38500,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/rs7.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},
			['rs6'] = {							-- The vehicle ID
				['name'] = "RS6 ABT",					-- The vehicle display name
				['price_to_customer'] = 35500,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/rs6.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},
			['ttrs'] = {							-- The vehicle ID
				['name'] = "2010 TT RS",					-- The vehicle display name
				['price_to_customer'] = 35500,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/ttrs.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 0						-- Set on which page this vehicle will appear
			},
			['x6m'] = {							-- The vehicle ID
				['name'] = "X6M",					-- The vehicle display name
				['price_to_customer'] = 20500,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/x6m.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},
			['2019M5'] = {							-- The vehicle ID
				['name'] = "M5 F90 Competition",					-- The vehicle display name
				['price_to_customer'] = 30500,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/2019M5.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},
			['bmci'] = {							-- The vehicle ID
				['name'] = "M5 F90 2018",					-- The vehicle display name
				['price_to_customer'] = 40500,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/bmci.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},
			['m2'] = {							-- The vehicle ID
				['name'] = "M2",					-- The vehicle display name
				['price_to_customer'] = 10500,		-- Price the customer will pay when buy the product in dealership
				['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
				['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
				['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
				['max_stock'] = 150,				-- Max stock amount of this vehicle
				['img'] = 'images/m2.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
				['page'] = 1						-- Set on which page this vehicle will appear
			},
			['cats'] = {							-- The vehicle ID
			['name'] = "ATS-V Coupe",					-- The vehicle display name
			['price_to_customer'] = 17500,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/cats.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 2						-- Set on which page this vehicle will appear
			},
			['gmt900escalade'] = {							-- The vehicle ID
			['name'] = "Escalade GMT900",					-- The vehicle display name
			['price_to_customer'] = 17500,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/gmt900escalade.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 2						-- Set on which page this vehicle will appear
			},
			['cesc21'] = {							-- The vehicle ID
			['name'] = "2021 Cadillac Escalade",					-- The vehicle display name
			['price_to_customer'] = 19500,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/cesc21.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 2						-- Set on which page this vehicle will appear
			},
			['09tahoe'] = {							-- The vehicle ID
			['name'] = "2009 Chevrolet Tahoe",					-- The vehicle display name
			['price_to_customer'] = 6500,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/09tahoe.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 3						-- Set on which page this vehicle will appear
			},
			['2020ss'] = {							-- The vehicle ID
			['name'] = "2020 Chevrolet Camaro SS",					-- The vehicle display name
			['price_to_customer'] = 27000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/2020ss.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 3						-- Set on which page this vehicle will appear
			},
			['corvettec5z06'] = {							-- The vehicle ID
			['name'] = "Chevrolet Corvette C5 Z06",					-- The vehicle display name
			['price_to_customer'] = 41000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/corvettec5z06.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 3						-- Set on which page this vehicle will appear
			},
			['dl2016'] = {							-- The vehicle ID
			['name'] = "Ram Limited 2016",					-- The vehicle display name
			['price_to_customer'] = 16000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/dl2016.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 4						-- Set on which page this vehicle will appear
			},
			['16challenger'] = {							-- The vehicle ID
			['name'] = "2016 Dodge Challenger",					-- The vehicle display name
			['price_to_customer'] = 27000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/16challenger.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 4						-- Set on which page this vehicle will appear
			},
			['f150'] = {							-- The vehicle ID
			['name'] = "2012 Ford F150 SVT Raptor R",					-- The vehicle display name
			['price_to_customer'] = 27000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/f150.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 5						-- Set on which page this vehicle will appear
			},
			['20f250'] = {							-- The vehicle ID
			['name'] = "F-250 Super Duty",					-- The vehicle display name
			['price_to_customer'] = 29000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/20f250.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 5						-- Set on which page this vehicle will appear
			},
			['18f350ds'] = {							-- The vehicle ID
			['name'] = "F-350 Dually",					-- The vehicle display name
			['price_to_customer'] = 32000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/18f350ds.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 5						-- Set on which page this vehicle will appear
			},
			['crownvic'] = {							-- The vehicle ID
			['name'] = "Crown Vic",					-- The vehicle display name
			['price_to_customer'] = 4000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/crownvic.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 5						-- Set on which page this vehicle will appear
			},
			['20denalihd'] = {							-- The vehicle ID
			['name'] = "Sierra Denali HD3500",					-- The vehicle display name
			['price_to_customer'] = 21000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/20denalihd.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 6						-- Set on which page this vehicle will appear
			},
			['gmcs'] = {							-- The vehicle ID
			['name'] = "Sierra 1500 Crew Cab",					-- The vehicle display name
			['price_to_customer'] = 18000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/gmcs.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 6						-- Set on which page this vehicle will appear
			},
			['gmcyd'] = {							-- The vehicle ID
			['name'] = "Yukon Denali 2015",					-- The vehicle display name
			['price_to_customer'] = 15000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/gmcyd.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 6						-- Set on which page this vehicle will appear
			},
			['ap2'] = {							-- The vehicle ID
			['name'] = "Honda S2000 AP2",					-- The vehicle display name
			['price_to_customer'] = 22000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/ap2.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 7						-- Set on which page this vehicle will appear
			},
			['fk8'] = {							-- The vehicle ID
			['name'] = "Civic Type-R (FK8)",					-- The vehicle display name
			['price_to_customer'] = 27000,		-- Price the customer will pay when buy the product in dealership
			['price_to_owner'] = 30,			-- Price the dealership owner must pay when importing vehicles to your dealership
			['price_to_export'] = 50,			-- Price the dealership owner will earn when exporting vehicles to your dealership
			['amount_to_owner'] = 20,			-- Max amount of vehicles the owner will get when importing/exporting this vehicle
			['max_stock'] = 150,				-- Max stock amount of this vehicle
			['img'] = 'images/fk8.png',		-- Image file name of this vehicle inside nui/img (it can be a URL too)
			['page'] = 7						-- Set on which page this vehicle will appear
			},
				
			
		},
		['pagination'] = {				-- Create pages to your vehicles
			[0] = "Audi",
			[1] = "BMW",
			[2] = "Cadillac",
			[3] = "Chevrolet",
			[4] = "Dodge",
			[5] = "Ford",
			[6] = "GMC",
			[7] = "Honda",
			
		},
		['blips'] = {					-- Create the blips on map
			['id'] = 225,				-- Blip ID [Set this value 0 to dont have blip]
			['name'] = "Dealership",	-- Blip Name
			['color'] = 4,				-- Blip Color
			['scale'] = 0.5,			-- Blip Scale
		}
	},
	['Rally_dealer'] = {
		['stock_capacity'] = 300,
		['max_employees'] = 5,
		['vehicles'] = {
	 		['bfinjection'] = {
				['name'] = "BF Injection",
	 			['price_to_customer'] = 25000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/bfinjection.png',
	 			['page'] = 0
	 		},
	 		['bifta'] = {
				['name'] = "Bifta",
	 			['price_to_customer'] = 145000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Bifta.png',
	 			['page'] = 0
	 		},
	 		['bodhi2'] = {
				['name'] = "Bodhi 2",
	 			['price_to_customer'] = 110000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Bodhi2.png',
	 			['page'] = 0
	 		},
	 		['dubsta3'] = {
				['name'] = "Dubsta3",
	 			['price_to_customer'] = 370000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Dubsta3.png',
	 			['page'] = 0
	 		},
	 		['mesa3'] = {
				['name'] = "Mesa3",
	 			['price_to_customer'] = 130000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Mesa3.png',
	 			['page'] = 0
	 		},
	 		['rancherxl'] = {
				['name'] = "Rancher XL",
	 			['price_to_customer'] = 125000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Rancherxl.png',
	 			['page'] = 0
	 		},
	 		['rebel'] = {
				['name'] = "Rebel",
	 			['price_to_customer'] = 125000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Rebel.png',
	 			['page'] = 0
	 		},
	 		['riata'] = {
				['name'] = "Riata",
	 			['price_to_customer'] = 225000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Riata.png',
	 			['page'] = 0
	 		},
	 		['dloader'] = {
				['name'] = "Dloader",
	 			['price_to_customer'] = 75000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Dloader.png',
	 			['page'] = 0
	 		},
	 		['sandking'] = {
				['name'] = "Sand King",
	 			['price_to_customer'] = 175000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Sandking.png',
	 			['page'] = 0
	 		},
	 		['sandKing2'] = {
				['name'] = "Sand King 2",
	 			['price_to_customer'] = 150000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/SandKing2.png',
	 			['page'] = 0
	 		},
	 		['kamacho'] = {
				['name'] = "Kamacho",
	 			['price_to_customer'] = 350000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Kamacho.png',
	 			['page'] = 0
	 		},
	 		['dune'] = {
				['name'] = "Dune",
	 			['price_to_customer'] = 30000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/dune.png',
	 			['page'] = 0
	 		},
	 		['outlaw'] = {
				['name'] = "Outlaw",
	 			['price_to_customer'] = 130000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Outlaw.png',
	 			['page'] = 0
	 		},
	 		['riata'] = {
				['name'] = "Riata",
	 			['price_to_customer'] = 100000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Riata.png',
	 			['page'] = 0
	 		},
	 		['rebel'] = {
				['name'] = "Rebel",
	 			['price_to_customer'] = 80000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Rebel.png',
	 			['page'] = 0
	 		},
	 	},
	 	['pagination'] = {
	 		[0] = "OFF-Road",
	 	},
	 	['blips'] = {
	 		['id'] = 225,
			['name'] = "Dealership",
	 		['color'] = 4,
	 		['scale'] = 0.5,
	 	}
	},
	['bike_dealer'] = {
		['stock_capacity'] = 300,
		['max_employees'] = 5,
		['vehicles'] = {
	 		['dv4r'] = {
				['name'] = "Ducati DV4R",
	 			['price_to_customer'] = 25000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/bfinjection.png',
	 			['page'] = 0
	 		},

	 	},
	 	['pagination'] = {
	 		[0] = "Road Bikes",
			[1] = "Sprots Bikes",
			[2] = "Motorcross Bikes"
	 	},
	 	['blips'] = {
	 		['id'] = 225,
			['name'] = "Bike Dealership",
	 		['color'] = 4,
	 		['scale'] = 0.5,
	 	}
	},
	['redline_dealer'] = {
		['stock_capacity'] = 300,
		['max_employees'] = 3,
		['vehicles'] = {
			 ['evo8'] = {
				['name'] = "Lancer Evo 8",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/evo8.png',
	 			['page'] = 0
	 		},
			 ['mlmansory'] = {
				['name'] = "Mansory",
	 			['price_to_customer'] = 57000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/mlmansory.png',
	 			['page'] = 0
	 		},
			 ['papiss17'] = {
				['name'] = "Chev Drag",
	 			['price_to_customer'] = 37000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/papiss17.png',
	 			['page'] = 0
	 		},
			 ['pgt322'] = {
				['name'] = "Porche GT3",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/pgt322.png',
	 			['page'] = 0
	 		},
			 ['proc10'] = {
				['name'] = "Cevrolet Lowered",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/proc10.png',
	 			['page'] = 0
	 		},
			 ['razer350dually'] = {
				['name'] = "Ford F350 Lifted Flatbed",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/razer350dually.png',
	 			['page'] = 0
	 		},
			 ['s63amg18'] = {
				['name'] = "Mercedes AMG V8 S63",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/s63amg18.png',
	 			['page'] = 0
	 		},
			 ['scatpackrn'] = {
				['name'] = "Dodge Charger Scatpack",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/scatpackrn.png',
	 			['page'] = 0
	 		},
			 ['slammedhawk'] = {
				['name'] = "Jeep Grand Cherokee Slammed",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/slammedhawk.png',
	 			['page'] = 0
	 		},
			 ['sou_70chal'] = {
				['name'] = "Dodge Challenger",
	 			['price_to_customer'] = 50000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/sou_70chal.png',
	 			['page'] = 0
	 		},
	 	},
	 	['pagination'] = {
	 		[0] = "Performance",
	 	},
	 	['blips'] = {
	 		['id'] = 225,
			['name'] = "Redline Performance",
	 		['color'] = 4,
	 		['scale'] = 0.5,
	 	}
	},
	['Super_dealer'] = {
	 	['stock_capacity'] = 300,
		 ['max_employees'] = 5,
		['vehicles'] = {
	 		['adder'] = {
				['name'] = "Adder",
	 			['price_to_customer'] = 750000,
	 			['price_to_owner'] = 700000,
				['price_to_export'] = 750000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Adder.png',
	 			['page'] = 1
	 		},
			['autarch'] = {
				['name'] = "Autarch",
	 			['price_to_customer'] = 1100000,
	 			['price_to_owner'] = 1000000,
				['price_to_export'] = 1100000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Autarch.png',
	 			['page'] = 2
	 		},
			['banshee2'] = {
				['name'] = "Banshee 2",
	 			['price_to_customer'] = 300000,
	 			['price_to_owner'] = 290000,
				['price_to_export'] = 300000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Banshee2.png',
	 			['page'] = 1
	 		},
			['bullet'] = {
				['name'] = "Bullet",
	 			['price_to_customer'] = 375000,
	 			['price_to_owner'] = 365000,
				['price_to_export'] = 375000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Bullet.png',
	 			['page'] = 0
	 		},
			['cheetah2'] = {
				['name'] = "Cheetah 2",
	 			['price_to_customer'] = 255000,
	 			['price_to_owner'] = 245000,
				['price_to_export'] = 255000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Cheetah2.png',
	 			['page'] = 2
	 		},
			['entityxf'] = {
				['name'] = "Entityxf",
	 			['price_to_customer'] = 600000,
	 			['price_to_owner'] = 590000,
				['price_to_export'] = 600000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Entityxf.png',
	 			['page'] = 1
	 		},
			['fmj'] = {
				['name'] = "Fmj",
	 			['price_to_customer'] = 800000,
	 			['price_to_owner'] = 780000,
				['price_to_export'] = 800000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Fmj.png',
	 			['page'] = 2
	 		},
			['furia'] = {
				['name'] = "Furia",
	 			['price_to_customer'] = 765000,
	 			['price_to_owner'] = 755000,
				['price_to_export'] = 765000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Furia.png',
	 			['page'] = 1
	 		},
			['gp1'] = {
				['name'] = "GP1",
	 			['price_to_customer'] = 655000,
	 			['price_to_owner'] = 645000,
				['price_to_export'] = 655000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/GP1.png',
	 			['page'] = 2
	 		},
			['nero'] = {
				['name'] = "Nero",
	 			['price_to_customer'] = 595000,
	 			['price_to_owner'] = 585000,
				['price_to_export'] = 595000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Nero.png',
	 			['page'] = 0
	 		},
			['nero2'] = {
				['name'] = "Nero 2",
	 			['price_to_customer'] = 710000,
	 			['price_to_owner'] = 700000,
				['price_to_export'] = 710000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Nero2.png',
	 			['page'] = 2
	 		},
			['osiris'] = {
				['name'] = "Osiris",
	 			['price_to_customer'] = 700000,
	 			['price_to_owner'] = 690000,
				['price_to_export'] = 700000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Osiris.png',
	 			['page'] = 1
	 		},
			['penetrator'] = {
				['name'] = "Penetrator",
	 			['price_to_customer'] = 760000,
	 			['price_to_owner'] = 750000,
				['price_to_export'] = 760000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Penetrator.png',
	 			['page'] = 0
	 		},
			['reaper'] = {
				['name'] = "Reaper",
	 			['price_to_customer'] = 750000,
	 			['price_to_owner'] = 740000,
				['price_to_export'] = 750000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Reaper.png',
	 			['page'] = 1
	 		},
			['sc1'] = {
				['name'] = "SC1",
	 			['price_to_customer'] = 715000,
	 			['price_to_owner'] = 705000,
				['price_to_export'] = 715000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/SC1.png',
	 			['page'] = 0
	 		},
			['sultanrs'] = {
				['name'] = "Sultan RS",
	 			['price_to_customer'] = 500000,
	 			['price_to_owner'] = 490000,
				['price_to_export'] = 500000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/SultanRS.png',
	 			['page'] = 0
	 		},
			['t20'] = {
				['name'] = "T20",
	 			['price_to_customer'] = 750000,
	 			['price_to_owner'] = 740000,
				['price_to_export'] = 750000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/T20.png',
	 			['page'] = 1
	 		},
			['tempesta'] = {
				['name'] = "Tempesta",
	 			['price_to_customer'] = 625000,
	 			['price_to_owner'] = 615000,
				['price_to_export'] = 625000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Tempesta.png',
	 			['page'] = 1
	 		},
			['turismor'] = {
				['name'] = "Turismo R",
	 			['price_to_customer'] = 475000,
	 			['price_to_owner'] = 465000,
				['price_to_export'] = 475000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Turismor.png',
	 			['page'] = 1
	 		},
			['tyrus'] = {
				['name'] = "Tyrus",
	 			['price_to_customer'] = 715000,
	 			['price_to_owner'] = 705000,
				['price_to_export'] = 715000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Tyrus.png',
	 			['page'] = 2
	 		},
			['vacca'] = {
				['name'] = "Vacca",
	 			['price_to_customer'] = 475000,
	 			['price_to_owner'] = 465000,
				['price_to_export'] = 475000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Vacca.png',
	 			['page'] = 0
	 		},
			['visione'] = {
				['name'] = "Visione",
	 			['price_to_customer'] = 1000000,
	 			['price_to_owner'] = 9900000,
				['price_to_export'] = 1000000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Visione.png',
	 			['page'] = 1
	 		},
			['voltic'] = {
				['name'] = "Voltic",
	 			['price_to_customer'] = 490000,
	 			['price_to_owner'] = 480000,
				['price_to_export'] = 490000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Voltic.png',
	 			['page'] = 0
	 		},
			['zentorno'] = {
				['name'] = "Zentorno",
	 			['price_to_customer'] = 500000,
	 			['price_to_owner'] = 490000,
				['price_to_export'] = 500000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Zentorno.png',
	 			['page'] = 1
	 		},
			['tyrant'] = {
				['name'] = "Tyrant",
	 			['price_to_customer'] = 1100000,
	 			['price_to_owner'] = 1090000,
				['price_to_export'] = 1100000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Tyrant.png',
	 			['page'] = 0
	 		},
			['entity2'] = {
				['name'] = "Entity 2",
	 			['price_to_customer'] = 740000,
	 			['price_to_owner'] = 730000,
				['price_to_export'] = 740000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Entity2.png',
	 			['page'] = 0
	 		},
			['taipan'] = {
				['name'] = "Taipan",
	 			['price_to_customer'] = 850000,
	 			['price_to_owner'] = 840000,
				['price_to_export'] = 850000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Taipan.png',
	 			['page'] = 2
	 		},
			['cyclone'] = {
				['name'] = "Cyclone",
	 			['price_to_customer'] = 650000,
	 			['price_to_owner'] = 640000,
				['price_to_export'] = 650000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Cyclone.png',
	 			['page'] = 1
	 		},
			['italigtb'] = {
				['name'] = "Itali GTB",
	 			['price_to_customer'] = 760000,
	 			['price_to_owner'] = 750000,
				['price_to_export'] = 760000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Italigtb.png',
	 			['page'] = 0
	 		},
			['italigtb2'] = {
				['name'] = "Itali GTB 2",
	 			['price_to_customer'] = 765000,
	 			['price_to_owner'] = 755000,
				['price_to_export'] = 765000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Italigtb2.png',
	 			['page'] = 0
	 		},
			['vagner'] = {
				['name'] = "Vagner",
	 			['price_to_customer'] = 1000000,
	 			['price_to_owner'] = 9900000,
				['price_to_export'] = 1000000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Vagner.png',
	 			['page'] = 2
	 		},
			['xa21'] = {
				['name'] = "XA21",
	 			['price_to_customer'] = 1000000,
	 			['price_to_owner'] = 9900000,
				['price_to_export'] = 1000000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/XA21.png',
	 			['page'] = 1
	 		},
			['tezeract'] = {
				['name'] = "Tezeract",
	 			['price_to_customer'] = 900000,
	 			['price_to_owner'] = 890000,
				['price_to_export'] = 900000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Tezeract.png',
	 			['page'] = 2
	 		},
			['prototipo'] = {
				['name'] = "Prototipo",
	 			['price_to_customer'] = 1450000,
	 			['price_to_owner'] = 1350000,
				['price_to_export'] = 1450000,
	 			['amount_to_owner'] = 2,
				['max_stock'] = 10,
	 			['img'] = 'images/Prototipo.png',
	 			['page'] = 0
	 		},
	 	},
	 	['pagination'] = {
			[0] = "Super",
			[1] = "Luxury",
			[2] = "Race",
			[3] = "Sports",
	 	},
	 	['blips'] = {
	 		['id'] = 0,
			['name'] = "Dealership",
	 		['color'] = 4,
	 		['scale'] = 0.5,
	 	}
	},
	['Bikes_dealer'] = {
	 	['stock_capacity'] = 300,
		 ['max_employees'] = 5,
		['vehicles'] = {
	 		['akuma'] = {
				['name'] = "Akuma",
	 			['price_to_customer'] = 1750000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/akuma.png',
	 			['page'] = 3
	 		},
			['avarus'] = {
				['name'] = "Avarus",
	 			['price_to_customer'] = 450000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/avarus.png',
	 			['page'] = 2
	 		},
			['bagger'] = {
				['name'] = "Bagger",
	 			['price_to_customer'] = 75000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/bagger.png',
	 			['page'] = 6
	 		},
			['bati'] = {
				['name'] = "Bati",
	 			['price_to_customer'] = 375000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/bati.png',
	 			['page'] = 1
	 		},
			['bf400'] = {
				['name'] = "Bf400",
	 			['price_to_customer'] = 1000000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Bf400.png',
	 			['page'] = 0
	 		},
			['carbonrs'] = {
				['name'] = "Carbonrs",
	 			['price_to_customer'] = 490000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Carbonrs.png',
	 			['page'] = 1
	 		},
			['chimera'] = {
				['name'] = "Chimera",
	 			['price_to_customer'] = 190000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Chimera.png',
	 			['page'] = 2
	 		},
			['cliffhanger'] = {
				['name'] = "Cliffhanger",
	 			['price_to_customer'] = 390000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Cliffhanger.png',
	 			['page'] = 2
	 		},
			['daemon'] = {
				['name'] = "Daemon",
	 			['price_to_customer'] = 130000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Daemon.png',
	 			['page'] = 2
	 		},
			['daemon2'] = {
				['name'] = "Daemon 2",
	 			['price_to_customer'] = 140000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Daemon2.png',
	 			['page'] = 2
	 		},
			['defiler'] = {
				['name'] = "Defiler",
	 			['price_to_customer'] = 400000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/defiler.png',
	 			['page'] = 3
	 		},
			['diablous'] = {
				['name'] = "Diablous",
	 			['price_to_customer'] = 440000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Diablous.png',
	 			['page'] = 3
	 		},
			['diablous2'] = {
				['name'] = "Diablous 2",
	 			['price_to_customer'] = 455000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Diablous2.png',
	 			['page'] = 3
	 		},
			['double'] = {
				['name'] = "Double",
	 			['price_to_customer'] = 640000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Double.png',
	 			['page'] = 1
	 		},
			['enduro'] = {
				['name'] = "Enduro",
	 			['price_to_customer'] = 65000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Enduro.png',
	 			['page'] = 0
	 		},
			['esskey'] = {
				['name'] = "Esskey",
	 			['price_to_customer'] = 90000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Esskey.png',
	 			['page'] = 5
	 		},
			['faggio'] = {
				['name'] = "Faggio",
	 			['price_to_customer'] = 7500,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Faggio.png',
	 			['page'] = 4
	 		},
			['faggio2'] = {
				['name'] = "Faggio 2",
	 			['price_to_customer'] = 6000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Faggio2.png',
	 			['page'] = 4
	 		},
			['faggio3'] = {
				['name'] = "Faggio 3",
	 			['price_to_customer'] = 6000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Faggio3.png',
	 			['page'] = 4
	 		},
			['fcr'] = {
				['name'] = "Fcr",
	 			['price_to_customer'] = 160000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Fcr.png',
	 			['page'] = 5
	 		},
			['fcr2'] = {
				['name'] = "Fcr 2",
	 			['price_to_customer'] = 170000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Fcr2.png',
	 			['page'] = 5
	 		},
			['gargoyle'] = {
				['name'] = "Gargoyle",
	 			['price_to_customer'] = 310000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Gargoyle.png',
	 			['page'] = 2
	 		},
			['hakuchou'] = {
				['name'] = "Hakuchou",
	 			['price_to_customer'] = 800000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Hakuchou.png',
	 			['page'] = 1
	 		},
			['hexer'] = {
				['name'] = "Hexer",
	 			['price_to_customer'] = 60000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Hexer.png',
	 			['page'] = 2
	 		},
			['innovation'] = {
				['name'] = "Innovation",
	 			['price_to_customer'] = 130000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Innovation.png',
	 			['page'] = 2
	 		},
			['lectro'] = {
				['name'] = "Lectro",
	 			['price_to_customer'] = 205000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/lectro.png',
	 			['page'] = 3
	 		},
			['manchez'] = {
				['name'] = "Manchez",
	 			['price_to_customer'] = 245000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Manchez.png',
	 			['page'] = 0
	 		},
			['nemesis'] = {
				['name'] = "Nemesis",
	 			['price_to_customer'] = 180000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Nemesis.png',
	 			['page'] = 3
	 		},
			['nightblade'] = {
				['name'] = "Nightblade",
	 			['price_to_customer'] = 360000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Nightblade.png',
	 			['page'] = 2
	 		},
			['pcj'] = {
				['name'] = "Pcj",
	 			['price_to_customer'] = 47500,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Pcj.png',
	 			['page'] = 5
	 		},
			['ruffian'] = {
				['name'] = "Ruffian",
	 			['price_to_customer'] = 160000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Ruffian.png',
	 			['page'] = 5
	 		},
			['sanchez'] = {
				['name'] = "Sanchez",
	 			['price_to_customer'] = 600000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Sanchez.png',
	 			['page'] = 0
	 		},
			['sanctus'] = {
				['name'] = "Sanctus",
	 			['price_to_customer'] = 775000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Sanctus.png',
	 			['page'] = 2
	 		},
			['sovereign'] = {
				['name'] = "Sovereign",
	 			['price_to_customer'] = 80000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/sovereign.png',
	 			['page'] = 6
	 		},
			['thrust'] = {
				['name'] = "Thrust",
	 			['price_to_customer'] = 100000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Thrust.png',
	 			['page'] = 6
	 		},
			['vindicator'] = {
				['name'] = "Vindicator",
	 			['price_to_customer'] = 145000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Vindicator.png',
	 			['page'] = 6
	 		},
			['vortex'] = {
				['name'] = "Vortex",
	 			['price_to_customer'] = 375000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Vortex.png',
	 			['page'] = 1
	 		},
			['wolfsbane'] = {
				['name'] = "Wolfsbane",
	 			['price_to_customer'] = 85000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Wolfsbane.png',
	 			['page'] = 2
	 		},
			['zombiea'] = {
				['name'] = "Zombiea",
	 			['price_to_customer'] = 105000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Zombiea.png',
	 			['page'] = 2
	 		},
			['zombieb'] = {
				['name'] = "Zombieb",
	 			['price_to_customer'] = 122500,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Zombieb.png',
	 			['page'] = 2
	 		},
			['blazer'] = {
				['name'] = "Blazer",
	 			['price_to_customer'] = 90000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Blazer.png',
	 			['page'] = 7
	 		},
			['blazer4'] = {
				['name'] = "Blazer 4",
	 			['price_to_customer'] = 240000,
	 			['price_to_owner'] = 30,
				['price_to_export'] = 43000,
	 			['amount_to_owner'] = 35,
				['max_stock'] = 10,
	 			['img'] = 'images/Blazer4.png',
	 			['page'] = 7
	 		},
			
	 	},
	 	['pagination'] = {
	 		[0] = "Trail",
	 		[1] = "Sport",
	 		[2] = "Custom",
	 		[3] = "Naked",
	 		[4] = "Scooter",
	 		[5] = "Street",
	 		[6] = "Touring",
	 		[7] = "Quad",
	 	},
	 	['blips'] = {
	 		['id'] = 226,
			['name'] = "Dealership",
	 		['color'] = 4,
	 		['scale'] = 0.5,
	 	}
	},
}

-- Cargo delivery locations
Config.delivery_locations = {
	[1] = { 1014.62, -3132.29, 5.91 }
}

-- Setting to remove inactive dealerships
Config.clear_dealerships = {
	['active'] = false,				-- Set to false to disable this function
	['min_stock_amount'] = 30,		-- Minimum percentage of stock to consider an inactive dealerships. Dealerships that have been inactive for a long time will be removed
	['min_stock_variety'] = 70,		-- Minimum percentage of variety of products in stock to consider an inactive dealerships. Dealerships that have been inactive for a long time will be removed
	['cooldown'] = 72				-- Time (in hours) that the dealerships needs to be below the minimum amount of stock to be removed
}

Config.hotkeys = {
	['openNui'] = 38,		-- E
	['testDrive'] = 38,		-- E
	['buyVehicle'] = 29,	-- B
	['unlockTruck'] = 182 	-- L
}

Config.createTable = true