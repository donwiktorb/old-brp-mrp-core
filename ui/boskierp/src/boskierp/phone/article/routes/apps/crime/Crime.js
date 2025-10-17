


import sendMessage from '../../../../../../Api'
import Messages from '../../../../components/Messages'
import { Link } from 'react-router-dom'
import React, { useEffect, useState } from 'react'
import ScrollToHashElement from './ScrollToHash'
export default function Crime(props) {
    const [data, setData] = useState(props.data)
    const [messages, setMessages] = useState(props.messages || [])


    useEffect(() => {
        setData(props.data)
    }, [props.data])

    useEffect(() => {
        let bg = document.getElementById('phone-bg-main').style.background
        let bgElem = document.getElementById('phone-bg-main')
        if (bgElem) bgElem.style.background = 'rgb(0,0,0,50)'
        return () => {
            let bgElem = document.getElementById('phone-bg-main')
            if (bgElem) 
                bgElem.style.background = bg
        }

    }, [])


    const onSubmitJoin = (e) => {
        e.preventDefault()
        let submitter = e.nativeEvent.submitter
        let value = e.currentTarget.elements.crimeValue.value
        e.target.reset()
        sendMessage('phone_crime_action', {
            type: submitter.id,
            value: value
        })
    }
    useEffect(() => {
        sendMessage('phone_chat_get_messages', {
            type:'darkweb'
        })
    }, [])
    const onSendMessage = (e) => {
        e.preventDefault()
        let target = e.currentTarget.elements.content
        let value = e.currentTarget.elements.content.value
        e.target.reset()
        sendMessage('phone_chat_send_message', {
            message: value,
            type: 'darkweb'
        })
    }

    return <div className="w-full h-full scroll-smooth">
        <ScrollToHashElement />
        <div className="w-full h-full overflow-hidden">
            <div id="main" className="w-full h-full relative flex group/main">
                <button className="w-4 h-1/4 absolute top-1/2 -translate-y-1/2 left-0 hover:w-full transition-[width,height] duration-700 delay-50 easy-in-out hover:h-full rounded-r-lg hover:rounded-none overflow-hidden group/crime hover:rounded-none bg-gray-900 z-30">
                    <div className="flex break-all uppercase tracking-widest group-hover/crime:hidden text-purple-400">
                        CELE
                    </div>
                    <div className="w-full h-full flex justify-evenly items-center hidden group-hover/crime:flex">
                        <div className="w-full h-full overflow-y-scroll flex flex-col  gap-3 p-3">
                            {data.actions.map((v, i) => {
                                return <div className="w-full h-18 bg-gray-700 rounded-lg flex justify-start text-left px-3 group/action">
                                    <div className="flex flex-col w-3/4 h-full">
                                        <div>
                                            Napad na Paleto
                                        </div>
                                        <div className="flex text-sm gap-3 ">
                                            <div>
                                                Koszt: <span className="text-orange-500">0.5</span> BTC
                                            </div>
                                        </div>
                                        <div className="flex text-sm gap-3 flex-col h-full group-hover/action:h-full px-4 transition-[height] delay-150 ease-in-out duration-300 overflow-hidden">
                                            <ul className="list-disc">
                                                <li>
                                                    Osoby: 4
                                                </li>
                                                <li>
                                                    Wiertło
                                                </li>
                                                <li>
                                                    Karta dostepu
                                                </li>
                                            </ul>
                                            {/* <div>
                                                Osoby: 4
                                            </div>
                                            <div>
                                                Koszt: <span className="text-orange-500">0.5</span> BTC
                                            </div> */}
                                        </div>
                                    </div>
                                    <div className="w-1/4 h-full">
                                        <button className="w-full h-full flex justify-center items-center hover:scale-110 transition-all text-orange-500 hover:text-white">
                                            <svg className="w-6 h-6" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M11 8C11 7.44772 11.4477 7 12 7C12.5523 7 13 7.44772 13 8V11H16C16.5523 11 17 11.4477 17 12C17 12.5523 16.5523 13 16 13H13V16C13 16.5523 12.5523 17 12 17C11.4477 17 11 16.5523 11 16V13H8C7.44771 13 7 12.5523 7 12C7 11.4477 7.44772 11 8 11H11V8Z" fill="currentColor" />
                                                <path fill-rule="evenodd" clip-rule="evenodd" d="M23 12C23 18.0751 18.0751 23 12 23C5.92487 23 1 18.0751 1 12C1 5.92487 5.92487 1 12 1C18.0751 1 23 5.92487 23 12ZM3.00683 12C3.00683 16.9668 7.03321 20.9932 12 20.9932C16.9668 20.9932 20.9932 16.9668 20.9932 12C20.9932 7.03321 16.9668 3.00683 12 3.00683C7.03321 3.00683 3.00683 7.03321 3.00683 12Z" fill="currentColor" />
                                            </svg>

                                        </button>
                                    </div>
                                </div>
                            })}
                        </div>

                    </div>
                </button>
                <div className="w-full h-full flex flex-col">
                    <div className="w-full h-[10%] flex justify-evenly items-center">
                        <div className="w-full h-full flex justify-center">
                            <div>
                                {data.name}
                            </div>
                        </div>
                        <div className="w-full h-full flex justify-center px-4">
                            <div className="flex w-full h-fit border p-0.5 border-orange-500 justify-evenly">
                                <div className="w-auto h-auto flex justify-center items-center">
                                    {data.btc} BTC
                                </div>
                                <div className="w-auto h-auto flex justify-center items-center">
                                    <svg className="w-6 h-6 text-orange-500" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M11 8C11 7.44772 11.4477 7 12 7C12.5523 7 13 7.44772 13 8V11H16C16.5523 11 17 11.4477 17 12C17 12.5523 16.5523 13 16 13H13V16C13 16.5523 12.5523 17 12 17C11.4477 17 11 16.5523 11 16V13H8C7.44771 13 7 12.5523 7 12C7 11.4477 7.44772 11 8 11H11V8Z" fill="currentColor" />
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M23 12C23 18.0751 18.0751 23 12 23C5.92487 23 1 18.0751 1 12C1 5.92487 5.92487 1 12 1C18.0751 1 23 5.92487 23 12ZM3.00683 12C3.00683 16.9668 7.03321 20.9932 12 20.9932C16.9668 20.9932 20.9932 16.9668 20.9932 12C20.9932 7.03321 16.9668 3.00683 12 3.00683C7.03321 3.00683 3.00683 7.03321 3.00683 12Z" fill="currentColor" />
                                    </svg>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="w-full h-[90%] flex justify-evenly items-center ">
                        <div className="w-full h-full flex flex-col gap-4 overflow-y-scroll px-4">
                            {!data.inGroup && <form onSubmit={onSubmitJoin} className="w-full h-auto flex flex-col">
                                <input id="crimeValue" className="text-black focus:outline-none px-0.5" placeholder="Nazwa grupy" type="text" />
                                <div className="w-full h-auto flex justify-around items-center p-3">
                                    <button id="crime-create" className="p-0.5 border hover:bg-blue-500 transition-all px-3 border-orange-500 shadow-orange-500 shadow" type="submit" >
                                        Stwórz
                                    </button>
                                    <button id="crime-join" className="p-0.5 border-blue-500 border px-3 hover:bg-orange-500 transition-all shadow shadow-blue-500" type="submit" >
                                        Dołącz
                                    </button>
                                </div>
                            </form>}
                            {data.inGroup && <div className="w-full h-full flex flex-col gap-3">
                                <div className="w-full h-auto">
                                    Jesteś w grupie: {data.group}
                                </div>


                                <form onSubmit={onSubmitJoin} className="w-full h-auto flex items-center">
                                    <input id="crimeValue" className="text-black h-fit focus:outline-none px-0.5" placeholder="Wpisz id obywatela" type="text" />
                                    <div className="w-full h-auto flex justify-around items-center p-3">
                                        <button id="crime-invite" className="p-0.5 border hover:bg-blue-500 transition-all px-3 border-orange-500 shadow-orange-500 shadow" type="submit" >
                                            Zaproś
                                        </button>
                                    </div>
                                </form>

                                <div className="w-full h-3/5 overflow-y-scroll flex flex-col gap-4">
                                    {data.members.map((v, i) => {
                                        return <div className="w-full h-14 border-b ">
                                            {v}
                                        </div>
                                    })}
                                </div>
                                <button className="p-0.5 border hover:bg-blue-500 transition-all px-3 border-purple-500 shadow-red-500 shadow" type="submit" >
                                    Opuść grupe
                                </button>
                            </div>}
                        </div>
                    </div>
                </div>
            </div>
            <div id="actions" className="w-full h-full relative flex flex-col gap-4 group/actions p-2">
                <Messages messages={messages} onSubmit={onSendMessage} style={{ownerAuthor: 'bg-gray-900 rounded-none', author: 'bg-gray-500 rounded-none', contentAuthor: 'bg-slate-900 after:border-t-gray-900', content: 'bg-gray-500 after:border-t-gray-500', main: 'rounded-none', input:'rounded-none', buttons:'rounded-none'}} defaultAvatar="https://boskierp.pl/img/ss/dwb_yowb.png" />
            </div>
            <div className="w-4 h-1/4 absolute top-1/2 -translate-y-1/2 right-0.5 overflow-hidden flex flex-col justify-around items-around">
                <Link to="#main" className="w-4 h-4 rounded-full border-4 target:bg-gray-700" />
                <Link to="#actions" className="w-4 h-4 rounded-full border-4" />
                <a href="#page4" className="w-4 h-4 rounded-full border-4" />
                <a href="#page5" className="w-4 h-4 rounded-full border-4" />
            </div>
        </div>
    </div>
}
