Config = {}

Config.Channels = {
    [911] = {
        label = "Police Radio",
        jobs = {
            "police"
        }
    }
}

Config.Locale = "en"

-- pma-voice, mumble-voip or saltychat
Config.VoiceScript = "pma-voice"

-- item -> Opens through the Config.Item itemname
-- command -> Opens through the command /radio
-- keybind -> Opens through a button press (Config.Button)
-- custom -> Opens through the event "zerio-radio:client:open"
Config.OpenType = "command"

Config.Item = "radio"
-- Full keybind list exists here, https://docs.fivem.net/docs/game-references/controls/ 
-- (Only important if Config.OpenType is keybind)
Config.Button = 318

-- ONLY FOR MUMBLE-VOIP, has to be the same as the talking key for the animation to work
Config.RadioKey = 137




-- DONT CHANGE THIS IF YOU DONT KNOW WHAT YOU ARE DOING!!!!!!!!!!!!!!!!
Config.EventNames = {
    PlayerLoaded = "QBCore:Client:OnPlayerLoaded"
}