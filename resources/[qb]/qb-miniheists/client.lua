local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

--Lab Raid Stuff --------------------------------------------------------------------------------------------------

RegisterNetEvent('qb-miniheists:client:LabRaid', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"wait"})
    QBCore.Functions.Progressbar('pickup', 'Getting Job...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('You will be emailed shortly with the location', 'primary')
        if CurrentCops >= Config.MinimumPolice then
        TriggerServerEvent('QBCore:Server:AddItem', "electronickit", 1)
        Wait(5000)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Lugo Bervich',
            subject = 'Bio Research...',
            message = 'Heres the location. Find me that research!',
            })
        SetNewWaypoint(3536.97, 3669.4, 28.12)
        ExportLabTarget()
        else
            QBCore.Functions.Notify('Not enough police presence', 'error', 7500)
        end
    end)
end)

RegisterNetEvent('qb-miniheists:client:StartLabHack', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerServerEvent('QBCore:Server:RemoveItem', "electronickit", 1)
            TriggerServerEvent('police:server:policeAlert', 'Break in at Humane Labs!')
            TriggerEvent('animations:client:EmoteCommandStart', {"type"})
            QBCore.Functions.Progressbar('cnct_elect', 'Bypassing Firewall...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
            end)
            Wait(7500)
        TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        exports["memorygame_2"]:thermiteminigame(2, 2, 2, 10,
    function() -- Success
        Wait(100)
        TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        Wait(500)
        QBCore.Functions.Progressbar('po_usb', 'Downloading Research..', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        end)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('QBCore:Server:AddItem', "lab-usb", 1)
        SpawnGuardsLab()
        QBCore.Functions.Notify('You Successfully Downloaded the Research, Get Out Of There!', 'primary')
        Wait(7500)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Lugo Bervich',
            subject = 'Bio-Research...',
            message = 'You caused quite a noise down in old labs, bring me that research',
            })
    end,
        function() 
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            QBCore.Functions.Notify('You failed Hacking', 'error')
        end)
    else
        QBCore.Functions.Notify('You are missing something', 'error')
    end

    end, "electronickit")
end)

RegisterNetEvent('qb-miniheists:client:GiveUSBLab', function()
    TriggerServerEvent('QBCore:Server:RemoveItem', "lab-usb", 1)
    TriggerServerEvent('qb-miniheists:server:RecievePaymentLab')
    TriggerServerEvent('qb-miniheists:server:LabReward')
end)

