local function ActivatePedTarget(ped, k)
    if Config.Target == "QB" or "qb" then
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = "client",
                    event = "Daze-talktopeds:client:NPC",
                    icon = "fas fa-comments",
                    label = "Speak with "..Config.Peds[k].PedName,
                    ped = k

                },
            },
            distance = 3.0
        })
    elseif Config.Target == "ESX" then
        exports['qtarget']:AddTargetEntity(ped, {
            options = {
                {
                    event = "Daze-talktopeds:client:NPC",
                    icon = "fas fa-comments",
                    label = "Speak with "..Config.Peds[k].PedName,
                    ped = k
                },
            },
            distance = 2
        })
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Peds) do
        RequestModel(v.ped)
        while not HasModelLoaded(v.ped) do
            Wait(20)
        end
        local inRange = false
        local spawned = v.spawned
        while not spawned do
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local dist = #(pedCoords - v.coords)
            
            if dist <= 500 then
                inRange = true
            end
    
            if dist <= 100 then
                local npc = CreatePed(0, v.ped, v.coords['x'], v.coords['y'], v.coords['z'], v.heading, true, 1)
                ActivatePedTarget(npc, k)
                v.spawned = true
                break
            end
    
            if not inRange then
                Wait(2000)
            end
            Wait(100)
        end
        Wait(100)
    end
end)

RegisterNetEvent('Daze-talktopeds:client:NPC')
AddEventHandler('Daze-talktopeds:client:NPC', function(data)
    local ped = PlayerPedId()
    print(data.ped)
    local Name = Config.Peds[data.ped].PedName
    local line = 1
    if data.hookto then
        line = data.hookto
    end
    if line ~= 0 then
        local msg = Config.Peds[data.ped].Lines[line].npc
        local myMenu = {}
        myMenu = {
            {
                id = 1,
                header = Name,
                isMenuHeader = true
            },
            {
                header = msg,
                params = {
                event = "Daze-talktopeds:client:Talk",
                args = {
                    ped = data.ped,
                    hookto = line
                }
            }
            }
        }
        exports['qb-menu']:openMenu(myMenu)
    end
end)

RegisterNetEvent('Daze-talktopeds:client:Talk')
AddEventHandler('Daze-talktopeds:client:Talk', function(data)
    local Name = Config.Peds[data.ped].PedName
    local line = 1
    local msg = ""
        local myMenu = {}
        myMenu = {
            {
                id = 1,
                header = "You",
                isMenuHeader = true
            },
        }
        if data.hookto ~= nil then
            line = data.hookto
        end
        for k, v in pairs (Config.Peds[data.ped].Lines[line].player) do
            msg = v.text
            myMenu[#myMenu+1] = {
                header = msg,
                --text = desc,
                params = {
                    event = "Daze-talktopeds:client:NPC",
                    args = {
                        ped = data.ped,
                        hookto = v.LineHook
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(myMenu)
end)

