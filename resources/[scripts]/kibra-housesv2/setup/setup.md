------------------------------ Kibra Houses V2 - Installation Guide -----------------------------------

For Support: https://discord.com/invite/pK7996Yu3e Kibra Store

REQUIREMENTS (
    qb-phone: https://github.com/qbcore-framework/qb-phone
    qb-inventory: https://github.com/qbcore-framework/qb-inventory,
    cron: https://github.com/esx-framework/cron
)

The starting order of the scripts should be as follows;
 - ensure cron
 - ensure qb-inventory
 - ensure kibra-housesv2
 - ensure qb-phone

1. QB-INVENTORY/JS/APP.JS

FormatItemInfo Functions in add
---------------------------------------------------------------------------------------------------------------------------------
  } else if (itemData.name == "housekeys") {
            $(".item-info-title").html('<p>'+itemData.label+'</p>')
            $(".item-info-description").html('<p><strong></strong><span>Daire No: ' + itemData.info.HouseId + '</span></p>');
---------------------------------------------------------------------------------------------------------------------------------

2. QB-CORE/SHARED/ITEMS.LUA 
 Add the items table
---------------------------------------------------------------------------------------------------------------------------------
['housekeys'] 				 	 = {['name'] = 'housekeys', 			  	  	['label'] = 'House Key', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'housekeys.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Pistols'},
	['doorlock'] 				 	 = {['name'] = 'doorlock', 			  	  		['label'] = 'Doorlock', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'doorlock.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Pistols'},
---------------------------------------------------------------------------------------------------------------------------------

3. QB-PHONE/FXMANIFEST.LUA

Add server_scripts table
---------------------------------------------------------------------------------------------------------------------------------
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    '@kibra-housesv2/shared.lua'
}
---------------------------------------------------------------------------------------------------------------------------------

4. QB-PHONE/SERVER/MAIN.LUA

""qb-phone:server:PayInvoice"" Replace the callback named qb-phone:server:PayInvoice with the following lines of code.
---------------------------------------------------------------------------------------------------------------------------------
QBCore.Functions.CreateCallback('qb-phone:server:PayInvoice', function(source, cb, society, amount, invoiceId, sendercitizenid)
    local Invoices = {}
    local Ply = QBCore.Functions.GetPlayer(source)
    local SenderPly = QBCore.Functions.GetPlayerByCitizenId(sendercitizenid)
    local invoiceMailData = {}
    if SenderPly and Config.BillingCommissions[society] then
        local commission = round(amount * Config.BillingCommissions[society])
        SenderPly.Functions.AddMoney('bank', commission)
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Commission Received',
            message = string.format('You received a commission check of $%s when %s %s paid a bill of $%s.', commission, Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    elseif not SenderPly then
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Bill Paid',
            message = string.format('%s %s paid a bill of $%s', Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    end
    if society == Cfg.HouseBillLabel then MySQL.Async.fetchAll('UPDATE kibra_houses SET date = @date WHERE id = @id', {["@date"] = os.time(), ["@id"] = sendercitizenid}) end
    Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
    TriggerEvent('qb-phone:server:sendNewMailToOffline', sendercitizenid, invoiceMailData)
    TriggerEvent("qb-bossmenu:server:addAccountMoney", society, amount)
    MySQL.Async.execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
    local invoices = MySQL.Sync.fetchAll('SELECT * FROM phone_invoices WHERE citizenid = ?', {Ply.PlayerData.citizenid})
    if invoices[1] ~= nil then
        Invoices = invoices
    end
    cb(true, Invoices)
end)
---------------------------------------------------------------------------------------------------------------------------------

