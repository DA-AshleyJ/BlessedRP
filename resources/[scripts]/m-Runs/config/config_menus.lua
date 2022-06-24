local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()

AddEventHandler('m-Runs:Client:MenuGeral', function()
    local playerPed = PlayerPedId()
    local job = QBCore.Functions.GetPlayerData().job.name
    local gang = QBCore.Functions.GetPlayerData().gang.name
    if IsEntityDead(playerPed) then return Notify(Language[LanguageType]["Notifys"].Dead, "error") end -- If player is dead
    if IsPedSwimming(playerPed) then return Notify(Language[LanguageType]["Notifys"].Water, "error") end -- If player is on water
    if IsPedSittingInAnyVehicle(playerPed) then return Notify(Language[LanguageType]["Notifys"].Veiculo, "error") end -- If player is on vehicle
    if Config.Utility.Mask then local playerPed = PlayerPedId() if GetPedDrawableVariation(playerPed, 1) == 0 then Notify(Language[LanguageType]["Notifys"].Face) return false end end -- If player have mask
    if Config.Utility.NeedJob == true then if job ~= Config.Utility.Job then Notify(Language[LanguageType]["Notifys"].NoJob) return false end end -- If player have the job
    if Config.Utility.NeedGang == true then if gang ~= Config.Utility.Gang then Notify(Language[LanguageType]["Notifys"].NoGang) return false end end -- If player have the gang
    local charinfo = QBCore.Functions.GetPlayerData().metadata["runsxp"]
    if charinfo >= Config.Utility.LevelSystem["General"].Level3 then
        exports['qb-menu']:openMenu({
            {   header = Language[LanguageType]["QBMenu"].Available.."<br>Your Level: "..charinfo,  isMenuHeader = true},
            {   header = Language[LanguageType]["QBMenu"].GunsRun,    params = { event = "m-Runs:Client:GunsRun"  }},
            {   header = Language[LanguageType]["QBMenu"].CokeRun,    params = { event = "m-Runs:Client:CokeRun"  }},
            {   header = Language[LanguageType]["QBMenu"].WeedRun,    params = { event = "m-Runs:Client:WeedRun"  }},
        })
    elseif charinfo >= Config.Utility.LevelSystem["General"].Level2 then
        exports['qb-menu']:openMenu({
            {   header = Language[LanguageType]["QBMenu"].Available.."<br>Your Level: "..charinfo,  isMenuHeader = true},
            {   header = Language[LanguageType]["QBMenu"].CokeRun,    params = { event = "m-Runs:Client:CokeRun"  }},
            {   header = Language[LanguageType]["QBMenu"].WeedRun,    params = { event = "m-Runs:Client:WeedRun"  }},
        })
    else
        exports['qb-menu']:openMenu({
            {   header = Language[LanguageType]["QBMenu"].Available.."<br>Your Level: "..charinfo,  isMenuHeader = true},
            {   header = Language[LanguageType]["QBMenu"].WeedRun,    params = { event = "m-Runs:Client:WeedRun"  }},
        })
    end
end)


