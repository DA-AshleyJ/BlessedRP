local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-ambulancegarage:server:buyVehicle', function(vehicleData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert(
        'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid, result[1]["model"],
            GetHashKey(result[1]["model"]),
            result[1]["mods"],
            result[1]["plate"],
            0
        })
        TriggerClientEvent('QBCore:Notify', src, "vehicle bought", 'info', 3500))