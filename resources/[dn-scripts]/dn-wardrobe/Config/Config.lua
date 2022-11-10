Config = {
    ['General'] = { -- Basic ting.
        ['CheckForUpdates'] = false -- Om scriptet skal tjekke om du har den nyeste version. (Standard: false)
    },
    ['Notifications'] = {
        ['System'] = 'pNotify', -- Det notifikations system der skal bruges, vælg venligst et system der er installeret på din server. Muligheder: 'vRP', 'pNotify', 'mythic_notify', 'T-Notify' og 'mb_notify'. (Standard: 'pNotify')
        ['Messages'] = { -- Her kan du ændre alle notifikationer.
            ['NameUsed'] = { -- Den notifikation der kommer når man ikke kan gemme et outfit fordi man allerede har et outfit med samme navn.
                ['Msg'] = 'Du har allerede et outfit med det navn. Du kan overskrive det gamle for at opdatere det.', -- Beskeden til den notifikation der kommer når man ikke kan gemme et outfit fordi man allerede har et outfit med samme navn. (Standard: 'Du har allerede et outfit med det navn, du kan overskrive det gamle for at opdatere det.')
                ['Timeout'] = 4500, -- Hvor lang tid (i ms) notifikationen skal være der. Virker ikke til vRP notifikationer. (Standard: 4500)
                ['Type'] = 'fejl', -- Type af notifikation. (Bestemmer ofte farven) (Standard: 'fejl')
                ['Location'] = 'BC', -- Lokation af notifikationen på skærmen. Se under Config for en forklaring. Virker ikke til vRP notifikationer eller mythic notify. (Standard: 'BC')
                ['ProgressBar'] = true -- Om der skal være en "progress bar" som viser hvornår notifikationen er væk. Virker ikke til vRP notifikationer, mythic_notify, mb_notify eller T-Notify. (Standard: true)
            },
            ['BadName'] = { -- Den notifikation der kommer når man ikke kan gemme et outfit fordi navnet man vælger er tomt.
                ['Msg'] = 'Ugyldigt navn. Prøv venligst igen med et andet navn.', -- Beskeden til den notifikation der kommer når man ikke kan gemme et outfit fordi navnet man vælger er tomt. (Standard: 'Ugyldigt navn. Prøv venligst igen med et andet navn.')
                ['Timeout'] = 4500, -- Hvor lang tid (i ms) notifikationen skal være der. Virker ikke til vRP notifikationer. (Standard: 4500)
                ['Type'] = 'fejl', -- Type af notifikation. (Bestemmer ofte farven) (Standard: 'fejl')
                ['Location'] = 'BC', -- Lokation af notifikationen på skærmen. Se under Config for en forklaring. Virker ikke til vRP notifikationer eller mythic notify. (Standard: 'BC')
                ['ProgressBar'] = true -- Om der skal være en "progress bar" som viser hvornår notifikationen er væk. Virker ikke til vRP notifikationer, mythic_notify, mb_notify eller T-Notify. (Standard: true)
            }
        },
        ['vRPTypeColors'] = { -- Hvilke farver der skal bruges til de forskellige typer af notifikationer.
            ['fejl'] = '~r~', -- Type = 'fejl'. (Standard: '~r~')
            ['success'] = '~g~', -- Type = 'success'. (Standard: '~g~')
            ['info'] = '~b~' -- Type = 'info'. (Standard: '~b~')
        }
    },
    ['Menus'] = { -- Indstillinger til alle menuer.
        ['Garderobe'] = { -- Menuen der kommer frem når man åbner garderoben.
            ['Navn'] = 'Garderobe', -- Hvilket navn menuen skal have. (Standard: 'Garderobe')
            ['Color'] = nil, -- Hvilken baggrundsfarve menuen's header skal have. Skal skrives som CSS, ligesom der her: 'rgb(0, 255, 0)' hvilket er grøn. Kan også være nil for ikke at vælge en specifik farve. (Standard: nil)
            ['Buttons'] = { -- Indstillinger til de knapper der er i menuen.
                ['SaveNewOutfit'] = { -- Knappen til at gemme et nyt outfit med nuværende tøj.
                    ['Name'] = '> Gem nyt outfit', -- Navnet af knappen. (Standard: '> Gem nyt outfit')
                    ['Description'] = 'Gem et nyt outfit med dit nuværende tøj.' -- Beskrivelsen af knappen. (Standard: 'Gem et nyt outfit med dit nuværende tøj.')
                },
                ['Outfit'] = { -- Knappen der er til hvert outfit. (Navnet kan ikke ændres da det automatisk er navnet af outfittet.)
                    ['Description'] = 'Se muligheder for dette outfit.' -- Beskrivelsen af knappen. (Standard: 'Se muligheder for dette outfit.')
                }
            }
        },
        ['Outfit'] = { -- Menuen der kommer frem når man trykker på et outfit.
            ['Prefix'] = 'Outfit - ', -- Det tekst der skal stå foran navnet af outfittet i menuens header. (Standard: 'Outfit - ')
            ['Color'] = nil, -- Hvilken baggrundsfarve menuen's header skal have. Skal skrives som CSS, ligesom der her: 'rgb(0, 255, 0)' hvilket er grøn. Kan også være nil for ikke at vælge en specifik farve. (Standard: nil)
            ['Buttons'] = { -- Indstillinger til de knapper der er i menuen.
                ['Anvend'] = { -- Knappen til at bruge det outfit man har trykket på.
                    ['Name'] = 'Anvend', -- Navnet af knappen. (Standard: 'Anvend')
                    ['Description'] = 'Anvend dette outfit.' -- Beskrivelsen af knappen. (Standard: 'Anvend dette outfit.')
                },
                ['Overskriv'] = { -- Knappen til at overskrive det outfit man har trykket på.
                    ['Name'] = 'Overskriv', -- Navnet af knappen. (Standard: 'Overskriv')
                    ['Description'] = 'Overskriv dette outfit med dit nuværende tøj.' -- Beskrivelsen af knappen. (Standard: 'Overskriv dette outfit med dit nuværende tøj.')
                },
                ['Slet'] = { -- Knappen til at slette det outfit man har trykket på.
                    ['Name'] = 'Slet', -- Navnet af knappen. (Standard: 'Slet')
                    ['Description'] = 'Slet dette outfit.' -- Beskrivelsen af knappen. (Standard: 'Slet dette outfit.')
                }
            }
        }
    },
    ['Blips'] = { -- Indstillinger til blips.
        ['Enabled'] = false, -- Om der skal være en blip på kortet. (Standard: false (Blips vises ikke))
        ['Type'] = 73, -- Hvilken type blip der skal vises på kortet, alle blips kan findes her: https://docs.fivem.net/docs/game-references/blips/ (Standard: 73 (T-Shirt ikon))
        ['Color'] = 1, -- Hvilken farve blips på kortet skal have, alle farver kan findes i bunden af denne side: https://docs.fivem.net/docs/game-references/blips/ (Standard: 1 (Rød))
        ['Navn'] = 'Garderobe' -- Hvilket navn blipsne på kortet skal have. (Standard: 'Garderobe')
    },
    ['Markers'] = { -- Indstillinger til markers.
        ['Enabled'] = true, -- Om der skal være en marker på jorden. (Standard: true (Markers vises))
        ['R'] = 255, -- R delen af RGB farven. (Standard: 255)
        ['G'] = 35, -- G delen af RGB farven. (Standard: 30)
        ['B'] = 35 -- B delen af RGB farven. (Standard: 30)
    },
    ['Locations'] = { -- Positioner hvor der skal være en garderobe. (Standard: Alle tøjbutikker)
        {
            ['X'] = 428.4245300293, -- X koordinatet af positionen.
            ['Y'] = -799.13848876953, -- Y koordinatet af positionen.
            ['Z'] = 29.491121292114, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = 457.87490844727, -- X koordinatet af positionen.
            ['Y'] = -988.79724121094, -- Y koordinatet af positionen.
            ['Z'] = 30.689332962036, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = 300.31643676758, -- X koordinatet af positionen.
            ['Y'] = -595.12176513672, -- Y koordinatet af positionen.
            ['Z'] = 43.283988952637, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = 125.95215606689, -- X koordinatet af positionen.
            ['Y'] = -222.29319763184, -- Y koordinatet af positionen.
            ['Z'] = 54.55786895752, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = -158.69647216797, -- X koordinatet af positionen.
            ['Y'] = -298.07907104492, -- Y koordinatet af positionen.
            ['Z'] = 39.733276367188, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = -1196.7733154297, -- X koordinatet af positionen.
            ['Y'] = -769.82202148438, -- Y koordinatet af positionen.
            ['Z'] = 17.31721496582, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = -3169.9538574219, -- X koordinatet af positionen.
            ['Y'] = 1046.958984375, -- Y koordinatet af positionen.
            ['Z'] = 20.863212585449, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = 8.9369354248047, -- X koordinatet af positionen.
            ['Y'] = 6518.66015625, -- Y koordinatet af positionen.
            ['Z'] = 31.878038406372, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = 1690.7781982422, -- X koordinatet af positionen.
            ['Y'] = 4829.7202148438, -- Y koordinatet af positionen.
            ['Z'] = 42.074565887451, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        },
        {
            ['X'] = 104.52131652832, -- X koordinatet af positionen.
            ['Y'] = -1302.9869384766, -- Y koordinatet af positionen.
            ['Z'] = 28.76877784729, -- Z koordinatet af positionen.
            ['Radius'] = 2 -- Hvor langt væk man kan stå fra koordinaterne mens menuen stadig vises.
        }
    }
}

--[[
    Forklaring af notifikations lokationer.
        Første bogstav (lodret position):
            T: Toppen af skærmen. (Top)
            B: Bunden af skærmen. (Bottom)

        Andet bogstav (vandret position):
            L: Venstre side af skærmen. (Left)
            C: Midten af skærmen. (Center)
            R: Højre side af skærmen. (Right)

    Eksempler:
        BC: I midten og i bunden af skærmen.
        TR: Øverst højre hjørne af skærmen.
        BL: Nederst venstre hjørne af skærmen.
]]--