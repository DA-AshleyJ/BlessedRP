--[[------------------------------------------------------------------------------
  -- File         : /client/utils/utils.lua
  -- Created Date : Monday April 27 2020
  -- Purpose      : A set of utility functions to be used on the client side
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

-- Global Variables --
Debug = false

------------------------------------------------------------------------------
--- Utils function for printing out debug messages for development
-- Takes in the input and if Debug == True then prints else does nothing
-- @param input the statement to print
function DebugPrint(input)
    if Debug then
        print("[ELS DEBUG] " .. tostring(input))
    end
end

------------------------------------------------------------------------------
--- Utils function for checking if the player can control ELS
-- @param playerSeatPosition The player's seat position
-- @output boolean is the player in the correct seat to control ELS
function CanControlELS(vehicle, playerPed)
    local seats = AllowedVehicles[GetCarHash(vehicle)].misc.seatsCanControl

    for _,v in pairs(seats) do
        if GetPedInVehicleSeat(vehicle, tonumber(v)) == playerPed then
            return true
        end
    end

    return false
end

function resetExtras(vehicle)
    if EnabledVehicles[vehicle] ~= nil then
        local vehicleConfig = AllowedVehicles[GetCarHash(vehicle)]

        if vehicleConfig and vehicleConfig.extras ~= nil then
            for extra= 1, 12 do
                if vehicleConfig.extras['extra' .. extra] ~= nil then
                    if vehicleConfig.extras['extra' .. extra].enabled then
                        SetVehicleExtra(vehicle, extra, 1)
                    end
                end
            end
        end
    end
end