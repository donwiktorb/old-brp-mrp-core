
import React from 'react'
import { Link, Navigate } from 'react-router-dom'
import sendMessage from '../../../Api'
// infinite scrolling? fetch data every scroll? at first fetch like 10 rows and stuff?

export default class Database extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            people: [],
            closest: false
            // // people: [
            // //     {
            // //         name: "John Black",
            // //         id: 2
            // //     },
            // //     ...Array(44).fill({
            // //         name: Math.random,
            // //         id: Math.random
            // //     }).map((v) => {return {name: v.name(), id: v.id()}})
            // // ]
        }
    }

    searchName = async (e) => {
        e.preventDefault()
        const {value} = e.target[0]
        let people = await sendMessage('tablet_database_search', {
            name: value
        })


        this.setState({
            people: people
        })
    }

    searchCar = async (e) => {
        e.preventDefault()
        const {value} = e.target[0]
        let people = await sendMessage('tablet_database_search_car', {
            plate: value
        })

        this.setState({
            people: people
        })
    }

    searchClose = async (e) => {
        e.preventDefault()
        let people = await sendMessage('tablet_database_search_close', {
        })

        this.setState({
            closest: people
        })
    }

    render() {
        return (
            <div className="w-full h-full  rounded-lg">
                <div className=" h-full w-full">
                    <div className="justify-center items-center text-white h-full w-full">
                        <div className=" text-white h-full">
                            <div className=" w-full p-2 h-full">
                                <div className="flex flex-col flex-wrap h-full">
                                {this.state.closest && (
                                    <Navigate  to={`../file/${this.state.closest.id}`} relative="path" state={{
                                        userData: this.state.closest
                                    }}/>
                                )}
                                    <div className="h-full bg-black bg-opacity-70 rounded-lg">
                                        <div className="border-b border-black rounded overflow-auto h-full">
                                            <div className="p-2 flex gap-2">
                                                <form className="w-2/3" onSubmit={this.searchName}>
                                                    {/* <label for="default-search" className="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-gray-300">Szukaj</label> */}
                                                    <div className="relative">
                                                        <div className="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                                            <svg aria-hidden="true" className="w-5 h-5 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                                        </div>

                                                        <input type="search" id="default-search" className="block p-4 pl-10 w-full text-sm text-white  rounded-lg border border-black bg-black bg-opacity-70 focus:ring-gray-500 focus:border-gray-500 " placeholder="Wpisz imię i nazwisko lub pesel" />
                                                        <div className="absolute right-2.5 bottom-2.5">
                                                            <button type="submit" className="text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-4 py-2">Szukaj</button>
                                                            <button onClick={this.searchClose} type="button" className="text-white mx-2 bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-gray-600 dark:hover:bg-gray-400 dark:focus:ring-gray-800">Sprawdź najbliższą osobę</button>
                                                        </div>
                                                    </div>
                                                </form>

                                                <form className="w-1/3" onSubmit={this.searchCar}>
                                                    {/* <label for="default-search" className="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-gray-300">Szukaj</label> */}
                                                    <div className="relative">
                                                        <div className="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                                            <svg aria-hidden="true" className="w-5 h-5 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                                        </div>

                                                        <input type="search" id="default-search" className="block p-4 pl-10 w-full text-sm text-white  rounded-lg border border-black bg-black bg-opacity-70 focus:ring-gray-500 focus:border-gray-500 " placeholder="Wpisz rejestracje" />
                                                        <div className="absolute right-2.5 bottom-2.5">
                                                            <button type="submit" className="text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-gray-600 dark:hover:bg-gray-400 dark:focus:ring-gray-800">Szukaj</button>
                                                            <button type="submit" className="text-white mx-2 bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-gray-600 dark:hover:bg-gray-400 dark:focus:ring-gray-800">Sprawdź najbliższe auto</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

   
                                            <table className="table-fixed w-full">
                                                <thead className="border-b border-black sticky top-0 bg-black bg-opacity-50">
                                                    <tr>
                                                        <th>Imię i nazwisko/Rejestracja</th>
                                                        <th>Numer dowodu/Pesel własciciela</th>
                                                        {/* <th>Zarządzaj</th> */}
                                                    </tr>
                                                </thead>
                                                <tbody className="break-words">
                                                    {this.state.people.map((v) => {
                                                        return <tr className="border-b border-white hover:bg-gray-700">
                                                            <td className="p-2">
                                                                <Link to={`../file/${v.id}`} relative="path" state={{
                                                                    userData: v
                                                                }}>
                                                                    {v.name}
                                                                </Link>
                                                            </td>
                                                            <td>{v.id}</td>
                                                        </tr>
                                                    })}
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}
