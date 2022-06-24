QBCore = exports['qb-core']:GetCoreObject()
Users = {}
Vehicles = {}
Jobs = {}
JobGrades = {}
LicenseLabels = {}
Accounts = {}
Properties = {}
OwnedProperties = {}
Callback = {}



function loadStaff()
    local query = "SELECT citizenid FROM players WHERE job LIKE "

    for k, v in pairs(Config.Departaments) do
        query = query .. "'%" .. k .. "%'" .. "OR job LIKE "
    end

    query = query .. " 'xxx' "


    exports.oxmysql:query(
        query,
        {},
        function(info)
            for _, v in ipairs(info) do

                updateUser(v.citizenid, 0)
            end
        end
    )
end

function fetchInfo()

if Config.AccountInformation == 'qb-management' then
    exports.oxmysql:query(
            "SELECT * FROM management_funds WHERE 1",
            {},
            function(info)
                for _, v in ipairs(info) do
                    Accounts[v.job_name] = tonumber(v.amount)
                end
            end
        )
elseif Config.AccountInformation ~= '' then
    local result = json.decode(LoadResourceFile(Config.AccountInformation, "./" .. Config.AccountFile ..".json"))
    if not result then
        return
    end
    for k,v in pairs(result) do
        local k = tostring(k)
        local v = tonumber(v)
        if k and v then
            Accounts[k] = v
        end
    end
end


    if Config.UsingQBHouses then
        exports.oxmysql:query(
            "SELECT * FROM houselocations WHERE 1",
            {},
            function(info)
                for _, v in ipairs(info) do
                    Properties[v.name] = v
                end
            end
        )



        exports.oxmysql:query(
            "SELECT * FROM player_houses WHERE 1",
            {},
            function(info)
                for _, v in ipairs(info) do

                    if OwnedProperties[v.citizenid] == nil then

                        OwnedProperties[v.citizenid] = {v.house}
                    else
                        table.insert(OwnedProperties[v.citizenid], v.house)
                    end
                end
            end
        )
    end



    Citizen.Wait(500)

    local Players = QBCore.Functions.GetPlayers()

    for i = 1, #Players, 1 do
        local Player = QBCore.Functions.GetPlayer(Players[i])


        updateUser(Player.PlayerData.citizenid, 0)
    end

    loadStaff()
end

RegisterCommand(
    "announce",
    function(source, args, rawCommand)
       local Player = QBCore.Functions.GetPlayer(source)

        if Config.Departaments[Player.PlayerData.job.name] ~= nil then
           exports.oxmysql:update(
                "INSERT INTO `mdw_announcements`( `announcement`, `date`) VALUES (:text,:date)",
                {["text"] = rawCommand:gsub("announce", ""), ["date"] = os.time()},
                function()
                end
            )
        end
    end
)

function searchCars(text, field, s)

    local search = {}

 exports.oxmysql:query(
                        "SELECT * FROM player_vehicles WHERE  LOWER(plate) LIKE LOWER(:plate) LIMIT 10",
                        {["plate"] = "%" .. text .. "%"},
                        function(results2)
                            for _, g in ipairs(results2) do
                                exports.oxmysql:query(
                                    "SELECT * FROM players WHERE  citizenid = :cid LIMIT 10",
                                    {["cid"] = g.citizenid},
                                    function(results3)
                                        for _, b in ipairs(results3) do
                                            table.insert(search, b)
                                        end

                                        TriggerClientEvent("core_mdw:searchSQL_c", s, search, field)
                                    end
                                )
                            end
                        end
                    )

end

