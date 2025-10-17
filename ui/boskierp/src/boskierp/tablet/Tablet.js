import React from 'react'
import { Routes, Route, Link } from "react-router-dom";
import Main from './pages/Main'
import Database from './pages/Database'
import File from './pages/File'
import Jail from './pages/Jail'
import Ticket from './pages/Ticket'
import Crimes from './pages/Crimes'
import Manage from './pages/Manage'
import Mainambulance from './pages/MainAMR'
import Tariff from './pages/Tariff'
import Dispatch from './pages/Dispatch'
import MainLSC from './pages/MainLSC'
import Tune from './pages/Tune'
import Ticket2 from './pages/Ticket2'
import sendMessage from '../../Api';
import Manage2 from './pages/Manage2'
import Tariff2 from './pages/Tariff2'
import Ticket3 from './pages/Ticket3'

export default class TabletPolice extends React.Component {
    constructor(props) {
        super(props)
        this.routes = {
            police: [{
                path: "/",
                element: <Main />
            },
            {
                path: "/db",
                element: <Database />
            },
            {
                path: "/jail",
                element: <Jail />
            },
            {
                path: "/crimes",
                element: <Crimes />
            },
            {
                path: "/ticket",
                element: <Ticket />
            },
            {
                path: "/file/:id",
                element: <File />
            },
            {
                path: "/manage",
                element: <Manage2 />
            },
            {
                path: "/dispatch",
                element: <Dispatch />
            }
            ],
            ambulance: [
                {
                    path: "/",
                    element: <Mainambulance />
                },
                {
                    path: "/db",
                    element: <Database />
                },
                {
                    path: "/jail",
                    element: <Jail />
                },
                {
                    path: "/tariff",
                    element: <Tariff />
                },
                {
                    path: "/ticket",
                    element: <Ticket2 />
                },
                {
                    path: "/file/:id",
                    element: <File />
                },
                {
                    path: "/manage",
                    element: <Manage2 />
                }
            ],
            mechanic: [
                {
                    path: "/",
                    element: <MainLSC />
                },
                {
                    path: "/db",
                    element: <Database />
                },
                {
                    path: "/tariff",
                    element: <Tariff2 />
                },
                {
                    path: "/ticket",
                    element: <Ticket3 />
                },
                {
                    path: "/tune",
                    element: <Tune />
                },
                {
                    path: "/file/:id",
                    element: <File />
                },

                {
                    path: "/manage",
                    element: <Manage2 />
                }
            ],
            justice: [                {
                    path: "/",
                    element: <MainLSC />
                },
                {
                    path: "/db",
                    element: <Database />
                },
                {
                    path: "/tariff",
                    element: <Tariff2 />
                },
                {
                    path: "/ticket",
                    element: <Ticket3 />
                },
                {
                    path: "/tune",
                    element: <Tune />
                },
                {
                    path: "/file/:id",
                    element: <File />
                },

                {
                    path: "/manage",
                    element: <Manage2 />
                }]
        }

        this.logos = {
            ambulance: "https://static.wikia.nocookie.net/wyspa/images/0/04/EMS.png/revision/latest?cb=20210514101135&path-prefix=pl",
            police: "https://www.clipartmax.com/png/full/139-1391304_in-2004-congress-established-the-national-counterterrorism-los-santos-police-department.png",
            mechanic: "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
            justice: "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
        }

        this.topLinks = {
            ambulance: [
                {
                    label: "Main page",
                    value: ""
                },
                {
                    label: "Baza danych",
                    value: "db"
                },
                {
                    label: "Taryfikator",
                    value: "tariff"
                },
                {
                    label: "Faktura",
                    value: "ticket"
                },
                {
                    label: "Manage",
                    value: "manage"
                }
            ],
            police: [
                {
                    label: "Main page",
                    value: ""
                },
                {
                    label: "Baza danych",
                    value: "db"
                },
                {
                    label: "Taryfikator",
                    value: "crimes"
                },
                {
                    label: "Jail",
                    value: "jail"
                },
                {
                    label: "Ticket",
                    value: "ticket"
                },
                {
                    label: "Manage",
                    value: "manage"
                },
                {
                    label: "Dispatch",
                    value: "dispatch"
                }
            ],
            mechanic: [
                {
                    label: "Main page",
                    value: ""
                },
                {
                    label: "Baza danych",
                    value: "db"
                },
                {
                    label: "Taryfikator",
                    value: "tariff"
                },

                {
                    label: "Ticket",
                    value: "ticket"
                },
                {
                    label: "Manage",
                    value: "manage"
                }
            ],
            justice: [
                {
                    label: "Main page",
                    value: ""
                },
                {
                    label: "Baza danych",
                    value: "db"
                },
                {
                    label: "Taryfikator",
                    value: "tariff"
                },

                {
                    label: "Ticket",
                    value: "ticket"
                },
                {
                    label: "Manage",
                    value: "manage"
                }
            ]
        }

        this.state = {
            currentJ: 'mechanic',
            show: false,
        }
        this.designs={
                ambulance: {
                    tablet: "",
                    nav: "h-min rounded-t-lg bg-pink-900",
                    main: "bg-pink-900 w-full h-full rounded-b opacity-90 overflow-auto",
                    button: "border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-pink-600 text-pink-400 hover:text-white hover:bg-pink-600 focus:ring-pink-800"
                },
                police: {
                    tablet: "",
                    nav: "h-min rounded-t-lg bg-gray-800",
                    main: "bg-gray-800 w-full h-full rounded-b opacity-90 overflow-auto",
                    button: "border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-gray-600 text-gray-400 hover:text-white hover:bg-gray-600 focus:ring-gray-800"
                },
                mechanic: {
                    tablet: "",
                    nav: "h-min rounded-t-lg bg-yellow-800",
                    main: "bg-yellow-800 w-full h-full rounded-b opacity-90 overflow-auto",
                    button: "border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-yellow-600 text-yellow-400 hover:text-white hover:bg-yellow-600 focus:ring-gray-800"
                },
                justice: {
                    tablet: "",
                    nav: "h-min rounded-t-lg bg-gray-800",
                    main: "bg-gray-800 w-full h-full rounded-b opacity-90 overflow-auto",
                    button: "border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-gray-600 text-gray-400 hover:text-white hover:bg-gray-600 focus:ring-gray-800"
                }
            }

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
    }

