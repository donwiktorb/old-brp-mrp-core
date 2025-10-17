Config.Tablet = {}

Config.Tablet.DispatchVehicles = {
    ['police'] = { {
        label = 'Victoria',
        value = 'crown'
    } },
    ['ambulance'] = { {
        label = 'Victoria',
        value = 'crown'
    } },
    ['mechanic'] = {

    }
}

Config.Tablet.Tags = {
    ['police'] = {
        "Poszukiwany"
    },
    ['ambulance'] = {
        "Byl raz"
    },
    ['mechanic'] = {
        "Robil tune",
    },
    ['justice'] = {

    }
}

Config.Tablet.Logos = {
    ambulance = "https://static.wikia.nocookie.net/wyspa/images/0/04/EMS.png",
    police =
    "https://www.clipartmax.com/png/full/139-1391304_in-2004-congress-established-the-national-counterterrorism-los-santos-police-department.png",
    mechanic = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
}


Config.Tablet.Licenses = {
    ['police'] = {
        "short"
    },
    ['ambulance'] = {
        "Ubez"
    },
    ['mechanic'] = {
        "oc",
        "ac"
    },
    ['justice'] = {

    }
}

Config.Tablet.Designs= {
    ambulance = {
        tablet = "",
        nav = "h-min rounded-t-lg bg-pink-900",
        main = "bg-pink-900 w-full h-full rounded-b opacity-90 overflow-auto",
        button =
        "border focus =ring-4 focus =outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-pink-600 text-pink-400 hover:text-white hover:bg-pink-600 focus:ring-pink-800"
    },
    police = {
        tablet = "",
        nav = "h-min rounded-t-lg bg-gray-800",
        main = "bg-gray-800 w-full h-full rounded-b opacity-90 overflow-auto",
        button =
        "border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-gray-600 text-gray-400 hover:text-white hover:bg-gray-600 focus:ring-gray-800"
    },
    mechanic = {
        tablet = "",
        nav = "h-min rounded-t-lg bg-yellow-800",
        main = "bg-yellow-800 w-full h-full rounded-b opacity-90 overflow-auto",
        button =
        "border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-yellow-600 text-yellow-400 hover:text-white hover:bg-yellow-600 focus:ring-gray-800"
    },
    justice = {

        tablet = "",
        nav = "h-min rounded-t-lg bg-gray-800",
        main = "bg-gray-800 w-full h-full rounded-b opacity-90 overflow-auto",
        button =
        "border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-gray-600 text-gray-400 hover:text-white hover:bg-gray-600 focus:ring-gray-800"
    }
}

Config.Tablet.TopLinks = {
    ambulance = {
        {
            label = "Main page",
            value = ""
        },
        {
            label = "Baza danych",
            value = "db"
        },
        {
            label = "Taryfikator",
            value = "tariff"
        },
        {
            label = "Faktura",
            value = "ticket"
        },
        {
            label = "Manage",
            value = "manage"
        }
    },
    police = {
        {
            label = "Main page",
            value = ""
        },
        {
            label = "Baza danych",
            value = "db"
        },
        {
            label = "Taryfikator",
            value = "crimes"
        },
        {
            label = "Jail",
            value = "jail"
        },
        {
            label = "Ticket",
            value = "ticket"
        },
        {
            label = "Manage",
            value = "manage"
        },
        {
            label = "Dispatch",
            value = "dispatch"
        }

    },
    mechanic = {
        {
            label = "Main page",
            value = ""
        },
        {
            label = "Baza danych",
            value = "db"
        },
        {
            label = "Taryfikator",
            value = "tariff"
        },

        {
            label = "Ticket",
            value = "ticket"
        },
        {
            label = "Manage",
            value = "manage"
        }
    },


    justice = {


        {
            label = "Main page",
            value = ""
        },
        {
            label = "Baza danych",
            value = "db"
        },
        {
            label = "Taryfikator",
            value = "crimes"
        },
        {
            label = "Jail",
            value = "jail"
        },
        {
            label = "Ticket",
            value = "ticket"
        },
        {
            label = "Manage",
            value = "manage"
        },
        {
            label = "Dispatch",
            value = "dispatch"
        }

    }
}

