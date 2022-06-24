local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

VehColors = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steel",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black Steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "Police Car Blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metallic Dark Blue",
    ['147'] = "Black",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "Default Alloy Color",
    ['157'] = "Epsilon Blue",
    ['158'] = "Pure Gold",
    ['159'] = "Brushed Gold",
    ['160'] = "MP100"
}

QBCore = exports['qb-core']:GetCoreObject()

local job = ""

local isVisible = false
local tabletObject = nil

Citizen.CreateThread(
    function()

        while QBCore.Functions.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        job = QBCore.Functions.GetPlayerData().job.name
    end
)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler(
    "QBCore:Client:OnJobUpdate",
    function(JobInfo)
        job = JobInfo.name
    end
)


function updateMDW()
    Citizen.Wait(100)

    QBCore.Functions.TriggerCallback(
        "core_mdw:updateInfo",
        function(incidents, reports, announcements, evidence)
            SendNUIMessage(
                {
                    type = "update",
                    incidents = incidents,
                    announcements = announcements,
                    reports = reports,
                    evidence = evidence
                }
            )
        end
    )
end

function toggleTablet()
    local playerPed = PlayerPedId()

    if not isVisible then
        local dict = "amb@world_human_seat_wall_tablet@female@base"
        RequestAnimDict(dict)
        if tabletObject == nil then
            tabletObject = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(playerPed), 1, 1, 1)
            AttachEntityToEntity(
                tabletObject,
                playerPed,
                GetPedBoneIndex(playerPed, 28422),
                0.0,
                0.0,
                0.03,
                0.0,
                0.0,
                0.0,
                1,
                1,
                0,
                1,
                0,
                1
            )
        end
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(100)
        end
        if not IsEntityPlayingAnim(playerPed, dict, "base", 3) then
            TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
        end
        isVisible = true
    else
        ClearPedTasks(playerPed)
        DeleteEntity(tabletObject)
        tabletObject = nil
        isVisible = false
    end
end

function openMDW()
    if Config.Departaments[job] ~= nil then
        QBCore.Functions.TriggerCallback(
            "core_mdw:getUsers",
            function(users)
                local x, y = GetScreenResolution()

                toggleTablet()

                SetNuiFocus(true, true)
                SendNUIMessage(
                    {
                        type = "open",
                        charges = Config.Charges,
                        departaments = Config.Departaments,
                        vehColors = VehColors,
                        warrantending = Config.WarrantEndingWarningTime,
                        badges = Config.Badges,
                        instantadmins = Config.InstantAdministrator,
                        users = users,
                        citizenid = QBCore.Functions.GetPlayerData().citizenid
                    }
                )

                updateMDW()
            end
        )
    else
        SendTextMessage(Config.Text["no_permission"])
    end
end

RegisterCommand(
    Config.OpenCommand,
    function()
        openMDW()
    end
)

RegisterNetEvent("core_mdw:searchSQL_c")
AddEventHandler(
    "core_mdw:searchSQL_c",
    function(results, field)


SendNUIMessage(
                {
                    type = "searchResults",
                   results = results,
                   field = field
                }
            )


        end)

RegisterNetEvent("core_mdw:updated")
AddEventHandler(
    "core_mdw:updated",
    function(users)


SendNUIMessage(
                {
                    type = "updateUsers",
                   users = users
                }
            )


        end)

RegisterNetEvent("core_mdw:broadcast_c")
AddEventHandler(
    "core_mdw:broadcast_c",
    function(broadcast_type, message)
        if broadcast_type == "everyone" then
            SendNUIMessage(
                {
                    type = "broadcast",
                    broadcast_type = broadcast_type,
                    message = message
                }
            )
        elseif broadcast_type == "police" then
            for k, v in pairs(Config.Departaments) do
                if (k == job) then
                    SendNUIMessage(
                        {
                            type = "broadcast",
                            broadcast_type = broadcast_type,
                            message = message
                        }
                    )
                end
            end
        elseif broadcast_type == "emergency" then
            for k, v in pairs(Config.EmergencyJobs) do
                if (k == job) then
                    SendNUIMessage(
                        {
                            type = "broadcast",
                            broadcast_type = broadcast_type,
                            message = message
                        }
                    )
                end
            end
        end
    end
)

RegisterNUICallback(
    "saveIncident",
    function(data)
        local title, location, time, description, crims, officers, spectators, incident, evidence =
            data["title"],
            data["location"],
            data["time"],
            data["description"],
            data["crims"],
            data["officers"],
            data["spectators"],
            data["incident"],
            data["evidence"]

        TriggerServerEvent(
            "core_mdw:saveIncident",
            title,
            location,
            time,
            description,
            crims,
            officers,
            spectators,
            incident,
            evidence
        )

        updateMDW()
    end
)

RegisterNUICallback(
    "removeReport",
    function(data)
        local id = data["id"]

        TriggerServerEvent("core_mdw:removeReport", id)
        updateMDW()
    end
)

RegisterNUICallback(
    "removeEvidence",
    function(data)
        local id = data["id"]

        TriggerServerEvent("core_mdw:removeEvidence", id)
        updateMDW()
    end
)

RegisterNUICallback(
    "removeIncident",
    function(data)
        local incident = data["incident"]

        TriggerServerEvent("core_mdw:removeIncident", incident)
        updateMDW()
    end
)

