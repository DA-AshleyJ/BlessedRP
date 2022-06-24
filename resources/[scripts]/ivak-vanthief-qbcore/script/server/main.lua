local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ivak-vanthief:AkR53PsKWETU98pDUMah')
AddEventHandler('ivak-vanthief:AkR53PsKWETU98pDUMah', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Players = QBCore.Functions.GetPlayers()

    local cops = 0
    for i=1, #Players, 1 do
        local Player = QBCore.Functions.GetPlayer(Players[i])
        if Player.PlayerData.job.name == 'police' then
            cops = cops + 1
        end
    end

    if cops >= Config.MinPolice or cops == Config.MinPolice then
        TriggerClientEvent('ivak-vanthief:9mb1Bh0fjClitijWbUOq', src)
    else
        TriggerClientEvent('ivak-vanthief:notify', src, Config.Locale['no_cops'])
    end
end)

RegisterServerEvent('ivak-vanthief:YcB9jfzrY9TbrvWIhUVu')
AddEventHandler('ivak-vanthief:YcB9jfzrY9TbrvWIhUVu', function(coords)
	local Players = QBCore.Functions.GetPlayers()
    for i=1, #Players, 1 do
        local Player = QBCore.Functions.GetPlayer(Players[i])
        if Player.PlayerData.job.name == 'police' then
            TriggerClientEvent('ivak-vanthief:notify', Players[i], Config.Locale['pol_msg'])
            TriggerClientEvent('ivak-vanthief:KwPlSZkI2vrqqPDi1Pd4', Players[i], coords)
        end
    end
end)

RegisterServerEvent('ivak-vanthief:kppKY43jcIHnjPlCRw4D')
AddEventHandler('ivak-vanthief:kppKY43jcIHnjPlCRw4D', function()
    TriggerClientEvent('ivak-vanthief:tUznYAPengeJvqdHNxsJ', -1)
end)

RegisterServerEvent('ivak-vanthief:8mwlGHX0z3CU6oeLNRKx')
AddEventHandler('ivak-vanthief:8mwlGHX0z3CU6oeLNRKx', function()
    TriggerClientEvent('ivak-vanthief:gtoP7JGjzoYFN8DPWXln', -1)
end)

RegisterServerEvent('ivak-vanthief:KUsRmWpBKDuFb7NnmbCQ')
AddEventHandler('ivak-vanthief:KUsRmWpBKDuFb7NnmbCQ', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Config.UseMoney == true then 
        local money = Config.Reward
        Player.Functions.AddMoney('cash', money)
        TriggerClientEvent('ivak-vanthief:notify', src, Config.Locale['maked_money']..money..Config.Locale['cash'])
    end

    if Config.UseItem == true then
        local item = Config.Items[math.random(1, #Config.Items)]
        local items = Player.Functions.GetItemByName(item)
        Player.Functions.AddItem(item, Config.ItemAmount)
        TriggerClientEvent('ivak-vanthief:notify', src, Config.Locale['get_item']..Config.ItemAmount..Config.Locale['item_count']..items.label)
    end

    TriggerClientEvent('ivak-vanthief:rnKxIFXMYTeaf9YuAevL', -1)
end)