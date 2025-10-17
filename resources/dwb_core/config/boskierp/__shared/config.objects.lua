Config.Objects = {
    Callbacks = {
        ['has-job'] = function(data)
            return User:HasJob(data)
        end,
        ['can-sell-drugs'] = function(ped, data)
            if not User:HasItem(data.drugs) then return end
            if Ped:IsType(ped, {data.noThesePeds}) then return end
            return true
        end
    },
    Types = {
        ['ped'] = {
            title = "Ped",
            name = 'ped',
            elements = {
                {
                    label = 'Sprzedaj narkotyki',
                    value = 'sell-drugs',
                    clientFn = "sell-drugs",
                    cb = "can-sell-drugs",
                    drugs = {'weed_pooch', 'mef_pooch', 'coke_pooch'},
                    notThesePeds = {55, 43}
                }
            }
        },
        ['vehicle'] = {
            title = "Pojazd",
            name = 'vehicle',
            elements = {
                {
                    inVehicle = false,
                    label = 'Obróc pojazd',
                    value = 'flip-vehicle',
                    clientFn = "flip-vehicle"
                }
            }
        }
    },
    Interactions = {
        [-1126237515] = {
            title = 'ATM',
            name = 'bank',
            closeOnSubmit = true,
            elements = {
                {
                    label = 'Otworz',
                    value = 'open',
                    name = 'bank'
                }
            }
        },
        [1511282135] = {
            title = "Doniczka",
            name = 'pot',
            elements = {
                {
                    label = 'Zasiej marihuane',
                    value = 'plant',
                    drug = 'weed'
                },
            }
        },
        [1315651205] = {
            title = "Doniczka",
            name = 'pot',
            elements = {
                {
                    label = 'Podlej',
                    value = 'water'
                },
            }
        },
        [`prop_roadcone02a`] = {
            title = "Pachołek",
            name = 'cone',
            cb = 'has-job',
            job = 'police',
            elements = {
                {
                    label = 'Podnieś',
                    value = 'grab',
                    clientFn = "delete-entity"
                }
            }
        },
        [`prop_barrier_work05`] = {
            title = "Barierka",
            name = 'barrrier',
            cb = 'has-job',
            job = 'police',
            elements = {
                {
                    label = 'Podnieś',
                    value = 'grab',
                    clientFn = "delete-entity"
                }
            }
        },
        [`p_ld_stinger_s`] = {
            title = "Kolczatka",
            name = 'stinger',
            job = 'police',
            cb = 'has-job',
            
            elements = {
                {
                    label = 'Podnieś',
                    value = 'grab',
                    clientFn = "delete-entity"
                }
            }
        },
        [927793327]   = {
            title = "Barbell",
            name = 'barbell',
            elements = {
                {
                    label = 'Cwicz',
                    value = 'train',
                    clientFn = "barbell-train"
                }
            }
        },
        [-1095992177]  = {
            title = "Wyciskanie",
            name = 'laweczka',
            elements = {
                {
                    label = 'Cwicz',
                    value = 'train',
                    clientFn = "free-train"
                }
            }
        },
        [1005957871]  = {
            title = "Wyciskanie",
            name = 'laweczka',
            elements = {
                {
                    label = 'Cwicz',
                    value = 'train',
                    clientFn = "free-train"
                }
            }
        },
        [233175726]   = {
            title = "Pullup",
            name = 'pullup',
            elements = {
                {
                    label = 'Cwicz',
                    value = 'train',
                    clientFn = "pull-train"
                }
            }
        },

        ---lawki
        [-99500382]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [1805980844]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [2037887057]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-1215681419] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-628719744]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-1062810675] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-763859088]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-1631057904] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-1317098115] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-403891623]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [437354449]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [1290593659]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [-70627249]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        [1916676832]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [267626795]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                    offsets = {
                        { -0.9, 0.0, 0.3 },
                        { 0.0,  0.0, 0.3 },
                        { 0.9,  0.0, 0.3 },
                    }
                }
            }
        },
        ---

        -- [1805980844] = {
        --     title = 'Siedzenie',
        --     name = 'seat',
        --     elements = {
        --         {
        --             label = 'Usiądź',
        --             value = 'seat',
        --             clientFn = "seat",
        --             offsets = {
        --                 {-0.9, 0.0,0.3},
        --                 {0.0, 0.0,0.3},
        --                 {0.9, 0.0,0.3},
        --         }
        --     }
        -- }
        -- },
        -- [-1198343923] = {
        --     title = 'Siedzenie',
        --     name = 'seat',
        --     elements = {
        --         {
        --             label = 'Usiądź',
        --             value = 'seat',
        --             clientFn = "seat",
        --             offsets = {
        --                 {-0.9, 0.0,0.3},
        --                 {0.0, 0.0,0.3},
        --                 {0.9, 0.0,0.3},
        --         }
        --     }
        -- }
        -- },
        [-109356459]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1198343923] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [449297510]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [525667351]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [764848282]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [725259233]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1064877149]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [2064599526]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1941377959] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1545434534]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [826023884]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1281480215]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1612971419]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1691387372]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1028260687]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-2105381678] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1118419705] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [900821510]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [181607490]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [558578166]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [536071214]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [96868307]    = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1268458364]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1480618483]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [475561894]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1037469683]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1103738692]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1544350879]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [854385596]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [291348133]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1071807406]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1108904010] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1633198649] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1262298127]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1737474779]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-2065455377] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1173315865] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-721037220]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [736919402]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1196890646]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [604553643]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [867556671]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [589738836]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-501934650]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-109356459]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-784954167]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1291993936] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-881696544]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1869605644] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-784954167]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1291993936] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [98421364]    = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1869605644] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-881696544]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [47332588]    = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-2016553006] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-377849416]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1521264200] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1235256368] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1761659350] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [146905321]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-741944541]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1716133836]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1289815393] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1190156817] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-28672923]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },

        [-293380809]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-591349326]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1355718178]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-294499241]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1320300017] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1005619310] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1019962318]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1841495633] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1894671041]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [544186037]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [773405192]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-2021659595] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1975077032]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1199485389] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1446187959]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-881525183]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1526269963]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-406716247]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1593135630]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [1532110050]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1877459292] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [2109741755]  = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [465467525]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [-1726933877] = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
        [417935208]   = {
            title = 'Siedzenie',
            name = 'seat',
            elements = {
                {
                    label = 'Usiądź',
                    value = 'seat',
                    clientFn = "seat",
                }
            }
        },
    }
}


