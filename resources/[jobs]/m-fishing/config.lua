Config = {}

---------------
-- Utility
---------------
Config.Framework = "NEW" -- "NEW" - New qbcore | "OLD" - Old qbcore
Config.CoreName = "qb-core" -- Core
Config.TempoEsperaPescar = {minTime = 5000, maxTime = 10000}   -- How long a player will be waiting to fish, during or after casting fishingrod
Config.StopFishing = 73  -- Stop Fishing Key [X] (https://docs.fivem.net/docs/game-references/controls/)
Config.QBTarget = "qb-target"  -- The name of the Target export you are using 
Config.SkillBarFish = "qb-skillbar"	-- np-skillbar / reload-skillbar or qb-skillbar
Config.EnableCommandForProp = true 		-- Enable command to remove fishing rod prop from hand
Config.CommandForProp = "propcana"
Config.HudRelieveStress = "hud:server:RelieveStress"
Config.BonusForEating = "all" 	-- You can put: armour, stress, stamina or all
Config.BonusStress = math.random(5, 10)
Config.BonusAmour = math.random(5, 10)
Config.BonusStamina = 1.0
Config.EnableRentBoat = true

---------------
-- Blips
---------------
Config.EnableGeneralBlips = true
Config.BlipSpriteLegalFishing = 410
Config.BlipDisplayLegalFishing = 4
Config.BlipScaleLegalFishing = 0.7
Config.BlipColourLegalFishing = 74
Config.LegalFishing = {
    [1] = { x = -1814.75, y = -951.19, z = 1.7, name = "Legal Fishing Zone"},
    [2] = { x = -283.98, y = 6602.14, z = 1.33, name = "Legal Fishing Zone"},
}

----------------------
-- Stash 
----------------------
Config.Stash = {
	Name = "FishingBox_",
	Weight = 500000,
	Slots = 12,
}

----------------------
-- Car 
----------------------
Config.PayForVehicle = true
Config.AmountPayForVehicle = 250
Config.Fuel = "LegacyFuel"                                          -- Name of your fuel script
Config.VehicleKeysTrigger = "vehiclekeys:client:SetOwner"           -- Trigger to give vehiclekeys

Config.Barcos = {
    [1] = {barco = "dinghy"},    -- Boat                                 
}

Config.SpawnBarcoLosSantos = { -- Locations to spawn boat SandyShores
    [1] = {x = -1827.51, y = -956.93, z = -0.14, h = 114.64},        
    [2] = {x = -1836.51, y = -946.11, z = -0.27, h = 94.39},
    -- You can add more
}

Config.SpawnBarcoPaletoBay = { -- Locations to spawn boat PaletoBay
    [1] = {x = -292.51, y = 6617.31, z = -0.40, h = 38.70},        
    [2] = {x = -294.22, y = 6637.88, z = -0.40, h = 71.35},
    -- You can add more
}

---------------
-- Fish
---------------
Config.PeixeLegal = { -- Legal Fish
	"cavala",
	"bacalhau",
	"robalo",
	"linguado",
	"fishingtin",
	"raia",
	"fishingboot",
	"salmao",
	"atum",
	"sardinha",
	"peixegato",
	"tamboril"
}

Config.PeixeIlegal = { -- Illegal Fish
	"golfinho",
	"tubaraotigre",
	"tubaraomartelo",
	"baleia",
	"fishingboot",
}

---------------
-- Upgrades
---------------
-- Upgrade Fishingrod
Config.ItemNecessario1 = "raia"					-- First item needed to upgrade fishing rod
Config.ItemNecessario1Label = "Stingray" 		-- Item name to look nice in the menu :D
Config.AmountItemNecessario1 = 25 				-- Amount of first item needed
Config.ItemNecessario2 = "bacalhau" 			-- Second item needed to upgrade fishing rod
Config.ItemNecessario2Label = "Cod" 			-- Item name to look nice in the menu :D
Config.AmountItemNecessario2 = 50 				-- Amount of second item needed

-- Upgrade Net
Config.ItemNecessarioRede1 = "raia"					-- First item needed to upgrade fishing rod
Config.ItemNecessarioRede1Label = "Stingray" 		-- Item name to look nice in the menu :D
Config.AmountItemNecessarioRede1 = 25 				-- Amount of first item needed
Config.ItemNecessarioRede2 = "bacalhau" 			-- Second item needed to upgrade fishing rod
Config.ItemNecessarioRede2Label = "Cod" 			-- Item name to look nice in the menu :D
Config.AmountItemNecessarioRede2 = 50 				-- Amount of second item needed

---------------
-- Rewards
---------------
-- Fishing with fishingrod
Config.RewardFishingRod = {
	FishingRodLevel_1 = {
		Max = 1,
		Min = 1,
	},
	FishingRodLevel_2 = {
		Max = 2,
		Min = 2,
	},
	FishingRodLevel_3 = {
		Max = 3,
		Min = 3,
	},
	FishingRodLevel_4 = {
		Max = 4,
		Min = 4,
	},
	FishingRodLevel_5 = {
		Max = 5,
		Min = 5,
	},
}

--------------------------
-- FISHING NET
--------------------------
Config.FishingNet = {
	Enable = true, -- Enable fishing net?
	BlockBoat = true, -- Block boat when is fishing with fishing net ( Not to spam multiple fishing nets )
}

Config.FishingTimeWithNet = 30000 -- 30 Seconds
Config.RewardsNetFish = {
	NetNivel_1 = {
		Max = 3,
		Min = 2,
	},
	NetNivel_2 = {
		Max = 4,
		Min = 3,
	},
	NetNivel_3 = {
		Max = 5,
		Min = 4,
	},
	NetNivel_4 = {
		Max = 6,
		Min = 5,
	},
	NetNivel_5 = {
		Max = 7,
		Min = 6,
	},
}

---------------
-- Sell Fishs
---------------
Config.EnableBlipSelling = true
Config.VendaPeixes = { -- Blip to sell fish you have caught (ONLY LEGAL FISH)
    [1] = { x = -1816.40, y = -1193.33, z =  13.305, name = "Selling Fish"},
    [2] = { x = -638.65, y = -1249.60, z =  11.81, name = "Selling Fish"},
}

-- Legal Fish
Config.PrecoCavala   	= math.random(1,5)       	-- Price of sell Mackerel
Config.PrecoBacalhau 	= math.random(1,5)      	-- Price of sell Cod
Config.PrecoRobalo   	= math.random(1,5)      	-- Price of sell Bass Fish
Config.PrecoLinguado 	= math.random(1,5)      	-- Price of sell Flounder
Config.PrecoRaia     	= math.random(1,5)      	-- Price of sell Stingrays
Config.PrecoSalmao 	 	= math.random(1,5)			-- Price of sell Stingray
Config.PrecoAtum 	 	= math.random(1,5)			-- Price of sell Tuna Fish
Config.PrecoSardinha 	= math.random(1,5)			-- Price of sell Sardine
Config.PrecoPeixeGato 	= math.random(1,5)			-- Price of sell Catfish
Config.PrecoTamboril	= math.random(1,5)			-- Price of sell Monkfish

-- Ilegal Fish
Config.TypePayment = "blackmoney" -- "cash" or "blackmoney"
Config.Markedbills = "markedbills"
Config.PrecoGolfinho      	= math.random(100,200)   	-- Price of sell Dolphins
Config.PrecoTubaraoTigre   	= math.random(200,300)   	-- Price of sell Tigersharks
Config.PrecoTubaraoMartelo  = math.random(300,400)   	-- Price of sell Hammerhead Sharks
Config.PrecoBaleia  		= math.random(400,500)   	-- Price of sell Killer Whales


---------------
-- Treasure Chest
---------------
Config.CaixasRaras = { 			-- The percentage of these boxes going fishing is: 10%
	"fishingloot",
	"fishinglootbig",
}

Config.RewardDinheiroLootBox = 100   -- Cash reward when opening the box: fishingloot
Config.RewardItemLootBox = 'diamond_ring' -- Item reward when opening the box: fishingloot

Config.RewardsCaixaTesouro = {            -- These items will come out in the box fishinglootbig                      
    [1] = { name = "water", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 1, },
	[2] = { name = "ouro", 	price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 2, },
    [3] = { name = "phone", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 3, },
    [4] = { name = "ferro", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 4, },
    [5] = { name = "water", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 5, },
}

---------------
-- Notifications
---------------
Config["Notificacoes"] = {
	-- General
	["NaoTensNecessario"] = "You don't have the necessary.",
	["SemCanaPesca"] = "You don't have a fishingrod.",
	["SoAnoite"] = "We only work between 20:00 and 00:00.",
	["VoltaNoite"] = "Come back here overnight.",
	["Info1"] = "I know of a friend who buys these fish.",
	["Info2"] = "Search for the restaurant: Train Los Santos Dinner.",
	["NadarPescar"] = "You can't swim and fish at the same time..",
	["ForaVeiculo"] = "You need to be out of a vehicle to fish.",
	["PressionaX"] = "Press [X] to stop fishing",
	["LongeCosta"] = "You need to be further from the coast.",
	["AncoraSolta"] = "Anchor successfully released.",
	["LargarAncora"] = "Boat docked successfully.",
	["PescadoSucesso"] = "Successfully caught fish.",
	["SemIscas"] = "You don't have any fishing bait with you",
	["TentarAbrirTesouro"] = "Trying to open the treasure chest..",
	["ChavePartiu"] = "The corroded key broke.",
	["BauAberto"] = "Treasure chest open! Be sure to collect all your treasure!",
	["Cancelado"] = "Canceled.",
	["ParastePesca"] = "You stopped fishing.",
	["AguaNaoProfunda"] = "The water isn't deep enough to fish.",
	["PescaTerminou"] = "You stopped fishing.",
	["PeixeEscapou"] = "The fish escaped!",
	["NaoTensChave"] = "You don't have the key to open it.",
	["PeixeFugiu"] = "The fish ran away!",
	["SpawnBloqueado"] = "There is a vehicle blocking the spawn.",
	["CallPolice"] = "Someone saw you and called the police!",
	["SemIsca"] = "You don't have any fishbait.",
	-- Sell illegal fish
	["GolfinhoVendido"] = "Dolphin sold by: $"..Config.PrecoGolfinho,
	["NaoTensGolfinho"] = "You don't have any dolphins to sell.",
	["TubaraoTVendido"] = "Tiger shark sold by: $"..Config.PrecoTubaraoTigre,
	["NaoTensTubaraoT"] = "You don't have any tiger sharks for sale.",
	["TubaraoMVendido"] = "Hammer shark sold by: $"..Config.PrecoTubaraoMartelo,
	["NaoTensTubaraoM"] = "You don't have any hammerhead sharks for sale.",
	["BaleiaVendida"] = "Whale sold by: $"..Config.PrecoBaleia,
	["NaoTensBaleia"] = "You don't have any whales to sell.",
	-- Sell legal fish
	["CavalaVendida"] = "Mackerel sold by: $"..Config.PrecoCavala,
	["NaoTensCavala"] = "You don't have any mackerel to sell.",
	["BacalhauVendido"] = "Cod sold by: $"..Config.PrecoBacalhau,
	["NaoTensBacalhau"] = "You don't have any cod to sell.",
	["RobaloVendido"] = "Bass sold by: $"..Config.PrecoRobalo,
	["NaoTensRobalo"] = "You don't have any bass to sell.",
	["LinguadoVendido"] = "Flounder sold by: $"..Config.PrecoLinguado,
	["NaoTensLinguado"] = "You don't have any flounder to sell.",
	["RaiaVendida"] = "Stingray sold by: $"..Config.PrecoRaia,
	["NaoTensRaia"] = "You don't have any stingray to sell.",
	["SalmaoVendida"] = "Salmon sold by: $"..Config.PrecoSalmao,
	["NaoTensSalmao"] = "You don't have any salmon to sell.",
	["AtumVendida"] = "Tuna fish sold by: $"..Config.PrecoAtum,
	["NaoTensAtum"] = "You don't have any tuna fish to sell.",
	["SardinhaVendida"] = "Sardine sold by: $"..Config.PrecoSardinha,
	["NaoTensSardinha"] = "You don't have sardine fish to sell.",
	["PeixeGatoVendida"] = "Catfish sold by: $"..Config.PrecoPeixeGato,
	["NaoTensPeixeGato"] = "You don't have catfish to sell.",
	["TamborilVendida"] = "Monkfish sold by: $"..Config.PrecoPeixeGato,
	["NaoTensTamboril"] = "You don't have monkfish to sell.",
	-- Cooking
	["SemBacalhau"] = "You don't have cod.",
	["SemCavala"] = "You don't have mackerel.",
	["SemSalmao"] = "You don't have salmon.",
	["SemSardinha"] = "You don't have sardines.",
	-- Progressbar anchor
	["DroppingAnchor"] = "Dropping the anchor...",
	["PullingAnchor"] = "Pulling the anchor...",
	-- Automatic net fish
	["NetFishing"] = "Fishing...",
	["DroppingNet"] = "Laying the fishing net..",
	["NoBoat"] = "You're not on any boat.",
	["AutomaticNet"] = "The net will fish automatically, you can do other things.",
	["NetCorrupted"] = "The net corrupted and you caught nothing.",
}

---------------
-- Menus
---------------
Config.QBMenuFish = "qb-menu"
Config["QBMenu"] = {
	-- General
	["Pescador"] = "[👩‍🏭] Fisherman",
	["PedirCana"] = "[🎣] I want a fishingrod!",
	["PedirRede"] = "[🎣] I want a net!",
	["AbrirLoja"] = "[📦] Open Shop",
	["UpgradeCana"] = "[✅] Evolve my fishingrod!",
	["UpgradeRede"] = "[✅] Evolve my net!",
	["SellFish"] = "[🐠] I want sell fish!",
	["InfoSobrePeixeIlegal"] = "Do you know anything about illegal fish?",
	-- Sell Legal Fish
	["SellHeader"] = "[🍽] Pearl's Seafood Restaurante",
	["VenderCavala"] = "[🐠] Sell Mackerel",
	["PrecoCavala"] = "Current Price: $"..Config.PrecoCavala.." each",
	["VenderBacalhau"] = "[🐠] Sell Cod",
	["PrecoBacalhau"] = "Current Price: $"..Config.PrecoBacalhau.." each",
	["VenderRobalo"] = "[🐠] Sell Bass",
	["PrecoRobalo"] = "Current Price: $"..Config.PrecoRobalo.." each",
	["VenderLinguado"] = "[🐠] Sell Flounder",
	["PrecoLinguado"] = "Current Price: $"..Config.PrecoLinguado.." each",
	["VenderRaia"] = "[🐠] Sell Stingray",
	["PrecoRaia"] = "Current Price: $"..Config.PrecoRaia.." each",
	["VenderSalmao"] = "[🐠] Sell Salmon",
	["PrecoSalmao"] = "Current Price: $"..Config.PrecoSalmao.." each",
	["VenderAtum"] = "[🐠] Sell Tuna Fish",
	["PrecoAtum"] = "Current Price: $"..Config.PrecoAtum.." each",
	["VenderSardinha"] = "[🐠] Sell Sardine",
	["PrecoSardinha"] = "Current Price: $"..Config.PrecoSardinha.." each",
	["VenderPeixeGato"] = "[🐠] Sell Catfish",
	["PrecoPeixeGato"] = "Current Price: $"..Config.PrecoPeixeGato.." each",
	["VenderTamboril"] = "[🐠] Sell Monkfish",
	["PrecoTamboril"] = "Current Price: $"..Config.PrecoTamboril.." each",
	-- Sell Ilegal Fish
	["VenderGolfinho"] = "[🐬] Sell Dolphin",
	["PrecoGolfinho"] = "Current Price: $"..Config.PrecoGolfinho.." each",
	["VenderTubaraoTigre"] = "[🦈] Sell Tiger Shark",
	["PrecoTubaraoTigre"] = "Current Price: $"..Config.PrecoTubaraoTigre.." each",
	["VenderTubaraoMartelo"] = "[🦈] Sell Hammer Shark",
	["PrecoTubaraoMartelo"] = "Current Price: $"..Config.PrecoTubaraoMartelo.." each",
	["VenderBaleia"] = "[🐋] Sell Whale",
	["PrecoBaleia"] = "Current Price: $"..Config.PrecoBaleia.." each",
	["FecharMenu"] = "[❌] Close",
	-- Upgrades
    ["Upgrades"] = "[✅] Upgrade Fishingrod",
    ["UpgradeLevel2"] = "[🎣] Upgrade to level 2",
    ["RequiredLevel2"] = "Required: <br>"..Config.AmountItemNecessario1.."x "..Config.ItemNecessario1Label.."<br>"..Config.AmountItemNecessario2.."x "..Config.ItemNecessario2Label,
    ["UpgradeLevel3"] = "[🎣] Upgrade to level 3",
    ["RequiredLevel3"] = "Required: <br>"..Config.AmountItemNecessario1.."x "..Config.ItemNecessario1Label.."<br>"..Config.AmountItemNecessario2.."x "..Config.ItemNecessario2Label,
    ["UpgradeLevel4"] = "[🎣] Upgrade to level 4",
    ["RequiredLevel4"] = "Required: <br>"..Config.AmountItemNecessario1.."x "..Config.ItemNecessario1Label.."<br>"..Config.AmountItemNecessario2.."x "..Config.ItemNecessario2Label,
    ["UpgradeLevel5"] = "[🎣] Upgrade to level 5",
    ["RequiredLevel5"] = "Required: <br>"..Config.AmountItemNecessario1.."x "..Config.ItemNecessario1Label.."<br>"..Config.AmountItemNecessario2.."x "..Config.ItemNecessario2Label,

    ["UpgradesRede"] = "[✅] Upgrade Net",
    ["UpgradeRedeLevel2"] = "[🎣] Upgrade to level 2",
    ["RequiredRedeLevel2"] = "Required: <br>"..Config.AmountItemNecessarioRede1.."x "..Config.ItemNecessarioRede1Label.."<br>"..Config.AmountItemNecessarioRede2.."x "..Config.ItemNecessarioRede2Label,
    ["UpgradeRedeLevel3"] = "[🎣] Upgrade to level 3",
    ["RequiredRedeLevel3"] = "Required: <br>"..Config.AmountItemNecessarioRede1.."x "..Config.ItemNecessarioRede1Label.."<br>"..Config.AmountItemNecessarioRede2.."x "..Config.ItemNecessarioRede2Label,
    ["UpgradeRedeLevel4"] = "[🎣] Upgrade to level 4",
    ["RequiredRedeLevel4"] = "Required: <br>"..Config.AmountItemNecessarioRede1.."x "..Config.ItemNecessarioRede1Label.."<br>"..Config.AmountItemNecessarioRede2.."x "..Config.ItemNecessarioRede2Label,
    ["UpgradeRedeLevel5"] = "[🎣] Upgrade to level 5",
    ["RequiredRedeLevel5"] = "Required: <br>"..Config.AmountItemNecessarioRede1.."x "..Config.ItemNecessarioRede1Label.."<br>"..Config.AmountItemNecessarioRede2.."x "..Config.ItemNecessarioRede2Label,
    -- Cooking
    ["Campfire"] = "🔥 Campfire",
    ["CozinharBacalhau"] = "[🍳] Cooking cod",
	["CozinharCavala"] 	= "[🍳] Cooking mackerel",
	["CozinharSalmao"] = "[🍳] Cooking salmon",
	["CozinharSardinha"] = "[🍳] Cooking sardines",
	-- Rent Boats
	["RentBoat"] = "[🛶] I need a boat!",
	["DevolverBarco"] = "[🛶] Return boat",
	["LosSantos"] = "[🏢] Los Santos",
	["PaletoBay"] = "[🏘] Paleto Bay",

}

Config["Targets"] = {
	["Fisherman"] = "Talk with the fisherman",
	["IconFisherman"] = "fas fa-fish",
	["Employe"] = "Talk with employee",
	["IconEmploye"] = "fas fa-fish",
	["Employe2"] = "Talk with employee",
	["IconEmploye2"] = "fas fa-fish",
	["Cook"] = "Cook",
	["IconCook"] = "fa-solid fa-cake-candles",
	["Bonfire"] = "Extinguish Bonfire",
	["IconBonfire"] = "fas fa-fire",
}

---------------
-- Peds
---------------
Config.PedListFishing = {                                              
	{
		model = "s_m_y_ammucity_01",                            
		coords = vector3(-1816.21, -951.54, 0.45),               
		heading = 110.0,
		gender = "male",
        scenario = "WORLD_HUMAN_STAND_FISHING"
	},
	{
		model = "s_m_y_ammucity_01",                            
		coords = vector3(-283.98, 6602.14, 0.33),               
		heading = 55.57,
		gender = "male",
        scenario = "WORLD_HUMAN_STAND_FISHING"
	},
    {
		model = "s_m_y_busboy_01",
		coords = vector3(-1816.406, -1193.334, 13.305),         
		heading = 325.172,
		gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD"
	},
	{
		model = "a_m_y_mexthug_01",
		coords = vector3(-371.11, 277.47, 85.42),     -- Location to sell illegal fish    
		heading = 308.44,
		gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD"
	},
	{
		model = "s_m_y_busboy_01",
		coords = vector3(-638.65, -1249.60, 10.81),         
		heading = 170.44,
		gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD"
	},
}


-----------------
-- Shop
-----------------
Config.OpenInvTrigger   = "inventory:server:OpenInventory"          
Config.ShopName         = "Fishing Shop"                          
Config.Products = {
    ["Fishing"] = {
        [1] = {
            name = "fishbait",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "fishbaitilegal",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "anchor",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "fishicebox",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "fogueira",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 5,
        },
        -- You can add more items
    },
}

Config.LojinhaFishing = {
    ["Fishing"] = {
        ["label"] = "Fishing",
        ["type"] = "BM",
        ["coords"] = {
            [1] = {
                ["x"] = 1333.06,    -- Dont touch, is using qb-target.
                ["y"] = 4326.86,    -- Dont touch, is using qb-target.
                ["z"] = 38.017,     -- Dont touch, is using qb-target.
            },
        },
        ["CoisasBoas"] = Config.Products["Fishing"],
    },
}

------------- 
--- Police Alert Ilegal Fishing
------------
Config.ChanceChamarPolicia = 10     -- 10% probability to call cops
function AlertarPolicia(src)
	local PlayerPed = PlayerPedId()
	local PlayerPos = GetEntityCoords(PlayerPed)
	--TriggerEvent('qb-dispatch:houserobbery', PlayerPos)
	-- Trigger your dispatch
end
