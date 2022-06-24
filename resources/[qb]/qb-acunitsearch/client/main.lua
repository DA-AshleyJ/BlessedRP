local QBCore = exports['qb-core']:GetCoreObject()

local searched = {3423423}
local dumpsters = {1709954128, -1625667924, 1131941737, -1625667924}
local canSearch = true

RegisterNetEvent('qb-acunitsearch:client:searchaircon', function()
    if canSearch then
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local dumpsterFound = false

        for i = 1, #dumpsters do
            local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
            local dumpPos = GetEntityCoords(dumpster)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)

            if dist < 1.8 then
            for i = 1, #searched do
                if searched[i] == dumpster then
                    airconFound = true
                end
                if i == #searched and airconFound then
                    QBCore.Functions.Notify('This aircon has already been searched', 'error')
                elseif i == #searched and not airconFound then

    local itemType = math.random(#Config.RewardTypes)
	TriggerEvent('qb-acunitsearch:client:progressbar',itemType)
    TriggerServerEvent('qb-acunitsearch:server:startAirconTimer', aircon)
    table.insert(searched, aircon)
                end
            end
        end
    end
end
end)

RegisterNetEvent('qb-acunitsearch:server:removeAircon')
AddEventHandler('qb-acunitsearch:server:removeAircon', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

RegisterNetEvent('qb-acunitsearch:client:progressbar', function(itemType)
	local src = source
    local ply = QBCore.Functions.GetPlayerData()
    local item = math.random(#Config.RewardsSmall)
    QBCore.Functions.Progressbar("aircon_find", "Searching aircon..", math.random (3000, 5000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        if Config.RewardTypes[itemType].type == "item" then
            QBCore.Functions.Notify("Found Something", "success")
            TriggerServerEvent('qb-acunitsearch:server:recieveItem', Config.RewardsSmall[item].item, math.random (Config.RewardsSmall[item].minAmount, Config.RewardsSmall[item].maxAmount))
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.RewardsSmall[item].item], "add")
        elseif Config.RewardTypes[itemType].type == "money" then
            QBCore.Functions.Notify("Found Some Money", "success")
            TriggerServerEvent('qb-acunitsearch:server:givemoney', math.random (10, 40))
        elseif Config.RewardTypes[itemType].type == "nothing" then
            QBCore.Functions.Notify("Found Nothing", "error")
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        QBCore.Functions.Notify("Stopped Searching", "error")
    end)
end)
