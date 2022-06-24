Citizen.CreateThread(function()
    if(Config.CheckVersion)then
        PerformHttpRequest("https://specialstos.github.io/versionCheck/StoreRobberies.txt", function( err, version, headers )
            local currentVersion = GetResourceMetadata( GetCurrentResourceName(), "version" ) 
            if(currentVersion==version)then
                print("^3[StoreRobberies] ^2Resource is up to date. Version: " .. (version) .. ".^7" )
            else
                print("^3[StoreRobberies] ^1Resource is outdated. Your current version is: " .. (currentVersion) .. ". Latest version is: " .. (version)  .. ". ^7")
            end
        end)
    end
end)