CreateThread(function()
    RequestModel(`ig_brad`)
      while not HasModelLoaded(`ig_brad`) do
      Wait(1)
    end
      labboss = CreatePed(2, `ig_brad`, 1230.29, -2911.49, 8.50, 127.0, false, false) 
      SetPedFleeAttributes(labboss, 0, 0)
      SetPedDiesWhenInjured(labboss, false)
      TaskStartScenarioInPlace(labboss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(labboss, true)
      SetBlockingOfNonTemporaryEvents(labboss, true)
      SetEntityInvincible(labboss, true)
      FreezeEntityPosition(labboss, true)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("Lab-Raid", vector3(1230.29, -2911.49, 8.50), 1, 1, {
        name="Lab-Raid",
        heading=127,
        debugpoly = false,
    }, {
        options = {
            {
                event = "qb-miniheists:client:LabRaid",
                icon = "far fa-phone",
                label = "Request Job",
                item = "phone",
            },
            {
                event = "qb-miniheists:client:GiveUSBLab",
                icon = "far fa-phone",
                label = "Receive Payment",
                item = "lab-usb",
            },
        },
        distance = 1.5
    })
end)


labsecurity = {
    ['labpatrol'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuardsLab()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, `PLAYER`)
    AddRelationshipGroup('labpatrol')

    for k, v in pairs(Config['labsecurity']['labpatrol']) do
        loadModel(v['model'])
        labsecurity['labpatrol'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(labsecurity['labpatrol'][k])
        networkID = NetworkGetNetworkIdFromEntity(labsecurity['labpatrol'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(labsecurity['labpatrol'][k], 0)
        SetPedRandomProps(labsecurity['labpatrol'][k])
        SetEntityAsMissionEntity(labsecurity['labpatrol'][k])
        SetEntityVisible(labsecurity['labpatrol'][k], true)
        SetPedRelationshipGroupHash(labsecurity['labpatrol'][k], `labpatrol`)
        SetPedAccuracy(labsecurity['labpatrol'][k], 75)
        SetPedArmour(labsecurity['labpatrol'][k], 100)
        SetPedCanSwitchWeapon(labsecurity['labpatrol'][k], true)
        SetPedDropsWeaponsWhenDead(labsecurity['labpatrol'][k], false)
        SetPedFleeAttributes(labsecurity['labpatrol'][k], 0, false)
        GiveWeaponToPed(labsecurity['labpatrol'][k], `WEAPON_PISTOL`, 255, false, false)
        TaskGoToEntity(labsecurity['labpatrol'][k], PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(labsecurity['labpatrol'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, `labpatrol`, `labpatrol`)
    SetRelationshipBetweenGroups(5, `labpatrol`, `PLAYER`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `labpatrol`)
end

function ExportLabTarget()
    exports['qb-target']:AddBoxZone("hack-lab", vector3(3536.97, 3669.4, 28.12), 1, 1, {
        name="hack-lab",
        heading=350,
        debugpoly = false,
    }, {
        options = {
            {
            event = "qb-miniheists:client:StartLabHack",
            icon = "far fa-usb",
            label = "Hack Research Files",
            item = "electronickit",
            },
        },
        distance = 1.5
    })
end

--MRPD Raid Stuff ------------------------------------------------------------------------------------------

RegisterNetEvent('qb-miniheists:client:MRPDRaid', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"wait"})
    QBCore.Functions.Progressbar('pickup', 'Getting an ear full...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('You will be emailed shortly with the location', 'primary')
        if CurrentCops >= Config.MinimumPolice then
        TriggerServerEvent('QBCore:Server:AddItem', "electronickit", 1)
        Wait(5000)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Maria Rodriguez',
            subject = 'Damning Evidence...',
            message = 'A client needs some evidence out of the system before their trial date. Connect to the database at MRPD from a power box on the outside wall. please be quick about it... Vamos!',
            })
        SetNewWaypoint(457.3, -1001.49, 30.73)
        ExportMRPDTarget()
        else
            QBCore.Functions.Notify('Not enough police presence', 'error', 7500)
        end
    end)
end)

RegisterNetEvent('qb-miniheists:client:StartMRPDHack', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerServerEvent('QBCore:Server:RemoveItem', "electronickit", 1)
            TriggerServerEvent('police:server:policeAlert', 'Hacking Detected at MRPD!')
            TriggerEvent('animations:client:EmoteCommandStart', {"type"})
            QBCore.Functions.Progressbar('cnct_elect', 'Bypassing Firewall...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
            end)
            Wait(7500)
        TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        exports["memorygame_2"]:thermiteminigame(2, 2, 2, 10,
    function() -- Success
        Wait(100)
        TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        Wait(500)
        QBCore.Functions.Progressbar('po_usb', 'Transferring Files to USB..', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        end)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('QBCore:Server:AddItem', "mrpd-usb", 1)
        SpawnGuardsMRPD()
        QBCore.Functions.Notify('You got the evidence!', 'primary')
        Wait(7500)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Maria Rodriguez',
            subject = 'Damning Evidence...',
            message = 'My client will be very impressed. Way to go friend. Now bring me the evidence so i can destroy it myself! I got some cash and crypto for when you get here',
            })
    end,
        function() 
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            QBCore.Functions.Notify('You failed Hacking', 'error')
        end)
    else
        QBCore.Functions.Notify('You are missing something', 'error')
    end

    end, "electronickit")
end)

RegisterNetEvent('qb-miniheists:client:GiveUSB-MRPD', function()
    TriggerServerEvent('QBCore:Server:RemoveItem', "mrpd-usb", 1)
    TriggerServerEvent('qb-miniheists:server:RecievePaymentMRPD')
    TriggerServerEvent('qb-miniheists:server:MRPDReward')
end)



CreateThread(function()
    RequestModel(`g_f_y_vagos_01`)
      while not HasModelLoaded(`g_f_y_vagos_01`) do
      Wait(1)
    end
      mrpdboss = CreatePed(2, `g_f_y_vagos_01`, -1079.15, -1678.71, 3.50, 287.06, false, false) 
      SetPedFleeAttributes(mrpdboss, 0, 0)
      SetPedDiesWhenInjured(mrpdboss, false)
      TaskStartScenarioInPlace(mrpdboss, "g_f_y_vagos_01", 0, true)
      SetPedKeepTask(mrpdboss, true)
      SetBlockingOfNonTemporaryEvents(mrpdboss, true)
      SetEntityInvincible(mrpdboss, true)
      FreezeEntityPosition(mrpdboss, true)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("MRPD-Raid", vector3(-1079.15, -1678.71, 4.58), 1, 1, {
        name="MRPD-Raid",
        heading=287.06,
        debugpoly = false,
    }, {
        options = {
            {
                event = "qb-miniheists:client:MRPDRaid",
                icon = "far fa-phone",
                label = "Request Job",
                item = "phone",
            },
            {
                event = "qb-miniheists:client:GiveUSB-MRPD",
                icon = "far fa-phone",
                label = "Receive Payment",
                item = "mrpd-usb",
            },
        },
        distance = 1.5
    })
end)


