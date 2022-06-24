local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent('RouteDispensary:Payment')
AddEventHandler('RouteDispensary:Payment', function()
    local chance = math.random (1, 10)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.AddMoney("cash", Config.Payment, "sold-dispensary")
    TriggerClientEvent("QBCore:Notify", _source, "You recieved $100 for working", "success")
    if chance == 10 then
        ply.Functions.AddItem('weed_white-widow_seed', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_white-widow_seed'], "add")
        TriggerClientEvent("QBCore:Notify", _source, "You found a White Widow Seed in the vehicle.", "success")
    end
end)

RegisterServerEvent('RouteDispensary:Tips')
AddEventHandler('RouteDispensary:Tips', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    local tipammount = math.random(Config.TipMin, Config.TipMax)
    Player.Functions.AddMoney("cash", tipammount, "sold-dispensary")
    TriggerClientEvent("QBCore:Notify", _source, "They tipped $"..tipammount, "success")
end)