function searchSQL(text, field, s)

    local split = {}
    local second = ""
    local search = {}

    for i in string.gmatch(text, "%S+") do
        table.insert(split, i)
    end

    if not split[1] then
        split[1] = ""
    end

    if not split[2] then
        split[2] = ""
    end

   
        exports.oxmysql:query(
           "SELECT * FROM players WHERE  (LOWER(charinfo) LIKE LOWER(:text)) AND (LOWER(charinfo) LIKE LOWER(:text2)) LIMIT 10",
            {["text"] = "%" .. split[1] .. "%", ["text2"] = "%" .. split[2] .. "%"},
            function(results)
                for _, v in ipairs(results) do

                    local char = json.decode(v.charinfo)
                    v.firstname = char.firstname
                    v.lastname = char.lastname

                    table.insert(search, v)
                end

                if #search == 0 then
                   searchCars(text, field, s)
                else
                    TriggerClientEvent("core_mdw:searchSQL_c", s, search, field)
                end
            end
        )
    
end

function updateUser(user, callback)

   exports.oxmysql:query(
        "SELECT * FROM players WHERE citizenid = :cid",
        {["cid"] = user},
        function(info)
            for _, v in ipairs(info) do
                exports.oxmysql:query(
                    "SELECT *  FROM player_vehicles WHERE citizenid = :cid",
                    {["cid"] = v.citizenid},
                    function(vehInfo)
                                    
                                    local Player = QBCore.Functions.GetPlayerByCitizenId(v.citizenid)
                               
                                    v.vehicles = {}
                                    v.housing = {}
                                    v.licenses = {}



                                    local metadata = nil
                                    if Player then
                                        metadata = Player.PlayerData.metadata

                                    else
                                        metadata = json.decode(v.metadata)
                                    end

                                     for h, f in pairs(metadata.licences) do
                                        if f then
                                    v.licenses[h] = h
                                        end
                                   end

                                    for _, g in ipairs(vehInfo) do

                                        g.label = g.plate --CHANGE
                                        v.vehicles[g.plate] = g
                                    end
                                    v.jobs = {}

                                    local job = json.decode(v.job)

                                    if Config.ExcludeJobs[job.name] == nil then

                                
                                        
                                        v.jobs[job.name] = {
                                            label = job.label ..
                                                " - " .. job.grade.name,
                                            gradeSalary = job.payment,
                                            gradeName = job.grade.level,
                                            gradeLabel = job.grade.name,
                                            jobLabel = job.label,
                                            funds = Accounts[job.name] or 0
                                        }
                                    end

                                    if (v.mdw_staffdata ~= nil and v.mdw_staffdata ~= "") then
                                        local staffdata = json.decode(v.mdw_staffdata)
                                        v.permissions = staffdata.permissions
                                        v.badges = staffdata.badges
                                    else
                                        v.permissions = {}
                                        v.permissions["issuewarrant"] = false
                                        v.permissions["editincident"] = false
                                        v.permissions["deleteincident"] = false
                                        v.permissions["createincident"] = false
                                        v.permissions["createreport"] = false
                                        v.permissions["editreport"] = false
                                        v.permissions["deletereport"] = false
                                        v.permissions["editprofile"] = false
                                        v.permissions["revokelicense"] = false
                                        v.permissions["administrator"] = false
                                        v.badges = {["placeholder"] = false}
                                    end

                                    if QBCore.Functions.GetPlayerByCitizenId(v.citizenid) then
                                        v.online = true
                                    else
                                        v.online = false
                                    end

                                    if Config.UsingQBHouses then
                                        v.housing = {}

                                     if OwnedProperties[v.citizenid] ~= nil then

                                        for _,z in pairs( OwnedProperties[v.citizenid] ) do

                                         v.housing[tostring(z)] = {
                                                    label = Properties[z].label,
                                                    entering = Properties[z].coords
                                                }
                                            end
                                     end
                                               
                                          
                                    end

                                    local char = json.decode(v.charinfo)

                                    v.dateofbirth = char.birthdate
                                    v.nationality = char.nationality
                                     v.phone_number = char.phone

                                    v.firstname = char.firstname
                                    v.lastname = char.lastname

                                    v.name = v.firstname .. " " .. v.lastname
                                    Users[v.citizenid] = v

                                    if callback > 0 then
                                        Callback[callback][v.citizenid] = v
                                    end
                                
                          
                    end
                )
            end
        end
    )
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function updateUsers(users, s)
    Callback[s] = {}
    local count = 0
    local ignore = {}

    for _, v in ipairs(users) do
        if ignore[v] == nil then
        updateUser(v, s)
        count = count + 1
        ignore[v] = true
        end
    end

    while (tablelength(Callback[s]) ~= count) do
        Citizen.Wait(100)
    end

    TriggerClientEvent("core_mdw:updated", s, Callback[s])
