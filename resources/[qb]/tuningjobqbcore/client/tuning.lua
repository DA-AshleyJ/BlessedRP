
local QBCore = exports['qb-core']:GetCoreObject()

-- Turbo Events
RegisterNetEvent('6scripts-tuning:client:applyTurbo', function()
	local playerPed	= PlayerPedId()
    local coords	= GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
		QBCore.Functions.Notify("Cannot Install while inside vehicle", "error", 3500)
        ClearPedTasks(playerPed)
        return
    end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		end
		if DoesEntityExist(vehicle) then
			local plate = GetVehicleNumberPlateText(vehicle)
			if Config.isVehicleOwned then
				QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
					if owned then
						AnimationPlay("mini@repair", "fixing_a_ped", 35000)
						SetVehicleEngineOn(vehicle, false, false, true)
						SetVehicleDoorOpen(vehicle, 4, false, false)
							local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
							Skillbar.Start({
								duration = math.random(2500,5000),
								pos = math.random(10, 30),
								width = math.random(10, 20),
							}, function()
								QBCore.Functions.Notify("Success! Installing Turbo", "success", 3500)
								FreezeEntityPosition(playerPed, true)
								time = math.random(7000,10000)
								QBCore.Functions.Progressbar("", "Installing Turbo", time, false, true, {
									disableMovement = false,
									disableCarMovement = false,
									disableMouse = false,
									disableCombat = true,
								}, {}, {}, {}, function() -- Done
								ClearPedTasks(playerPed)
								SetVehicleModKit(vehicle, 0)
								ToggleVehicleMod(vehicle, 18, true)
								SetVehicleDoorShut(vehicle, 4, false)
								FreezeEntityPosition(playerPed, false)
								SetVehicleEngineOn(vehicle, true, true)
								Car = QBCore.Functions.GetVehicleProperties(vehicle)
								TriggerServerEvent('6scripts-tuning:server:UpdateVehicle', Car)
								TriggerServerEvent('6scripts-tuning:server:Turbo')
								end)
							end, function()
								QBCore.Functions.Notify("Turbo installation failed!", "error", 3500)
								ClearPedTasks(playerPed)
							end)
					else
						QBCore.Functions.Notify("Nobody owns this vehicle", "error", 3500)
					end
				end, plate)
			else
				AnimationPlay("mini@repair", "fixing_a_ped", 35000)
				SetVehicleEngineOn(vehicle, false, false, true)
				SetVehicleDoorOpen(vehicle, 4, false, false)
					local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
					Skillbar.Start({
						duration = math.random(2500,5000),
						pos = math.random(10, 30),
						width = math.random(10, 20),
					}, function()
						QBCore.Functions.Notify("Success! Installing Turbo", "success", 3500)
						FreezeEntityPosition(playerPed, true)
						time = math.random(7000,10000)
						QBCore.Functions.Progressbar("", "Installing Turbo", time, false, true, {
							disableMovement = false,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = true,
						}, {}, {}, {}, function() -- Done
						ClearPedTasks(playerPed)
						SetVehicleModKit(vehicle, 0)
						ToggleVehicleMod(vehicle, 18, true)
						SetVehicleDoorShut(vehicle, 4, false)
						FreezeEntityPosition(playerPed, false)
						SetVehicleEngineOn(vehicle, true, true)
						CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
						TriggerServerEvent('6scripts-tuning:server:UpdateVehicle', CurrentVehicleData)
						TriggerServerEvent('6scripts-tuning:server:Turbo')
						end)
					end, function()
						QBCore.Functions.Notify("Turbo installation failed!", "error", 3500)
						ClearPedTasks(playerPed)
					end)
				
			end
		end
	else
		QBCore.Functions.Notify("There is no vehicle nearby", "error", 3500)
	end
end)

