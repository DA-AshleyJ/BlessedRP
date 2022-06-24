Framework = exports["qb-core"]:GetCoreObject()

if Config.OpenType == "item" then
    Framework.Functions.CreateUseableItem(Config.Item, function(source, item)
        TriggerClientEvent("zerio-radio:client:open", source)
    end)
end