import React from 'react'
import { Routes, Route, Link } from "react-router-dom";
import Main from './pages/Main'
import Database from './pages/Database'
import File from './pages/File'
import Jail from './pages/Jail'
import Ticket from './pages/Ticket'

export default class Tablet extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            showDropdown: false,
            location: '/base/static/ui/build',
            people: [
            ]
        }
        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
    }

    open(data) {
        this.setState(
            {
                show: true
            }
        )
    }

    close(data) {
        this.setState(
            {
                show: false
            }
        )
    }

    toggledropdown(e, state) {
        this.setState({ showDropdown: state })
    }

    render() {
        if (!this.state.show) return <></>
        return (
            <div className={`flex h-screen justify-center items-center w-full absolute z-20 `} >
                {/* overflow-hidden*/}<div id="tablet" className="h-5/6 w-5/6 text-center font-sans rounded-lg bg-black bg-opacity-80">
                    <div className="h-full w-full bg-black flex flex-col rounded-md">
                        <nav className="h-min rounded-lg bg-gray-800">
                            <div className="mx-auto w-max px-2 sm:px-6 lg:px-8">
                                <div className="relative flex h-16 items-center justify-between">
                                    <div className="absolute inset-y-0 left-0 flex items-center sm:hidden">
                                        <button type="button" className="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white" aria-controls="mobile-menu" aria-expanded="false">
                                            <span className="sr-only">open main menu</span>

                                            <svg className="block h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" strokeWidth="1.5" stroke="currentcolor" aria-hidden="true">
                                                <path strokeLinecap="round" strokeLinejoin="round" d="m3.75 6.75h16.5m3.75 12h16.5m-16.5 5.25h16.5" />
                                            </svg>

                                            <svg className="hidden h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" strokeWidth="1.5" stroke="currentcolor" aria-hidden="true">
                                                <path strokeLinecap="round" strokeLinejoin="round" d="m6 18l18 6m6 6l12 12" />
                                            </svg>
                                        </button>
                                    </div>
                                    <div className="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
                                        <div className="flex flex-shrink-0 items-center">
                                            <img src="https://www.clipartmax.com/png/full/139-1391304_in-2004-congress-established-the-national-counterterrorism-los-santos-police-department.png" className="block h-10 w-10" alt="lspd logo" />
                                            {/* <img className="block h-8 w-auto lg:hidden" src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=500" alt="your company"/>
                                <img className="hidden h-8 w-auto lg:block" src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=500" alt="your company"/> */}
                                        </div>
                                        <div className="hidden sm:ml-6 sm:block">
                                            <div className="flex space-x-4">
                                                <Link to={``}>
                                                    <button type="button" className="text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Strona główna</button>
                                                </Link>
                                                <div>
                                                    {/* <Link to={`db`}> */}
                                                    <button type="button" onClick={(e) => this.toggledropdown(e, true)} data-dropdown-toggle="dropdown" className="text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Baza danych</button>
                                                    <div id="dropdown" style={{ display: this.state.showDropdown ? 'block' : 'none' }} className="hidden absolute z-10 w-44 bg-white m-2 rounded divide-y divide-gray-100 shadow dark:bg-gray-700">
                                                        <ul className="py-1 text-sm text-gray-700 dark:text-gray-200" aria-labelledby="dropdowndefault" onMouseLeave={(e) => this.toggledropdown(e, false)}>
                                                            <li>

                                                                <Link to={`db`}>
                                                                    <button className="block w-full py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Wyszukaj</button>
                                                                </Link>
                                                            </li>
                                                            <li>
                                                                <button className="w-full block py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Poszukiwani</button>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                    {/* </Link> */}
                                                </div>
                                                <Link to={`file`}>
                                                    <button type="button" className="text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Taryfikator</button>
                                                </Link>
                                                <Link to={`jail`}>
                                                    <button type="button" className="text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Więzienie</button>
                                                </Link>
                                                <Link to={`ticket`}>
                                                    <button type="button" className="text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Mandaty</button>
                                                </Link>
                                                {/* <a href="/" className="bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium" aria-current="page">dashboard</a>

                                    <a href="/" className="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">team</a>

                                    <a href="/" className="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">projects</a>

                                    <a href="/" className="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">calendar</a> */}
                                            </div>
                                        </div>
                                    </div>
                                    <div className="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
                                        <button type="button" className="rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800">
                                            <span className="sr-only">view notifications</span>
                                            <svg className="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" strokeWidth="1.5" stroke="currentcolor" aria-hidden="true">
                                                <path strokeLinecap="round" strokeLinejoin="round" d="m14.857 17.082a23.848 23.848 0 005.454-1.31a8.967 8.967 0 0118 9.75v-.7v9a6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0" />
                                            </svg>
                                        </button>

                                        <div className="relative ml-3">
                                            <div>
                                                <button type="button" className="flex rounded-full bg-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800" id="user-menu-button" aria-expanded="false" aria-haspopup="true">
                                                    <span className="sr-only">open user menu</span>
                                                    <img className="h-8 w-8 rounded-full" src="YOURS" alt="" />
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </nav>
                        <div className="bg-gray-800 w-full h-full rounded opacity-90 overflow-auto">
                            <Routes>
                                <Route path="/" element={<Main />} />
                                <Route path={`/db`} element={<Database />} />
                                <Route path={`/jail`} element={<Jail />} />
                                <Route path={`/ticket`} element={<Ticket />} />
                                <Route path={`/file/:id`} element={<File />} />
                            </Routes>
                        </div>
                        <div className="bg-black text-white rounded-b-md">
                            <h2>hi</h2>
                        </div>
                    </div>
                </div>
            </div>

        );
    }
}