function AnimationPlay(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(1000) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

-- Headlights

RegisterNetEvent('6scripts-tuning:client:applyXenons', function()
	local playerPed	= PlayerPedId()
    local coords	= GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
		QBCore.Functions.Notify("Cannot Install while inside vehicle", "error", 3500)
        ClearPedTasks(playerPed)
        return
    end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		end
		if DoesEntityExist(vehicle) then
			if Config.isVehicleOwned then
				local plate = GetVehicleNumberPlateText(vehicle)
				QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
					if owned then
						AnimationPlay("mini@repair", "fixing_a_ped", 35000)
							local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
							Skillbar.Start({
								duration = math.random(2500,5000),
								pos = math.random(10, 30),
								width = math.random(10, 20),
							}, function()
								QBCore.Functions.Notify("Success! Installing Xenon Headlights", "success", 3500)
								FreezeEntityPosition(playerPed, true)
								time = math.random(3000,7000)
								-- TriggerEvent('pogressBar:drawBar', time, 'Installing Xenon Headlights')
								QBCore.Functions.Progressbar("", "Installing Xenon Headlights", time, false, true, {
									disableMovement = false,
									disableCarMovement = false,
									disableMouse = false,
									disableCombat = true,
								}, {}, {}, {}, function() -- Done
									SetVehicleModKit(vehicle, 0)
									ToggleVehicleMod(vehicle, 22, true)
									ClearPedTasks(playerPed)
									FreezeEntityPosition(playerPed, false)
									CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
									TriggerServerEvent('6scripts-tuning:server:UpdateVehicle', CurrentVehicleData)
									TriggerServerEvent('6scripts-tuning:server:Xenon')
								end)
							end, function()
								QBCore.Functions.Notify("Xenon Headlight installation failed!", "error", 3500)
								ClearPedTasks(playerPed)
							end)
						
					else
						QBCore.Functions.Notify("Nobody owns this vehicle", "error", 3500)
					end
				end, plate)
			else
				AnimationPlay("mini@repair", "fixing_a_ped", 35000)
					local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
					Skillbar.Start({
						duration = math.random(2500,5000),
						pos = math.random(10, 30),
						width = math.random(10, 20),
					}, function()
						QBCore.Functions.Notify("Success! Installing Xenon Headlights", "success", 3500)
						FreezeEntityPosition(playerPed, true)
						time = math.random(3000,7000)
						QBCore.Functions.Progressbar("", "Installing Xenon Headlights", time, false, true, {
							disableMovement = false,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = true,
						}, {}, {}, {}, function() -- Done
						SetVehicleModKit(vehicle, 0)
						ToggleVehicleMod(vehicle, 22, true)
						ClearPedTasks(playerPed)
						FreezeEntityPosition(playerPed, false)
						CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
						TriggerServerEvent('6scripts-tuning:server:UpdateVehicle', CurrentVehicleData)
						TriggerServerEvent('6scripts-tuning:server:Xenon')
						end)
					end, function()
						QBCore.Functions.Notify("Xenon Headlight installation failed!", "error", 3500)
						ClearPedTasks(playerPed)
					end)
			end
		end
	else
		QBCore.Functions.Notify("There is no vehicle nearby", "error", 3500)
	end
end)

RegisterNetEvent('6scripts-tuning:client:xenonMenu', function()
	local playerPed	= PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed)
		local plate = GetVehicleNumberPlateText(vehicle)
		if Config.isVehicleOwned then
			QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
				if owned then
					xenonControllerMenu()
				else
					QBCore.Functions.Notify("Nobody owns this vehicle", "error", 3500)
				end
			end, plate)
		else
			xenonControllerMenu()
		end
	else
		QBCore.Functions.Notify("You need to be inside a vehicle to use this", "error", 3500)
    end
end)

