Config.Drugs = {
    Sell = {
        {
            name = 'weed_pooch',
            price = {1320, 5520},
            amount = {1, 4},
            title = "drugs",
            msg = 'sold_weed',
            chance = {1,5},
            money = 'black_money',
            requiredJobs = {
                {
                    job = {'police', 'sheriff'},
                    count = 2
                }
            }  

        },
        {
            name = 'mef_pooch',
            price = {5320, 12320},
            amount = {1, 4},
            title = "drugs",
            msg = 'sold_mef',
            chance = {1,5},
            money = 'black_money',
            requiredJobs = {
                {
                    job = {'police', 'sheriff'},
                    count = 3
                }
            }  
        },
        {
            name = 'coke_pooch',
            price = {10200, 18900},
            amount = {1, 4},
            title = "drugs",
            msg = 'sold_coke',
            chance = {1,5},
            money = 'black_money',
            requiredJobs = {
                {
                    job = {'police', 'sheriff'},
                    count = 6
                }
            }  
        }
    },
}

Config.Drugs.Pot = 1511282135

Config.Drugs.Pots = {
    ['weed'] = {
        name = 'weed',
        requiredItem = "weed",
        requiredCount = 10,
        giveItem = 'weed_leaf',
        giveCount = {1, 10},
        objects = {
            [500] = 1511282135,
            [1000] = 1315651205,
            [1500] = 1027382312,
            [2000] = 469652573,
            [2500] = 716763602
        }  
    }
}