Config.Tablet.Tariff = {
    ['police'] = {{
        label = 'Wykroczenia drogowe',
        elements = {{
            label = 'Jazda bez uprawnień kat. A',
            money = 5000
        }, {
            label = 'Jazda bez uprawnień kat. B',
            money = 7500
        }, {
            label = 'Jazda bez uprawnień kat. C',
            money = 12500
        }, {
            label = 'Przekroczenia prędkości od 50 - 100 km/h',
            money = 5000
        }, {
            label = 'Przekroczenia prędkości od + 100 km/h',
            money = 10000
        }, {
            label = 'Przejazd na czerwonym świetle',
            money = 5000
        }, {
            label = 'Jazda bez świateł',
            money = 2000
        }, {
            label = 'Jazda niepoprawnym pasem ruchu',
            money = 5000
        }, {
            label = 'Jazda pod wpływem wpływam substancji odurzających',
            money = 12500
        }, {
            label = 'Nadużywanie sygnału dźwiękowego',
            money = 2000
        }, {
            label = 'Złamanie linii ciągłej',
            money = 5000
        }, {
            label = 'Potrącenie przechodnia',
            money = 20000,
            time = 5
        }, {
            label = 'Spowodowanie kolizji',
            money = 10000
        }, {
            label = 'Nieprawidłowe zaparkowanie pojazdu',
            money = 3000
        }, {
            label = 'Brawurowa jazda',
            money = 12500
        }, {
            label = 'Porusznie się pojazdem niezdatnym do ruchu',
            money = 10000
        }, {
            label = 'Ucieczka ucieczki przed LSPD', --Stawianie oporu podczas zatrzymnaia
            money = 12500,
            time = 15
        }}
    }, {
        label = 'Napady',
        elements = {{
            label = 'Próba rabunku',
            money = 10000,
            time = 10
        }, {
            label = 'Rabunek sklepu',
            money = 20000,
            time = 20
        }, {
            label = 'Napad na bank fleeca ',
            money = 65000,
            time = 25
        }, {
            label = 'Napad na Jubilera ',
            money = 45000,
            time = 45
        }, {
            label = 'Napad na AmmuNation ',
            money = 55000,
            time = 50
        }, {
            label = 'Napad na bank głowny ',
            money = 95000,
            time = 65
        }, {
            label = 'Napad na Jacht ',
            money = 80000,
            time = 70
        }, {
            label = 'Napad na Human Labs ',
            money = 150000,
            time = 100
        }, {
            label = 'Napad na komedne ',
            money = 1000000,
            time = 125
        }, {
            label = 'Zamach terrorystyczny',
            money = 5000000,
            time = 250
        }}
    }, {
        label = 'Broń',
        elements = {{
            label = 'Bezpodstawne użycie broni ',
            money = 10000,
            time = 5
        }, {
            label = 'Groźby z użyciem broni ',
            money = 21000,
            time = 10
        }, {
            label = 'Posiadanie broni bez licencji ',
            money = 35000,
            time = 15
        }, {
            label = 'posiadanie nielegalnej broni krótkiej ',
            money = 45000,
            time = 25
        }, {
            label = 'Posiadanie broni długiej/automatycznej ',
            money = 100000,
            time = 50
        }, {
            label = 'posiadanie broni policyjnej ',
            money = 60000,
            time = 35
        }, {
            label = 'Posiadanie sprzętu policyjnego ',
            money = 50000,
            time = 25
        }, {
            label = 'Posiadanie broni białej ',
            money = 20000,
            time = 10
        }, {
            label = 'Handel bronią krotką ',
            money = 70000,
            time = 40
        }, {
            label = 'Handel bronią długą/automatyczną ',
            money = 225000,
            time = 90
        }}
    }, {
        label = 'Przemoc',
        elements = {{
            label = 'Usiłowanie zabójstwa ',
            money = 50000,
            time = 20
        }, {
            label = 'Usiłowanie zabójstwa funkcjonariuza ',
            money = 75000,
            time = 40
        }, {
            label = 'Zakłócanie porządku publicznego ',
            money = 7500,
            time = 2
        }, {
            label = 'Nieumyślny uszczerbek na zdrowiu ',
            money = 10000,
            time = 5
        }, {
            label = 'Naruszenie nietylakności cielesnej ',
            money = 20000,
            time = 7
        }, {
            label = 'Napaść na funkcjonariuza publicznego ',
            money = 55000,
            time = 35
        }, {
            label = 'Próba napaści ',
            money = 35000,
            time = 15
        }, {
            label = 'Napaść ',
            money = 45000,
            time = 25
        }}
    }, {
        label = 'Porwania i Kradzieże',
        elements = {{
            label = 'Porwanie obywatela ',
            money = 40000,
            time = 20
        }, {
            label = 'Porwanie funkcjonariusza Publicznego ',
            money = 65000,
            time = 45
        }, {
            label = 'Pozbawienie wolności obywatela ',
            money = 35000,
            time = 15
        }, {
            label = 'Kradzież pojazdu ',
            money = 20000,
            time = 5
        }, {
            label = 'Kradzież Pojazdu Uprzywilejowanego ',
            money = 35000,
            time = 10
        }, {
            label = 'Kradzież mienia ',
            money = 12500,
            time = 2
        }, {
            label = 'Kradzież pojazdu z napaścią ',
            money = 30000,
            time = 8
        }, {
            label = 'Włamanie ',
            money = 27500,
            time = 12
        }}
    }, {
        label = 'Narkotyki',
        elements = {{
            label = 'Posiadanie marihuany ',
            money = 15000,
            time = 5
        }, {
            label = 'Posiadanie metamfetaminy ',
            money = 35000,
            time = 25
        }, {
            label = 'Posiadanie mefedronu ',
            money = 25000,
            time = 15
        }, {
            label = 'Posiadnie kokainy ',
            money = 20000,
            time = 10
        }, {
            label = 'Posiadanie opium ',
            money = 45000,
            time = 35
        }, {
            label = 'Posiadanie ecstasy ',
            money = 30000,
            time = 20
        }, {
            label = 'Handel narkotykiami miękkimi ',
            money = 25000,
            time = 25
        }, {
            label = 'Handel narkotykami twardymi ',
            money = 50000,
            time = 45
        }}
    }, {
        label = 'Wykroczenia',
        elements = {{
            label = 'Prowokacja policji do pościgu ',
            money = 30000
        }, {
            label = 'Niewykonywanie poleceń funkcjonariusza ',
            money = 15000
        }, {
            label = 'Utrudnianie pracy służbom porządowym ',
            money = 20000
        }, {
            label = 'Obraza funkcjonariusza 1-5 ',
            money = 5000
        }, {
            label = 'Liczne obraza funkcjonariusza 5-20 ',
            money = 10000
        }, {
            label = 'Nagminne obrazy funkcjonariusza 20+ ',
            money = 15000
        }, {
            label = 'Wandalizm ',
            money = 3500
        }}
    }, {
        label = 'Inne',
        elements = {{
            label = 'Próba przekupstwa ',
            money = 20000,
            time = 10
        }, {
            label = 'Groźby karalne ',
            money = 15000,
            time = 4
        }, {
            label = 'Posiadanie nieopodatkowanych pieniedzy ',
            money = 17500,
            time = 8
        }, {
            label = 'Posiadanie kontrabandy ',
            money = 15000,
            time = 10
        }, {
            label = 'Fałszywe wezwanie pomocy ',
            money = 15500,
            time = 4
        }, {
            label = 'Składanie fałszywych zeznań ',
            money = 20000,
            time = 7
        }, {
            label = 'Podszywanie ',
            money = 30000,
            time = 10
        }, {
            label = 'Przynależność do zorganizowanej grupy ',
            money = 150000,
            time = 40
        }, {
            label = 'Prowadzenie zorganizowanej grupy ',
            money = 350000,
            time = 70
        }, {
            label = 'Współdziała w przestępstwie ',
            money = 55000,
            time = 30
        }, {
            label = 'Pomoc w ucieczce ',
            money = 65000,
            time = 20
        }, {
            label = 'Pomoc w ucieczce z konwoju ',
            money = 500000,
            time = 70
        }}
    }},
    ['ambulance'] = {
        {
            label = 'Odniesione Obrażenia',
            elements = {{
                label = 'Plasterek ',
                money = 1500
            }, {
                label = 'Obdarcia/Siniaki ',
                money = 1500
            }, {
                label = 'Rozciety łuk brwiowy ',
                money = 300
            }, {
                label = 'Urazy głowy ',
                money = 950
            }, {
                label = 'Rany cięte ',
                money = 350
            }, {
                label = 'Złamanie zamknięte ',
                money = 900
            }, {
                label = 'Złamanie otwarte ',
                money = 950
            }, {
                label = 'Choroby wewnętrzne ',
                money = 950
            }, {
                label = 'Rana postrzałowa biodra ',
                money = 950
            }, {
                label = 'Rana postrzałowa barku',
                money = 1000
            }, {
                label = 'Rana postrzałowa Tułowia ',
                money = 1200
            }, {
                label = 'Rana postrzałowa Głowy/szyji ',
                money = 750
            }, {
                label = 'Wielokrotne i różne obrażenia ',
                money = 500
            }, {
                label = 'Oparzenia ',
                money = 400
            }, {
                label = 'Omdlenia ',
                money = 400
            }, {
                label = 'Podtopienia ',
                money = 300
            }, {
                label = 'Wybicie/skręcenie stawu ',
                money =450
            }, {
                label = 'Ściąganie szwów/gipsu ',
                money = 300
            }}
        }},
    ['mechanic'] = {
        {
            label = 'Tune samochodu',
            money =200
        },

        {
            label = 'Naprawa samochodu',
            money =400
        },
        {
            label = 'Wyczyszczenie',
            money =400
        },
        {
            label = 'Holowanie',
            money =400
        },
    },
    ['justice'] = {}
}




