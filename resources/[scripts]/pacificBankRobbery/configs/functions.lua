function round(number, decimals) --Used to round distances. Was taken from stack overflow for ease.
    local power = 10^decimals
    return math.floor(number * power) / power
end

function randomFloat(lower, greater) --Used to make float randoms. Was taken from stack overflow for ease.
    return lower + math.random()  * (greater - lower);
end


loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function DrawText3D(x,y,z, text) --Just a simple generic 3d text function. Copy pasted from my own core. Feel free to change the 3d text here. You got x,y,z and text.
    globalWait = 10
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
      end
end

function takeAnim() --This function is used to do the take animation when cracking the register or safebox.
    local ped = GetPlayerPed(-1)
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(100)

    Citizen.CreateThread(function()
        while (IsEntityPlayingAnim(globalPlayerPed, "amb@prop_human_bum_bin@idle_b", "idle_d", 3)) do
            DisableAllControlActions(0)
            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
    RemoveAnimDict("amb@prop_human_bum_bin@idle_b")
end

function LockpickAnim() --This function is used to do the lockpicking animation while cracking the register.
    loadDict("veh@break_in@0h@p_m_one@")
    Citizen.CreateThread(function()
        while lockpicking and not registering do
            if(not IsEntityPlayingAnim(globalPlayerPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3))then
                TaskPlayAnim(globalPlayerPedId, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            end
            Citizen.Wait(100)
        end
        StopAnimTask(GetPlayerPed(-1), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
    end)
end

function _CreatePed(hash, coords, heading) --This function is used to spawn the ped.
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedDropsWeaponsWhenDead(ped, false)
    FreezeEntityPosition(ped, false)
    return ped
end

function CreateSafe()
	RequestModel(`prop_ld_int_safe_01`)
	
    while not HasModelLoaded(`prop_ld_int_safe_01`) do
        Citizen.Wait(100)
	end

	safe = CreateObject(`prop_ld_int_safe_01`, 259.10, 204.23, 109.29, true, false, false)
    SetEntityHeading(safe,GetEntityHeading(safe)+getRotation(0.225))

    safe2 = CreateObject(`prop_ld_int_safe_01`, 266.35, 214.31, 109.29, true, false, false)
    SetEntityHeading(safe2,GetEntityHeading(safe2)+getRotation(0.144))

	FreezeEntityPosition(safe,true)
    FreezeEntityPosition(safe2,true)
end

function CreateCash()
    for i = 1, #Config.PacificBank.cash do
        if not Config.PacificBank.cash[i].stolen then
            RequestModel(`hei_prop_hei_cash_trolly_01`)
            
            while not HasModelLoaded(`hei_prop_hei_cash_trolly_01`) do
                Citizen.Wait(100)
            end

            cash[i] = CreateObject(`hei_prop_hei_cash_trolly_01`, Config.PacificBank.cash[i].cashCoords.x, Config.PacificBank.cash[i].cashCoords.y, Config.PacificBank.cash[i].cashCoords.z, true, false, false)
            
            if(Config.PacificBank.cash[i].cashRotation == nil) then
                Config.PacificBank.cash[i].cashRotation = 0.00
            end

            SetEntityHeading(cash[i],GetEntityHeading(cash[i])+getRotation(0.144 + Config.PacificBank.cash[i].cashRotation))

        else
            RequestModel(`prop_gold_trolly`)
        
            while not HasModelLoaded(`prop_gold_trolly`) do
                Citizen.Wait(100)
            end
        
            if(Config.PacificBank.cash[i].cashRotation == nil) then
                Config.PacificBank.cash[i].cashRotation = 0.00
            end

            cash[i] = CreateObject(`prop_gold_trolly`, Config.PacificBank.cash[i].cashCoords.x, Config.PacificBank.cash[i].cashCoords.y, Config.PacificBank.cash[i].cashCoords.z, true, false, false)
            SetEntityHeading(cash[i],GetEntityHeading(cash[i])+getRotation(0.144 + Config.PacificBank.cash[i].cashRotation))
        end

        FreezeEntityPosition(cash[i],true)
    end
end

function getRotation(input)
	return 360/(10*input)
end

function initialiseLasers()

    laser = --1st left
    Laser.new(
        vector3(254.687, 219.774, 104.699),
        {vector3(253.328, 216.107, 100.683), vector3(254.647, 215.652, 100.683), vector3(255.875, 215.193, 100.683), vector3(256.699, 216.871, 100.683), vector3(255.13, 217.491, 100.683), vector3(253.645, 218.028, 100.683), vector3(254.503, 219.624, 100.683), vector3(255.77, 219.182, 100.683), vector3(257.305, 218.738, 100.683)},
        {travelTimeBetweenTargets = {0.1, 1.5}, waitTimeAtTargets = {0.1, 1.5}, randomTargetSelection = true, maxDistance = 5.0, name = "1left"}
    )
    
    laser2 =  --2nd left
    Laser.new(
        vector3(257.269, 218.835, 104.685),
        {vector3(257.148, 218.723, 100.683), vector3(255.9, 219.192, 100.683), vector3(254.61, 219.638, 100.683), vector3(256.614, 217.07, 100.683), vector3(255.235, 217.601, 100.683), vector3(253.989, 218.089, 100.683), vector3(253.354, 216.17, 100.683), vector3(254.6, 215.715, 100.683), vector3(255.889, 215.221, 100.683)},
        {travelTimeBetweenTargets = {0.1, 1.5}, waitTimeAtTargets = {0.1, 1.5}, randomTargetSelection = true, maxDistance = 5.0, name = "2left"}
    )

    laser3 = --1st right
    Laser.new(
      vector3(253.342, 216.008, 104.725),
      {vector3(253.324, 216.108, 100.683), vector3(254.672, 215.65, 100.683), vector3(255.911, 215.233, 100.683), vector3(253.856, 217.973, 100.683), vector3(255.269, 217.411, 100.683), vector3(256.678, 216.921, 100.683), vector3(254.632, 219.718, 100.683), vector3(255.867, 219.249, 100.683), vector3(257.269, 218.733, 100.683)},
      {travelTimeBetweenTargets = {0.1, 1.5}, waitTimeAtTargets = {0.1, 1.5}, randomTargetSelection = true, maxDistance = 5.0, name = "1right"}
    )

    laser4 = --2nd right
    Laser.new(
      vector3(255.945, 215.061, 104.731),
      {vector3(253.311, 216.146, 100.683), vector3(254.622, 215.716, 100.683), vector3(255.978, 215.178, 100.683), vector3(253.867, 217.866, 100.683), vector3(255.143, 217.378, 100.683), vector3(256.608, 216.844, 100.683), vector3(254.641, 219.727, 100.683), vector3(255.821, 219.233, 100.683), vector3(257.227, 218.753, 100.683)},
      {travelTimeBetweenTargets = {0.1, 1.5}, waitTimeAtTargets = {0.1, 1.5}, randomTargetSelection = true, maxDistance = 5.0, name = "2right"}
    )
    

    laser.onPlayerHit(function(playerBeingHit, hitPos)
        if playerBeingHit then
            StartEntityFire(globalPlayerPed)
            SetPedToRagdoll(globalPlayerPed, 1000, 1000, 0, 0, 0, 0)
            Citizen.Wait(5000)
            StopEntityFire(globalPlayerPed)
        end
    end)

    laser2.onPlayerHit(function(playerBeingHit, hitPos)
        if playerBeingHit then
            StartEntityFire(globalPlayerPed)
            SetPedToRagdoll(globalPlayerPed, 1000, 1000, 0, 0, 0, 0)
            Citizen.Wait(5000)
            StopEntityFire(globalPlayerPed)
        end
    end)

    laser3.onPlayerHit(function(playerBeingHit, hitPos)
        if playerBeingHit then
            StartEntityFire(globalPlayerPed)
            SetPedToRagdoll(globalPlayerPed, 1000, 1000, 0, 0, 0, 0)
            Citizen.Wait(5000)
            StopEntityFire(globalPlayerPed)
        end
    end)

    laser4.onPlayerHit(function(playerBeingHit, hitPos)
        if playerBeingHit then
            StartEntityFire(globalPlayerPed)
            SetPedToRagdoll(globalPlayerPed, 1000, 1000, 0, 0, 0, 0)
            Citizen.Wait(5000)
            StopEntityFire(globalPlayerPed)
        end
    end)
end


function lasersToggler(state)
    laser.setActive(state)
    laser2.setActive(state)
    laser3.setActive(state)
    laser4.setActive(state)
end

function meltDoor(id)
    dasvidania = false

    Citizen.CreateThread(function()
        local timer = GetGameTimer() + 6700
        while timer >= GetGameTimer() do
            if(IsPedDeadOrDying(globalPlayerPed) and not dasvidania)then

                dasvidania = true

                while (bag == nil or scene == nil)do
                    Citizen.Wait(100)
                end

                NetworkStopSynchronisedScene(scene)
                DeleteObject(bag)
            end
            Wait(100)
        end
    end)

    SetCurrentPedWeapon(globalPlayerPed, `WEAPON_UNARMED`, true)
    
    Citizen.Wait(500)

    while 
    (
    IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@cop@unarmed", "intro", 3) or
    IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@1h", "outro", 3)
    ) 
    do
        Citizen.Wait(100)
    end

    RequestNamedPtfxAsset("scr_ornate_heist")

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")

    RequestModel("hei_p_m_bag_var22_arm_s")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        Citizen.Wait(100)
    end

    while not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
        Citizen.Wait(100)
    end

    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(100)
    end

    SetEntityHeading(globalPlayerPedId, Config.PacificBank.doors[id].anim.h)

    Citizen.Wait(200)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(globalPlayerPedId)))

    scene = NetworkCreateSynchronisedScene(Config.PacificBank.doors[id].anim.x, Config.PacificBank.doors[id].anim.y, Config.PacificBank.doors[id].anim.z, rotx, roty, rotz + Config.PacificBank.doors[id].anim.extra, 2, false, false, 1065353216, 0, 1.3)

    bag = CreateObject(`hei_p_m_bag_var22_arm_s`, Config.PacificBank.doors[id].anim.x, Config.PacificBank.doors[id].anim.y, Config.PacificBank.doors[id].anim.z,  true,  true, false)

    SetEntityCollision(bag, false, true)

    NetworkAddPedToSynchronisedScene(globalPlayerPedId, scene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)

    SetPedComponentVariation(globalPlayerPedId, 5, 0, 0, 0)

    NetworkStartSynchronisedScene(scene)

    Citizen.Wait(2000)

    if(not dasvidania)then
        local x, y, z = table.unpack(GetEntityCoords(globalPlayerPedId))
        thermite = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)

        SetEntityCollision(thermite, false, true)
        
        AttachEntityToEntity(thermite, globalPlayerPedId, GetPedBoneIndex(globalPlayerPedId, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)

        Citizen.Wait(4000)

        DeleteObject(bag)
        SetPedComponentVariation(globalPlayerPedId, 5, 45, 0, 0)
        DetachEntity(thermite, 1, 1)
        FreezeEntityPosition(thermite, true)

        
        TriggerServerEvent("pacificBankRobbery:server:thermiteEffect", id)
        
        NetworkStopSynchronisedScene(scene)
        
        Citizen.Wait(30000)
        
        DeleteObject(thermite)
    end

    if(not dasvidania)then
        TriggerServerEvent("pacificBankRobbery:server:breakDoor", id)
    end
end

function plantBomb()

    SetCurrentPedWeapon(globalPlayerPed, `WEAPON_UNARMED`, true)
    
    Citizen.Wait(500)

    while 
    (
    IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@cop@unarmed", "intro", 3) or
    IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@1h", "outro", 3)
    ) 
    do
        Citizen.Wait(100)
    end

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")

    RequestModel("hei_p_m_bag_var22_arm_s")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        Citizen.Wait(100)
    end

    while not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
        Citizen.Wait(100)
    end

    SetEntityHeading(globalPlayerPedId, Config.PacificBank.vaultDoor.bombLocation.h)

    Citizen.Wait(200)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(globalPlayerPedId)))

    local scene = NetworkCreateSynchronisedScene(Config.PacificBank.vaultDoor.bombLocation.x, Config.PacificBank.vaultDoor.bombLocation.y, Config.PacificBank.vaultDoor.bombLocation.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)

    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, Config.PacificBank.vaultDoor.bombLocation.x, Config.PacificBank.vaultDoor.bombLocation.y, Config.PacificBank.vaultDoor.bombLocation.z,  true,  true, false)

    SetEntityCollision(bag, false, true)

    NetworkAddPedToSynchronisedScene(globalPlayerPedId, scene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)

    SetPedComponentVariation(globalPlayerPedId, 5, 0, 0, 0)

    NetworkStartSynchronisedScene(scene)

    Citizen.Wait(1000)

    local x, y, z = table.unpack(GetEntityCoords(globalPlayerPedId))
    bomb = CreateObject(`prop_ld_bomb`, x, y, z + 0.2,  true,  true, true)

    SetEntityCollision(bomb, false, true)
    
    AttachEntityToEntity(bomb, globalPlayerPedId, GetPedBoneIndex(globalPlayerPedId, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(4000)

    DeleteObject(bag)
    SetPedComponentVariation(globalPlayerPedId, 5, 45, 0, 0)
    DetachEntity(bomb, 1, 1)
    FreezeEntityPosition(bomb, true)
    SetEntityHeading(bomb, GetEntityHeading(bomb)+getRotation(0.148))
    
    NetworkStopSynchronisedScene(scene)

    TriggerServerEvent("pacificBankRobbery:server:vaultOpener", "bomb")
end

function hackPanel()

    SetCurrentPedWeapon(globalPlayerPed, `WEAPON_UNARMED`, true)

    Citizen.Wait(500)

    while 
    (
    IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@cop@unarmed", "intro", 3) or
    IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@1h", "outro", 3)
    ) 
    do
        Citizen.Wait(100)
    end

    local targetPosition, targetRotation = (vec3(GetEntityCoords(globalPlayerPedId))), vec3(GetEntityRotation(globalPlayerPedId))

    RequestAnimDict("anim@heists@ornate_bank@hack")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@hack") do
        Citizen.Wait(100)
    end

    local animation = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_enter", Config.PacificBank.vaultDoor.hackLocation.x, Config.PacificBank.vaultDoor.hackLocation.y, Config.PacificBank.vaultDoor.hackLocation.z, Config.PacificBank.vaultDoor.hackLocation.x, Config.PacificBank.vaultDoor.hackLocation.y, Config.PacificBank.vaultDoor.hackLocation.z, 0, 2)

    local animation2 = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_loop", Config.PacificBank.vaultDoor.hackLocation.x, Config.PacificBank.vaultDoor.hackLocation.y, Config.PacificBank.vaultDoor.hackLocation.z, Config.PacificBank.vaultDoor.hackLocation.x, Config.PacificBank.vaultDoor.hackLocation.y, Config.PacificBank.vaultDoor.hackLocation.z, 0, 2)

    local animation3 = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_exit", Config.PacificBank.vaultDoor.hackLocation.x, Config.PacificBank.vaultDoor.hackLocation.y, Config.PacificBank.vaultDoor.hackLocation.z, Config.PacificBank.vaultDoor.hackLocation.x, Config.PacificBank.vaultDoor.hackLocation.y, Config.PacificBank.vaultDoor.hackLocation.z, 0, 2)

    SetEntityHeading(globalPlayerPedId, Config.PacificBank.vaultDoor.hackLocation.h)

    Citizen.Wait(100)

    FreezeEntityPosition(globalPlayerPedId, true)

    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_prop_heist_card_hack_02")

    while not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_prop_heist_card_hack_02")do
        Citizen.Wait(100)
    end

    local scene = NetworkCreateSynchronisedScene(animation, targetRotation, 2, false, false, 1065353216, 0, 1.3)

    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)

    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)

    local card = CreateObject(`hei_prop_heist_card_hack_02`, targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(globalPlayerPedId, scene, "anim@heists@ornate_bank@hack", "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@hack", "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, scene, "anim@heists@ornate_bank@hack", "hack_enter_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, scene, "anim@heists@ornate_bank@hack", "hack_enter_card", 4.0, -8.0, 1)

    local scene2 = NetworkCreateSynchronisedScene(animation2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(globalPlayerPedId, scene2, "anim@heists@ornate_bank@hack", "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@hack", "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, scene2, "anim@heists@ornate_bank@hack", "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, scene2, "anim@heists@ornate_bank@hack", "hack_loop_card", 4.0, -8.0, 1)

    local scene3 = NetworkCreateSynchronisedScene(animation3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(globalPlayerPedId, scene3, "anim@heists@ornate_bank@hack", "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@hack", "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, scene3, "anim@heists@ornate_bank@hack", "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, scene3, "anim@heists@ornate_bank@hack", "hack_exit_card", 4.0, -8.0, 1)

    SetPedComponentVariation(globalPlayerPedId, 5, 0, 0, 0)

    Citizen.Wait(200)
    NetworkStartSynchronisedScene(scene)
    Citizen.Wait(6000)
    NetworkStartSynchronisedScene(scene2)
    Citizen.Wait(500)
    
    local timer = 0

        while(timer <= 15000 and not IsPedDeadOrDying(globalPlayerPed))do
            

            DrawText3D(globalPlayerCoords.x, globalPlayerCoords.y, globalPlayerCoords.z+0.10, Languages[Config.Language]['cancel'])
            DrawText3D(globalPlayerCoords.x, globalPlayerCoords.y, globalPlayerCoords.z, Languages[Config.Language]['boot'] .. " - " .. round(timer / 150, 1) .. "%")
            timer = timer + randomFloat(4.5, 8.2)

            if IsControlJustPressed(1, Config.CancelLocker) then
                timer = 16000
            end

            Citizen.Wait(5)
        end

        if timer>= 15000 and timer ~= 16000 then
            hacking = true
            TriggerEvent("mhacking:show")
            TriggerEvent("mhacking:start", math.random(2, 5), math.random(10, 15), OnMHackingDone)

            while hacking do
                Citizen.Wait(100)
            end
        
            Citizen.Wait(1500)
            NetworkStartSynchronisedScene(scene3)
            TriggerServerEvent("pacificBankRobbery:server:vaultOpener", "hack")
            Citizen.Wait(4600)
            NetworkStopSynchronisedScene(scene3)
        
            DeleteObject(bag)
            DeleteObject(laptop)
            DeleteObject(card)
        
            FreezeEntityPosition(globalPlayerPed, false)
            SetPedComponentVariation(globalPlayerPed, 5, 45, 0, 0)
        else
            Citizen.Wait(1500)
            NetworkStartSynchronisedScene(scene3)
            Citizen.Wait(4600)
            NetworkStopSynchronisedScene(scene3)
            DeleteObject(bag)
            DeleteObject(laptop)
            DeleteObject(card)
            FreezeEntityPosition(globalPlayerPed, false)
            SetPedComponentVariation(globalPlayerPed, 5, 45, 0, 0)
        end
end

function breakLocker(id)
    if(not Config.PacificBank.lockers[id].opened or not Config.PacificBank.lockers[id].busy)then

        SetCurrentPedWeapon(globalPlayerPed, `WEAPON_UNARMED`, true)
    
        Citizen.Wait(500)
    
        while 
        (
        IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@cop@unarmed", "intro", 3) or
        IsEntityPlayingAnim(globalPlayerPed, "reaction@intimidation@1h", "outro", 3)
        ) 
        do
            Citizen.Wait(100)
        end

        SetEntityCoords(globalPlayerPed, Config.PacificBank.lockers[id].lockerCoords.x, Config.PacificBank.lockers[id].lockerCoords.y, Config.PacificBank.lockers[id].lockerCoords.z-1.0, 1, 0, 0, 1)
        SetEntityHeading(globalPlayerPed, Config.PacificBank.lockers[id].lockerHeading)
        
        TaskStartScenarioInPlace(globalPlayerPedId, "WORLD_HUMAN_WELDING", 0, true)

        local timer = 0

        while(timer <= 15000 and not IsPedDeadOrDying(globalPlayerPed))do
            

            DrawText3D(globalPlayerCoords.x, globalPlayerCoords.y, globalPlayerCoords.z+0.10, Languages[Config.Language]['cancel'])
            DrawText3D(Config.PacificBank.lockers[id].lockerCoords.x, Config.PacificBank.lockers[id].lockerCoords.y, Config.PacificBank.lockers[id].lockerCoords.z, Languages[Config.Language]['breakingLocker'] .. " - " .. round(timer / 150, 1) .. "%")
            timer = timer + randomFloat(4.5, 8.2)

            if IsControlJustPressed(1, Config.CancelLocker) then
                timer = 16000
            end

            Citizen.Wait(5)
        end

        ClearAllPedProps(globalPlayerPedId)
        ClearPedTasksImmediately(globalPlayerPedId)


        if timer>= 15000 and timer ~= 16000 then
            TriggerServerEvent("pacificBankRobbery:server:stealableOpen", GetPlayerServerId(globalPlayerId), "locker", id, serverKeyGen)
            Citizen.Wait(250)
            TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", id, false)
        else
            TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", id, false)
        end
    end
end

function modeler(model, pedNumber)
    if(model ~= nil)then
        Citizen.Wait(1000)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end
        prop = CreateObject(model, 1.0, 1.0, 1.0, 1, 1, 0)
        local bone = GetPedBoneIndex(RandomPeds[pedNumber], 28422)
        AttachEntityToEntity(prop, RandomPeds[pedNumber], bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    end
end

function OnMHackingDone(success, timeremaining) --Idk why the fuck MHacking works like this but it does. You need a second function lul.
    if success then
        TriggerEvent('mhacking:hide')
        hacking = false
    else
        TriggerEvent("mhacking:start", math.random(2, 5), math.random(10, 15), OnMHackingDone)
	end
end

function stealCash(i)

    TriggerServerEvent("pacificBankRobbery:server:busyState", "cash", i, true)

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_hei_cash_trolly_01")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
        Citizen.Wait(100)
    end

    local targetPosition, targetRotation = (vec3(Config.PacificBank.cash[i].cashCoords.x, Config.PacificBank.cash[i].cashCoords.y, Config.PacificBank.cash[i].cashCoords.z+0.49)), vec3(GetEntityRotation(cash[i]))
    local animPos = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@grab_cash", "grab", targetPosition, targetRotation, 0, 2)

    FreezeEntityPosition(globalPlayerPed, true)

    local scene = NetworkCreateSynchronisedScene(targetPosition, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(globalPlayerPed, scene, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(cash[i], scene, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)


    NetworkStartSynchronisedScene(scene)

    Citizen.Wait(37000) -- 47.93 secs



    NetworkStopSynchronisedScene(scene)

    DeleteObject(bag)

    FreezeEntityPosition(globalPlayerPed, false)

    TriggerServerEvent("pacificBankRobbery:server:stealableOpen", GetPlayerServerId(globalPlayerId), "cash", i, serverKeyGen)
    Citizen.Wait(250)
    TriggerServerEvent("pacificBankRobbery:server:busyState", "cash", i, false)
end