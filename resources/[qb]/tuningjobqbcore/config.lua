Config = {}

Config.AuthorizedIds = {
    "TJW46668",
	"EWX00489",
}

Config.Locations = {
    ["blip"] = vector3(-573.33, -926.28, 23.89),
    ["stash"] = vector3(-586.57, -929.92, 23.89),
    ["duty"] = vector3(-589.0, -932.18, 23.89),
    ["orderParts"] = vector3(-582.6, -920.3, 23.89),
    ["vehicle"] = vector4(-563.45, -906.56, 23.84, 271.91), 
    ["deliveryPoint"] = vector3(-545.92, -926.29, 23.86), -- change to location where you want the delivery guy to come
    ["dyno"] =  vector3(-582.81, -931.73, 23.54),
}

Config.Vehicles = {
    ["towtruck"] = "Towtruck",
}
 
Config.isVehicleOwned = false                    -- checks if the vehicle is owned

Config.PedDriver = 'a_m_m_tranvest_01' -- https://docs.fivem.net/docs/game-references/ped-models/
Config.DeliveryVehicle = 'rumpo2'
-- In Seconds
Config.Timer = 50 -- how much should the driver wait for the player before going away (in seconds)
Config.NitroBoost = 35.0