Config.Objects.Functions = {
    ['delete-entity'] = function(ent, data)
        -- Animation:Play(PlayerPedId(), '', '', 3.0 ,3.0 ,-1)
        local net = NetworkGetNetworkIdFromEntity(ent)
        UI:Open('Bar', {
            name = 'delete-entity',
            time = 30,
            show = true,
            task = "Podnosisz"
        }, function(data,menu)
            menu.close()
            ClearPedTasks(PlayerPedId())
            Event:TriggerNet('dwb:objects:delete', net)
        end)
    end,
    
    ['flip-vehicle'] = function(ent, data)
        -- Animation:Play(PlayerPedId(), '', '', 3.0 ,3.0 ,-1)
        UI:Open('Bar', {
            name = 'flip',
            time = 30,
            show = true,
            task = "Obracanie samochodu"
        }, function(data,menu)
            menu.close()
            ClearPedTasks(PlayerPedId())
            SetVehicleOnGroundProperly(ent)
        end)
    end,
    ['sell-drugs'] = function(ent, data)
        if not Entity(ent).state.drugSell then
            Entity(ent).state.drugSell = true
            Event:TriggerNet('dwb:drugs:sell', NetworkGetNetworkIdFromEntity(ent))        
        end
    end,
    ['seat'] = function(ent, data)
        local heading = GetEntityHeading(ent)
        SetEntityHeading(PlayerPedId(), 360.0 - (180 - heading))
        local newHeading = 360.0 - (180 - heading)
        if not data.current.offsets then
            local retv = GetOffsetFromEntityInWorldCoords(ent, 0.0, 0.0, 0.5)
            if not IsAnyPedNearPoint(retv, 1.0) then
                FreezeEntityPosition(ent, true)

                PlaceObjectOnGroundProperly(ent)

                TaskStartScenarioAtPosition(PlayerPedId(), 'PROP_HUMAN_SEAT_BENCH', retv, newHeading, -1, true, true)
            end
        else
            local found = false
            for k, v in pairs(data.current.offsets) do
                local retv = GetOffsetFromEntityInWorldCoords(ent, v[1], v[2], v[3])
                if not IsAnyPedNearPoint(retv, 0.5) then
                    found = retv
                end
            end
            if found then
                FreezeEntityPosition(ent, true)

                PlaceObjectOnGroundProperly(ent)

                TaskStartScenarioAtPosition(PlayerPedId(), 'PROP_HUMAN_SEAT_BENCH', found, newHeading, -1, true, true)
            end
        end
    end,
    ['pull-train'] = function(ent)
        -- local retv = GetEntityCoords(ent)
        local heading = GetEntityHeading(ent)
        SetEntityHeading(PlayerPedId(), 360.0 - (180 - heading))
        local retv = GetOffsetFromEntityInWorldCoords(ent, -1.4, -0.5, 0.0)
        if not IsAnyPedNearPoint(retv, 1.0) then
            SetEntityCoordsNoOffset(PlayerPedId(), retv.x, retv.y, retv.z)
            Animation:Play(PlayerPedId(), "switch@franklin@gym", "001942_02_gc_fras_ig_5_base", 8.0, 3.0, 1.0, 1, nil,
                false, false, false)


            local grade = 0.3

            Citizen.CreateThread(function()
                while grade >= 0.10 and grade <= 0.90 do
                    Wait(0)
                    SetEntityAnimSpeed(PlayerPedId(), 'switch@franklin@gym', "001942_02_gc_fras_ig_5_base", grade)
                    -- SetEntityAnimCurrentTime(PlayerPedId(), 'switch@franklin@gym', "001942_02_gc_fras_ig_5_base", grade)
                end
            end)

            Skills:OpenClick(function(data, menu)
                grade = grade + 0.10
                if grade >= 0.90 then
                    menu.close()
                    Skills:Update('MP0_STAMINA', 7)
                    ClearPedTasks(PlayerPedId())
                end
            end, function(data, menu)
                grade = grade - 0.10
                -- SetEntityAnimCurrentTime(PlayerPedId(), 'switch@franklin@gym', "001942_02_gc_fras_ig_5_base", grade)
                if grade <= 0.10 then
                    menu.close()
                    ClearPedTasks(PlayerPedId())
                end
            end, function(data, menu)
                menu.close()
                ClearPedTasks(PlayerPedId())
            end)
        end
    end,
    ['free-train'] = function(ent)
        local retv = GetEntityCoords(ent)
        if not IsAnyPedNearPoint(retv, 1.0) then
            local heading = GetEntityHeading(ent)
            -- local obj = GetClosestObjectOfType(DWB.PlayerData.Coords, 3.0, 927793327, false, false, false)
            local obj = CreateObject(927793327, 1.0, 1.0, 1.0, false, 1, 0)
            if obj and DoesEntityExist(obj) and not IsEntityAttached(obj) then
                N_0xb2d0bde54f0e8e5a(obj, true)
                AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0,
                    0.0, 0, 0, 0, 0, 2, 1)
                SetEntityHeading(PlayerPedId(), 360.0 - (180 - heading))
                -- local retv = GetOffsetFromEntityInWorldCoords(ent, 0.0, -1.0, 0.0)
                SetEntityCoordsNoOffset(PlayerPedId(), retv.x, retv.y, retv.z)


                Animation:Play(PlayerPedId(), "amb@prop_human_seat_muscle_bench_press@idle_a", "idle_a", 8.0, 3.0, -1, 1,
                    nil, false, false, false)

                local grade = 0.3

                Citizen.CreateThread(function()
                    while grade >= 0.10 and grade <= 0.90 do
                        Wait(0)
                        -- SetEntityAnimSpeed(PlayerPedId(), 'amb@prop_human_seat_muscle_bench_press@idle_a', "idle_a",
                        --     grade)
                        SetEntityAnimCurrentTime(PlayerPedId(), 'amb@prop_human_seat_muscle_bench_press@idle_a', "idle_a", grade)
                    end
                end)

                UI:Open('Skills', {
                    docType = 'circle',
                    name = 'skills',
                    show = true
                }, function(data, menu)
                    grade = grade + 0.05
                    if grade >= 0.90 then
                        grade = 0.15
                        Skills:Update('MP0_STRENGTH', 5)
                    end
                end, function(data,menu)
                    menu.close()
                    DetachEntity(obj)
                    ClearPedTasks(PlayerPedId())
                end)

                -- -- Skills:OpenClick(function(data, menu)
                -- --     grade = grade + 0.05
                -- --     if grade >= 0.90 then
                -- --         menu.close()
                -- --         DetachEntity(obj)
                -- --         Skills:Update('MP0_STRENGTH', 5)
                -- --         Notification:ShowCustom('info', 'Trening', 'boost')
                -- --         ClearPedTasks(PlayerPedId())
                -- --     end
                -- -- end, function(data, menu)
                -- --     grade = grade - 0.05
                -- --     -- SetEntityAnimCurrentTime(PlayerPedId(), 'switch@franklin@gym', "001942_02_gc_fras_ig_5_base", grade)
                -- --     if grade <= 0.10 then
                -- --         menu.close()
                -- --         DetachEntity(obj)
                -- --         ClearPedTasks(PlayerPedId())
                -- --     end
                -- -- end, function(data, menu)
                -- --     menu.close()
                -- --     DetachEntity(obj)
                -- --     ClearPedTasks(PlayerPedId())
                -- -- end)
            end
        end
    end,
    ['barbell-train'] = function(ent)
        if not IsEntityAttached(ent) then
            N_0xb2d0bde54f0e8e5a(ent, true)
            AttachEntityToEntity(ent, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0, 0, 0, 0, 2, 1)
            Animation:Play(PlayerPedId(), "amb@world_human_muscle_free_weights@male@barbell@base", "base", 8.0, 3.0, -1,
                1, nil, false, false, false)

            local grade = 0.3

            Citizen.CreateThread(function()
                while grade >= 0.10 and grade <= 0.90 do
                    Wait(0)
                    SetEntityAnimSpeed(PlayerPedId(), 'amb@world_human_muscle_free_weights@male@barbell@base', "base",
                        0.0)
                    SetEntityAnimCurrentTime(PlayerPedId(), 'amb@world_human_muscle_free_weights@male@barbell@base',
                        "base", grade / 9)
                end
            end)

            Skills:OpenClick(function(data, menu)
                grade = grade + 0.05
                if grade >= 0.90 then
                    menu.close()
                    DetachEntity(ent)
                    Skills:Update('MP0_STRENGTH', 7)
                    ClearPedTasks(PlayerPedId())
                end
            end, function(data, menu)
                grade = grade - 0.05
                -- SetEntityAnimCurrentTime(PlayerPedId(), 'switch@franklin@gym', "001942_02_gc_fras_ig_5_base", grade)
                if grade <= 0.10 then
                    menu.close()
                    DetachEntity(ent)
                    ClearPedTasks(PlayerPedId())
                end
            end, function(data, menu)
                menu.close()
                DetachEntity(ent)
                ClearPedTasks(PlayerPedId())
            end)
        end
    end,
}