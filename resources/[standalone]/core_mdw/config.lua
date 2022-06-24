Config = {

UsersUpdateRate = 20, -- Interval in seconds when users are updated in script. For example user buys a vehicle it will be only shown if users are updated.

DiscordWebhook = '', -- Discord webhook to send mdw changes

OpenCommand = 'mdw', -- Command to open MDW

AccountInformation = 'IF-bossmenu', -- In which resource is accounts.json (or other file containing data) located (qb-bossmenu, qb-management by default )
AccountFile = 'accounts', -- In which file data is located (accounts by default)

UsingCoreEvidence = true, -- You can link evidence to an incident
UsingCoreMultijob = true, -- (Will be available soon)
UsingCoreInsurance = false, -- (Will be avilable soon)
UsingQBHouses = true, -- Shows owned houses in user profile

Departaments = { -- Add departaments that can access MDW
    ['police'] = {label = "LSPD"},
    ['ambulance'] = {label = "EMS"}
},

EmergencyJobs = { -- Add emergency jobs that will get emergency broadcasts
    ['ambulance'] = true
},

Badges = { -- Add badges for officers that can be added with administrator permission
    ['honor'] = "HONOR BADGE"

},

InstantAdministrator = { -- To become administrator of MDW enter your citizen id from database (example: XTL14520)
    ['QLO43502'] = true,
    ['EWX00489'] = true,
    ['ASL57210'] = true
},

ExcludeJobs = {
    ['mafia'] = true
},

WarrantEndingWarningTime = 48, -- Hours before warrant will become visable in dashboard as its close to expiering


Charges = { -- Specify the jail time and fine for each crime 

	['arson'] = {label = "Arson", jail = 48, fine = 10000, color= "#ff2e2e"},
	['burglary'] = {label = "Burglary", jail = 5, fine = 3000, color = "#2e93ff"},
	['passsingredlight'] = {label = "Driving trough Red Light", jail = 0, fine = 5000, color = "#ffae2b"},
	['harassment'] = {label = "Harassment", jail = 0, fine = 1000, color= "#44ff2b"},
    ['drugpossesion'] = {label = "Drug Possession", jail = 12, fine = 5000, color= "#2e93ff"},
    ['homocide'] = {label = "Homocide", jail = 63, fine = 12000, color= "#ff2e2e"},
    ['robbery'] = {label = "Armed Robbery", jail = 123, fine = 20000, color= "#ff2e2e"}

},
 

Text = {

    ['license_revoked'] = 'Your license was revoked!',
    ['license_revoked_success'] = 'You revoked license!',
    ['waypoint_set']= 'Waypoint set!',
    ['no_permission'] = 'You dont have rights to do this'
    

}

}


-- Called when you press sentance button in charges menu (Only appears if criminal is online)
function SentanceCriminal(target, jail, fine, charges)



TriggerServerEvent('police:server:JailPlayer', target, jail)
TriggerServerEvent('police:server:BillPlayer', target, fine)



end



function SendTextMessage(msg)

        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)

        --EXAMPLE USED IN VIDEO
        --exports['mythic_notify']:SendAlert('inform', msg)

end