    setCrimeMsg = (val) => {
        this.crimeMsg = val
    }

    setCrimeVals = (time, money) => {
        this.crimeMoney = money
        this.crimeTime = time
    }

    open(data) {
        this.setState(
            data
        )
    }

    close(data) {
        this.setState(
            {
                show: false
            }
        )
    }

    shut = (e) => {
        sendMessage("menu_cancel", {
            name: this.state.name || 'tablet'
        })
        // // this.setState({ show: false })
    }

    reload = (e) => {
        // window.location.reload(false)
    }

    render() {
        if (!this.state.show) return <></>
        return (
            <div className={`flex h-screen justify-center items-center w-full absolute z-20 `} >
                <div id="tablet" className="h-5/6 w-5/6 text-center font-sans rounded-lg bg-black bg-opacity-80 opacity-90">
                    <div className="h-full w-full bg-black flex flex-col rounded-t-md">
                        <nav className={this.designs[this.state.currentJ].nav}>
                            <div className="mx-auto w-max px-2 sm:px-6 lg:px-8">
                                <div className="relative flex h-16 items-center justify-between">
                                    <div className="flex flex-1 items-center justify-center">
                                        <div className="flex flex-shrink-0 items-center">
                                            <img src={this.logos[this.state.currentJ]} className="block h-10 w-10" alt="logo" />
                                        </div>
                                        <div className="hidden sm:ml-6 sm:block">
                                            <div className="flex space-x-4">
                                                {this.topLinks[this.state.currentJ].map((v) => {
                                                    return <Link to={v.value}>
                                                        <button type="button" className={this.designs[this.state.currentJ].button}>{v.label}</button>
                                                    </Link>
                                                })}
                                                <button onClick={this.shut} type="button" className={this.designs[this.state.currentJ].button}>Zamknij</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </nav>
                        <div className={this.designs[this.state.currentJ].main}>
                            <Routes>
                                {this.routes[this.state.currentJ].map((v) => {
                                    return <Route path={v.path} element={v.element} />
                                })}
                            </Routes>
                        </div>
                        <div className="text-white rounded-b-md bg-gray-800">
                        </div>
                    </div>
                </div>
            </div>

        );
    }
}