mrpdsecurity = {
    ['mrpdpatrol'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuardsMRPD()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, `PLAYER`)
    AddRelationshipGroup('labpatrol')

    for k, v in pairs(Config['mrpdsecurity']['mrpdpatrol']) do
        loadModel(v['model'])
        mrpdsecurity['mrpdpatrol'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(mrpdsecurity['mrpdpatrol'][k])
        networkID = NetworkGetNetworkIdFromEntity(mrpdsecurity['mrpdpatrol'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(mrpdsecurity['mrpdpatrol'][k], 0)
        SetPedRandomProps(mrpdsecurity['mrpdpatrol'][k])
        SetEntityAsMissionEntity(mrpdsecurity['mrpdpatrol'][k])
        SetEntityVisible(mrpdsecurity['mrpdpatrol'][k], true)
        SetPedRelationshipGroupHash(mrpdsecurity['mrpdpatrol'][k], `mrpdpatrol`)
        SetPedAccuracy(mrpdsecurity['mrpdpatrol'][k], 75)
        SetPedArmour(mrpdsecurity['mrpdpatrol'][k], 100)
        SetPedCanSwitchWeapon(mrpdsecurity['mrpdpatrol'][k], true)
        SetPedDropsWeaponsWhenDead(mrpdsecurity['mrpdpatrol'][k], false)
        SetPedFleeAttributes(mrpdsecurity['mrpdpatrol'][k], 0, false)
        GiveWeaponToPed(mrpdsecurity['mrpdpatrol'][k], `WEAPON_PISTOL`, 255, false, false)
        TaskGoToEntity(mrpdsecurity['mrpdpatrol'][k], PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(mrpdsecurity['mrpdpatrol'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, `mrpdpatrol`, `mrpdpatrol`)
    SetRelationshipBetweenGroups(5, `mrpdpatrol`, `PLAYER`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `mrpdpatrol`)
end

function ExportMRPDTarget()
    exports['qb-target']:AddBoxZone("hack-mrpd", vector3(457.3, -1001.49, 30.73), 1, 1, {
        name="hack-mrpd",
        heading=358,
        debugpoly = false,
    }, {
        options = {
            {
            event = "qb-miniheists:client:StartMRPDHack",
            icon = "far fa-usb",
            label = "Hack Evience Files",
            item = "electronickit",
            },
        },
        distance = 1.5
    })
end

--Salvage Raid Stuff -------------------------------------------------------------------------------------------------


RegisterNetEvent('qb-miniheists:client:SalvageRaid', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"idle"})
    QBCore.Functions.Progressbar('pickup', 'Getting Job...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('You will be emailed shortly with the location', 'primary')
        if CurrentCops >= Config.MinimumPolice then
        TriggerServerEvent('QBCore:Server:AddItem', "weapon_crowbar", 1)
        Wait(5000)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Dan Bugerman',
            subject = 'Rare Parts...',
            message = 'I need some rare parts laddy and i know rogers salvage & Scrap have em in a box somewhere in that machine room! I will pay ya handsomely for em',
            })
        SetNewWaypoint(-599.13, -1610.86, 27.04)
        ExportOilTarget()
        else
            QBCore.Functions.Notify('Not enough police presence', 'error', 7500)
        end
    end)
end)

RegisterNetEvent('qb-miniheists:client:StartSalvageHack', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_crowbar", 1)
            TriggerServerEvent('police:server:policeAlert', 'Robbery at Rogers salvage and scrap!')
            TriggerEvent('animations:client:EmoteCommandStart', {"type"})
            QBCore.Functions.Progressbar('cnct_elect', 'Breaking Box...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
            end)
            Wait(7500)
        TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        exports["memorygame_2"]:thermiteminigame(2, 2, 2, 10,
    function() -- Success
        Wait(100)
        TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        Wait(500)
        QBCore.Functions.Progressbar('po_usb', 'Grabbing Parts..', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        end)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('QBCore:Server:AddItem', "salvage-parts", 1)
        SpawnGuardsSalvage()
        QBCore.Functions.Notify('You stole the parts! But your crowbar broke', 'primary')
        Wait(7500)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Dan Bugerman',
            subject = 'Rare Parts...',
            message = 'HAHA Rogers not a appy chappy lad. bring them parts over and ill see ya reet',
            })
    end,
        function() 
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            QBCore.Functions.Notify('You failed Hacking', 'error')
        end)
    else
        QBCore.Functions.Notify('You are missing something', 'error')
    end

    end, "weapon_crowbar")
