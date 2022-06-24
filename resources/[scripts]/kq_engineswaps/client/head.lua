if Config.UseNewQBExport then
    QBCore = exports['qb-core']:GetCoreObject()
end

job = QBCore.Functions.GetPlayerData().job

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    job = QBCore.Functions.GetPlayerData().job
end)


RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    job = JobInfo
end)