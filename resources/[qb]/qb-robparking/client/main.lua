---------------
-- Variables --
---------------
local QBCore = exports['qb-core']:GetCoreObject()

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local MeterObjects = {
    2108567945,
}

local requiredItemsShowed = false
local requiredItems = {}

local timer = 0
local canRob = true

MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true,
}

FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
}


Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
	end
end)


function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


function IsNearParkingMeter()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for k, v in pairs(MeterObjects) do
      local closestObj = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 3.0, v, false, 0, 0)
      local objCoords = GetEntityCoords(closestObj)
      if closestObj ~= 0 then
        local dist = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, objCoords.x, objCoords.y, objCoords.z, true)
        if dist <= 1.5 then
          return true
        end
      end
    end
    return false
end


function IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
  end


function lockpickDone(success)

    local pos = GetEntityCoords(GetPlayerPed(-1))
    if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end

    if success then
        PoliceCall()
        TriggerServerEvent('qb-robparking:server:sp1d3r1987')
        print("done")

        canRob = false
        timer = 300
    else
        if math.random(1, 100) <= 40 and IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
            QBCore.Functions.Notify("You ripped your gloves..")
        end
        if math.random(1, 100) <= 10 then
            TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], "remove")
        end
    end
end



function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(GetPlayerPed(-1), 3)
    local model = GetEntityModel(GetPlayerPed(-1))
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if MaleNoHandshoes[armIndex] ~= nil and MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if FemaleNoHandshoes[armIndex] ~= nil and FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end


function PoliceCall()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local chance = 75
    if GetClockHours() >= 1 and GetClockHours() <= 6 then
        chance = 25
    end
    if math.random(1, 100) <= chance then
        local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
        local streetLabel = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        if street2 ~= nil and street2 ~= "" then 
            streetLabel = streetLabel .. " " .. street2
        end
        local gender = "Man"
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = "Woman"
        end
        local msg = "Parking meter robbery " .. gender .." at " .. streetLabel
        TriggerServerEvent("police:server:ParkingRobberyCall", pos, msg, gender, streetLabel)
-- Linden outlaw alerts below this line --
        local data = {displayCode = '211', description = 'Robbery', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Parking Meter Robbery'}
        local dispatchData = {dispatchData = data, caller = 'Alarm', streetLabel}
        TriggerEvent('wf-alerts:svNotify', dispatchData, gender)
-- Linden outlaw alerts Above this line --
        print("alert")
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        inRange = false
        local pos = GetEntityCoords(GetPlayerPed(-1))

        requiredItems = {
            [1] = {name = QBCore.Shared.Items["lockpick"]["name"], image = QBCore.Shared.Items["lockpick"]["image"]},
        }

        if IsNearParkingMeter() then
            inRange = true
            DrawText3Ds(pos.x, pos.y, pos.z, '[E] Rob Parking Meter')

            if IsControlJustPressed(1, Keys["E"])  then
                if (IsInVehicle()) then
                    QBCore.Functions.Notify('You cannot rob a parking meter in a vehicle!', 'error')
                else
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)

                        if result == true then
                            if canRob == true then
                                TriggerServerEvent('qb-hud:Server:GainStress', 1) 
                                TriggerEvent("qb-lockpick:client:openLockpick", lockpickDone)
                            else
                                QBCore.Functions.Notify('You are robbing a parking meter too soon, you have to wait '..timer..' seconds', 'error')
                            end
                        else
                            QBCore.Functions.Notify('You do not have the necessary tools!', 'error')
                        end
                    end, "lockpick")
                end
            end

            if not requiredItemsShowed then
                requiredItemsShowed = true
                TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            end
        end


        if not inRange then
            if requiredItemsShowed then
                requiredItemsShowed = false
                TriggerEvent('inventory:client:requiredItems', requiredItems, false)
            end
            Citizen.Wait(1500)
          end
	end
end)


Citizen.CreateThread(function()
    while true do
        if canRob == false then
            if timer < 0 then
                timer = 0
                canRob = true
            else
                if timer == 0 then
                    canRob = true
                else
                    timer = timer - 60
                end
            end
        end
        Citizen.Wait(60000)
    end
end)

