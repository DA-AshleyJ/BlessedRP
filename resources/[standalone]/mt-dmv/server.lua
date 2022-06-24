local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('mt-dmv:driverpaymentpassed')
AddEventHandler('mt-dmv:driverpaymentpassed', function ()
    if Config.DriversTest then
        local info = {}
        local _source = source
        local Player = QBCore.Functions.GetPlayer(_source)
        local licenseTable = Player.PlayerData.metadata['licences']
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
        info.type = "C | A | D"
        licenseTable['driver'] = true
        Player.Functions.SetMetaData('licences', licenseTable)
        Player.Functions.RemoveMoney(Config.PaymentType, Config.Amount['driving'])
        if Config.GiveItem == true then
            Player.Functions.AddItem('driver_license', 1, nil, info)
            TriggerClientEvent('QBCore:Notify', "You pass the test and you get your license", "success")
            TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['driver_license'], 'add')
        else
            TriggerClientEvent('QBCore:Notify', "You passed the test! go to the council to get your card.")
        end
        TriggerClientEvent('QBCore:Notify', "You pay $"..Config.Amount['driving'],"success")
    end
end)

RegisterServerEvent('mt-dmv:driverpaymentfailed')
AddEventHandler('mt-dmv:driverpaymentfailed', function ()
    local amount = Config.Amount['driving']/2
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.RemoveMoney(Config.PaymentType, amount)
    QBCore.Functions.Notify("You pay $"..amount.."","success")
end)

QBCore.Functions.CreateCallback('mt-dmv:server:menu', function(source, cb)
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    local licenseTable = Player.PlayerData.metadata["licences"]
    if licenseTable['permit'] == true then
        cb(false)
    else
        cb(true)
    end
end)