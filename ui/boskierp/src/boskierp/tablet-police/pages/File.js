

import React from 'react'

import { useParams } from "react-router-dom";

export default function File(props) {
    const people = [
        {
            name: 'Prawo jazdy kat. A',
            radio: '2.00',
            id: 1,
            duty: true
        }
    ]

    const tags =  [
        {
            name: 'Poszukiwany'
        },
        {
            name: "Bezpieczny"
        },
        {
            name: "Niebezpieczny",
            selected: true
        },
        {
            name: "Pod napieciem"
        }
    ]

    return (
            <div className=" w-full h-full text-white">
                <div className="flex h-full w-full">
                    <div className="h-full ">
                        <div className="w-full h-full flex justify-start flex-col items-center p-2 shadow-md dark:bg-gray-800 dark:border-gray-700">
                            <div className="flex flex-col items-center pb-10">
                                <img className="mb-3 w-24 h-24 rounded-full shadow-lg" src="https://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg" alt="Bonnie"/>
                                <h5 className="mb-1 text-xl font-medium text-gray-900 dark:text-white">Natalcia</h5>
                                <div className="flex flex-col items-start">
                                    <span className="text-sm text-gray-500 dark:text-gray-400">Płeć: Kobieta</span>
                                    <span className="text-sm text-gray-500 dark:text-gray-400">DOB: 1998-02-02</span>
                                </div>
                                <div className="flex mt-4 space-x-3 md:mt-6">
                                    <form>   
                                        <label for="default-search" className="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-gray-300">Szukaj</label>
                                        <div className="relative">
                                            <div className="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                                <svg aria-hidden="true" className="w-5 h-5 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                            </div>
                                            <input type="search" id="default-search" className="block p-2 pl-10 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-gray-500 focus:border-gray-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-gray-500 dark:focus:border-blue-500" placeholder="Wklej link" required/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div className="w-full h-full overflow-auto">
                                {people.map((v) => {
                                    return <div className="">
                                        <div>{v.name}</div>
                                    </div>
                                })}
                            </div>
                        </div>
                    </div>
                    <div className="w-full h-full">
                            <div className="h-1/6">
                                <div className="w-full h-full">
                                    <div className="w-full h-full overflow-auto">
                                        <button type="button" className="m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Poszukiwany</button>
                                        <button type="button" className="m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Niebezpieczny</button>
                                        <button type="button" className="m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Handlarz narkotyków</button>
                                        <button type="button" className="m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Handlarz bronią</button>
                                        <button type="button" className="m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Grupa przestępcza</button>
                                    </div>
                                </div>
                            </div>
                            <div className="w-full h-5/6 p-4">
                                <div className="w-full h-full bg-gray-900 rounded">
                                    <div className="w-full h-1/6 flex justify-center items-center">
                                        <button type="button" className="grow m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Notatki</button>
                                        <button type="button" className="grow m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Ewidencja</button>
                                        <button type="button" className="grow m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Pojazdy</button>
                                        <button type="button" className="grow m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Mandaty</button>
                                        <button type="button" className="grow m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Wyroki</button>
                                    </div>
                                    <div className="w-full h-5/6">
                                        <div className="w-full h-full opacity-90 bg-gray">
                                            <div className="w-full h-1/6">
                                                <button type="button" className="w-3/4 m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">Dodaj notatke</button>
                                            </div>
                                            <div className="w-full h-5/6 overflow-auto p-4"> 
                                                <div className="w-full h-full bg-black">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
    )
}
