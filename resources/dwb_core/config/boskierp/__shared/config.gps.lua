Config.GPS = {}
Config.GPS.Blips = {
    ['lost'] = {
        blip = 57,
        color = 43
    },
    ['ambulance'] = {
        blip = 57,
        color = 42,
        heliBlip = 15,
    },
    ['ambulance_on'] = {
        blip = 3,
        heliBlip = 15,
    },
    ['police'] = {
        blip = 57,
        color = 42,
        heliBlip = 15,
    },
    ['police_on'] = {
        blip = 3,
        heliBlip = 15,
    },
    ['mechanic'] = {
        blip = 57,
        color = 47,
        heliBlip = 15,
    },
    ['mechanic_on'] = {
        blip = 3,
        color = 47,
        heliBlip = 15,
    }
}

Config.GPS.Jobs = {
    ['police'] = {'police', 'sheriff'},
    ['sheriff'] = {'police', 'sheriff'},
    ['mechanic'] = {'mechanic'}
}