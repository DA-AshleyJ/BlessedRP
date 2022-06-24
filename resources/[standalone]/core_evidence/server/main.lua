
shots = {}
blood = {}

QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback(
    "core_evidence:getData",
    function(source, cb)
        cb({shots = shots, blood = blood, time = os.time()})
    end
)

QBCore.Functions.CreateCallback(
    "core_evidence:getStorageData",
    function(source, cb)
        exports.oxmysql:query(
            "SELECT * FROM `evidence_storage` WHERE 1",
            {},
            function(reports)
                cb(reports)
            end
        )
    end
)

RegisterServerEvent("core_evidence:deleteEvidenceFromStorage")
AddEventHandler(
    "core_evidence:deleteEvidenceFromStorage",
    function(id)
        exports.oxmysql:update(
            "DELETE FROM `evidence_storage` WHERE id = :id",
            {
                ["id"] = id
            }
        )
    end
)

RegisterServerEvent("core_evidence:addEvidenceToStorage")
AddEventHandler(
    "core_evidence:addEvidenceToStorage",
    function(evidence)
        exports.oxmysql:update(
            "INSERT INTO `evidence_storage`(`data`) VALUES (:evidence)",
            {
                ["evidence"] = evidence
            }
        )
    end
)

RegisterServerEvent("core_evidence:removeEverything")
AddEventHandler(
    "core_evidence:removeEverything",
    function()
        for k, v in pairs(blood) do
            if v.interior == 0 then
                blood[k] = nil
            end
        end
        for k, v in pairs(shots) do
      
            if v.interior == 0 then
                shots[k] = nil
            end
        end
    end
)

RegisterServerEvent("core_evidence:removeBlood")
AddEventHandler(
    "core_evidence:removeBlood",
    function(identifier)
        blood[identifier] = nil
    end
)

RegisterServerEvent("core_evidence:removeShot")
AddEventHandler(
    "core_evidence:removeShot",
    function(identifier)
        shots[identifier] = nil
    end
)

RegisterServerEvent("core_evidence:LastInCar")
AddEventHandler(
    "core_evidence:LastInCar",
    function(id)
        local src = source
        local entity = NetworkGetEntityFromNetworkId(id)
        local xPlayer = QBCore.Functions.GetPlayer(NetworkGetEntityOwner(entity))

        if xPlayer ~= nil then
            if NetworkGetEntityOwner(entity) ~= src then

        
        reportInfo = {}
        if Config.showFirstname then reportInfo.firstname = xPlayer.PlayerData.charinfo.firstname end
        if Config.showLastname then reportInfo.lastname = xPlayer.PlayerData.charinfo.lastname end
        if Config.showGender then reportInfo.gender = xPlayer.PlayerData.charinfo.gender end
        if Config.showBirthdate then reportInfo.birthdate = xPlayer.PlayerData.charinfo.birthdate end
        if Config.showPhone then reportInfo.phone = xPlayer.PlayerData.charinfo.phone end


                
                        TriggerClientEvent("core_evidence:addFingerPrint", src, reportInfo)
                   
            else
                TriggerClientEvent("core_evidence:SendTextMessage", src, Config.Text["no_fingerprints_found"])
            end
        else
            TriggerClientEvent("core_evidence:SendTextMessage", src, Config.Text["no_fingerprints_found"])
        end
    end
)

RegisterServerEvent("core_evidence:saveBlood")
AddEventHandler(
    "core_evidence:saveBlood",
    function(street, coords, interior)
        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)

        local time = os.time()

        reportInfo = {}
        reportInfo.location = street
        if Config.showFirstname then reportInfo.firstname = xPlayer.PlayerData.charinfo.firstname end
        if Config.showLastname then reportInfo.lastname = xPlayer.PlayerData.charinfo.lastname end
        if Config.showGender then reportInfo.gender = xPlayer.PlayerData.charinfo.gender end
        if Config.showBirthdate then reportInfo.birthdate = xPlayer.PlayerData.charinfo.birthdate end
        if Config.showPhone then reportInfo.phone = xPlayer.PlayerData.charinfo.phone end

        blood[time] = {coords = coords, reportInfo = reportInfo, interior = interior}
            		
          
    end
)

QBCore.Functions.CreateUseableItem(
    "uvlight",
    function(playerId)
        TriggerClientEvent("core_evidence:checkForFingerprints", playerId)
    end
)

RegisterServerEvent("core_evidence:saveShot")
AddEventHandler(
    "core_evidence:saveShot",
    function(street, coords, bullet, interior)
        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)

        local time = os.time()
             
        reportInfo = {}       
        reportInfo.location = street
         if Config.showFirstname then reportInfo.firstname = xPlayer.PlayerData.charinfo.firstname end
        if Config.showLastname then reportInfo.lastname = xPlayer.PlayerData.charinfo.lastname end
        if Config.showGender then reportInfo.gender = xPlayer.PlayerData.charinfo.gender end
        if Config.showBirthdate then reportInfo.birthdate = xPlayer.PlayerData.charinfo.birthdate end
        if Config.showPhone then reportInfo.phone = xPlayer.PlayerData.charinfo.phone end
        
        shots[time] = {coords = coords, bullet = bullet, reportInfo = reportInfo, interior = interior}
            
           
    end
)
