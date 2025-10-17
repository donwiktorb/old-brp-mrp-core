Config.Queue = {}
Config.Settings = {

  tech = true,
  techMessage = "Przerwa techniczna...",
}

Config.Queue.Admins = {
  ["steam:"] = true,
}

Config.Queue.Card = [==[{
    "type": "AdaptiveCard",
    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
    "version": "1.6",
    "body": [
        {
            "type": "TextBlock",
            "text": "Witaj na BoskieRP",
            "wrap": true,
            "color": "Yellow",
            "weight": "Bolder",
            "size": "Medium",
            "spacing": "None",
            "horizontalAlignment": "Center"
        },
        {
            "type": "Container",
            "items": [
                {
                    "type": "TextBlock",
                    "text": "Hej {player}",
                    "wrap": true
                }
            ]
        },
        {
            "type": "TextBlock",
            "text": "Trwa łączenie się z serwerem..",
            "wrap": true,
            "color": "Accent"
        },
        {
            "type": "ColumnSet",
            "columns": [
                {
                    "type": "Column",
                    "width": "stretch",
                    "items": [
                        {
                            "type": "ActionSet",
                            "actions": [
                                {
                                    "type": "Action.OpenUrl",
                                    "title": "DISCORD",
                                    "style": "positive",
                                    "url": "http://dc.boskierp.pl"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type": "Column",
                    "width": "stretch",
                    "items": [
                        {
                            "type": "ActionSet",
                            "actions": [
                                {
                                    "type": "Action.OpenUrl",
                                    "title": "STRONA",
                                    "url": "https://boskierp.pl/"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type": "Column",
                    "width": "stretch",
                    "items": [
                        {
                            "type": "ActionSet",
                            "actions": [
                                {
                                    "type": "Action.OpenUrl",
                                    "title": "SKLEP",
                                    "url": "https://militaryrp.tebex.io/"
                                }
                            ]
                        },
                        {
                            "type": "TextBlock",
                            "text": "BoskieRP 2019-",
                            "wrap": true,
                            "size": "Small"
                        }
                    ]
                }
            ]
        }
    ],
    "verticalContentAlignment": "Top"
}]==]

Config.Queue.discordBonus = {
  default = 100,

  booster = 200,
  donator = 100,
}

Config.Queue.tech = {
  status = false,
  msg = "Przerwa techniczna ...",
  allowed = {
    ["steam:11000010c53c6f3"] = true,
    ["steam:1100001146482b4"] = true,
    ["steam:110000117b25758"] = true,
    ["steam:11000013fed2db0"] = true,
  },
}

Config.Queue.time = 1

Config.Queue.charLimit = 2
Config.Queue.NoChar = true

Config.Queue.coords = {
  {
    label = "Lotnisko LS",
    coords = vector3(-1037.776, -2737.93, 20.1693),
    heading = 200,
  },
  {
    label = "Urząd pracy LS",
    coords = vector3(-259.5498, -976.1302, 31.21998),
    heading = 200,
  },
  {
    label = "Sandy",
    coords = vector3(1856.136, 3681.884, 34.26752),
    heading = 200,
  },
  {
    label = "Grapeseed",
    coords = vector3(1658.752, 4856.414, 41.94684),
    heading = 200,
  },
  {
    label = "Paleto Bay",
    coords = vector3(-439.7914, 6019.98, 31.4901),
    heading = 200,
  },
}

Config.Queue.cards = {
  init = [==[
        {   
        "type": "AdaptiveCard",
        "body": [
            {
                "type": "TextBlock",
                "size": "medium",
                "weight": "bolder",
                "text": "Postać"
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "items": [
                            {
                                "type": "TextBlock",
                                "weight": "Bolder",
                                "text": "Wybierz lub stwórz nową postać",
                                "wrap": true
                            }
                        ],
                        "width": "stretch"
                    }
                ]
            },
            {
                "type": "Input.ChoiceSet",
                "id": "choice",
                "choices": [
                    {
                        "title": "Stwórz nową postać",
                        "value": "new"
                    },
                ],
                "value": "new",
                "errorMessage": "Nie wybrałeś akcji.",
                "isRequired": true,
                "placeholder": "Kliknij, aby wybrać lub stwórz nową"
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "width": "stretch",
                        "items": [
                            {
                                "type":"ActionSet",
                                "horizontalAlignment": "Center",
                                "width":"stretch",
                                "actions": [
                                    {
                                        "type": "Action.Submit",
                                        "title": "Wybierz",
                                        "id": "submit",
                                        "style": "positive" 

                                    },
                                    {
                                        "type": "Action.Submit",
                                        "title": "Usuń",
                                        "id": "delete",
                                        "style": "positive" 

                                    },
                                ],
                            },
                        ],
                    },
                ]
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "width": "stretch",
                        "items": [
                            {
                                "type":"ActionSet",
                                "horizontalAlignment": "Center",
                                "actions": [
                                    {
                                      "type":"Action.OpenUrl",
                                      "title": "Strona",
                                      "url": "https://boskierp.pl",
                                    },
                                    {
                                        "type":"Action.OpenUrl",
                                        "title": "Discord",
                                        "url": "https://discord.gg/n9zytQK7D6",
                
                                    },
                                ]
                            },
                        ],
                    }
                ]
            },
            
        ],
    "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
        "version":"1.5"
    }
    ]==],
  new = [==[
        {   
        "type": "AdaptiveCard",
        "body": [
            {
                "id": "firstname",
                "type": "Input.Text",
                "placeholder": "Imię",
                "isRequired": true,
                "label": "Imię",
                "maxLength": 20,
                "errorMessage": "Wybierz imię o maksymalnej długości 20 znaków."
            },
            {
                "id": "lastname",
                "type": "Input.Text",
                "placeholder": "Nazwisko",
                "isRequired": true,
                "label": "Nazwisko",
                "maxLength": 20,
                "errorMessage": "Wybierz nazwisko o maksymalnej długości 20 znaków."
            },
            {
                "id": "dateofbirthday",
                "type": "Input.Date",
                "label": "Data Urodzenia",
                "min": "1900-11-11",
                "max": "2021-11-11",
                "isRequired": true,
                "errorMessage": "Wybierz datę urodzenia pomiędzy 1900-11-11 a 2021-11-11."
            },
            {
                "id": "height",
                "type": "Input.Number",
                "placeholder": "Wzrost (min. 140 do 200)",
                "min": 140,
                "max": 200,
                "isRequired": true,
                "label": "Wzrost",
                "errorMessage": "Wybierz wzrost między 140 a 200."
            },
            {
                "id": "sex",
                "type": "Input.ChoiceSet",
                "choices": [
                    {
                        "title": "Mężczyzna",
                        "value": "m"
                    },
                    {
                        "title": "Kobieta",
                        "value": "f"
                    }
                ],
                "placeholder": "Płeć",
                "isRequired": true,
                "label": "Płeć",
                "errorMessage": "Wybierz płeć.",
                "style":"expanded",
                "value": "m"
            },
            {
                "type":"ActionSet",
                "actions": [
                    {
                        "type": "Action.Submit",
                        "title": "Stwórz"
                    }
                ],
            }
        ],
        "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
        "version":"1.0"
    }
    ]==],
  remove = [==[
        {   
        "type": "AdaptiveCard",
        "body": [
            {
                "type": "TextBlock",
                "size": "medium",
                "weight": "bolder",
                "text": "Postać"
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "items": [
                            {
                                "type": "TextBlock",
                                "weight": "Bolder",
                                "text": "Jesteś pewny że chcesz usunąc postać?",
                                "wrap": true
                            }
                        ],
                        "width": "stretch"
                    }
                ]
            },
            {
                "type":"ActionSet",
                "actions": [
                    {
                        "type": "Action.Submit",
                        "title": "Tak, usuń",
                        "id": "accept",
                        "style": "positive" 

                    },
                    {
                        "type": "Action.Submit",
                        "title": "Nie, anuluj",
                        "id": "cancel",
                        "style": "positive" 

                    }
                ]
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "items": [
                            {
                                "type":"ActionSet",
                                "actions": [
                                    {
                                      "type":"Action.OpenUrl",
                                      "title": "Strona",
                                      "url": "https://boskierp.pl",
                                    },
                                    {
                                        "type":"Action.OpenUrl",
                                        "title": "Discord",
                                        "url": "https://discord.gg/n9zytQK7D6",
                
                                    },
                                ]
                            },
                        ],
                        "width": "stretch"
                    }
                ]
            },
        ],
    "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
        "version":"1.0"
    }
    ]==],
  pos = [==[
        {   
        "type": "AdaptiveCard",
        "body": [
            {
                "id": "coords",
                "type": "Input.ChoiceSet",
                "choices": [
                    {
                        "title": "Ostatnia pozycja",
                        "value": "last"
                    }
                ],
                "placeholder": "Pozycja",
                "isRequired": true,
                "label": "Pozycja",
                "errorMessage": "Wybierz pozycję.",
                "style":"expanded",
                "value": "last"
            },
            {
                "type":"ActionSet",
                "actions": [
                    {
                        "type": "Action.Submit",
                        "title": "Wybierz"
                    }
                ],
            }
        ],
        "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
        "version":"1.0"
    }
    ]==],
}

