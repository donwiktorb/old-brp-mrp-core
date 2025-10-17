

import React from 'react'
import sendMessage from '../../../Api'


export default class Main extends React.Component {
        constructor(props) {
        super(props)
        this.state = {
            elements: {
                sideTitle: "Opcje",
                firstButton: {
                    label: "10-78 IMPORTANT"
                },
                sideButtons: [
                    {
                        label: "10-07"
                    }
                ]
            },
            reports: props.reports || [],
            notes: props.notes || [],
            dutyPeople: props.dutyPeople || []
        }
    }

    async componentDidMount () {
        const reports = await sendMessage('tablet_get_reports', {
        })
        this.setState({reports:reports})
    }

    accept(e, i) {
        sendMessage('tablet_accept_report', {
            repId: i,
            report: this.state.reports[i]
        })
    }

    deny(e, i) {
        sendMessage('tablet_deny_report', {
            repId: i,
            report: this.state.reports[i]
        })
    }

    render() {
        return (    
            <div className="bg-pink-900 w-full h-full text-white">
                <div className="flex h-full">
                    <div className="w-1/4 ">
                        <div className="w-full h-full flex justify-start flex-col items-center p-2 shadow-md bg-pink-800 border-gray-700">
                            <div className="flex flex-col items-center pb-10 w-full">
                                <div>
                                    <h2>{this.state.elements.sideTitle}</h2>
                                </div>
                                <div className="p-2 w-full">
                                    <div className="mx-2">
                                        <button type="button" className="w-full border  focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2 border-red-500 text-red-500 hover:text-white hover:bg-red-600 focus:ring-red-900">{this.state.elements.firstButton.label}</button>
                                    </div>
                                    <div className="flex justify-center">
                                        {this.state.elements.sideButtons.map((v) => {
                                            return <button type="button" className="w-full m-2  border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center border-pink-600 text-gray-400 hover:text-white hover:bg-gray-600 focus:ring-gray-800">{v.label}</button>
                                        })} 
                                    </div>
                                </div>
                            </div>
                            <div className="w-full h-full overflow-auto">
                                {this.state.dutyPeople.map((v) => {
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
                                <div className="p-2 bg-pink-700 rounded text-left">
                                    <h2>Ostatnie zgłoszenia</h2>
                                </div>
                                <table className="table-fixed w-full">
                                    <thead className="sticky top-0 bg-pink-800">
                                        <tr>
                                            <th className="w-1/6">Imię i nazwisko</th>
                                            <th>Treśc zgłoszenia</th>
                                            <th className="w-1/6">Narzędzia</th>
                                        </tr>
                                    </thead>
                                    <tbody className="break-words">
                                        {this.state.reports.map((v,i ) => {
                                            return <tr className="border-b hover:bg-pink-700 ">
                                                <td className="p-2">{v.name}</td>
                                                <td className="p-2 text-left">{v.content}</td>
                                                <td className="p-2">
                                                    <button type="button" onClick={(e) => this.accept(e, i)} className=" border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2 border-green-500 text-green-500 hover:text-white hover:bg-green-600 focus:ring-green-800">Przyjmij zgłoszenie ({v.accepted})</button>
                                                    <button type="button" onClick={(e) => this.deny(e, i)} className="text-red-700  border focus:ring-4 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2 border-red-500 hover:text-white hover:bg-red-600 focus:ring-red-900">Odrzuć zgłoszenie</button>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div className="w-full h-1/2 ">
                            <div className="w-full h-full overflow-auto">
                                <div className="p-2 bg-pink-700 rounded text-left">
                                    <h2>Ostatnie faktury</h2>
                                </div>
                                <table className="table-fixed w-full">
                                    <thead className="sticky top-0 bg-pink-800">
                                        <tr>
                                            <th className="w-1/5">Imię i nazwisko</th>
                                            <th>Treśc</th>
                                        </tr>
                                    </thead>
                                    <tbody className="break-words">
                                        {this.state.notes.map((v) => {
                                            return <tr className="border-b hover:bg-pink-700 ">
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