end



Citizen.CreateThread(function()
        fetchInfo()
    end)

QBCore.Functions.CreateCallback(
    "core_mdw:getUsers",
    function(source, cb)
        local user = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        updateUser(user, 0)
        Citizen.Wait(200)
        cb(Users)
    end
)

QBCore.Functions.CreateCallback(
    "core_mdw:updateInfo",
    function(source, cb)
        local Incidents = {}
        local Reports = {}
        local Announcements = {}
        local Evidence = {}

        exports.oxmysql:query(
            "SELECT * FROM mdw_incidents WHERE 1",
            {},
            function(incident)
                for _, v in ipairs(incident) do
                    local data = json.decode(v.data)

                    Incidents[v.id] = {
                        title = v.title,
                        location = v.location,
                        time = v.time,
                        description = v.description,
                        crims = data.crims,
                        officers = data.officers,
                        spectators = data.spectators,
                        evidence = data.evidence
                    }
                end

                exports.oxmysql:query(
                    "SELECT * FROM mdw_reports WHERE 1",
                    {},
                    function(reports)
                        for _, g in ipairs(reports) do
                            Reports[g.id] = {
                                title = g.title,
                                incident = g.incident,
                                description = g.description,
                                ongoing = g.ongoing,
                                expire = g.expire,
                                created = g.created
                            }
                        end

                        exports.oxmysql:query(
                            "SELECT * FROM mdw_announcements WHERE 1",
                            {},
                            function(announcements)
                                for _, z in ipairs(announcements) do
                                    Announcements[z.id] = {text = z.announcement, date = z.date}
                                end

                                exports.oxmysql:query(
                                    "SELECT * FROM mdw_evidence WHERE 1",
                                    {},
                                    function(evidences)
                                        for _, b in ipairs(evidences) do
                                            Evidence[b.id] = {
                                                image = b.image,
                                                description = b.description,
                                                type = "evidence"
                                            }
                                        end

                                        if Config.UsingCoreEvidence then
                                            exports.oxmysql:query(
                                                "SELECT * FROM evidence_storage WHERE 1",
                                                {},
                                                function(evidences2)
                                                    for _, b in ipairs(evidences2) do
                                                        Evidence[b.id] = {
                                                            data = json.decode(b.data),
                                                            type = "ecosystem"
                                                        }
                                                    end

                                                    cb(Incidents, Reports, Announcements, Evidence)
                                                end
                                            )
                                        else
                                            cb(Incidents, Reports, Announcements, Evidence)
                                        end
                                    end
                                )
                            end
                        )
                    end
                )
            end
        )
    end
)

