local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-miniheists:server:RecievePaymentLab', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', Config.PaymentLab)
end)

RegisterNetEvent('qb-miniheists:server:RecievePaymentMRPD', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', Config.PaymentMRPD)
end)

RegisterNetEvent('qb-miniheists:server:ReceivePaymentSalvage', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', Config.PaymentSalvage)
end)

RegisterNetEvent('qb-miniheists:server:LabReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)

    if otherchance == odd then
        local item = math.random(1, #Config.LabRewards)
        local amount = math.random(Config.LabRewards[item]["amount"]["min"], Config.LabRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.LabRewards[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.LabRewards[item]["item"]], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
        end
    else
        local amount = math.random(2, 4)
        if Player.Functions.AddItem("lockpick", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lockpick"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
        end
    end
end)

RegisterNetEvent('qb-miniheists:server:MRPDReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)

    if otherchance == odd then
        local item = math.random(1, #Config.MRPDRewards)
        local amount = math.random(Config.MRPDRewards[item]["amount"]["min"], Config.MRPDRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.MRPDRewards[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.MRPDRewards[item]["item"]], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
        end
    else
        local amount = math.random(2, 4)
        if Player.Functions.AddItem("lockpick", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lockpick"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
        end
    end
end)

RegisterNetEvent('qb-miniheists:server:SalvageReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)

    if otherchance == odd then
        local item = math.random(1, #Config.SalvageRewards)
        local amount = math.random(Config.SalvageRewards[item]["amount"]["min"], Config.SalvageRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.SalvageRewards[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.SalvageRewards[item]["item"]], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
        end
    else
        local amount = math.random(2, 4)
        if Player.Functions.AddItem("weapon_hammer", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_hammer"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
        end
    end
end)
