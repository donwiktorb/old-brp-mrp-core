


import React, { useEffect } from 'react'
export default function Store(props) {

    // useEffect(() => {
    //     let bg = document.getElementById('phone-bg-main').style.background
    //     document.getElementById('phone-bg-main').style.background = 'rgb(0,0,0,50)'
    //     return () => {
    //         document.getElementById('phone-bg-main').style.background = bg
    //     }

    // }, [])

    return <div className="w-full h-full">
        <div className="w-full h-max flex flex-col gap-4 py-4 px-0.5">
            <div>
                Soon
            </div>
            {/* {Array(34).fill().map((v, i) => {
                return <div className="flex justify-around items-center w-full h-14 bg-gray-700 rounded-lg p-0.5 px-4" key={`app-store-${i}`}>
                    <div className="w-full h-full flex gap-3">
                        <div className="h-full flex justify-center items-center">
                            <img className="w-10 h-10 object-scale-down origin-center rounded-full" src="https://play-lh.googleusercontent.com/KxqmhoEIe6RwzXwVCI8LGpYoGWIp05ketQ_dR2ZIbJGil7UAhDQeF3LdFdMSNDkn2QKd" alt="LOGO" />
                        </div>
                        <div className="h-full flex flex-col text-sm justify-center text-left">
                            <div>
                                DarkChat
                            </div>
                            <div className="text-xs truncate">
                                Aplikacja do czatowania
                            </div>
                        </div>
                    </div>
                    <div className="h-full flex justify-center items-center">
                        <div className="w-9 h-9 rounded-full border-[3px] p-[4px] hover:text-blue-500 hover:border-blue-500 transition-all group/download">
                            <svg className="w-full h-full group-hover/download:scale-90 transition-all" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <title />
                                <g id="Complete">
                                    <g id="download">
                                        <g>
                                            <path d="M3,12.3v7a2,2,0,0,0,2,2H19a2,2,0,0,0,2-2v-7" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" />
                                            <g>
                                                <polyline data-name="Right" fill="none" id="Right-2" points="7.9 12.3 12 16.3 16.1 12.3" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" />
                                                <line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="12" x2="12" y1="2.7" y2="14.2" />
                                            </g>
                                        </g>
                                    </g>
                                </g>
                            </svg>
                        </div>
                    </div>
                </div>
            })} */}
        </div>
    </div>
}