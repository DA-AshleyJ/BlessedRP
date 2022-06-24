local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()

function Notify(msg)
    QBCore.Functions.Notify(msg)
end

function PoliceCall()
    local alertCoords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("core_dispatch:addCall", "10-15", "Possible Drug Related Activity", {{icon = "fa-solid fa-messages-dollar", info = "Automatic Call"},{icon = "fa-solid fa-align-left", info = "There have been reports of suspicious activity reported at this address"}}, {alertCoords[1], alertCoords[2], alertCoords[3]}, "police", 10000, 110, 79)
end

function ProgressBar(msg) -- General progressbar
    QBCore.Functions.Progressbar("ProgressBar", msg, 5000, false, true, {disableMovement = true,disableCarMovement = false,disableMouse = false,
    disableCombat = false, }, {}, {}, {}, function() end)
end

function OpeningBox(msg) -- Progress bar when opening the boxes
    QBCore.Functions.Progressbar("OpeningBox", msg, 5000, false, true, {disableMovement = true,disableCarMovement = true,disableMouse = false,
    disableCombat = true}, {animDict = "mp_arresting",anim = "a_uncuff",flags = 49}, {}, {}, function() end)
end

function EmailWeedRun() -- For Weedrun
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = Language[LanguageType]["Email"]["WeedRun"].Sender,
        subject = Language[LanguageType]["Email"]["WeedRun"].Subject,
        message = Language[LanguageType]["Email"]["WeedRun"].Email,
    })
end

function EmailWeedRun2() -- For Weedrun
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = Language[LanguageType]["Email"]["WeedRun"].Sender,
        subject = Language[LanguageType]["Email"]["WeedRun"].Subject,
        message = Language[LanguageType]["Email"]["WeedRun"].Email2,
    })
end

function EmailCokeRun() -- For CokeRun
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = Language[LanguageType]["Email"]["CokeRun"].Sender,
        subject = Language[LanguageType]["Email"]["CokeRun"].Subject,
        message = Language[LanguageType]["Email"]["CokeRun"].Email,
    })
end

function EmailCokeRun2() -- For CokeRun
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = Language[LanguageType]["Email"]["CokeRun"].Sender,
        subject = Language[LanguageType]["Email"]["CokeRun"].Subject,
        message = Language[LanguageType]["Email"]["CokeRun"].Email2,
    })
end

function EmailGunsRun() -- For GunsRun
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = Language[LanguageType]["Email"]["GunsRun"].Sender,
        subject = Language[LanguageType]["Email"]["GunsRun"].Subject,
        message = Language[LanguageType]["Email"]["GunsRun"].Email,
    })
end

function EmailGunsRun2() -- For GunsRun
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = Language[LanguageType]["Email"]["GunsRun"].Sender,
        subject = Language[LanguageType]["Email"]["GunsRun"].Subject,
        message = Language[LanguageType]["Email"]["GunsRun"].Email2,
    })
end

