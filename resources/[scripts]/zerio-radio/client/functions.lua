Framework = exports["qb-core"]:GetCoreObject()

settings = {}

Animation = {
    Prop = GetHashKey('prop_cs_hand_radio'),
    Bone = 28422,
	Offset = vector3(0.0, 0.0, 0.0),
	Rotation = vector3(0.0, 0.0, 0.0),
	Dictionary = {
		"cellphone@",
		"cellphone@in_car@ds",
		"cellphone@str",    
		"random@arrests"
	},
	Animation = {
		"cellphone_text_in",
		"cellphone_text_out",
		"cellphone_call_listen_a",
		"generic_radio_chatter"
	}
}

isOpen = false

function open()
    if isOpen == false then
        RequestModel(Animation.Prop)
    
        while not HasModelLoaded(Animation.Prop) do
            Citizen.Wait(150)
        end

        Handle = CreateObject(Animation.Prop, 0.0, 0.0, 0.0, true, true, false)

        local bone = GetPedBoneIndex(PlayerPedId(), Animation.Bone)

        SetCurrentPedWeapon(PlayerPedId(), GetHashKey('weapon_unarmed'), true)
        AttachEntityToEntity(Handle, PlayerPedId(), bone, Animation.Offset.x, Animation.Offset.y, Animation.Offset.z, Animation.Rotation.x, Animation.Rotation.y, Animation.Rotation.z, true, false, false, false, 2, true)

        SetModelAsNoLongerNeeded(Handle)

        SetNuiFocus(true,true)
        SendNUIMessage({
            action = "open",
            data = {}
        })
        isOpen = true
    end
end

RegisterNetEvent("zerio-radio:client:open")
AddEventHandler("zerio-radio:client:open", function()
    open()
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false,false)
    isOpen = false

    local dictionaryType = 1 + (IsPedInAnyVehicle(PlayerPedId(), false) and 1 or 0)
    local animationType = 1 + (isOpen and 0 or 1)
    local dictionary = Animation.Dictionary[dictionaryType]
    local animation = Animation.Animation[animationType]

    TaskPlayAnim(PlayerPedId(), dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)

    Citizen.Wait(700)

    StopAnimTask(PlayerPedId(), dictionary, animation, 1.0)

    NetworkRequestControlOfEntity(Handle)

    while not NetworkHasControlOfEntity(Handle) do
        Citizen.Wait(0)
    end
    
    DetachEntity(Handle, true, false)
    DeleteEntity(Handle)
end)

Citizen.CreateThread(function()
    while true do
        if isOpen then
            local dictionaryType = 1 + (IsPedInAnyVehicle(PlayerPedId(), false) and 1 or 0)
            local animationType = 1 + (isOpen and 0 or 1)
            local dictionary = Animation.Dictionary[dictionaryType]
            local animation = Animation.Animation[animationType]
    
            RequestAnimDict(dictionary)
    
            while not HasAnimDictLoaded(dictionary) do
                Citizen.Wait(150)
            end
            
            if IsEntityPlayingAnim(PlayerPedId(), dictionary, animation, 3) ~= 1 then
                TaskPlayAnim(PlayerPedId(), dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
            end
            Citizen.Wait(500)
        else
            Citizen.Wait(1000)
        end
    end
end)