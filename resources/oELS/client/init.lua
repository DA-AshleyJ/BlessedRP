--[[------------------------------------------------------------------------------
  -- File         : /client/init.lua
  -- Created Date : Monday April 27 2020
  -- Purpose      : Entrypoint for the program. Manages keys and activations
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

-- Global Variables --
AllowedVehicles = {} -- Vehicles that we have ELS for
EnabledVehicles = {} -- Vehicles that have used ELS
CurrentStage = 0 -- Front, Rear, Off

------------------------------------------------------------------------------
--- Appends vehicle to a table of vehicles
-- Description of what it does
-- @param vehicle the vehicle to be added
function AddVehicleToTables(vehicle)
    if EnabledVehicles[vehicle] == nil then
        EnabledVehicles[vehicle] = {
            primary = false,
            secondary = false,
            warning = false,
            ally = false,
            onscene = false,
            frontPrimary = false,
            backPrimary = false,
            wigWags = false,

            spotlight = false,
            spotlightZ = 0,
            spotlightY = 0,
            spotlightX = 0,

            siren = 0,
            sound = nil,

            indicator = 0,
            stage = 0
        }

        for extra=1, 12 do
            SetVehicleExtra(vehicle, extra, true)
        end

        resetExtras(vehicle)

        Citizen.CreateThread(function()
            EnviromentalLights(vehicle)
        end)
    end
end

------------------------------------------------------------------------------
--- Loads every vehicle into allowedVehicle from a vehicles.json
function LoadVehicleJsons()
    local scriptName = GetCurrentResourceName()
    local vehiclesList = json.decode(LoadResourceFile(scriptName, "els/vehicles.json"))

    for i, fileName in ipairs(vehiclesList) do
        --DebugPrint(' Parsing file ' .. fileName)

        local dataFile = LoadResourceFile(scriptName, "els/" .. fileName .. ".json")

        if dataFile then
            jsonData = json.decode(dataFile)

            AllowedVehicles[fileName] = jsonData
        else
            --DebugPrint("Unable to find file " .. fileName .. ".json")
            --print('[ELS WARN] Unable to find ELS file for ' .. fileName)
        end
    end
end

------------------------------------------------------------------------------
--- Gets the current hash key from the models ID
-- Returns the model name of the vehicle from the models ID if the vehicle is in the allowed vehicles list else false
-- @param carId The id of a model of car
-- @return allowedVehicle The model name of the vehicle
function GetCarHash(vehicleId)
    local vehicle = GetEntityModel(vehicleId)

    if vehicle then
        for allowedVehicle, _ in pairs(AllowedVehicles) do
            if vehicle == GetHashKey(allowedVehicle) then
                return allowedVehicle
            end
        end
    end

    return false
end