RegisterNetEvent('6scripts-tuning:client:applyXenonColor', function(args) 
    local args = tonumber(args)
    local playerPed	= PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
    xenonControllerMenu()
	if args == 1 then 
		SetVehicleHeadlightsColour(vehicle, 0)
    elseif args == 2 then 
		SetVehicleHeadlightsColour(vehicle, -1)      
    elseif args == 3 then 
		SetVehicleHeadlightsColour(vehicle, 1)    
    elseif args == 4 then 
		SetVehicleHeadlightsColour(vehicle, 2)    
    elseif args == 5 then
		SetVehicleHeadlightsColour(vehicle, 3)
	elseif args == 6 then
		SetVehicleHeadlightsColour(vehicle, 4)    
	elseif args == 7 then
		SetVehicleHeadlightsColour(vehicle, 5)    
	elseif args == 8 then
		SetVehicleHeadlightsColour(vehicle, 6)    
	elseif args == 9 then
		SetVehicleHeadlightsColour(vehicle, 7)    
	elseif args == 10 then
		SetVehicleHeadlightsColour(vehicle, 8)    
	elseif args == 11 then
		SetVehicleHeadlightsColour(vehicle, 9)   
	elseif args == 12 then
		SetVehicleHeadlightsColour(vehicle, 10)    
	elseif args == 13 then
		SetVehicleHeadlightsColour(vehicle, 11)    
	elseif args == 14 then
		SetVehicleHeadlightsColour(vehicle, 12)    
    else
        exports['qb-menu']:closeMenu()
        CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
        TriggerServerEvent('6scripts-tuning:server:UpdateVehicle', CurrentVehicleData)
    end
end)

function xenonControllerMenu()
    exports['qb-menu']:openMenu({
		{
            header = "Xenon Menu",
            txt = "adjust vehicle headlight color",
            isMenuHeader = true
        },
		{
            header = "Stock",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 1
            }
        },
        {
            header = "Ice blue",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 2
            }
        },
		{
            header = "Blue",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 3
            }
        },
		{
            header = "Electric Blue",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 4
            }
        },
		{
            header = "Mint Green",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 5
            }
        },
		{
            header = "Lime Green",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 6
            }
        },
		{
            header = "Yellow",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 7
            }
        },
		{
            header = "Golden",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 8
            }
        },
		{
            header = "Orange",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 9
            }
        },
		{
            header = "Red",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 10
            }
        },
		{
            header = "Pony Pink ",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 11
            }
        },
		{
            header = "Hot Pink",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 12
            }
        },
		{
            header = "Purple",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 13
            }
        },
		{
            header = "Blacklight",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 14
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "6scripts-tuning:client:applyXenonColor",
				args = 15
            }
        },
    })
end

RegisterNetEvent('6scripts-tuning:client:SuspensionMenu', function() 
    local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
    local plate = GetVehicleNumberPlateText(vehicle)
	
    if IsPedSittingInAnyVehicle(playerPed) then
		QBCore.Functions.Notify("Cannot adjust suspension while inside vehicle", "error", 3500)
        ClearPedTasks(playerPed)
        return
    end
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		end
		if DoesEntityExist(vehicle) then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
				if Config.isVehicleOwned then
					QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
						if owned then
							MenuForSuspension()
							TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true) 
						else
							QBCore.Functions.Notify("Nobody owns this vehicle", "error", 3500)
						end
					end, plate)
				else
					MenuForSuspension()
					TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true) 
				end
            else
            QBCore.Functions.Notify("You are missing suspension wrenches", "error", 3500)
			end
            end, 'suspension_wrenches') 
		end
	else
        exports['mythic_notify']:DoHudText('error', 'There is no vehicle nearby')
	end
end)

local wheels = {
    "wheel_lf",
    "wheel_rf",
    "wheel_lm1",
    "wheel_rm1",
    "wheel_lm2",
    "wheel_rm2",
    "wheel_lm3",
    "wheel_rm3",
    "wheel_lr",
    "wheel_rr",
}

