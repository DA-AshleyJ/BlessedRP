Config = {}

Config.ferryModel = "ferry"
Config.AttachNotify = true
Config.NotiLoadMessage = "Vehicle attached to ferry"
Config.rampInstant = true
RegisterKeyMapping('+ferryiAttach', 'Attach/Detach Vehicle', 'keyboard', 'g')
RegisterKeyMapping('+ferryiInteract', 'Interact with Ferry', 'keyboard', 'e')
RegisterKeyMapping('+ferryiWarp', 'Get in attached vehicle', 'keyboard', 'f')