end)

RegisterNetEvent('qb-miniheists:client:GiveRareParts', function()
    TriggerServerEvent('QBCore:Server:RemoveItem', "salvage-parts", 1)
    TriggerServerEvent('qb-miniheists:server:ReceivePaymentSalvage')
    TriggerServerEvent('qb-miniheists:server:SalvageReward')
end)


CreateThread(function()
    RequestModel(`s_m_m_trucker_01`)
      while not HasModelLoaded(`s_m_m_trucker_01`) do
      Wait(1)
    end
      salvageboss = CreatePed(2, `s_m_m_trucker_01`, -97.58, -1013.66, 26.28, 158.0, false, false) 
      SetPedFleeAttributes(salvageboss, 0, 0)
      SetPedDiesWhenInjured(salvageboss, false)
      TaskStartScenarioInPlace(salvageboss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(salvageboss, true)
      SetBlockingOfNonTemporaryEvents(salvageboss, true)
      SetEntityInvincible(salvageboss, true)
      FreezeEntityPosition(salvageboss, true)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("Salvage-Raid", vector3(-97.58, -1013.66, 27.28), 1, 1, {
        name="Salvage-Raid",
        heading=158,
        debugpoly = false,
    }, {
        options = {
            {
                event = "qb-miniheists:client:SalvageRaid",
                icon = "far fa-phone",
                label = "Request Job",
                item = "phone",
            },
            {
                event = "qb-miniheists:client:GiveRareParts",
                icon = "far fa-phone",
                label = "Give Parts",
                item = "salvage-parts",
            },
        },
        distance = 1.5
    })
end)


salvageworkers = {
    ['salvagepatrol'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuardsSalvage()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, `PLAYER`)
    AddRelationshipGroup('salvagepatrol')

    for k, v in pairs(Config['salvageworkers']['salvagepatrol']) do
        loadModel(v['model'])
        salvageworkers['salvagepatrol'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(salvageworkers['salvagepatrol'][k])
        networkID = NetworkGetNetworkIdFromEntity(salvageworkers['salvagepatrol'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(salvageworkers['salvagepatrol'][k], 0)
        SetPedRandomProps(salvageworkers['salvagepatrol'][k])
        SetEntityAsMissionEntity(salvageworkers['salvagepatrol'][k])
        SetEntityVisible(salvageworkers['salvagepatrol'][k], true)
        SetPedRelationshipGroupHash(salvageworkers['salvagepatrol'][k], `salvagepatrol`)
        SetPedAccuracy(salvageworkers['salvagepatrol'][k], 75)
        SetPedArmour(salvageworkers['salvagepatrol'][k], 100)
        SetPedCanSwitchWeapon(salvageworkers['salvagepatrol'][k], true)
        SetPedDropsWeaponsWhenDead(salvageworkers['salvagepatrol'][k], false)
        SetPedFleeAttributes(salvageworkers['salvagepatrol'][k], 0, false)
        GiveWeaponToPed(salvageworkers['salvagepatrol'][k], `WEAPON_HAMMER`, 255, false, false)
        TaskGoToEntity(salvageworkers['salvagepatrol'][k], PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(salvageworkers['salvagepatrol'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, `salvagepatrol`, `salvagepatrol`)
    SetRelationshipBetweenGroups(5, `salvagepatrol`, `PLAYER`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `salvagepatrol`)
end

function ExportOilTarget()
    exports['qb-target']:AddBoxZone("hack-salvage", vector3(-599.12, -1610.86, 27.04), 1, 1, {
        name="hack-salvage",
        heading=350,
        debugpoly = false,
    }, {
        options = {
            {
            event = "qb-miniheists:client:StartSalvageHack",
            icon = "far fa-usb",
            label = "Break Box Open",
            item = "weapon_crowbar",
            },
        },
        distance = 1.5
    })
end