RegisterNetEvent('6scripts-tuning:client:InstallSuspension', function(args) 
    local args = tonumber(args)
    local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
    SetVehicleModKit(vehicle, 0)
    -- MenuForSuspension()
	if args == 1 then 
        SetVehicleMod(vehicle, 15, 4, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
		TriggerServerEvent('6scripts-tuning:server:Suspension')
    elseif args == 2 then 
        SetVehicleMod(vehicle, 15, 0, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
		TriggerServerEvent('6scripts-tuning:server:Suspension')
    elseif args == 3 then 
        SetVehicleMod(vehicle, 15, 1, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
		TriggerServerEvent('6scripts-tuning:server:Suspension')
    elseif args == 4 then 
        SetVehicleMod(vehicle, 15, 2, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
		TriggerServerEvent('6scripts-tuning:server:Suspension')
    elseif args == 5 then
        SetVehicleMod(vehicle, 15, 3, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
		TriggerServerEvent('6scripts-tuning:server:Suspension')
    else
        exports['qb-menu']:closeMenu()
		ClearPedTasks(playerPed)
    end
end)

AddEventHandler('6scripts-tuning:client:TooLazyToThinkForaName', function ()
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
	exports['qb-menu']:closeMenu()
	ClearPedTasks(playerPed)
	
	CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
    TriggerServerEvent('6scripts-tuning:server:UpdateVehicle', CurrentVehicleData)
end)

function MenuForSuspension()
    exports['qb-menu']:openMenu({
		{
            header = "Coilover Menu",
            txt = "adjust vehicle height",
            isMenuHeader = true
        },
        {
            header = "Stock",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallSuspension",
				args = 1
            }
        },
        {
            header = "Stage 1",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallSuspension",
				args = 2
            }
        },
		{
            header = "Stage 2",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallSuspension",
				args = 3
            }
        },
        {
            header = "Stage 3",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallSuspension",
				args = 4
            }
        },
        {
            header = "Stage 4",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallSuspension",
				args = 5
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallSuspension",
				args = 6
            }
        },
    })
end

-- Engine Part
RegisterNetEvent('6scripts-tuning:client:EngineMenu', function() 
    local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
		QBCore.Functions.Notify("Cannot change engine while inside vehicle", "error", 3500)
        return
    end
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
    local plate = GetVehicleNumberPlateText(vehicle)

    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		end
		if DoesEntityExist(vehicle) then
				if Config.isVehicleOwned then
					QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
						if owned then
							MenuEngine()
						else
							QBCore.Functions.Notify("Nobody owns this vehicle", "error", 3500)
						end
					end, plate)
				else
					MenuEngine(vehicle)
				end
		end
	else
        exports['mythic_notify']:DoHudText('error', 'There is no vehicle nearby')
	end
end)

function MenuEngine(vehicle)
	SetVehicleDoorOpen(vehicle, 4, false, false)
	Wait(1000)
	AnimationPlay("mini@repair", "fixing_a_ped", 35000)
    exports['qb-menu']:openMenu({
		{
            header = "Engine Menu",
            txt = "change vehicle engine",
            isMenuHeader = true
        },
        {
            header = "Stock",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallEngine",
				args = 1
            }
        },
        {
            header = "Stage 1",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallEngine",
				args = 2
            }
        },
		{
            header = "Stage 2",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallEngine",
				args = 3
            }
        },
        {
            header = "Stage 3",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallEngine",
				args = 4
            }
        },
        {
            header = "Stage 4",
            txt = "",
            params = {
                event = "6scripts-tuning:client:InstallEngine",
				args = 5
            }
        },
    })
end