RegisterNUICallback(
    "updateProfile",
    function(data)
        local picture, person, description = data["picture"], data["person"], data["description"]

        TriggerServerEvent("core_mdw:updateProfile", person, picture, description)
    end
)
RegisterNUICallback(
    "addToIncidentEvidence",
    function(data)
        local incident, field, id, incidents = data["incident"], data["field"], data["id"], data["incidents"]

        TriggerServerEvent("core_mdw:insertIntoFieldEvidence", incident, id, incidents)

        updateMDW()
    end
)

RegisterNUICallback(
    "addToIncident",
    function(data)
        local incident, field, citizenid, firstname, lastname, incidents =
            data["incident"],
            data["field"],
            data["citizenid"],
            data["firstname"],
            data["lastname"],
            data["incidents"]

        TriggerServerEvent("core_mdw:insertIntoField", incident, field, citizenid, firstname, lastname, incidents)

        updateMDW()
    end
)

RegisterNUICallback(
    "revokeLicense",
    function(data)
        local person, license = data["person"], data["license"]

        TriggerServerEvent("core_mdw:revokeLicnese", person, license)
    end
)

RegisterNUICallback(
    "broadcast",
    function(data)
        local broadcast_type, message = data["type"], data["message"]

        TriggerServerEvent("core_mdw:broadcast", broadcast_type, message)

        updateMDW()
    end
)

RegisterNUICallback(
    "updateReport",
    function(data)
        local id, title, description, incident, ongoing, expire =
            data["id"],
            data["title"],
            data["description"],
            data["incident"],
            data["ongoing"],
            data["expire"]

        TriggerServerEvent("core_mdw:updateReport", id, title, incident, description, ongoing, expire)

        updateMDW()
    end
)

RegisterNUICallback(
    "createReport",
    function(data)
        local id, title, description, incident, ongoing, expire =
            data["id"],
            data["title"],
            data["description"],
            data["incident"],
            data["ongoing"],
            data["expire"]

        TriggerServerEvent("core_mdw:createReport", id, title, incident, description, ongoing, expire)

        updateMDW()
    end
)

RegisterNUICallback(
    "saveEvidence",
    function(data)
        local id, image, description = data["id"], data["image"], data["description"]

        TriggerServerEvent("core_mdw:saveEvidence", id, image, description)

        updateMDW()
    end
)

RegisterNUICallback(
    "setHouseWaypoint",
    function(data)
        local waypoint = json.decode(data["waypoint"])

        SendTextMessage(Config.Text["waypoint_set"])
        SetNewWaypoint(waypoint.enter.x, waypoint.enter.y)
    end
)

RegisterNUICallback(
    "createEvidence",
    function(data)
        local id, image, description = data["id"], data["image"], data["description"]

        TriggerServerEvent("core_mdw:createEvidence", id, image, description)

        updateMDW()
    end
)

RegisterNUICallback(
    "createIncident",
    function(data)
        local incident = data["incident"]

        TriggerServerEvent("core_mdw:createIncident", incident)

        updateMDW()
    end
)

RegisterNUICallback(
    "saveVehicle",
    function(data)
        local plate, image, impounded, owner =
            data["plate"],
            data["image"],
            data["impounded"],
             data["owner"]


        TriggerServerEvent("core_mdw:saveVehicle", plate, impounded, image, owner)
    end
)

RegisterNUICallback(
    "sentance",
    function(data)
        local jail, fine, person, charges = data["jail"], data["fine"], data["person"], data["charges"]

        TriggerServerEvent('core_mdw:sentance', person, tonumber(jail), tonumber(fine), charges)
    

    end
)

RegisterNetEvent("core_mdw:sentance")
AddEventHandler(
    "core_mdw:sentance",
    function(person, jail, fine, charges)
        SentanceCriminal(person, jail, fine, charges)
    end
)

RegisterNUICallback(
    "searchSQL",
    function(data)
        local text, field = data["text"], data['field']

        TriggerServerEvent('core_mdw:searchSQL', text, field)
    

    end
)

RegisterNUICallback(
    "updateUsers",
    function(data)
        local users = data["users"]

        TriggerServerEvent('core_mdw:updateUsers', users)
    

    end
)


RegisterNUICallback(
    "saveStaffProfile",
    function(data)
        local person, picture, alias, permissions, badges =
            data["person"],
            data["picture"],
            data["alias"],
            data["permissions"],
            data["badges"]

        local mdw_data = {}
        mdw_data.permissions = permissions
        mdw_data.badges = badges

        TriggerServerEvent("core_mdw:updateStaffProfile", person, picture, alias, mdw_data)
    end
)

RegisterNUICallback(
    "close",
    function(data)
        
        TriggerScreenblurFadeOut(1000)
        toggleTablet()
        SetNuiFocus(false, false)
    end
)

RegisterNUICallback(
    "sendMessage",
    function(data)
        SendTextMessage(Config.Text[data["message"]])
    end
)

RegisterNetEvent("core_mdw:sendMessage")
AddEventHandler(
    "core_mdw:sendMessage",
    function(msg)
        SendTextMessage(msg)
    end
)

--EXPORTS

exports(
    "openMDW",
    function()
        openMDW()
    end
)
