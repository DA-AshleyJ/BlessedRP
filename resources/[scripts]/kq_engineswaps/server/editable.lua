function CanUseWorkshop(player, workshop)
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))

    local job = xPlayer.PlayerData.job
    if not workshop.playerWorkshop then
        if job.name ~= workshop.jobWorkshop or job.grade.level < workshop.permissions.swapJobGrade then
            TriggerClientEvent('kq_engineswaps:notify', player, L('~r~You do not have the permission to do this'))
            return false
        end
    end

    return true
end

function CanUsePurchaseEngines(player, workshop)
    local xPlayer = QBCore.Functions.GetPlayer(player)

    local job = xPlayer.PlayerData.job

    if not workshop.playerWorkshop and (job.name ~= workshop.jobWorkshop or job.grade.level < workshop.permissions.purchaseEngineJobGrade) then
        TriggerClientEvent('kq_engineswaps:notify', player, L('~r~You do not have the permission to do this'))
        return false
    end

    return true
end

function ChargeForEngine(player, engineKey, workshop)
    local xPlayer = QBCore.Functions.GetPlayer(player)
    local engine = Config.Engines[engineKey]

    if workshop.useSharedAccount then
        if exports['qb-bossmenu']:GetAccount(workshop.sharedAccount) >= engine.price then
            TriggerEvent('qb-bossmenu:server:removeAccountMoney', workshop.sharedAccount, engine.price)
            return true
        else
            TriggerClientEvent('kq_engineswaps:purchasePopup', player, L('YOUR SHARED ACCOUNT DOES NOT HAVE ENOUGH MONEY'))
            return false
        end
    else
        if xPlayer.PlayerData.money.bank >= tonumber(engine.price) then
            if xPlayer.Functions.RemoveMoney("bank", engine.price) then
                return true
            end
        else
            TriggerClientEvent('kq_engineswaps:purchasePopup', player, L('YOU CAN NOT AFFORD THIS PURCHASE'))
            return false
        end
    end
end

function _GetPlayerIdentifier(player)
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))

    return xPlayer.PlayerData.citizenid
end
