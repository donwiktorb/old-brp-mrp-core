
import React from 'react'
import sendMessage from '../../../Api';


export default class Main extends React.Component {
        constructor(props) {
        super(props)
        this.state = {
            elements: {
                sideTitle: "Opcje",
                firstButton: {
                    label: "10-78 IMPORTANT",
                    value: "backup"
                },
                sideButtons: [
                    {
                        label: "KOD 0",
                        value: "backup2"
                    }
                ]
            },
            reports: props.reports || [],
            notes: props.notes || [],
            dutyPeople: props.dutyPeople || [],
            userInfo: props.userInfo || []
        }
    }

    async componentDidMount () {
        const reports = await sendMessage('tablet_get_reports', {
        })
        this.setState({reports:reports})
        const dutyPeople = await sendMessage('tablet_get_duty', {
        })
        this.setState({dutyPeople:dutyPeople})
        const userInfo = await sendMessage('tablet_get_user_info', {
        })
        this.setState({userInfo:userInfo})
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

    backup = (e) => {
        sendMessage('tablet_backup', {
        })
    }

    backup2 = (e) => {
        sendMessage('tablet_backup_2', {
        })
    }

    render() {
        return (    
            <div className="bg-gray-800 w-full h-full text-white">
                <div className="flex h-full">
                    <div className="w-1/4 ">
          <div className="w-full h-full flex justify-start flex-col items-center p-2 shadow-md bg-gray-800 border-gray-700 gap-2">
                            <div className="font-bold text-left self-start">
                                {this.state.userInfo.map((v) => {
                                    return <div>
                                        {v}
                                    </div>
                                })}
                                </div>
                            </div>
                            <div className="w-full h-full overflow-auto flex flex-col gap-2">
                                {this.state.dutyPeople.map((v) => {
                                    return <div className="w-full p-2 bg-gray-500 rounded-lg">
                                        <div>{v.name}</div>
                                    </div>
                                })}
                            </div>
                        </div>
                    <div className="flex flex-col h-full w-full">
                        <div className="w-full h-full">
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
                                        </tr>
                                    </thead>
                                    <tbody className="break-words">
                                        {this.state.reports.map((v,i ) => {
                                            return <tr className="border-b hover:bg-gray-700 ">
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
                        {/* <div className="w-full h-1/2 ">
                            <div className="w-full h-full overflow-auto">
                                <div className="p-2 bg-gray-700 rounded text-left">
                                    <h2>Ostatnie notatki</h2>
                                </div>
                                <table className="table-fixed w-full">
                                    <thead className="sticky top-0 bg-gray-800">
                                        <tr>
                                            <th className="w-1/5">Imię i nazwisko</th>
                                            <th>Treśc notatki</th>
                                        </tr>
                                    </thead>
                                    <tbody className="break-words">
                                        {this.state.notes.map((v) => {
                                            return <tr className="border-b hover:bg-gray-700 ">
                                                <td className="p-2">{v.name}</td>
                                                <td className="p-2 text-left">{v.id}</td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div> */}
                    </div>
                </div>
            </div>
        );
    }
}
