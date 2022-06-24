--[[------------------------------------------------------------------------------
  -- File         : /client/keyPress.lua
  -- Created Date : Monday April 27 2020
  -- Purpose      : Entrypoint for the program. Manages keys and activations
  -- Author       : Will North, Owen Morgan, Tom Sirett
  -- *****
  -- Licence      : TBC
--]]------------------------------------------------------------------------------

Citizen.CreateThread(function()
    RequestAmbientAudioBank("DLC_WMSIRENS\\SIRENPACK_ONE", false)
    RequestAmbientAudioBank("DLC_XCUSTOM\\XSIRENS_TWO", false)
    RequestAmbientAudioBank("DLC_XCUSTOM\\XSIRENS_THREE", false)
    RequestAmbientAudioBank("DLC_XCUSTOM\\XSIRENS_FOUR", false)
    RequestAmbientAudioBank("DLC_XCUSTOM\\XSIRENS_FIVE", false)
    RequestAmbientAudioBank("DLC_XCUSTOM\\ELS_SOUNDS", false)
    
    LoadVehicleJsons()

    while true do
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(playerPed)
        if vehicle ~= 0 then
            local vehicleHash = GetCarHash(vehicle)

            -- Indicators

            DisableControlAction(0, Config.keyboard.indicatorLeft, true)
            DisableControlAction(0, Config.keyboard.indicatorRight, true)
            DisableControlAction(0, Config.keyboard.hazards, true)
            
            if GetLastInputMethod(0) then
                if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                    if IsDisabledControlJustReleased(1, Config.keyboard.indicatorLeft) then
                        DebugPrint("Left Indicator")
                        if GetVehicleIndicatorLights(vehicle) == 1 then
                            DebugPrint("Indicator is on")
                            TriggerServerEvent("ELS:UpdateIndicator", 1, 0)
                        else
                            DebugPrint("Indicator is off")
                            TriggerServerEvent("ELS:UpdateIndicator", 1, 1)
                        end
                    end

                    if IsDisabledControlJustReleased(1, Config.keyboard.indicatorRight) then
                        if GetVehicleIndicatorLights(vehicle) == 2 then
                            DebugPrint("Indicator is on")
                            TriggerServerEvent("ELS:UpdateIndicator", 0, 0)
                        else
                            DebugPrint("Indicator is off")
                            TriggerServerEvent("ELS:UpdateIndicator", 0, 1)
                        end
                    end

                    if IsDisabledControlJustReleased(1, Config.keyboard.hazards) then
                        if GetVehicleIndicatorLights(vehicle) == 3 then
                            TriggerServerEvent("ELS:UpdateIndicator", 0, 0)
                            TriggerServerEvent("ELS:UpdateIndicator", 1, 0)
                        else
                            TriggerServerEvent("ELS:UpdateIndicator", 0, 1)
                            TriggerServerEvent("ELS:UpdateIndicator", 1, 1)
                        end
                    end
                end
            end

            if AllowedVehicles[vehicleHash] and CanControlELS(vehicle, playerPed) then
                if EnabledVehicles[vehicle] == nil then
                    AddVehicleToTables(vehicle)
                end
                
                DisableControlAction(0, Config.keyboard.primaryLights, true)
                DisableControlAction(0, Config.keyboard.secondaryLights, true)
                DisableControlAction(0, Config.keyboard.warningLights, true)
                DisableControlAction(0, Config.keyboard.sirenToggle, true)
                DisableControlAction(0, Config.keyboard.sirenSwitch, true)
                DisableControlAction(0, Config.keyboard.bullhorn, true)

                DisableControlAction(0, Config.controller.primaryLights, true)
                DisableControlAction(0, Config.controller.sirenToggle, true)
                DisableControlAction(0, Config.controller.sirenSwitch, true)
                DisableControlAction(0, Config.controller.bullhorn, true)

                DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK
                DisableControlAction(0, 73, true) -- INPUT_VEH_DUCK
                DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
                DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK
                DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK
                DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
                DisableControlAction(0, 85, true) -- INPUT_VEH_PREV_RADIO
                DisableControlAction(0, 58, true) -- INPUT_SELECT_WEAPON_MELEE
                DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM
                DisableControlAction(1, 80, true) -- INPUT_VEH_CIN_CAM

                SetVehRadioStation(vehicle, "OFF")
                SetVehicleRadioEnabled(vehicle, false)
                SetVehicleAutoRepairDisabled(vehicle, true)
                DisableVehicleImpactExplosionActivation(vehicle, true)

                -- Keyboard Support

                if GetLastInputMethod(0) then
                    -- Primary Lights

                    if IsDisabledControlJustReleased(1, Config.keyboard.primaryLights) then
                        if string.sub(vehicleHash, 0, 3) ~= 'LAS' then
                            PlaySoundFrontend(-1, "optilink", "DLC_ELS_SOUNDSET", true)
                        end

                        DebugPrint("Primary lights toggled.")

                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        if EnabledVehicles[vehicle].stage == 0 then
                            if string.sub(vehicleHash, 0, 3) == 'LAS' then
                                PlaySoundFrontend(-1, "999mode", "DLC_ELS_SOUNDSET", true)
                            end
                            PlaySoundFrontend(-1, "999mode", "DLC_ELS_SOUNDSET", true)
                            -- Primaries Only
                            TriggerServerEvent("ELS:UpdateStatus", "primary", true)
                            TriggerServerEvent("ELS:UpdateStage", 1)
                        elseif EnabledVehicles[vehicle].stage == 1 then
                            TriggerServerEvent("ELS:UpdateStatus", "backPrimary", false)
                            TriggerServerEvent("ELS:UpdateStatus", "secondary", false)
                            TriggerServerEvent("ELS:UpdateStage", 0)
                            --TriggerServerEvent("ELS:UpdateStatus", "backPrimary", true)
                            --TriggerServerEvent("ELS:UpdateStatus", "secondary", true)
                            --TriggerServerEvent("ELS:UpdateStage", 2)
                        else
                            -- Turn Off
                            TriggerServerEvent("ELS:UpdateStatus", "backPrimary", false)
                            TriggerServerEvent("ELS:UpdateStatus", "secondary", false)
                            TriggerServerEvent("ELS:UpdateStage", 0)
                        end
                    end

                    -- Secondary Lights

                    if IsDisabledControlJustReleased(1, Config.keyboard.secondaryLights) then
                        PlaySoundFrontend(-1, "optilink", "DLC_ELS_SOUNDSET", true)
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        DebugPrint(EnabledVehicles[vehicle].secondary)

                        TriggerServerEvent("ELS:UpdateStatus", "secondary", not EnabledVehicles[vehicle].secondary)
                    end
                    
                    -- Warning Lights

                    if IsDisabledControlJustReleased(1, Config.keyboard.warningLights) then
                        PlaySoundFrontend(-1, "optilink", "DLC_ELS_SOUNDSET", true)
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        TriggerServerEvent("ELS:UpdateStatus", "warning", not EnabledVehicles[vehicle].warning)
                    end
                    
                    -- Toggle Sirens (On/Off)

                    if IsDisabledControlJustReleased(1, Config.keyboard.sirenToggle) then
                        DebugPrint("Sirens Toggled")
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        if EnabledVehicles[vehicle].primary then
                            if EnabledVehicles[vehicle].siren == 0 then
                                TriggerServerEvent("ELS:UpdateSiren", 1)
                                DebugPrint("Sirens Toggled On")
                            else
                                TriggerServerEvent("ELS:UpdateSiren", 0)
                                DebugPrint("Sirens Toggled Off")

                                local blipId = GetSoundId()
                                PlaySoundFromEntity(blipId, "SULTAN_HORN", vehicle, 0, 0, 0)
                                Citizen.Wait(100)
                                StopSound(blipId)
                                ReleaseSoundId(blipId)

                                Citizen.Wait(100)

                                local blipId2 = GetSoundId()
                                PlaySoundFromEntity(blipId2, "SULTAN_HORN", vehicle, 0, 0, 0)
                                Citizen.Wait(100)
                                StopSound(blipId2)
                                ReleaseSoundId(blipId2)
                            end
                        end
                    end
                    
                    -- Switch Tones

                    if IsDisabledControlJustReleased(1, Config.keyboard.sirenSwitch) then
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        if EnabledVehicles[vehicle].siren ~= 0 then
                            if EnabledVehicles[vehicle].siren + 1 > #AllowedVehicles[vehicleHash].sirens.sounds then
                                TriggerServerEvent("ELS:UpdateSiren", 1)
                            else
                                TriggerServerEvent("ELS:UpdateSiren", EnabledVehicles[vehicle].siren + 1)
                            end
                        end
                    end
                    
                    -- Bullhorn Down

                    if IsDisabledControlJustPressed(1, Config.keyboard.bullhorn) then
                        DebugPrint("Bullhorn pressed")

                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        TriggerServerEvent("ELS:ToggleBullhorn", true)
                    end
                    
                    -- Bullhorn Up

                    if IsDisabledControlJustReleased(1, Config.keyboard.bullhorn) then
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        TriggerServerEvent("ELS:ToggleBullhorn", false)
                    end

                    -- Spotlight

                    if AllowedVehicles[vehicleHash].misc.spotLight.enabled then
                        DisableControlAction(0, 39, true) -- [
                        DisableControlAction(0, 124, true) -- NUMPAD 4
                        DisableControlAction(0, 125, true) -- NUMPAD 6
                        DisableControlAction(0, 126, true) -- NUMPAD 5
                        DisableControlAction(0, 127, true) -- NUMPAD 8
                        DisableControlAction(0, 314, true) -- NUMPAD +

                        if IsDisabledControlJustReleased(1, 39) then
                            if EnabledVehicles[vehicle] == nil then
                                AddVehicleToTables(vehicle)
                            end

                            TriggerServerEvent("ELS:ToggleSpotlight", not EnabledVehicles[vehicle].spotlight)
                        end

                        if IsDisabledControlJustReleased(1, 124) then
                            if EnabledVehicles[vehicle] == nil then
                                AddVehicleToTables(vehicle)
                            end

                            local heading = GetEntityHeading(vehicle)

                            if heading >= 180 and heading <= 365 then
                                EnabledVehicles[vehicle].spotlightY = EnabledVehicles[vehicle].spotlightY + 0.1
                            else
                                EnabledVehicles[vehicle].spotlightY = EnabledVehicles[vehicle].spotlightY - 0.1
                            end

                            TriggerServerEvent("ELS:UpdateSpotlight", EnabledVehicles[vehicle].spotlightX, EnabledVehicles[vehicle].spotlightY, EnabledVehicles[vehicle].spotlightZ)
                        end

                        if IsDisabledControlJustReleased(1, 125) then
                            if EnabledVehicles[vehicle] == nil then
                                AddVehicleToTables(vehicle)
                            end

                            local heading = GetEntityHeading(vehicle)

                            if heading >= 180 and heading <= 365 then
                                EnabledVehicles[vehicle].spotlightY = EnabledVehicles[vehicle].spotlightY - 0.1
                            else
                                EnabledVehicles[vehicle].spotlightY = EnabledVehicles[vehicle].spotlightY + 0.1
                            end

                            TriggerServerEvent("ELS:UpdateSpotlight", EnabledVehicles[vehicle].spotlightX, EnabledVehicles[vehicle].spotlightY, EnabledVehicles[vehicle].spotlightZ)
                        end

                        if IsDisabledControlJustReleased(1, 126) then
                            if EnabledVehicles[vehicle] == nil then
                                AddVehicleToTables(vehicle)
                            end

                            EnabledVehicles[vehicle].spotlightZ = EnabledVehicles[vehicle].spotlightZ - 0.1

                            TriggerServerEvent("ELS:UpdateSpotlight", EnabledVehicles[vehicle].spotlightX, EnabledVehicles[vehicle].spotlightY, EnabledVehicles[vehicle].spotlightZ)
                        end
                        

                        if IsDisabledControlJustReleased(1, 127) then
                            if EnabledVehicles[vehicle] == nil then
                                AddVehicleToTables(vehicle)
                            end

                            EnabledVehicles[vehicle].spotlightZ = EnabledVehicles[vehicle].spotlightZ + 0.1

                            TriggerServerEvent("ELS:UpdateSpotlight", EnabledVehicles[vehicle].spotlightX, EnabledVehicles[vehicle].spotlightY, EnabledVehicles[vehicle].spotlightZ)
                        end
                        

                        if IsDisabledControlJustReleased(1, 314) then
                            if EnabledVehicles[vehicle] == nil then
                                AddVehicleToTables(vehicle)
                            end

                            EnabledVehicles[vehicle].spotlightX = 0
                            EnabledVehicles[vehicle].spotlightY = 0
                            EnabledVehicles[vehicle].spotlightZ = 0

                            TriggerServerEvent("ELS:UpdateSpotlight", EnabledVehicles[vehicle].spotlightX, EnabledVehicles[vehicle].spotlightY, EnabledVehicles[vehicle].spotlightZ)
                        end
                    end
                else
                    -- Controller Support

                    -- Primary Lights

                    if IsDisabledControlJustReleased(1, Config.controller.primaryLights) then
                        PlaySoundFrontend(-1, "optilink", "DLC_ELS_SOUNDSET", true)
                        DebugPrint("Primary lights toggled.")

                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        if EnabledVehicles[vehicle].stage == 0 then
                            -- Primaries Only
                            TriggerServerEvent("ELS:UpdateStatus", "primary", true)
                            TriggerServerEvent("ELS:UpdateStage", 1)
                        elseif EnabledVehicles[vehicle].stage == 1 then
                            TriggerServerEvent("ELS:UpdateStatus", "backPrimary", false)
                            TriggerServerEvent("ELS:UpdateStatus", "secondary", false)
                            TriggerServerEvent("ELS:UpdateStage", 0)
                            --TriggerServerEvent("ELS:UpdateStatus", "backPrimary", true)
                            --TriggerServerEvent("ELS:UpdateStatus", "secondary", true)
                            --TriggerServerEvent("ELS:UpdateStage", 2)
                        else
                            -- Turn Off
                            TriggerServerEvent("ELS:UpdateStatus", "backPrimary", false)
                            TriggerServerEvent("ELS:UpdateStatus", "secondary", false)
                            TriggerServerEvent("ELS:UpdateStage", 0)
                        end
                    end

                    -- Toggle Sirens (On/Off)

                    if IsDisabledControlJustReleased(1, Config.controller.sirenToggle) then
                        DebugPrint("Sirens Toggled")
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        if EnabledVehicles[vehicle].primary then
                            if EnabledVehicles[vehicle].siren == 0 then
                                TriggerServerEvent("ELS:UpdateSiren", 1)
                                DebugPrint("Sirens Toggled On")
                            else
                                TriggerServerEvent("ELS:UpdateSiren", 0)
                                DebugPrint("Sirens Toggled Off")

                                local blipId = GetSoundId()
                                PlaySoundFromEntity(blipId, "SULTAN_HORN", vehicle, 0, 0, 0)
                                Citizen.Wait(100)
                                StopSound(blipId)
                                ReleaseSoundId(blipId)

                                Citizen.Wait(100)

                                local blipId2 = GetSoundId()
                                PlaySoundFromEntity(blipId2, "SULTAN_HORN", vehicle, 0, 0, 0)
                                Citizen.Wait(100)
                                StopSound(blipId2)
                                ReleaseSoundId(blipId2)
                            end
                        end
                    end
                    
                    -- Switch Tones

                    if IsDisabledControlJustReleased(1, Config.controller.sirenSwitch) then
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        if EnabledVehicles[vehicle].siren ~= 0 then
                            if EnabledVehicles[vehicle].siren + 1 > #AllowedVehicles[vehicleHash].sirens.sounds then
                                TriggerServerEvent("ELS:UpdateSiren", 1)
                            else
                                TriggerServerEvent("ELS:UpdateSiren", EnabledVehicles[vehicle].siren + 1)
                            end
                        end
                    end
                    
                    -- Bullhorn Down

                    if IsDisabledControlJustPressed(1, Config.controller.bullhorn) then
                        DebugPrint("Bullhorn pressed")

                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        TriggerServerEvent("ELS:ToggleBullhorn", true)
                    end
                    
                    -- Bullhorn Up

                    if IsDisabledControlJustReleased(1, Config.controller.bullhorn) then
                        if EnabledVehicles[vehicle] == nil then
                            AddVehicleToTables(vehicle)
                        end

                        TriggerServerEvent("ELS:ToggleBullhorn", false)
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)
