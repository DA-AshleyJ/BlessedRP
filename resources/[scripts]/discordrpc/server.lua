--[[function GetAllPlayers()
    local players = {}

    for _, i in ipairs(GetPlayers()) do
        table.insert(players, i)    
    end

    return players
end]]
Citizen.CreateThread(function()
    while true do
        --local players = GetAllPlayers()
        local playercount = GetNumPlayerIndices()
        TriggerClientEvent("rpc:sendCount", -1, playercount)
        Citizen.Wait(10000);
    end
end)