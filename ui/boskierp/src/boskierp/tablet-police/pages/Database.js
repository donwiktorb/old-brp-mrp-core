
import React from 'react'
import {Link} from 'react-router-dom'


export default class Database extends React.Component {
        constructor(props) {
        super(props)
        this.state = {
            people: [
              
            ]
        }
    }

    render() {
        return (    
            <div className="w-full h-full bg-gray-800 rounded-lg">
                <div className=" h-full w-full">
                    <div className="justify-center items-center bg-gray-800 text-white h-full w-full">
                        <div className=" text-white h-full">
                            <div className="bg-gray-800 w-full p-2 h-full">
                                <div className="flex flex-col flex-wrap h-full">
                                    <div className="h-full bg-gray-900 rounded-lg">
                                        <div className="border-b border-black rounded overflow-auto h-full">
                                        <div className="p-2">
                                            <form>   
                                                <label for="default-search" className="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-gray-300">Szukaj</label>
                                                <div className="relative">
                                                    <div className="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                                        <svg aria-hidden="true" className="w-5 h-5 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                                    </div>

                                                    <input type="search" id="default-search" className="block p-4 pl-10 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-gray-500 focus:border-gray-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-gray-500 dark:focus:border-blue-500" placeholder="Wpisz imię i nazwisko"/>
                                                    <div className="absolute right-2.5 bottom-2.5">
                                                        <button type="submit" className="text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-gray-600 dark:hover:bg-gray-400 dark:focus:ring-gray-800">Szukaj</button>
                                                        <button type="submit" className="text-white mx-2 bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-gray-600 dark:hover:bg-gray-400 dark:focus:ring-gray-800">Sprawdź najbliższą osobę</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                            <table className="table-fixed w-full">
                                                <thead className="border-b border-black sticky top-0 bg-gray-800">
                                                    <tr>
                                                        <th>Imię i nazwisko</th>
                                                        <th>Numer dowodu</th>
                                                        {/* <th>Zarządzaj</th> */}
                                                    </tr>
                                                </thead>
                                                <tbody className="break-words">
                                                    {this.state.people.map((v) => {
                                                        return <tr className="border-b border-black hover:bg-gray-700">
                                                            <td className="p-2">
                                                                <Link to={`../file/${v.id}`} relative="path">
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