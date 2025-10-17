
import React from 'react'


export default class Main extends React.Component {
        constructor(props) {
        super(props)
        this.state = {
            people: [
              
            ]
        }
    }

    render() {
        return (    
            <div className="bg-gray-800 w-full h-full text-white">
                <div className="flex h-full">
                    <div className="w-1/4 ">
                        <div className="w-full h-full flex justify-start flex-col items-center p-2 shadow-md dark:bg-gray-800 dark:border-gray-700">
                            <div className="flex flex-col items-center pb-10 w-full">
                                <div>
                                    <h2>Opcje</h2>
                                </div>
                                <div className="p-2 w-full">
                                    <div className="mx-2">
                                        <button type="button" className="w-full text-red-700 hover:text-white border border-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">10-78 IMPORTANT</button>
                                    </div>
                                    <div className="flex justify-center">
                                        <button type="button" className="w-full m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">10-07</button>
                                        <button type="button" className="w-full m-2 text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800">10-78</button>
                                    </div>
                                </div>
                            </div>
                            <div className="w-full h-full overflow-auto">
                                {this.state.people.map((v) => {
                                    return <div className="">
                                        <div>{v.name}</div>
                                    </div>
                                })}
                            </div>
                        </div>
                    </div>
                    <div className="flex flex-col h-full w-full">
                        <div className="w-full h-1/2">
                            <div className="w-full h-full overflow-auto">
                                <div className="p-2 bg-gray-700 rounded text-left">
                                    <h2>Ostatnie zgłoszenia</h2>
                                </div>
                                <table className="table-fixed w-full">
                                    <thead className="sticky top-0 bg-gray-800">
                                        <tr>
                                            <th className="w-1/6">Imię i nazwisko</th>
                                            <th>Treśc zgłoszenia</th>
                                            <th className="w-1/6">Narzędzia</th>
                                            {/* <th>Zarządzaj</th> */}
                                        </tr>
                                    </thead>
                                    <tbody className="break-words">
                                        {this.state.people.map((v,i ) => {
                                            return <tr className="border-b hover:bg-gray-700 ">
                                                <td className="p-2">{v.name}</td>
                                                <td className="p-2 text-left">{v.id}</td>
                                                <td className="p-2">
                                                    <button type="button" className="text-green-700 hover:text-white border border-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:border-green-500 dark:text-green-500 dark:hover:text-white dark:hover:bg-green-600 dark:focus:ring-green-800">Przyjmij zgłoszenie ({i})</button>
                                                    <button type="button" className="text-red-700 hover:text-white border border-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">Odrzuć zgłoszenie</button>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div className="w-full h-1/2 ">
                            <div className="w-full h-full overflow-auto">
                                <div className="p-2 bg-gray-700 rounded text-left">
                                    <h2>Ostatnie notatki</h2>
                                </div>
                                <table className="table-fixed w-full">
                                    <thead className="sticky top-0 bg-gray-800">
                                        <tr>
                                            <th className="w-1/5">Imię i nazwisko</th>
                                            <th>Treśc notatki</th>
                                            {/* <th>Zarządzaj</th> */}
                                        </tr>
                                    </thead>
                                    <tbody className="break-words">
                                        {this.state.people.map((v) => {
                                            return <tr className="border-b hover:bg-gray-700 ">
                                                <td className="p-2">{v.name}</td>
                                                <td className="p-2 text-left">{v.id}</td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}