Config = {}

Config.Locale = "en" -- select from en/bg -- you can find them in lang.lua and if you want translate them

Config.Keybind = "F4" --Keybind used to open the menu

Config.Core = 'qb-core' -- your core prefix

Config.Duty = "QBCore:ToggleDuty" -- your duty event

Config.JobUpdate = 'QBCore:Client:OnJobUpdate' -- your on job update event 

Config.SetDuty = "QBCore:Client:SetDuty" -- your set duty event 

Config.UseKey = true -- If true the menu can be used anywhere -- If false the menu can be used only at location

Config.Mark = 21 -- drawMarker type -- see all at - https://docs.fivem.net/docs/game-references/markers/

Config.Coords =  vector4(-266.87, -960.06, 31.22, 31.12) -- Location if Config.UseKey = false to open menu at

Config.MarkerColor =  {r = 57, g = 125, b = 199, a = 0.9} -- Marker colours

Config.Dist1 = 2.0 -- press key

Config.Dist2 = 2.0 -- showing marker

Config.DrawUiText = "Press [F4] to open menu"

function ShowNotification(msg, type)
    --local IFCore = exports[Config.Core]:GetCoreObject() -- dont change IFCore as it will break the script
    --IFCore.Functions.Notify(msg, type) -- -- dont change IFCore as it will break the script
    
    exports['okokNotify']:Alert("MultiJob", msg, 5000, type) 
    -- you can change that to your own CLIENT SIDE
end

function ShowNotificationServer(source, msg, type)
   TriggerClientEvent('okokNotify:Alert', source, "MultiJob", msg, 5000, type)
-- TriggerClientEvent('QBCore:Notify', source, msg, type)
-- you can change that to your own SERVER SIDE
end


function DrawUI(text)
    exports['okokTextUI']:Open(text, 'darkblue', 'left')
    -- you can change that to your own CLIENT SIDE
end

function CloseUI()
    exports['okokTextUI']:Close() 
    -- you can change that to your own CLIENT SIDE
end



Config.Icons = { --Icons for jobs in the menu. Use job name(Case sensitive). Can use FontAwsome or Bootstrap Icons
    ['police'] = 'bi bi-shield-shaded',
    ['ambulance'] = 'fas fa-ambulance',
    ['tow'] = 'bi bi-truck-flatbed',
    ['taxi'] = 'fas fa-taxi',
    ['lawyer'] = 'bi bi-briefcase',
    ['judge'] = 'fas fa-gavel',
    ['realestate'] = 'bi bi-house',
    ['cardealer'] = 'fas fa-car',
    ['mechanic'] = 'bi bi-tools',
    ['reporter'] = 'bi bi-newspaper',
    ['trucker'] = 'fas fa-truck-moving',
    ['garbage'] = 'fas fa-recycle',
}

Config.DefaultIcon = "fas fa-briefcase" -- The default icon shown if the job isn't defined above ^^^

Config.BlackListedJobs = { --jobs that will not be automatically added to the multijob menu
    'unemployed',
    'examplejob2'
}

