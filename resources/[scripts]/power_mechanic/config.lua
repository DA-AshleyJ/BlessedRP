-- Enables command to open tablet - /tablet
enableCommand = true 

-- Change the command to open tablet.
tabletCommand = "tablet"

-- Requires an item to open the tablet.
commandItemRequired = false 

-- The item required to use the /command
itemRequired = 'phone'

-- You can trigger the below event to open the tablet from another resource or on item use incase you want to disable the command.
-- TriggerEvent('mechanic:tablet:open') -- Client Side

-- Enable ESX Support
enableESX = false

-- The event names, incase you have renamed standard esx functions
ESX_playerLoadedEvent = 'esx:playerLoaded'
ESX_jobUpdateEvent = 'esx:setJob'

-- Enable QBCore Support
enableQBCore = true

-- Name of your qb-core resource, incase you have renamed it. 
QBC_resourceName = 'qb-core'

-- The event names, incase you have renamed standard qbcore functions
QBC_playerLoadedEvent = 'QBCore:Client:OnPlayerLoaded'
QBC_jobUpdateEvent = 'QBCore:Client:OnJobUpdate'


-- Enable Job Whitelist
useJobWhitelist = true

-- whitelist the tablet to a job and vehicle class only.
-- ['jobName'] = {vehicleClassId, vehicleClassId}

---------------------
-- Vehicle Class List 
---------------------
-- 0: Compacts | 1: Sedans | 2: SUVs | 3: Coupes | 4: Muscle | 5: Sports Classics | 6: Sports | 7: Super | 8: Motorcycles | 9: Off-road | 10: Industrial | 11: Utility | 12: Vans | 13: Cycles | 14: Boats | 15: Helicopters | 16: Planes | 17: Service | 18: Emergency | 19: Military | 20: Commercial  
---------------------
jobWhitelist = {
 ['mechanic'] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},
 ['redline'] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},
 ['police'] = {18},
}


-- Item required for upgrades.
-- itemRequired = true -- This will require an item in order to change the mod,
-- itemName = 'item' -- The item name that is required. 
-- removeItem = true -- This will remove the item when its used on an upgrade. 
vehicleModUpgrades = {
--  [11] = {name = "Engine", itemRequired = true, itemName = 'engine', removeItem = true}, -- Example

 [11] = {name = "Engine", itemRequired = false, itemName = 'item', removeItem = false},
 [12] = {name = "Brakes", itemRequired = false, itemName = 'item', removeItem = false},
 [13] = {name = "Transmission", itemRequired = false, itemName = 'item', removeItem = false},
 [15] = {name = "Suspension", itemRequired = false, itemName = 'item', removeItem = false},
 [0] = {name = "Spoilers", itemRequired = false, itemName = 'item', removeItem = false},
 [1] = {name = "Front Bumper", itemRequired = false, itemName = 'item', removeItem = false},
 [2] = {name = "Rear Bumper", itemRequired = false, itemName = 'item', removeItem = false},
 [3] = {name = "Side Skirt", itemRequired = false, itemName = 'item', removeItem = false},
 [4] = {name = "Exhaust", itemRequired = false, itemName = 'item', removeItem = false},
 [5] = {name = "Frame", itemRequired = false, itemName = 'item', removeItem = false},
 [6] = {name = "Grille", itemRequired = false, itemName = 'item', removeItem = false},
 [7] = {name = "Hood", itemRequired = false, itemName = 'item', removeItem = false},
 [8] = {name = "Fender", itemRequired = false, itemName = 'item', removeItem = false},
 [9] = {name = "Right Fender", itemRequired = false, itemName = 'item', removeItem = false},
 [10] = {name = "Roof", itemRequired = false, itemName = 'item', removeItem = false},
 [25] = {name = "Vanity Plates", itemRequired = false, itemName = 'item', removeItem = false},
 [27] = {name = "Trim", itemRequired = false, itemName = 'item', removeItem = false},
 [28] = {name = "Ornaments", itemRequired = false, itemName = 'item', removeItem = false},
 [29] = {name = "Dashboard", itemRequired = false, itemName = 'item', removeItem = false},
 [30] = {name = "Dial", itemRequired = false, itemName = 'item', removeItem = false},
 [31] = {name = "Door Speaker", itemRequired = false, itemName = 'item', removeItem = false},
 [32] = {name = "Seats", itemRequired = false, itemName = 'item', removeItem = false},
 [33] = {name = "Steering Wheel", itemRequired = false, itemName = 'item', removeItem = false},
 [34] = {name = "Shifter Leavers", itemRequired = false, itemName = 'item', removeItem = false},
 [35] = {name = "Plaques", itemRequired = false, itemName = 'item', removeItem = false},
 [36] = {name = "Speakers", itemRequired = false, itemName = 'item', removeItem = false},
 [37] = {name = "Trunk", itemRequired = false, itemName = 'item', removeItem = false},
 [38] = {name = "Hydraulics", itemRequired = false, itemName = 'item', removeItem = false},
 [39] = {name = "Engine Block", itemRequired = false, itemName = 'item', removeItem = false},
 [40] = {name = "Air Filter", itemRequired = false, itemName = 'item', removeItem = false},
 [41] = {name = "Struts", itemRequired = false, itemName = 'item', removeItem = false},
 [42] = {name = "Arch Cover", itemRequired = false, itemName = 'item', removeItem = false},
 [43] = {name = "Aerials", itemRequired = false, itemName = 'item', removeItem = false},
 [44] = {name = "Trim 2", itemRequired = false, itemName = 'item', removeItem = false},
 [45] = {name = "Tank", itemRequired = false, itemName = 'item', removeItem = false},
 [99] = {name = "Windows", itemRequired = false, itemName = 'item', removeItem = false},
 [48] = {name = "Livery", itemRequired = false, itemName = 'item', removeItem = false},
 [18] = {name = "Turbo", itemRequired = false, itemName = 'item', removeItem = false},
 [14] = {name = "Horns", itemRequired = false, itemName = 'item', removeItem = false},
 [23] = {name = "Wheels", itemRequired = false, itemName = 'item', removeItem = false},
 ["wheeltypes"] = {name = "Wheel Types", itemRequired = false, itemName = 'item', removeItem = false},
 ["extra"] = {name = "Extras", itemRequired = false, itemName = 'item', removeItem = false},
}

Lang = {
 ['noVehicle'] = "You are not in or near a vehicle.",
 ['wrongClass'] = "You cannot use this tablet on this vehicle class.",
 ['cannotUseCommand'] = "You cannot use this command.",
 ['itemMissing'] = "You are missing required items.",
}