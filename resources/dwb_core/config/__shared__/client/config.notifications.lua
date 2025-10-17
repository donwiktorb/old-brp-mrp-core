Config.Notifications = {
    Types = {
        ['success'] = "",
        ['warn'] = 'x d',
        ['info'] = ""
    },
    Custom = {
        ['lost-gps'] = {
            sound = {
                type = "gta5",
                name = "CONFIRM_BEEP",


                name2 = "HUD_MINI_GAME_SOUNDSET",
                volume = 1.0
            },
            title = "Hi",
            content = {
                {
                    content = [[
                            <div class="flex">
                            <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            Godzina =
                            </div>
                            ]]
                },
                {
                    content = [[
                            <div class="flex">
                            <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http =//www.w3.org/2000/svg">
                            <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            Lokalizacja =
                            </div>
                            ]]
                }
            },
            -- // content = "Need something?",
            border = 0,
            style = {
                mainDiv = 'bg-black border-t-4 border-green-500 rounded-b text-green-500 px-4 py-3 shadow-md',
                borderDiv = 'bg-green-500 h-0.5 rounded-full transition-all duration-1000',
                borderDivMain = 'bg-green-600 h-0.5 rounded-full transition-all duration-1000',
                -- // img = `https://gtaim-panel.com/wp-content/uploads/2021/10/Screenshot_417.png` ,
                imgClass = "w-10 h-10 rounded-full",
                title = "font-bold",
                content = "text-sm",
                subDiv = "",
                perContent = "py-0.5",
                -- svg = [[
                --             <svg class="w-6 h-6 fill-current mr-4" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-351 153 256 256" xml:space="preserve">
                --             <path id="XMLID_1_" d="M-177.7,334.5c6.3-2.3,12.6-5.2,19.8-8.6c31.9-16.4,51.7-41.7,51.7-41.7s-32.5,0.6-64.4,17  c-4,1.7-7.5,4-10.9,5.7c5.7-7.5,12.1-16.4,18.7-25c25-37.1,31.3-77.3,31.3-77.3s-34.8,21-59.2,58.6c-5.2,7.5-9.8,14.9-13.8,22.7  c1.1-10.3,1.1-22.1,1.1-33.6c0-50-19.8-91.1-19.8-91.1s-19.8,40.5-19.8,91.1c0,12.1,0.6,23.3,1.1,33.6c-4-7.5-8.6-14.9-13.8-22.7  c-25-37.1-59.2-58.6-59.2-58.6s6.3,40,31.3,77.3c6.3,9.2,12.1,17.5,18.7,25c-3.4-2.3-7.5-4-10.9-5.7c-31.9-16.4-64.4-17-64.4-17  s19.8,25.6,51.7,41.7c6.9,3.4,13.2,6.3,19.8,8.6c-4,0.6-8,1.1-12.1,2.3c-30.5,6.4-53.2,23.9-53.2,23.9s27.3,7.5,58.6,1.1  c9.8-2.3,19.8-4.6,27.3-7.5c-1.1,1.1,15.8-8.6,21.6-14.4v60.4h8.6v-61.8c6.3,6.3,22.7,16.4,22.1,14.9c8,2.9,17.5,5.2,27.3,7.5  c30.8,6.3,58.6-1.1,58.6-1.1s-22.1-17.5-53.4-23.8C-169.6,335.7-173.7,335.1-177.7,334.5z"/>
                --             </svg>
                --         ]],
                -- mainTextClass = "flex flex-col gap-1 items-center",
                -- text = "[10-55]",
                -- textClass = "px-1.5"
            }
        },
        ['drugs'] = {
            sound = {
                type = "gta5",
                name = "CONFIRM_BEEP",


                name2 = "HUD_MINI_GAME_SOUNDSET",
                volume = 1.0
            },
            title = "Hi",
            content = {
                {
                    content = [[
                            <div class="flex">
                            <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            Godzina =
                            </div>
                            ]]
                },
                {
                    content = [[
                            <div class="flex">
                            <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http =//www.w3.org/2000/svg">
                            <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            Lokalizacja =
                            </div>
                            ]]
                }
            },
            -- // content = "Need something?",
            border = 0,
            style = {
                mainDiv = 'bg-black border-t-4 border-green-500 rounded-b text-green-500 px-4 py-3 shadow-md',
                borderDiv = 'bg-green-500 h-0.5 rounded-full transition-all duration-1000',
                borderDivMain = 'bg-green-600 h-0.5 rounded-full transition-all duration-1000',
                -- // img = `https://gtaim-panel.com/wp-content/uploads/2021/10/Screenshot_417.png` ,
                imgClass = "w-10 h-10",
                title = "font-bold",
                content = "text-sm",
                subDiv = "",
                perContent = "py-0.5",
                svg = [[
                            <svg class="w-6 h-6 fill-current mr-4" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-351 153 256 256" xml:space="preserve">
                            <path id="XMLID_1_" d="M-177.7,334.5c6.3-2.3,12.6-5.2,19.8-8.6c31.9-16.4,51.7-41.7,51.7-41.7s-32.5,0.6-64.4,17  c-4,1.7-7.5,4-10.9,5.7c5.7-7.5,12.1-16.4,18.7-25c25-37.1,31.3-77.3,31.3-77.3s-34.8,21-59.2,58.6c-5.2,7.5-9.8,14.9-13.8,22.7  c1.1-10.3,1.1-22.1,1.1-33.6c0-50-19.8-91.1-19.8-91.1s-19.8,40.5-19.8,91.1c0,12.1,0.6,23.3,1.1,33.6c-4-7.5-8.6-14.9-13.8-22.7  c-25-37.1-59.2-58.6-59.2-58.6s6.3,40,31.3,77.3c6.3,9.2,12.1,17.5,18.7,25c-3.4-2.3-7.5-4-10.9-5.7c-31.9-16.4-64.4-17-64.4-17  s19.8,25.6,51.7,41.7c6.9,3.4,13.2,6.3,19.8,8.6c-4,0.6-8,1.1-12.1,2.3c-30.5,6.4-53.2,23.9-53.2,23.9s27.3,7.5,58.6,1.1  c9.8-2.3,19.8-4.6,27.3-7.5c-1.1,1.1,15.8-8.6,21.6-14.4v60.4h8.6v-61.8c6.3,6.3,22.7,16.4,22.1,14.9c8,2.9,17.5,5.2,27.3,7.5  c30.8,6.3,58.6-1.1,58.6-1.1s-22.1-17.5-53.4-23.8C-169.6,335.7-173.7,335.1-177.7,334.5z"/>
                            </svg>
                        ]],
                -- mainTextClass = "flex flex-col gap-1 items-center",
                -- text = "[10-55]",
                -- textClass = "px-1.5"
            }
        },

        ['bank_add'] = {
            title = "bank",
            translate = 2,
            content = "bank_add",
            type = "simple",
            style = " bg-black border-t-4 border-green-500 rounded-b px-4 py-3 shadow-md text-green-500",
            svg = [[
                    <svg class="w-6 h-6 fill-current mr-4" version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" >
                    <g>
                        <circle fill="current" cx="32" cy="14" r="3"/>
                        <path fill="current" d="M4,25h56c1.794,0,3.368-1.194,3.852-2.922c0.484-1.728-0.242-3.566-1.775-4.497l-28-17   C33.438,0.193,32.719,0,32,0s-1.438,0.193-2.076,0.581l-28,17c-1.533,0.931-2.26,2.77-1.775,4.497C0.632,23.806,2.206,25,4,25z    M32,9c2.762,0,5,2.238,5,5s-2.238,5-5,5s-5-2.238-5-5S29.238,9,32,9z"/>
                        <rect x="34" y="27" fill="current" width="8" height="25"/>
                        <rect x="46" y="27" fill="current" width="8" height="25"/>
                        <rect x="22" y="27" fill="current" width="8" height="25"/>
                        <rect x="10" y="27" fill="current" width="8" height="25"/>
                        <path fill="current" d="M4,58h56c0-2.209-1.791-4-4-4H8C5.791,54,4,55.791,4,58z"/>
                        <path fill="current" d="M63.445,60H0.555C0.211,60.591,0,61.268,0,62v2h64v-2C64,61.268,63.789,60.591,63.445,60z"/>
                    </g>
                    </svg>
                ]],
        },
        ['bank_remove'] = {
            title = "bank",
            translate = 2,
            content = "bank_remove",
            type = "simple",
            style = " bg-black border-t-4 border-red-500 rounded-b px-4 py-3 shadow-md text-red-500",
            svg = [[
                    <svg class="w-6 h-6 fill-current mr-4" version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" >
                    <g>
                        <circle fill="current" cx="32" cy="14" r="3"/>
                        <path fill="current" d="M4,25h56c1.794,0,3.368-1.194,3.852-2.922c0.484-1.728-0.242-3.566-1.775-4.497l-28-17   C33.438,0.193,32.719,0,32,0s-1.438,0.193-2.076,0.581l-28,17c-1.533,0.931-2.26,2.77-1.775,4.497C0.632,23.806,2.206,25,4,25z    M32,9c2.762,0,5,2.238,5,5s-2.238,5-5,5s-5-2.238-5-5S29.238,9,32,9z"/>
                        <rect x="34" y="27" fill="current" width="8" height="25"/>
                        <rect x="46" y="27" fill="current" width="8" height="25"/>
                        <rect x="22" y="27" fill="current" width="8" height="25"/>
                        <rect x="10" y="27" fill="current" width="8" height="25"/>
                        <path fill="current" d="M4,58h56c0-2.209-1.791-4-4-4H8C5.791,54,4,55.791,4,58z"/>
                        <path fill="current" d="M63.445,60H0.555C0.211,60.591,0,61.268,0,62v2h64v-2C64,61.268,63.789,60.591,63.445,60z"/>
                    </g>
                    </svg>
                ]],
        },
    }
}
