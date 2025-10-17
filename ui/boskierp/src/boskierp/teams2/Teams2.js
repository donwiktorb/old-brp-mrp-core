
import React from 'react'
import sendMessage from '../../Api'

export default class Team extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            messages: {
                "choose": "Wybierz stronę",
                "join": "Dołącz",
                "players": "Członków",
                "warn": "Uwaga!",
                "warn_message": "Pamiętaj, że organizację wybierasz tylko raz!"
            },
            teams: [
                {
                    label: "Ballas",
                    value: "ballas",
                    class: "text-pink-500",
                    img: "https://img.gta5-mods.com/q95/images/ballas-gang-custom-map-v1/caa6d1-2015-11-28_00015%20-%20Copy.jpg"
                },
                {
                    label: "Grove Street",
                    value: "gs",
                    class: "text-green-500",
                    img: "https://www.igrandtheftauto.com/img/content/640x0/1671.jpg"
                },
                {
                    label: "Vagos",
                    value: "vago",
                    class: "text-yellow-500",
                    img: "https://staticg.sportskeeda.com/editor/2021/08/e9547-16294903374892-800.jpg"
                },
                {
                    label: "LSPD",
                    value: "lspd",
                    class: "text-blue-500",
                    img: "https://img.gta5-mods.com/q95/images/slicktop-lspd-vapid-interceptor-torrence-add-on/a9a95a-271590_20200726143218_1.png"
                }
            ],
            error: false,
            data: {
                "USA": {
                    players: 0,
                    max: 0
                },
                "RU": {
                    players: 0,
                    max: 0
                }
            }
        }

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
        this.set = this.set.bind(this)
    } 

    set(data4) {
        this.setState({data:data4})
    }

    open(cdata) {
        this.setState({show:true, data:cdata.data})
        // // this.setState((state) => {
        // //     const data = state.data
        // //     const show = true

        // //     // // cdata.data.forEach((v) => {
        // //     // //     data[v.team.toLowerCase()].players = v.players
        // //     // // })

        // //    return {
        // //         show,
        // //         data
        // //    } 
        // // })
    }

    close() {
        this.setState({show: false})
    }

    submit(e, type) {
        e.preventDefault()
        sendMessage('menu_submit', {
            current: type,
            name: "teams"
        })
    }

    render() {
        if (!this.state.show) return <div></div>
        return (    
            <div  className={`flex absolute h-screen justify-center items-center z-20 w-screen `} >
                <div className="h-5/6 w-5/6 text-center font-sans rounded-lg bg-gray-900 opacity-90">
                    <div className="h-full w-full flex flex-col rounded-md">
                        <nav className="text-center pt-4 text-4xl text-gray-200 font-bold italic uppercase">
                            <p>{this.state.messages.choose}</p>
                        </nav>
                        <div className="w-full h-full rounded overflow-auto">
                            <div className="w-full h-full flex">
                                {
                                    this.state.teams.map((v) => {
                                        return <div className="w-1/4 h-1/3 ">
                                    <div className="h-full p-2">
                                        <div className="w-full h-full p-4 justify-items-center overflow-auto">
                                            <div className="w-full h-full rounded-lg bg-black relative">
                                                <img className="
                                                    object-center
                                                    w-full h-full
                                                    hover:p-2
                                                    p-2
                                                    transition-all
                                                    hover:opacity-100
                                                " src={v.img} alt="soldier" />
                                                <button onClick={
                                                    (e) => this.submit(e, 'USA')
                                                } className="
                                                    bg-gray-800
                                                    opacity-80
                                                    select-none
                                                    w-full
                                                    p-2
                                                    rounded-b
                                                    hover:bg-gray-600
                                                    transition-all
                                                    absolute
                                                    text-white
                                                    bottom-0
                                                    left-1/2
                                                    -translate-x-1/2
                                                ">
                                                    <h1 className="text-xl">{this.state.messages.join}</h1>
                                                    <p class={v.class}>{v.label}</p>
                                                    {/* <p>{this.state.messages.players}: {this.state.data.USA.players} */}
                                                    {/* /{this.state.data.usa.max} */}
                                                    {/* </p> */}
                                                </button>
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                                    })                                    
                                }
                            </div>
                        </div>
                        <div className="rounded-b-md select-none">
                            <div class="flex p-4 mt-4 text-sm text-red-200 bg-red-900 rounded-b " role="alert">
                                <svg aria-hidden="true" class="flex-shrink-0 inline w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>
                                <span class="sr-only">Info</span>
                            <div>
                                <span class="font-medium">{this.state.messages.warn}!</span> {this.state.messages.warn_message}
                            </div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
        )
    }
} 