Config.Queue.emojis = {
  "🐌",
  "🐍",
  "🐎",
  "🐑",
  "🐒",
  "🐘",
  "🐙",
  "🐛",
  "🐜",
  "🐝",
  "🐞",
  "🐟",
  "🐠",
  "🐡",
  "🐢",
  "🐤",
  "🐦",
  "🐧",
  "🐩",
  "🐫",
  "🐬",
  "🐲",
  "🐳",
  "🐴",
  "🐅",
  "🐈",
  "🐉",
  "🐋",
  "🐀",
  "🐇",
  "🐏",
  "🐐",
  "🐓",
  "🐕",
  "🐖",
  "🐪",
  "🐆",
  "🐄",
  "🐃",
  "🐂",
  "🐁",
  "🔥",
}

Config.Queue.announcement = "Brak"
Config.Queue.discord = "http://dc.boskierp.pl"
Config.Queue.points = {
  { "steam:110000146e1a189", 1000 }, -- disstream
  { "steam:11000013e981840", 500 }, -- chuj wie kto, gruby powiedizal zebym dodal
  { "steam:1100001148f9182", 1000 }, -- nbwm
  { "steam:1100001353c8273", 500 }, -- ナイキの帽子をかぶった犬
  { "steam:11000014744cd22", 1000 }, -- rudy
  { "steam:110000137ba091c", 500 }, -- Lexuuu
  { "steam:1100001320bb693", 1000 }, -- Ansi
  { "steam:11000014503f0ae", 500 }, -- oliwier nie podal
  { "steam:11000013c4a8a26", 500 }, -- bolo
  { "steam:110000140cf5803", 500 }, -- kolega Czapli
  { "steam:110000116666ec5", 500 }, -- StaryDrems
  { "steam:11000010db1eba1", 500 }, -- ez
  { "steam:11000011d4190f0", 500 }, -- oliwier nie podsal
  { "steam:1100001444294fd", 500 }, -- $lek
  { "steam:110000135e67625", 1000 }, -- borajeee
  { "steam:11000011710557b ", 1000 }, -- nongtang1337
  { "steam:1100001490288d1", 500 }, -- pikachu
  { "steam:110000143b1d596", 500 }, -- cukier tato
  { "steam:1100001459e35a4", 1500 }, -- ktos tam taki
  { "steam:11000014638bd67", 500 }, -- Shadow
  { "steam:110000148e6d0da", 500 }, -- James
  { "steam:110000148008434", 1000 }, -- kacperek
  { "steam:1100001429d64a9", 500 }, -- Nowina b.l
  { "steam:11000013e0ae788", 500 }, -- James 2
  { "steam:11000014640b3a1", 500 }, -- Jakubowicz
  { "steam:110000115288e8b", 500 }, -- Bollson
  { "steam:110000146f9e482", 500 }, -- Kasjuszek
  { "steam:110000135e0896a", 500 }, -- nie podal gruby
  { "steam:11000013d73768b", 500 }, -- nie podal gruby
  { "steam:11000011b34b4e9", 500 }, -- lagun
  { "steam:11000011831a96b", 500 }, -- cfzhrnx
  { "steam:110000148e08cba", 500 }, -- gruby nie podawl
  { "steam:110000117ef72f9", 500 }, -- zeiden
  { "steam:110000119760215", 500 }, -- M3fu
  { "steam:110000137e4eb38", 500 }, -- AKUU
  { "steam:110000143090bb9", 500 }, -- serdziowski
  { "steam:1100001489a50a3", 500 }, --  Jack Therry
  { "steam:110000133b790b0", 1000 }, --  Zenkerek
  { "steam:11000013fb1fe6b", 500 }, -- newsuperdev
  { "steam:110000146ff639a", 500 }, -- HubertDrugieKonto
  { "steam:11000010e6a0ac1", 500 }, -- nexxuu
  { "steam:110000119fdadab", 500 }, -- czemu nie
  { "steam:11000014716c431", 500 }, -- diablos
  { "steam:1100001414225a1", 500 }, -- boner
  { "steam:11000013bd133a4", 500 }, -- Nexon
  { "steam:110000135ce486d", 500 }, -- Piotrek
  { "steam:110000148457d24", 500 }, -- prokokjasiu
  { "steam:11000011ce833a1", 500 }, -- Mati
  { "steam:11000013f7fecd3", 500 }, -- Dizzy
  { "steam:110000146e40cf6", 500 }, -- shadow
  { "steam:110000147c426b9", 500 }, -- aquarbt
  { "steam:110000143c50756", 500 }, -- kurcrrczee1
  { "steam:1100001464939e0", 500 }, -- kurcrrczee2
  { "steam:1100001425f67de", 500 }, -- jasiuszef
  { "steam:110000111b4ee9e", 500 }, -- g90
  { "steam:1100001352c7c92", 500 }, -- dinoxd
  { "steam:11000013ec12cd1", 500 }, -- oskar
  { "steam:11000013dac8ea4", 500 }, -- nesti
  { "steam:110000147b7b3a7", 500 }, -- Byczqq
  { "steam:110000131e3bdee", 500 }, -- EL67
  { "steam:110000131fceaa8", 500 }, -- Raullu
  { "steam:110000143235473", 500 }, -- gruby nie podal
  { "steam:11000010f20f8bf", 500 }, -- gruby nie podal
  { "steam:11000014792d26f", 500 }, -- gruby nie podal
  { "steam:1100001461a6b3d", 500 }, -- disstream
  { "steam:1100001453ea8ea", 500 }, -- kubakson23
  { "steam:110000146a12ffb", 500 }, -- kubson2
  { "steam:11000013e119ebb", 500 }, -- maksikrdzyz2
  { "steam:1100001450b4df2", 500 }, -- kubson
  { "steam:11000011ca9f802", 500 }, -- PAPIEZ
  { "steam:110000112d19f41", 1000 }, -- wxk
  { "steam:110000135c11d53", 500 }, -- lando
  { "steam:1100001450f4a63", 1000 }, -- Rarsi
  { "steam:1100001346aa24d", 500 }, -- Ruda
  { "steam:11000013e9a73d8", 500 }, -- Nachosek!
  { "steam:1100001122fd5ca", 1000 }, -- 420 Młody_Kobuch!
  { "steam:11000013dc51a02", 1000 }, -- ビス!
  { "steam:110000109d39657", 500 }, -- Hermanita —!
  { "steam:1100001404a458e", 1000 }, -- ArKuS1233!
  { "steam:110000147eb44e7", 1000 }, -- SHOTRP!
  { "steam:110000145b3eabb", 1000 }, -- Killer1337!
  { "steam:11000013a162d7a", 1000 }, -- Hesu!
  { "steam:110000147a93541", 1000 }, -- John Bravo!
  { "steam:11000013fb78100", 2000 }, -- korniszon101010!
  { "steam:11000013c81b54e", 1000 }, -- Rikus
  { "steam:110000147f3b948", 500 }, -- RYDZ10X
  { "steam:110000131fceaa8", 500 }, -- RaulU
  { "steam:1100001149d68ee", 500 }, -- cfzhrnx
  { "steam:110000146013fdf", 500 }, -- Dawid
  { "steam:11000013f3e504a", 1000 }, -- Ravoushi
  { "steam:110000133708673", 1000 }, -- Rikus
  { "steam:1100001485ab485", 1000 }, -- ! Igo
  { "steam:1100001091b8a22", 500 }, -- Piterro
  { "steam:110000117dc6ea1", 500 }, -- macius69#4444
  { "steam:11000014197c1e6", 500 }, -- czil
  { "steam:1100001178dca6a", 500 }, -- Piterro
  { "steam:11000014959bc93", 500 }, -- laneek
  { "steam:110000140db1fb2", 500 }, -- Piterro
  { "steam:11000013f974ffa", 500 }, -- KIT KAT
  { "steam:110000145273ed7", 500 }, -- Baueras
  { "steam:11000013bf36e1b", 500 }, -- Mateo Bombay
  { "steam:1100001416904d1", 1500 }, -- molly
  { "steam:110000143776001", 500 }, -- Yaoung Kaczor
  { "steam:110000135ee84bb", 500 }, -- Yaoung Kaczor
  { "steam:110000116a00ed3", 500 }, -- Yaoung Kaczor
  { "steam:110000148008434", 500 }, -- Yaoung Kaczor
  { "steam:11000014367d2f8", 500 }, -- animak21
  { "steam:11000013fafd963", 1000 }, -- Yaoung Kaczor
  { "steam:1100001178b0f3c", 500 }, -- Yaoung Kaczor
  { "steam:110000143aa2673", 500 }, -- KubiXparara
  { "steam:11000013584d285", 500 }, -- Yaoung Kaczor
  { "steam:11000010efe14fc", 500 }, -- Yaoung Kaczor
  { "steam:11000013b0c038c", 500 }, -- Telmoncik
  { "steam:11000010c792217", 1000 }, -- denny
  { "steam:110000131fd94bb", 500 }, -- krem
  { "steam:110000148c41252", 500 }, -- SmoLean_
  { "steam:11000013bb212fe", 1000 }, -- Azor
  { "steam:11000014a1690fa", 500 }, -- Sad Papa
  { "steam:11000013ec0655d", 1000 }, -- bary
  { "steam:11000013369458e", 1000 }, -- nwm jak to napisac
  { "steam:1100001474d3763", 1000 }, -- SubiiHewas

  { "steam:110000143e144a0", 500 }, -- szyszełeQ
  { "steam:110000142034011", 500 }, -- kuzix
  { "steam:1100001446cf6fa", 500 }, -- Marcelix
  { "steam:110000148d4a6fc", 1500 }, -- ale że za zero
  { "steam:1100001473ea721", 500 }, -- magik
  { "steam:1100001496a178a", 500 }, -- Cukier Tato.
  { "steam:1100001152f3f62", 500 }, -- Xibo
  { "steam:1100001133f7cf6", 1500 }, -- sk1nzey
  { "steam:110000141b7e5d5", 10000 }, -- Grandzik
  { "steam:110000117b25758", 10000 }, -- Kraqu
  { "steam:11000013fd9acbc", 500 }, -- Johny White łysy
  { "steam:1100001146482b4", 20000 }, -- true
  { "steam:1100001079bdaa4", 10000 }, -- semittu
  { "steam:1100001378e9b83", 500 }, --adikom
  { "steam:11000013c4190ea", 500 }, -- daw
  { "steam:1100001119c0ef2", 1000 }, -- kier
  { "steam:1100001423b9528", 1000 }, -- kier2
  { "steam:1100001176e14d0", 500 }, -- .
  { "steam:110000133bd72d0", 1000 }, -- Mrsq
  { "steam:110000112233a2", 500 }, -- MAKS
  { "steam:110000100b01b5b", 500 }, -- MAKS
  { "steam:11000013aedabe7", 1000 }, -- Wox6
  { "steam:11000010ec36fe3", 1000 }, -- Pablo
  { "steam:110000132a1b204", 1000 }, -- Neuronitto
  { "steam:1100001362deece", 1000 }, -- WhiteWolf 1100001397d8ff5
  { "steam:11000010b66827e", 1000 }, -- Rafal
  { "steam:1100001172940d7", 500 }, -- orzeszek
  { "steam:1100001397d8ff5", 1000 }, -- esert
  { "steam:11000013fed2db0", 1000 }, -- Oliwier
  { "steam:110000132402bc1", 2000 }, -- Dawidek
  { "steam:11000013ec716f4", 20000 }, -- bby
  { "steam:11000010c53c6f3", 1000 }, -- Dawidek

  { "steam:1100001174ba5ee", 500 }, -- jAKUBEK DO 5.07.2020
  { "steam:110000132dd7eba", 500 }, -- jAKUBEK DO 5.07.2020
  { "steam:11000013b78300a", 1000 }, -- vexu
  { "steam:1100001161e23ea", 1000 }, -- killc0
  { "steam:110000112e958e9", 500 }, -- flecik
  { "steam:11000013f0ffeb2", 500 }, -- 👽кσ¢υя ℓνℓ.1👽|
  { "steam:11000013c1410b6", 500 }, -- TheBestOfTheBest
  { "steam:11000013f5661af", 500 }, -- zVyr0L
  { "steam:11000013fb6bb23", 500 }, -- ظn1ʞɐɐɐ
  { "steam:110000141e10919", 500 }, -- Jacob Maka
  { "steam:110000141848e7e", 500 }, -- Jacob Maka
  { "steam:11000011500f8d8", 500 }, -- elmeder
  { "steam:110000134031e48", 1000 }, -- marsu
  { "steam:11000010c8212f5", 1000 }, -- aiden
  { "steam:1100001094a8195", 1000 }, -- Adyy
  { "steam:11000010AFC5286", 1000 }, -- DeraGoth
  { "steam:1100001192eedad", 1000 }, -- hxppson
  { "steam:11000014066efbe", 500 }, -- wajktor5
  { "steam:110000104f2b101", 1500 }, -- smokus
  { "steam:1100001422ad50b", 1000 }, -- enymType
  { "steam:1100001143c4663", 1000 }, -- Businessmeno Eduardo
  { "steam:11000013cb49d24", 1000 }, -- Xaypi
  { "steam:11000013b3bf343", 1000 }, -- kenveloo
  { "steam:110000140fab370", 1000 }, -- MaKaPaKaV2
  { "steam:11000014186f3a9", 1000 }, -- tab3lson
  { "steam:11000011abb846b", 1000 }, -- Kumpel
  { "steam:11000013d006a3c", 1000 }, -- Ravoushi
  { "steam:11000013f02cb77", 1000 }, -- Sewek
  { "steam:1100001340cdd0b", 1000 }, -- Businessmeno Eduardo
  { "steam:110000136547af9", 1500 }, -- Wtorus_
  { "steam:1100001137916eb", 1000 }, -- !karigan!
  { "steam:11000014148859a", 1000 }, -- ZaKi
  { "steam:11000011779089f", 1000 }, -- PanBrokul
  { "steam:1100001161e3e55", 1000 }, -- MarcyN
  { "steam:110000117848d5e", 1000 }, -- MarcyN
  { "steam:11000011a1ae5f3", 1000 }, -- hasuf
  { "steam:11000014214daea", 1000 }, -- Pogchamp
  { "steam:110000136a63370", 1000 }, -- Pogchamp
  { "steam:1100001159f8b38", 500 }, -- jerry
  { "steam:11000013eadfd20", 500 }, -- 8131
  { "steam:110000134139b8b", 500 }, -- 8131
  { "steam:110000141e7a822", 500 }, -- 8131
  { "steam:110000137380163", 500 }, -- 8131
  { "steam:11000012d1a9608", 500 }, -- zcraadek
  { "steam:11000013c9d110b", 500 }, -- zcraadek
  { "steam:11000012db1d0a0", 500 }, -- pepe
  { "steam:1100001187ec789", 1000 }, -- Cici.exe
  { "steam:11000013b5f72c7", 1000 }, -- Dominik
  { "steam:11000013ce561f", 1000 }, -- house
  { "steam:11000013daa0809", 500 }, -- Yanke$
  { "steam:110000112d05088", 1000 }, -- Jokerr
  { "steam:11000013ce0561f", 1000 }, -- Domek!
  { "steam:11000010dbe5673", 1000 }, -- Heput
  { "steam:1100001158a480a", 1000 }, -- Piorun
  { "steam:11000011a1ae5f3", 1000 }, -- Hasuf
  { "steam:11000013a85785e", 1000 }, -- Peterek
  { "steam:11000013235d61d", 500 }, -- 8281
  { "steam:11000011c9c2b3b", 500 }, -- 8281
  { "steam:11000011820431c", 500 }, -- 8281
  { "steam:110000113beaa08", 500 }, -- 8281
  { "steam:110000142fb960a", 1000 }, -- JA - jakis typ nie adminiostator
  { "steam:11000013be96a6b", 1000 }, -- 8281
  { "steam:1100001334d76ad", 1000 }, -- toxic_dawcc
  { "steam:110000142306bef", 500 }, -- JaJcoob
  { "steam:110000134be40ea", 1000 }, -- Propan
  { "steam:110000110c700d4", 1000 }, -- paj5
  { "steam:1100001409dc384", 500 }, -- Mlody
  { "steam:11000013611bce2", 500 }, -- Mlody
  { "steam:11000011032cb7c", 1000 }, -- dzban
  { "steam:11000011204982e", 500 }, -- TmK_kupione_przez_xaypiego
  { "steam:11000013d575198", 995 }, -- TmK 2
  { "steam:11000013f9ce7df", 1000 }, -- pistacja
  { "steam:110000110ccecda", 1000 }, -- pesos
  { "steam:11000011b5fb9ed", 1000 }, -- kamilos
  { "steam:11000011a31f95f", 500 }, -- pan koniczyn
  { "steam:110000107771936", 1000 }, -- Kordixx
  { "steam:11000014197e495", 1000 }, -- lawi
  { "steam:11000011532ea6f", 1000 }, -- highend
  { "steam:110000134fa6721", 1000 }, -- Siea
  { "steam:11000013e6e2a35", 1000 }, -- house
  { "steam:11000010bb7aeea", 1000 }, -- Dycha(Kierownik)
  { "steam:1100001407982b5", 1000 }, -- wiljej
  { "steam:11000013306a8a5", 1000 }, -- Desiginy
  { "steam:11000013e67286f", 1000 }, -- kenveloo
  { "steam:110000132b95900", 1000 }, -- MikUś
  { "steam:11000013621944a", 1000 }, -- Swizu
  { "steam:110000113d0cb07", 1000 }, -- Swizu
  { "steam:11000011ad26a35", 1000 }, -- LastSoul exorcist
  { "steam:11000014321487f", 500 }, -- kejp
  { "steam:11000013ede2a22", 500 }, -- koalakozaczek 110000117ad32c6
  { "steam:1100001368062a7", 500 }, -- loshu-_-
  { "steam:11000013f3b6ae1", 500 }, -- iwo_youtube
  { "steam:110000117ad32c6", 1000 }, -- BIALY
  { "steam:11000013ee7f853", 1000 }, -- tvmczk
  { "steam:11000013f5b2930", 500 }, -- RodzinaElite
  { "steam:1100001435e6299", 500 }, -- mystikkk_
  { "steam:1100001000056ba", 500 }, -- Kordixx
  { "steam:110000111167418", 500 }, -- ignorancik
  { "steam:11000010efe3705", 500 }, -- sacramonte
  { "steam:11000014275d1ff", 500 }, -- STEP Fabisz.
  { "steam:11000010d698212", 500 }, -- skokin
  { "steam:1100001161ba9b7", 500 }, -- 𝑴𝒓𝑪𝒂𝒕𝒔
  { "steam:11000010e0bb525", 500 }, -- Krycha
  { "steam:11000014314144e", 500 }, -- pan koniczyn
  { "steam:11000014250f4dc", 500 }, -- shootrp
  { "steam:110000140793dce", 500 }, -- neksiu 1100001154b6d70
  { "steam:110000117105464", 500 }, -- kacprax
  { "steam:1100001154b6d70", 500 }, -- Skubi
  { "steam:110000138742db2", 500 }, -- tomeczek
  { "steam:110000136a5ec01", 500 }, -- tomeczek
  { "steam:110000135947038", 500 }, -- ponczek
  { "steam:11000011ca69491", 500 }, -- piesel skiper
  { "steam:11000011405e38b", 500 }, -- jakis chlop co dal boosta
  { "steam:11000011108a16e", 500 }, -- Ku3Bcio
  { "steam:110000136fc0b8b", 500 }, -- olik
  { "steam:110000134398425", 1000 }, -- otomagicznykucyk
  { "steam:110000142b1fbcc", 500 }, -- Myszo Jelen
  { "steam:110000131f5dfe7", 500 }, -- MŁODY
  { "steam:11000013d60ae82", 1000 }, -- twst
  { "steam:11000013c859486", 500 }, -- Pan Bartosz
  { "steam:11000013f5b305c", 500 }, -- krakers
  { "steam:11000013cbb3233", 500 }, -- wajsu
  { "steam:110000141be49e8", 1000 }, -- fresyyx
  { "steam:1100001039cad5a", 1000 }, -- Chwm
  { "steam:110000104025c19", 1000 }, -- Heavy
  { "steam:11000011404a4ff", 500 }, -- Kosmi
  { "steam:11000011cd90344", 1000 }, -- szibson
  { "steam:1100001371c242b", 1000 }, -- szibson
  { "steam:1100001130efc64", 1000 }, -- pepey 110000133874818
  { "steam:11000013c958f25", 1000 }, -- trawapalestresy
  { "steam:110000133874818", 500 }, -- ramiroo
  { "steam:1100001347b43af", 500 }, -- dojczo
  { "steam:1100001432dad7b", 500 }, -- PHELKA
  { "steam:110000135aed685", 1500 }, -- 𝕺𝖑𝖆𝖋𝖚𝖘
  { "steam:11000011c1f7131", 500 }, -- kapiks
  { "steam:11000013d3f72e2", 500 }, -- subscriber
  { "steam:11000010420e522", 500 }, -- ! blejziakk🌌
  { "steam:11000013fbc52f6", 500 }, -- Marchello
  { "steam:11000014169b78f", 1000 }, -- Marchello
  { "steam:110000112a4fab9", 500 }, -- Boski
  { "steam:11000013cd56e60", 1000 }, -- elkretogiganto
  { "steam:11000013ec4cd0d", 1000 }, -- zielikson
  { "steam:110000100000638", 1000 }, -- kubeq
  { "steam:110000132a288c7", 1000 }, -- kubeq2
  { "steam:110000145a0fb38", 1000 }, -- P0LI3H
  { "steam:110000107894fd2", 500 }, -- Eddy
  { "steam:1100001425a6f38", 1000 }, -- ᴠɪᴏʟᴇɴᴛ⁂
  { "steam:110000144737c3b", 1000 }, -- killer
  { "steam:11000011440590c", 500 }, -- martinez
  { "steam:1100001416f1d3e", 500 }, -- martinez
  { "steam:110000145903d5a", 1000 }, -- ?
  { "steam:1100001349ad8c4", 1000 }, -- dominocars
  { "steam:110000111ea329c", 500 }, -- konkurs
  { "steam:110000132c5913f", 500 }, -- konkurs2
  { "steam:110000143dbe656", 1000 }, -- requu
  { "steam:11000013674ce7c", 500 }, -- stasiek
  { "steam:11000011a5d7505", 500 }, -- cherry
  { "steam:1100001445fa8f6", 500 }, -- cherry2
  { "steam:110000111e1bec6", 500 }, -- maro
  { "steam:1100001435f087b", 1000 }, -- marii
  { "steam:11000011980dc04", 500 }, -- Giseppe
  { "steam:110000118d098d3", 1500 }, -- Hancy
  { "steam:110000117d2795b", 1000 }, -- Osjarinjoo
  { "steam:11000011940dde8", 1000 }, -- Skaylaytm
  { "steam:11000011738ba7d", 500 }, -- Pablo
  { "steam:1100001182e60db", 500 }, -- trzebik2
  { "steam:110000142cc1b6c", 500 }, -- trzebik
  { "steam:11000011c43bd2b", 1000 }, -- shadow
  { "steam:11000011a6f2a6b", 500 }, -- ✞𝖆𝖓𝖙𝖊𝖐✞#6645
  { "steam:110000146218f55", 500 }, -- B4N4N
  { "steam:11000013f9d8478", 500 }, -- Hubciu
  { "steam:11000013d4b6d9f", 500 }, -- Nexe
  { "steam:110000142d5e644", 1000 }, -- dolar3k
  { "steam:11000013d292c3d", 1000 }, -- meadas
  { "steam:11000014493a45a", 1000 }, -- Maciejka
  { "steam:11000011a3ab174", 1000 }, -- Maciejka
  { "steam:11000014466acb6", 1000 }, -- x3awi
  { "steam:11000013d8e4da8", 500 }, -- Maupeczka
  { "steam:1100001067bd36e", 1000 }, -- sikorson
  { "steam:110000142943f40", 1000 }, -- deldfin
  { "steam:110000143fba0d6", 1000 }, -- nie wiem
  { "steam:1100001464e1c70", 1000 }, -- hmeeq
  { "steam:1100001447ada36", 1000 }, -- szybka sprawa
  { "steam:11000013c0cccfb", 500 }, -- princei
  { "steam:11000010bce563e", 500 }, -- Mrozu
  { "steam:11000014544de95", 500 }, -- Xayoo Industries
  { "steam:110000135645a85", 1000 }, -- R waw
  { "steam:11000010a61f0d9", 1000 }, -- jaszczurka
  { "steam:110000133d46098", 1000 }, -- dongrande
  { "steam:110000117bdfdd2", 500 }, -- pokczmap
  { "steam:110000144dc3024", 1000 }, -- dzoni
  { "steam:1100001462f9ccd", 1500 }, -- dzoni
  { "steam:110000146add5d8", 1000 }, -- no full auto
  { "steam:11000014024351a", 1000 }, -- AVooon
  { "steam:1100001400e4d49", 1000 }, -- Majorek
  { "steam:1100001363dc446", 1000 }, -- Tje reapoer
  { "steam:110000118810e30", 500 }, -- Banan
  { "steam:110000113e03d7a", 1000 }, -- ᲼᲼᲼
  { "steam:110000104e87bcb", 1000 }, -- konkurs
  { "steam:110000136e4ffe9", 1000 }, -- nikoo
  { "steam:1100001048a1a74", 1000 }, -- dezet
  { "steam:110000117a75d53", 300 }, -- kamilszef
  { "steam:11000011a80dc5f", 1000 }, -- singo
  { "steam:1100001413dd28f", 1000 }, -- !Kawa
  { "steam:11000013c8b75fc", 1000 }, -- wakooooo12
  { "steam:11000010cfcc5c9", 1000 }, -- fxd
  { "steam:110000142dbb5f8", 500 }, -- seuz
  { "steam:110000143019d9f", 500 }, -- !𝕲𝖆𝕹𝖌𝖚𝖘!
  { "steam:11000011d1849db", 500 }, -- Ar1
  { "steam:11000011c3cf74a", 1888 }, -- Agent Tomek
  { "steam:11000013d068396", 500 }, -- Dziadek staszek (mistrz)
  { "steam:11000013df73dc9", 500 }, -- Dziadek staszek (mistrz)
  { "steam:1100001445f9996", 750 }, -- CIUMA
  { "steam:110000145006c8e", 500 }, -- leewhite
  { "steam:11000013746d60d", 500 }, -- swaggi
  { "steam:110000142a21313", 500 }, -- †✘∂αѕzςzΰя✘†™
  { "steam:110000111d429df", 1000 }, -- tibijski zadymiarz
  { "steam:1100001373c85d2", 1000 }, -- wiedzmin
  { "steam:1100001448b6f23", 500 }, -- bedii
  { "steam:11000013b0f694c", 500 }, -- bedii drugie konto
  { "steam:110000145b3eabb", 1000 }, -- killer1337
  { "steam:11000010f0f8e15", 500 }, -- 1872
  { "steam:1100001148a4be8", 500 }, -- stxachu
  { "steam:110000144ae34a4", 500 }, -- stxachu 2
  { "steam:11000013e451df6", 1000 }, -- fifi
  { "steam:1100001452bfb7f", 500 }, -- tvurbina

  -- {'steamID', points},
  -- {'steam:0123456789', 1000}
}