RegisterNetEvent('6scripts-tuning:client:InstallEngine', function(args) 
	local time = math.random(6000,10000)
	local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
	Skillbar.Start({
	duration = math.random(2500,5000),
	pos = math.random(3, 30),
	width = math.random(2, 10),
	}, function()
	QBCore.Functions.Notify("Success! Installing Engine", "success", 3500)
	time = math.random(7000,10000)
	QBCore.Functions.Progressbar("", "Installing Engine", time, false, true, {
	disableMovement = false,
	disableCarMovement = false,
	disableMouse = false,
	disableCombat = true,
	}, {}, {}, {}, function() -- Done
	local args = tonumber(args)
    local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
	SetVehicleDoorShut(vehicle, 4, false)
	SetVehicleModKit(vehicle, 0)
	TriggerServerEvent('6scripts-tuning:server:Engine')
	if args == 1 then 
        SetVehicleMod(vehicle, 11, 4, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')

    elseif args == 2 then 
        SetVehicleMod(vehicle, 11, 0, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
    elseif args == 3 then 
        SetVehicleMod(vehicle, 11, 1, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
    elseif args == 4 then 
        SetVehicleMod(vehicle, 11, 2, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
    elseif args == 5 then
        SetVehicleMod(vehicle, 11, 3, false)
		TriggerEvent('6scripts-tuning:client:TooLazyToThinkForaName')
	end
	end)
	end, function()
		QBCore.Functions.Notify("Engine installation failed!", "error", 3500)
		ClearPedTasks(playerPed)
	end)
end)

-- Nitrous System
local NitrousActivated = false
local VehicleNitrous = {}
local Fxs = {}

local function trim(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('nitrous:GetNosLoadedVehs', function(vehs)
        VehicleNitrous = vehs
    end)
end)

RegisterNetEvent('6scripts-tuning:client:LoadNitrous', function()
    local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if not NitrousActivated then
        if IsInVehicle and not IsThisModelABike(GetEntityModel(GetVehiclePedIsIn(ped))) then
            if GetPedInVehicleSeat(veh, -1) == ped then
                QBCore.Functions.Progressbar("use_nos", "Connecting NOS...", 1000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['nos'], "remove")
                    TriggerServerEvent("QBCore:Server:RemoveItem", 'nos', 1)
                    local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
                    local Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
                    TriggerServerEvent('nitrous:server:LoadNitrous', Plate)
                end)
            else
                QBCore.Functions.Notify("You cannot do that from this seat!", "error")
            end
        else
            QBCore.Functions.Notify('You\'re Not In A Car', 'error')
        end
    else
        QBCore.Functions.Notify('You Already Have NOS Active', 'error')
    end
end)

local nosupdated = false

CreateThread(function()
    while true do
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
        if IsInVehicle then
            local Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
            if VehicleNitrous[Plate] ~= nil then
                if VehicleNitrous[Plate].hasnitro then
                    if IsControlJustPressed(0, 36) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
                        SetVehicleEnginePowerMultiplier(CurrentVehicle, Config.NitroBoost)
                        SetVehicleEngineTorqueMultiplier(CurrentVehicle, Config.NitroBoost)
                        SetEntityMaxSpeed(CurrentVehicle, 999.0)
                        NitrousActivated = true

                        CreateThread(function()
                            while NitrousActivated do
                                if VehicleNitrous[Plate].level - 1 ~= 0 then
                                    TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - 1))
                                    TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, true)
                                else
                                    TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                    NitrousActivated = false
                                    SetVehicleBoostActive(CurrentVehicle, 0)
                                    SetVehicleEnginePowerMultiplier(CurrentVehicle, LastEngineMultiplier)
                                    SetVehicleEngineTorqueMultiplier(CurrentVehicle, 1.0)
                                    StopScreenEffect("RaceTurbo")
                                    for index,_ in pairs(Fxs) do
                                        StopParticleFxLooped(Fxs[index], 1)
                                        TriggerServerEvent('nitrous:server:StopSync', trim(GetVehicleNumberPlateText(CurrentVehicle)))
                                        Fxs[index] = nil
                                    end
                                end
                                Wait(100)
                            end
                        end)
                    end

                    if IsControlJustReleased(0, 36) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
                        if NitrousActivated then
                            local veh = GetVehiclePedIsIn(PlayerPedId())
                            SetVehicleBoostActive(veh, 0)
                            SetVehicleEnginePowerMultiplier(veh, LastEngineMultiplier)
                            SetVehicleEngineTorqueMultiplier(veh, 1.0)
                            for index,_ in pairs(Fxs) do
                                StopParticleFxLooped(Fxs[index], 1)
                                TriggerServerEvent('nitrous:server:StopSync', trim(GetVehicleNumberPlateText(veh)))
                                Fxs[index] = nil
                            end
                            StopScreenEffect("RaceTurbo")
                            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, false)
                            NitrousActivated = false
                        end
                    end
                end
            else
                if not nosupdated then
                    TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
                    nosupdated = true
                end
                StopScreenEffect("RaceTurbo")
            end
        else
            if nosupdated then
                nosupdated = false
            end
            StopScreenEffect("RaceTurbo")
            Wait(1500)
        end
        Wait(300)
    end
