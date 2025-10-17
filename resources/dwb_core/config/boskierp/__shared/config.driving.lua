Config.Driving = {
  Prices = {
    ["dmv"] = 4444,
    ["driving_a"] = 4000,
    ["driving_b"] = 4000,
    ["driving_c"] = 4000,
  },
  Limits = {
    residence = 50,
    town = 80,
    freeway = 120,
  },
  maxErrors = 5,
  Questions = {
    ["dmv"] = {
      {
        label = "Co oznaczają białe linie w oznakowaniu poziomym?",
        answers = {
          { label = "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach", correct = false },
          { label = "Oznaczają zakaz wyprzedzania", correct = false },
          { label = "Oznaczają ograniczenie prędkości do 30mph", correct = false },
          { label = "Rozdzielają pasy ruchu prowadzące w tym samym kierunku", correct = true },
        },
      },
    },
  },
  Points = {
    ["driving_a"] = {
      {
        pos = vector3(255.139, -1400.731, 29.537),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("next_point_speed", Config.Driving.Limits["residence"]), 5000)
        end,
      },

      {
        pos = vector3(271.874, -1370.574, 30.932),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("go_next_point"), 5000)
        end,
      },

      {
        pos = vector3(234.907, -1345.385, 29.542),
        action = function(vehicle, setCurrentZoneType)
          Citizen.CreateThread(function()
            Text:DrawMission(TR("stop_for_ped"), 5000)
            PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", false, 0, true)
            FreezeEntityPosition(vehicle, true)
            Citizen.Wait(4000)

            FreezeEntityPosition(vehicle, false)
            Text:DrawMission(TR("good_lets_cont"), 5000)
          end)
        end,
      },

      {
        pos = vector3(217.821, -1410.520, 28.292),
        action = function(vehicle, setCurrentZoneType)
          setCurrentZoneType("town")

          Citizen.CreateThread(function()
            Text:DrawMission(TR("stop_look_left", Config.Driving.Limits["town"]), 5000)
            PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", false, 0, true)
            FreezeEntityPosition(vehicle, true)
            Citizen.Wait(6000)

            FreezeEntityPosition(vehicle, false)
            Text:DrawMission(TR("good_turn_right"), 5000)
          end)
        end,
      },

      {
        pos = vector3(178.550, -1401.755, 27.725),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("watch_traffic_lightson"), 5000)
        end,
      },

      {
        pos = vector3(113.160, -1365.276, 27.725),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("go_next_point"), 5000)
        end,
      },

      {
        pos = vector3(-73.542, -1364.335, 27.789),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("stop_for_passing"), 5000)
          PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", false, 0, true)
          FreezeEntityPosition(vehicle, true)
          Citizen.Wait(6000)
          FreezeEntityPosition(vehicle, false)
        end,
      },

      {
        pos = vector3(-355.143, -1420.282, 27.868),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("go_next_point"), 5000)
        end,
      },

      {
        pos = vector3(-439.148, -1417.100, 27.704),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("go_next_point"), 5000)
        end,
      },

      {
        pos = vector3(-453.790, -1444.726, 27.665),
        action = function(vehicle, setCurrentZoneType)
          setCurrentZoneType("freeway")

          Text:DrawMission(TR("hway_time", Config.Driving.Limits["freeway"]), 5000)
          PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", false, 0, true)
        end,
      },

      {
        pos = vector3(-463.237, -1592.178, 37.519),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("go_next_point"), 5000)
        end,
      },

      {
        pos = vector3(-900.647, -1986.28, 26.109),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("go_next_point"), 5000)
        end,
      },

      {
        pos = vector3(1225.759, -1948.792, 38.718),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("go_next_point"), 5000)
        end,
      },

      {
        pos = vector3(1225.759, -1948.792, 38.718),
        action = function(vehicle, setCurrentZoneType)
          setCurrentZoneType("town")
          Text:DrawMission(TR("in_town_speed", Config.Driving.Limits["town"]), 5000)
        end,
      },

      {
        pos = vector3(1163.603, -1841.771, 35.679),
        action = function(vehicle, setCurrentZoneType)
          Text:DrawMission(TR("gratz_stay_alert"), 5000)
          PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", false, 0, true)
        end,
      },

      {
        pos = vector3(235.283, -1398.329, 28.921),
        action = function(vehicle, setCurrentZoneType)
          Vehicle:Delete(vehicle)
        end,
      },
    },
  },
  Questions4 = {
    ["driving_a"] = {
      {
        inline = true,
        category = 4,
        label = "Co oznaczają białe linie w oznakowaniu poziomym?",
        checked = true,
        correct = "txt2",
        elements = {
          {
            type = "radio",
            name = "xd",
            label = "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            value = "txt",
          },
          {
            type = "radio",
            name = "xd",
            label = "Oznaczają zakaz wyprzedzania",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd",
            label = "Oznaczają ograniczenie prędkości do 30mph ",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd",
            label = "Rozdzielają pasy ruchu prowadzące w tym samym kierunku ",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Co oznaczają żółte linie w oznakowaniu poziomym?",
        checked = true,
        correct = "txt5",
        img = "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/gettyimages-636854346-b77d32f44cbe0b6103225fb7d93778fd.jpg",
        elements = {
          {
            type = "radio",
            name = "xd1",
            label = "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            value = "txt5",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Oznaczają ograniczenie prędkości do 80mph ",
            value = "txt15",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Oznaczają ograniczenie prędkości do 50mph ",
            value = "txt35",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Rozdzielają pasy ruchu prowadzące w tym samym kierunku ",
            value = "txt25",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co może zrobić kierowca w pojeździe A",
        checked = true,
        correct = "xxxd3",
        img = "https://cdn.discordapp.com/attachments/607315754555015198/1117159269595353168/image.png",
        elements = {
          {
            type = "radio",
            name = "xd4",
            label = "Nic",
            value = "asdad",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w lewo",
            value = "asdadsda",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w lewo i prawo ",
            value = "adsadsad",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w prawo ",
            value = "xxxd3",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Ile wynosi maksymalnie dozwolona dawka alkoholu we krwi podczas jazdy?",
        checked = true,
        correct = "xxxd5",
        elements = {
          {
            type = "radio",
            name = "xd5",
            label = "0.08 promila",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.04 promila",
            value = "tsdsdsdsad",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.2 promila",
            value = "txt3sdasdas",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.0 promila",
            value = "txt2sdsdsd",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Ile wynosi maksymalna prędkość na drodze w mieście?",
        checked = true,
        correct = "txt255",
        img = "https://cdn.discordapp.com/attachments/607315754555015198/1117159269595353168/image.png",
        elements = {
          {
            type = "radio",
            name = "xd6",
            label = "75mph",
            value = "xxxd5sdadsa",
          },
          {
            type = "radio",
            name = "xd6",
            label = "65mph",
            value = "txt1sdada",
          },
          {
            type = "radio",
            name = "xd6",
            label = "30mph",
            value = "txt3sdsdsd",
          },
          {
            type = "radio",
            name = "xd6",
            label = "35mph",
            value = "txt255",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Ile wynosi maksymalna prędkość na drodze publicznej poza miastem/highway",
        checked = true,
        correct = "txt155",
        img = "https://eerucg9262h.exactdn.com/wp-content/uploads/Depositphotos_17393531_s-2019.jpg",
        elements = {
          {
            type = "radio",
            name = "xd7",
            label = "60mph",
            value = "xxxd5sdsdad",
          },
          {
            type = "radio",
            name = "xd7",
            label = "65mph",
            value = "txt155",
          },
          {
            type = "radio",
            name = "xd7",
            label = "70mph",
            value = "txt3sdsdad",
          },
          {
            type = "radio",
            name = "xd7",
            label = "50mph",
            value = "txt2sdadass",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Co oznaczają te dwa znaki?",
        checked = true,
        correct = "txt1",
        img = "https://s7d2.scene7.com/is/image/TWCNews/1007_bn9_four_waystopjpg",
        elements = {
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, który jedzie prosto przez skrżyżowanie ignoruje go.",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, który pierwszy dojedzie do skrzyżowania ma pierwszeństwo",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, chcę skręcić w prawo zawsze ma pierwszeństwo",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Wszystkie odpowiedzi są poprawne",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Co oznacza ten znak",
        checked = true,
        correct = "xxxd5",
        img = "https://www.dmv.ca.gov/portal/uploads/2020/02/schoolzone.png",
        elements = {
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, jesteś blisko szkoły",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, chodnik jest blisko jezdni",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, brak chodnika",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, brak przejścia dla pieszych",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Prawidłowe wyprzedzanie pokazuje obrazek numer:",
        checked = true,
        correct = "xxxd5",
        img = "https://media.discordapp.net/attachments/607315754555015198/1117472440453439548/image.png",
        elements = {
          {
            type = "radio",
            name = "xd10",
            label = "Numer 1.",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd10",
            label = "Numer 2",
            value = "txt1",
          },
        },
      },
      {
        inline = true,
        category = 4,
        label = "Co należy robić podczas kontroli policyjnej?",
        checked = true,
        correct = "txt1",
        img = "https://www.ultimatedefensivedriving.us/wp-content/uploads/2023/02/police.jpg",
        elements = {
          {
            type = "radio",
            name = "xd8",
            label = "Nie robić gwałtownych ruchów",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Nie wysiadać z pojazdu",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Nie sięgać do schowka bez zezwolenia",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Wszystkie odpowiedzi są poprawne",
            value = "txt2",
          },
        },
      },
    },
    ["driving_b"] = {
      {
        inline = true,
        category = 4,
        name = "Co oznaczają białe linie w oznakowaniu poziomym?",
        checked = true,
        correct = "txt2",
        elements = {
          {
            type = "radio",
            name = "xd",
            label = "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            value = "txt",
          },
          {
            type = "radio",
            name = "xd",
            label = "Oznaczają zakaz wyprzedzania",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd",
            label = "Oznaczają ograniczenie prędkości do 30mph ",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd",
            label = "Rozdzielają pasy ruchu prowadzące w tym samym kierunku ",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co oznaczają żółte linie w oznakowaniu poziomym?",
        checked = true,
        correct = "txt",
        img = "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/gettyimages-636854346-b77d32f44cbe0b6103225fb7d93778fd.jpg",
        elements = {
          {
            type = "radio",
            name = "xd1",
            label = "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            value = "txt",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Oznaczają ograniczenie prędkości do 80mph ",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Oznaczają ograniczenie prędkości do 50mph ",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Rozdzielają pasy ruchu prowadzące w tym samym kierunku ",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co może zrobić kierowca w pojeździe A",
        checked = true,
        correct = "xxxd3",
        img = "https://cdn.discordapp.com/attachments/607315754555015198/1117159269595353168/image.png",
        elements = {
          {
            type = "radio",
            name = "xd4",
            label = "Nic",
            value = "txt",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w lewo",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w lewo i prawo ",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w prawo ",
            value = "xxxd3",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Ile wynosi maksymalnie dozwolona dawka alkoholu we krwi podczas jazdy?",
        checked = true,
        correct = "xxxd5",
        elements = {
          {
            type = "radio",
            name = "xd5",
            label = "0.08 promila",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.04 promila",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.2 promila",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.0 promila",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Ile wynosi maksymalna prędkość na drodze w mieście?",
        checked = true,
        correct = "txt2",
        img = "https://cdn.discordapp.com/attachments/607315754555015198/1117159269595353168/image.png",
        elements = {
          {
            type = "radio",
            name = "xd6",
            label = "75mph",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd6",
            label = "65mph",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd6",
            label = "30mph",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd6",
            label = "35mph",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Ile wynosi maksymalna prędkość na drodze publicznej poza miastem/highway",
        checked = true,
        correct = "txt1",
        img = "https://eerucg9262h.exactdn.com/wp-content/uploads/Depositphotos_17393531_s-2019.jpg",
        elements = {
          {
            type = "radio",
            name = "xd7",
            label = "60mph",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd7",
            label = "65mph",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd7",
            label = "70mph",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd7",
            label = "50mph",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co oznaczają te dwa znaki?",
        checked = true,
        correct = "txt1",
        img = "https://s7d2.scene7.com/is/image/TWCNews/1007_bn9_four_waystopjpg",
        elements = {
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, który jedzie prosto przez skrżyżowanie ignoruje go.",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, który pierwszy dojedzie do skrzyżowania ma pierwszeństwo",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, chcę skręcić w prawo zawsze ma pierwszeństwo",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Wszystkie odpowiedzi są poprawne",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co oznacza ten znak",
        checked = true,
        correct = "xxxd5",
        img = "https://www.dmv.ca.gov/portal/uploads/2020/02/schoolzone.png",
        elements = {
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, jesteś blisko szkoły",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, chodnik jest blisko jezdni",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, brak chodnika",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, brak przejścia dla pieszych",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Prawidłowe wyprzedzanie pokazuje obrazek numer:",
        checked = true,
        correct = "xxxd5",
        img = "https://media.discordapp.net/attachments/607315754555015198/1117472440453439548/image.png",
        elements = {
          {
            type = "radio",
            name = "xd10",
            label = "Numer 1.",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd10",
            label = "Numer 2",
            value = "txt1",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co należy robić podczas kontroli policyjnej?",
        checked = true,
        correct = "txt1",
        img = "https://www.ultimatedefensivedriving.us/wp-content/uploads/2023/02/police.jpg",
        elements = {
          {
            type = "radio",
            name = "xd8",
            label = "Nie robić gwałtownych ruchów",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Nie wysiadać z pojazdu",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Nie sięgać do schowka bez zezwolenia",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Wszystkie odpowiedzi są poprawne",
            value = "txt2",
          },
        },
      },
    },
    ["driving_c"] = {
      {
        inline = true,
        category = 4,
        name = "Co oznaczają białe linie w oznakowaniu poziomym?",
        checked = true,
        correct = "txt2",
        elements = {
          {
            type = "radio",
            name = "xd",
            label = "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            value = "txt",
          },
          {
            type = "radio",
            name = "xd",
            label = "Oznaczają zakaz wyprzedzania",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd",
            label = "Oznaczają ograniczenie prędkości do 30mph ",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd",
            label = "Rozdzielają pasy ruchu prowadzące w tym samym kierunku ",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co oznaczają żółte linie w oznakowaniu poziomym?",
        checked = true,
        correct = "txt",
        img = "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/gettyimages-636854346-b77d32f44cbe0b6103225fb7d93778fd.jpg",
        elements = {
          {
            type = "radio",
            name = "xd1",
            label = "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            value = "txt",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Oznaczają ograniczenie prędkości do 80mph ",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Oznaczają ograniczenie prędkości do 50mph ",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd1",
            label = "Rozdzielają pasy ruchu prowadzące w tym samym kierunku ",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co może zrobić kierowca w pojeździe A",
        checked = true,
        correct = "xxxd3",
        img = "https://cdn.discordapp.com/attachments/607315754555015198/1117159269595353168/image.png",
        elements = {
          {
            type = "radio",
            name = "xd4",
            label = "Nic",
            value = "txt",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w lewo",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w lewo i prawo ",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd4",
            label = "Skręcić w prawo ",
            value = "xxxd3",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Ile wynosi maksymalnie dozwolona dawka alkoholu we krwi podczas jazdy?",
        checked = true,
        correct = "xxxd5",
        elements = {
          {
            type = "radio",
            name = "xd5",
            label = "0.08 promila",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.04 promila",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.2 promila",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd5",
            label = "0.0 promila",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Ile wynosi maksymalna prędkość na drodze w mieście?",
        checked = true,
        correct = "txt2",
        img = "https://cdn.discordapp.com/attachments/607315754555015198/1117159269595353168/image.png",
        elements = {
          {
            type = "radio",
            name = "xd6",
            label = "75mph",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd6",
            label = "65mph",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd6",
            label = "30mph",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd6",
            label = "35mph",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Ile wynosi maksymalna prędkość na drodze publicznej poza miastem/highway",
        checked = true,
        correct = "txt1",
        img = "https://eerucg9262h.exactdn.com/wp-content/uploads/Depositphotos_17393531_s-2019.jpg",
        elements = {
          {
            type = "radio",
            name = "xd7",
            label = "60mph",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd7",
            label = "65mph",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd7",
            label = "70mph",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd7",
            label = "50mph",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co oznaczają te dwa znaki?",
        checked = true,
        correct = "txt1",
        img = "https://s7d2.scene7.com/is/image/TWCNews/1007_bn9_four_waystopjpg",
        elements = {
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, który jedzie prosto przez skrżyżowanie ignoruje go.",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, który pierwszy dojedzie do skrzyżowania ma pierwszeństwo",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Pojazd, chcę skręcić w prawo zawsze ma pierwszeństwo",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Wszystkie odpowiedzi są poprawne",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co oznacza ten znak",
        checked = true,
        correct = "xxxd5",
        img = "https://www.dmv.ca.gov/portal/uploads/2020/02/schoolzone.png",
        elements = {
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, jesteś blisko szkoły",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, chodnik jest blisko jezdni",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, brak chodnika",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd9",
            label = "Uważaj, brak przejścia dla pieszych",
            value = "txt2",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Prawidłowe wyprzedzanie pokazuje obrazek numer:",
        checked = true,
        correct = "xxxd5",
        img = "https://media.discordapp.net/attachments/607315754555015198/1117472440453439548/image.png",
        elements = {
          {
            type = "radio",
            name = "xd10",
            label = "Numer 1.",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd10",
            label = "Numer 2",
            value = "txt1",
          },
        },
      },
      {
        inline = true,
        category = 4,
        name = "Co należy robić podczas kontroli policyjnej?",
        checked = true,
        correct = "txt1",
        img = "https://www.ultimatedefensivedriving.us/wp-content/uploads/2023/02/police.jpg",
        elements = {
          {
            type = "radio",
            name = "xd8",
            label = "Nie robić gwałtownych ruchów",
            value = "xxxd5",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Nie wysiadać z pojazdu",
            value = "txt1",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Nie sięgać do schowka bez zezwolenia",
            value = "txt3",
          },
          {
            type = "radio",
            name = "xd8",
            label = "Wszystkie odpowiedzi są poprawne",
            value = "txt2",
          },
        },
      },
    },
  },
}

Config.Driving.Zones = {
  ["driving_a"] = {
    vehicle = "futo",
    type = "drivin",
    name = "drivin",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overridepos = true,
      drawMarker = true,
      createBlips = true,
      autoRoute = true,
      displayOnlyFirst = true,
      removeOnEnter = true,
      dynamicBlips = true,
    },
    marker = {
      type = 20,
      scale = vec3(3.0, 3.0, 3.0),
      color = {
        r = 178,
        g = 255,
        b = 25,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    messages = {},
    coords = {
      {
        pos = vec3(83.97, -1934.4, 20.7),
      },
    },
    label = "Trasa",
    blip = {
      label = "Trasa",
      category = 20,
      color = 3,
      scale = 0.9,
      sprite = 682,
      shortRange = true,
      display = 4,
    },
  },
}
