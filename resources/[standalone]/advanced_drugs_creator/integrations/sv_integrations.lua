-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found    
}

-- If you use different names for police job, you can add/change it here, all jobs here will be used for police features (example: the alerts)
POLICE_JOBS_NAMES = {
    ["police"] = true,
    ["fbi"] = true
}

-- Skips or not if an item exists (useful with inventories that doesn't save items in database or in ESX.Items table, example ox_inventory)
SKIP_ITEM_EXISTS_CHECK = false

-- Enable or not the integration for ox_inventory for ESX.Items table
USE_OX_INVENTORY = false

-- Force inventory refresh or not. Set to true if NPC selling is not working properly
FORCE_INVENTORY_REFRESH = false