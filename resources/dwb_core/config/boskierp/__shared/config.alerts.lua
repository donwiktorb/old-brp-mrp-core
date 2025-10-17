Config.Alerts = {
    ['10-13'] = {
        notify = {
            custom = true,
            title = "10-13",
            content = "Funkcjonariusz %s potrzebuje wsparcia",
            type = 'info'
        },
        name = '10-13',
        requiredJobs = { 'police', "sheriff", "fbi" },

        blip = {
            sprite = 119,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-13",
            wait = 160
        },
        minDist = 100.0,
        showBoth = true,
        distBlip = {
            type = 'radius',
            radius = 250.0,
            sprite = 9,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-13",
            wait = 160
        }

    },
    ['shooting'] = {


        notify = {
            custom = true,
            title = TR("shooting_title"),
            content = {
                "outlaw_shooting",
                "outlaw_shooting2",
            },
            type = 'info'
        },
        name = 'shooting',
        requiredJobs = { 'police', "sheriff", "fbi" },

        blip = {
            sprite = 119,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        },
        minDist = 100.0,
        showBoth = true,
        distBlip = {
            type = 'radius',
            radius = 250.0,
            sprite = 9,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        }
    },
   ['player_report'] = {
        notify = {
            custom = true,
            title = "Obywatel wzywa",
            content = "Tablet -> main -> przyjmij zgłoszenie",
            type = 'info'
        },
        name = 'player_report',
        requiredJobs = {"ambulance"},

        blip = {
            sprite = 119,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "Obywatel",
            wait = 160
        },
        minDist = 100.0,
        showBoth = true,
        distBlip = {
            type = 'radius',
            radius = 250.0,
            sprite = 9,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "Obywatel",
            wait = 160
        }
    },
   ['lost-gps'] = {
        notify = {
            custom = true,
            title = TR("shooting_title"),
            content = {
                "outlaw_shooting",
                "outlaw_shooting2",
            },
            type = 'lost-gps'
        },
        name = 'shooting',
        requiredJobs = { 'police', "sheriff", "fbi" },

        blip = {
            sprite = 119,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        },
        minDist = 100.0,
        showBoth = true,
        distBlip = {
            type = 'radius',
            radius = 250.0,
            sprite = 9,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        }
    },
    ['carthief_start'] = {
        notify = {
            title = TR("vehicle_stolen"),
            content = {
                "vehicle_steal2"
            },
            type = 'info'
        },
        name = 'carthief',
        requiredJobs = { 'police', "sheriff", "fbi" },
        blip = {
            -- noRemove = true,
            -- trans = 500,  -- im wieksze tym dluze jest blip
            sprite = 821,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        },
        minDist = 100.0,
        showBoth = true,
        distBlip = {
            type = 'radius',
            radius = 250.0,
            sprite = 9,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        }
    },
    ['carthief'] = {
        name = 'carthief',
        requiredJobs = { 'police', "sheriff", "fbi" },
        blip = {
            -- noRemove = true,
            -- trans = 500,  -- im wieksze tym dluze jest blip
            sprite = 821,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        },
        minDist = 100.0,
        showBoth = true,
        distBlip = {
            type = 'radius',
            radius = 250.0,
            sprite = 9,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-71",
            wait = 160
        }
    },
    ['drugs'] = {
        notify = {
            title = TR("drug_title"),
            content = {
                "outlaw_drug",
                "outlaw_drug2",
            },
            type = 'info'
        },
        name = 'drugs',
        requiredJobs = { 'police', "sheriff", "fbi" },

        blip = {
            sprite = 51,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-35",
            wait = 160
        },
        minDist = 100.0,
        showBoth = true,
        distBlip = {
            type = 'radius',
            radius = 25.0,
            sprite = 9,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = "10-25",
            wait = 160
        }
    },
    ['gang-room-take'] = {
        notify = {
            title = TR("gang-room-take"),
            content = {
                "gang-room-take",
            },
            type = 'warn'
        },
        name = 'gang-room-take',
        -- requiredJobsType = {"gang"},
        checkRequiredJobs = true,

        blip = {
            sprite = 51,
            color = 1,
            shortRange = true,
            scale = 1.0,
            label = TR("gang-room-take-blip"),
            wait = 160
        },
        -- minDist = 100.0,
        -- showBoth = true,
        -- distBlip = {
        --     type = 'radius',
        --     radius = 25.0,
        --     sprite = 9,
        --     color = 1,
        --     shortRange = true,
        --     scale = 1.0,
        --     label = "10-25",
        --     wait = 160
        -- }
    }
}