end)

exhaust_places = {
	"exhaust",
	"exhaust_2",
	"exhaust_3",
	"exhaust_4",
	"exhaust_5",
	"exhaust_6",
	"exhaust_7",
	"exhaust_8",
	"exhaust_9",
	"exhaust_10",
	"exhaust_11",
	"exhaust_12",
	"exhaust_13",
	"exhaust_14",
	"exhaust_15",
	"exhaust_16",
}

ParticleDict = "veh_xs_vehicle_mods"
ParticleFx = "veh_nitrous"
ParticleSize = 1.4

CreateThread(function()
    while true do
        if NitrousActivated then
            local veh = GetVehiclePedIsIn(PlayerPedId())
            if veh ~= 0 then
                TriggerServerEvent('nitrous:server:SyncFlames', VehToNet(veh))
                SetVehicleBoostActive(veh, 1)
                StartScreenEffect("RaceTurbo", 0.0, 0)

                for _,bones in pairs(exhaust_places) do
                    if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                        if Fxs[bones] == nil then
                            RequestNamedPtfxAsset(ParticleDict)
                            while not HasNamedPtfxAssetLoaded(ParticleDict) do
                                Wait(1000)
                            end
                            SetPtfxAssetNextCall(ParticleDict)
                            UseParticleFxAssetNextCall(ParticleDict)
                            Fxs[bones] = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.02, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)

local NOSPFX = {}

RegisterNetEvent('nitrous:client:SyncFlames', function(netid, nosid)
    local veh = NetToVeh(netid)
    if veh ~= 0 then
        local myid = GetPlayerServerId(PlayerId())
        if NOSPFX[trim(GetVehicleNumberPlateText(veh))] == nil then
            NOSPFX[trim(GetVehicleNumberPlateText(veh))] = {}
        end
        if myid ~= nosid then
            for _,bones in pairs(exhaust_places) do
                if NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones] == nil then
                    NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones] = {}
                end
                if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                    if NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones].pfx == nil then
                        RequestNamedPtfxAsset(ParticleDict)
                        while not HasNamedPtfxAssetLoaded(ParticleDict) do
                            Wait(1000)
                        end
                        SetPtfxAssetNextCall(ParticleDict)
                        UseParticleFxAssetNextCall(ParticleDict)
                        NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones].pfx = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.05, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)

                    end
                end
            end
        end
    end
end)

RegisterNetEvent('nitrous:client:StopSync', function(plate)
    for k, v in pairs(NOSPFX[plate]) do
        StopParticleFxLooped(v.pfx, 1)
        NOSPFX[plate][k].pfx = nil
    end
end)

RegisterNetEvent('nitrous:client:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
end)

RegisterNetEvent('nitrous:client:LoadNitrous', function(Plate)
    VehicleNitrous[Plate] = {
        hasnitro = true,
        level = 100,
    }
    local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then
        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, false)
    end
end)

RegisterNetEvent('nitrous:client:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then
        NitrousActivated = false
        TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
    end
end)

-- Dyno Part