RegisterServerEvent("core_mdw:removeIncident")
AddEventHandler(
    "core_mdw:removeIncident",
    function(incident)
        exports.oxmysql:update(
            "DELETE FROM `mdw_incidents` WHERE `id` = :id",
            {["id"] = incident},
            function()
            end
        )

        sendToDiscord(
            "Incident removed (#" .. incident .. ")",
            {
                {
                    ["name"] = "Removed By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:removeEvidence")
AddEventHandler(
    "core_mdw:removeEvidence",
    function(id)
        exports.oxmysql:update(
            "DELETE FROM `mdw_evidence` WHERE `id` = :id",
            {["id"] = id},
            function()
            end
        )

        sendToDiscord(
            "Evidence removed (#" .. id .. ")",
            {
                {
                    ["name"] = "Removed By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:removeReport")
AddEventHandler(
    "core_mdw:removeReport",
    function(id)
        exports.oxmysql:update(
            "DELETE FROM `mdw_reports` WHERE `id` = :id",
            {["id"] = id},
            function()
            end
        )

        sendToDiscord(
            "Report removed (#" .. id .. ")",
            {
                {
                    ["name"] = "Removed By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:saveEvidence")
AddEventHandler(
    "core_mdw:saveEvidence",
    function(id, image, description)
        exports.oxmysql:update(
            "UPDATE `mdw_evidence` SET `image`= :image , `description` = :description WHERE `id` = :id",
            {["description"] = description, ["image"] = image, ["id"] = id},
            function()
            end
        )

        sendToDiscord(
            "Evidence saved (#" .. id .. ")",
            {
                {
                    ["name"] = "Image",
                    ["value"] = image
                },
                {
                    ["name"] = "Description",
                    ["value"] = description
                },
                {
                    ["name"] = "Saved By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:saveVehicle")
AddEventHandler(
    "core_mdw:saveVehicle",
    function(plate, impounded, image, owner)



        exports.oxmysql:update(
            "UPDATE `player_vehicles` SET impounded = :impounded, mdw_image = :image WHERE `plate` = :plate",
            {["impounded"] = impounded, ["image"] = image, ['plate'] = plate},
            function()
            end
        )

        if impounded then
             exports.oxmysql:update(
            "UPDATE `player_vehicles` SET citizenid = :owner WHERE `plate` = :plate",
            {["owner"] = 'i_' .. owner, ['plate'] = plate},
            function()
            end
        )
        else
            exports.oxmysql:update(
            "UPDATE `player_vehicles` SET citizenid = :owner WHERE `plate` = :plate",
            {["owner"] = owner, ['plate'] = plate},
            function()
            end
        )
        end


    end
)

RegisterServerEvent("core_mdw:saveIncident")
AddEventHandler(
    "core_mdw:saveIncident",
    function(title, location, time, description, crims, officers, spectators, incident, evidence)
        local data = {}
        data.crims = crims
        data.officers = officers
        data.spectators = spectators
        data.evidence = evidence

        exports.oxmysql:update(
            "UPDATE `mdw_incidents` SET `title`= :title , `location` = :location , `time` = :time , description = :description , data = :data WHERE `id` = :id",
            {
                ["title"] = title,
                ["location"] = location,
                ["time"] = time,
                ["description"] = description,
                ["data"] = json.encode(data),
                ["id"] = incident
            },
            function()
            end
        )

        sendToDiscord(
            "Incident updated (#" .. incident .. ")",
            {
                {
                    ["name"] = "Title",
                    ["value"] = title
                },
                {
                    ["name"] = "Location",
                    ["value"] = location
                },
                {
                    ["name"] = "Description",
                    ["value"] = description
                },
                {
                    ["name"] = "Updated By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:insertIntoFieldEvidence")
AddEventHandler(
    "core_mdw:insertIntoFieldEvidence",
    function(incident, id, incidents)
        local current = incidents[incident]
        local data = {}

        current.evidence[id] = true

        data.crims = current.crims
        data.officers = current.officers
        data.spectators = current.spectators
        data.evidence = current.evidence

        exports.oxmysql:update(
            "UPDATE `mdw_incidents` SET data = :data WHERE `id` = :id",
            {["data"] = json.encode(data), ["id"] = incident},
            function()
            end
        )
    end
)

RegisterServerEvent("core_mdw:sentance")
AddEventHandler(
    "core_mdw:sentance",
    function(person, jail, fine, charges)
        local source = source
        local Victim = QBCore.Functions.GetPlayerByCitizenId(person)
           
        TriggerClientEvent('core_mdw:sentance', source, Victim.PlayerData.source, jail, fine, charges)
     
    end
)

RegisterServerEvent("core_mdw:searchSQL")
AddEventHandler(
    "core_mdw:searchSQL",
    function(text, field)
        searchSQL(text, field, source)
    end
)

RegisterServerEvent("core_mdw:updateUsers")
AddEventHandler(
    "core_mdw:updateUsers",
    function(users)
        updateUsers(users, source)
    end
)

RegisterServerEvent("core_mdw:insertIntoField")
AddEventHandler(
    "core_mdw:insertIntoField",
    function(incident, field, citizenid, firstname, lastname, incidents)
        local current = incidents[incident]
        local data = {}

        if field == "crims" then
            current.crims[citizenid] = {
                name = firstname .. " " .. lastname,
                charges = {["placeholder"] = false},
                warrant = ""
            }
        elseif field == "officers" then
            current.officers[citizenid] = {name = firstname .. " " .. lastname}
        elseif field == "spectators" then
            current.spectators[citizenid] = {name = firstname .. " " .. lastname}
        end

        data.crims = current.crims
        data.officers = current.officers
        data.spectators = current.spectators
        data.evidence = current.evidence

       exports.oxmysql:update(
            "UPDATE `mdw_incidents` SET data = :data WHERE `id` = :id",
            {["data"] = json.encode(data), ["id"] = incident},
            function()
            end
        )
    end
)

RegisterServerEvent("core_mdw:revokeLicnese")
AddEventHandler(
    "core_mdw:revokeLicnese",
    function(person, license)

        local xPlayer =QBCore.Functions.GetPlayerByCitizenId(person)
        local src = source

        if xPlayer then
         
            
             local licenseTable = xPlayer.PlayerData.metadata["licences"]
                licenseTable[license] = false
            
                xPlayer.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent("core_mdw:sendMessage", xPlayer.PlayerData.cid, Config.Text["license_revoked"])
        end

        TriggerClientEvent("core_mdw:sendMessage", src, Config.Text["license_revoked_success"])
    end
)

RegisterServerEvent("core_mdw:updateStaffProfile")
AddEventHandler(
    "core_mdw:updateStaffProfile",
    function(person, picture, alias, data)
        Users[person].mdw_image = picture
        Users[person].mdw_alias = alias
        Users[person].permissions = data.permissions
        Users[person].badges = data.badges

        exports.oxmysql:update(
            "UPDATE `players` SET mdw_image = :picture, mdw_alias = :alias, mdw_staffdata = :data WHERE `citizenid` = :id",
            {["picture"] = picture, ["alias"] = alias, ["data"] = json.encode(data), ["id"] = person},
            function()
            end
        )

        sendToDiscord(
            "Staff Profile updated (" .. Users[person].name .. ")",
            {
                {
                    ["name"] = "Image",
                    ["value"] = picture
                },
                {
                    ["name"] = "Alias",
                    ["value"] = alias
                },
                {
                    ["name"] = "Updated By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:updateProfile")
AddEventHandler(
    "core_mdw:updateProfile",
    function(person, picture, description)
        Users[person].mdw_image = picture
        Users[person].mdw_description = description

        exports.oxmysql:update(
            "UPDATE `players` SET mdw_image = :picture, mdw_description = :description WHERE `citizenid` = :id",
            {["picture"] = picture, ["description"] = description, ["id"] = person},
            function()
               
            end
        )

        sendToDiscord(
            "Profile updated (" .. Users[person].name .. ")",
            {
                {
                    ["name"] = "Image",
                    ["value"] = picture
                },
                {
                    ["name"] = "Description",
                    ["value"] = description
                },
                {
                    ["name"] = "Updated By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:createIncident")
AddEventHandler(
    "core_mdw:createIncident",
    function(incident)
        local data = {}
        data.crims = {}
        data.officers = {}
        data.spectators = {}
        data.evidence = {}

        exports.oxmysql:update(
            "INSERT INTO `mdw_incidents`(`id`, `title`, `location`, `time`, `description`, `data`) VALUES (:id,:title,:location,:time,:description,:data)",
            {
                ["title"] = "",
                ["location"] = "",
                ["time"] = "",
                ["description"] = "",
                ["data"] = json.encode(data),
                ["id"] = incident
            },
            function()
            end
        )
    end
)

RegisterServerEvent("core_mdw:createEvidence")
AddEventHandler(
    "core_mdw:createEvidence",
    function(id, image, description)
        exports.oxmysql:update(
            "INSERT INTO `mdw_evidence`(`id`, `image`, `description`) VALUES (:id,:image,:description)",
            {["description"] = description, ["image"] = image, ["id"] = id},
            function()
            end
        )

        sendToDiscord(
            "Evidence created (#" .. id .. ")",
            {
                {
                    ["name"] = "Image",
                    ["value"] = image
                },
                {
                    ["name"] = "Description",
                    ["value"] = description
                },
                {
                    ["name"] = "Created By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:broadcast")
AddEventHandler(
    "core_mdw:broadcast",
    function(broadcast_type, message)
        TriggerClientEvent("core_mdw:broadcast_c", -1, broadcast_type, message)
    end
)

RegisterServerEvent("core_mdw:updateReport")
AddEventHandler(
    "core_mdw:updateReport",
    function(id, title, incident, description, ongoing, expire)
       exports.oxmysql:update(
            "UPDATE `mdw_reports` SET `title`= :title , `incident` = :incident , `description` = :description , `ongoing`= :ongoing , `expire` = :expire WHERE `id` = :id",
            {
                ["title"] = title,
                ["incident"] = incident,
                ["description"] = description,
                ["ongoing"] = ongoing,
                ["expire"] = expire,
                ["id"] = id
            },
            function()
            end
        )

        sendToDiscord(
            "Report updated (#" .. id .. ")",
            {
                {
                    ["name"] = "Title",
                    ["value"] = title
                },
                {
                    ["name"] = "Incident",
                    ["value"] = incident
                },
                {
                    ["name"] = "Description",
                    ["value"] = description
                },
                {
                    ["name"] = "Ongoing",
                    ["value"] = ongoing
                },
                {
                    ["name"] = "Expire",
                    ["value"] = expire
                },
                {
                    ["name"] = "Updated By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

RegisterServerEvent("core_mdw:createReport")
AddEventHandler(
    "core_mdw:createReport",
    function(id, title, incident, description, ongoing, expire)
        exports.oxmysql:update(
            "INSERT INTO `mdw_reports`(`id`, `title`, `incident`, `description`, `ongoing`, `expire`, `created`) VALUES (:id,:title,:incident,:description,:ongoing,:expire, :created)",
            {
                ["title"] = title,
                ["id"] = id,
                ["incident"] = incident,
                ["description"] = description,
                ["ongoing"] = ongoing,
                ["expire"] = expire,
                ["created"] = os.time()
            },
            function()
            end
        )

        sendToDiscord(
            "Report created (#" .. id .. ")",
            {
                {
                    ["name"] = "Title",
                    ["value"] = title
                },
                {
                    ["name"] = "Incident",
                    ["value"] = incident
                },
                {
                    ["name"] = "Description",
                    ["value"] = description
                },
                {
                    ["name"] = "Expire",
                    ["value"] = expire
                },
                {
                    ["name"] = "Created By",
                    ["value"] = Users[QBCore.Functions.GetPlayer(source).PlayerData.citizenid].name
                }
            }
        )
    end
)

function sendToDiscord(title, message)
    if Config.DiscordWebhook ~= "" then
        local connect = {
            {
                ["color"] = 16494651,
                ["title"] = "**" .. title .. "**\n",
                ["fields"] = message
            }
        }

        PerformHttpRequest(
            Config.DiscordWebhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {username = Config.SystemName, embeds = connect, avatar_url = "https://i.ibb.co/CbB24PP/notify.png"}
            ),
            {["Content-Type"] = "application/json"}
        )
    end
end
