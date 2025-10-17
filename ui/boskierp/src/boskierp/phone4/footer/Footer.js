import React, {useState, useEffect } from 'react'

import { useNavigate} from "react-router-dom";
import sendMessage from '../../Api'

export default function Footer(props) {
    const navigate = useNavigate();
    const [notifies, setNotifies] = useState({
        // notifies:10,
        // messages:4,
        // calls:4
    })

    useEffect(() => {
        const fn = async () => {
            const contacts2 = await sendMessage('phone_get_notifies')
            setNotifies(contacts2)
        }
        fn()
    }, [])

    const buttonClicked = (nav) => {
        if (nav === '/') {
            let notifies2 = notifies
            notifies2.notifies = 0
            setNotifies(notifies2)
        } else if (nav === '/messages') {
            // setNotifies(notifies,{messages:0})
            // sendMessage('phone_clear_notifies', {
            //     type: "messages"
            // })
            let notifies2 = notifies
            notifies2.messages = 0
            setNotifies(notifies2)
        } else if (nav === '/calls') {
            let notifies2 = notifies
            notifies2.calls = 0
            setNotifies(notifies2)
            // setNotifies({calls:0})
        }
        navigate(nav)
    } 

    return (
        <div className=" select-none w-full h-18 relative">
            <section className="text-gray-400 bg-gray-700 bg-opacity-30 rounded-2xl py-2 pr-1">
                <div id="tabs" className="flex justify-between ">
                    <button
                    onClick={(e) => buttonClicked('/')}
                    className="w-full transition-all focus:text-royal hover:text-royal justify-center inline-block text-center pt-2 pb-1 hover:text-white relative"
                    >
                    {notifies.notifies > 0 && <div className="absolute top-0.5 right-0 text-white bg-blue-500 rounded-full p-0.5 w-5 h-5 text-sm flex justify-center items-center text-ellipsis overflow-hidden text-center">{notifies.notifies}</div>}
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 inline-block mb-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                    </svg>
                    <span className="tab block text-xs">Home</span>
                    </button>
                    <button
                    onClick={(e) => buttonClicked('/messages')}
                    className="w-full transition-all focus:text-royal hover:text-royal justify-center inline-block text-center pt-2 pb-1 hover:text-white relative"
                    >

                    {notifies.messages > 0 && <div className="absolute top-0.5 right-0 text-white bg-blue-500 rounded-full p-0.5 w-5 h-5 text-sm flex justify-center items-center text-ellipsis overflow-hidden text-center">{notifies.messages}</div>}
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 inline-block mb-1" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path opacity="0.8" d="M17.2678 8.56104L13.0024 11.9953C12.1952 12.6282 11.0636 12.6282 10.2564 11.9953L5.95435 8.56104" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                        <path fillRule="evenodd" clipRule="evenodd" d="M6.88787 3H16.3158C17.6752 3.01525 18.969 3.58993 19.896 4.5902C20.823 5.59048 21.3022 6.92903 21.222 8.29412V14.822C21.3022 16.1871 20.823 17.5256 19.896 18.5259C18.969 19.5262 17.6752 20.1009 16.3158 20.1161H6.88787C3.96796 20.1161 2 17.7407 2 14.822V8.29412C2 5.37545 3.96796 3 6.88787 3Z" strokeWidth="2" strokeLinejoin="round" stroke="currentColor"/>
                    </svg>
                    <span className="tab block text-xs">Wiadomości</span>
                    </button>
                    <button
                    onClick={(e) => buttonClicked('/apps')}
                    className="w-full transition-all focus:text-royal hover:text-royal justify-center inline-block text-center pt-2 pb-1 hover:text-white"
                    >
                    
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 inline-block mb-1" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2"
                        d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
                    </svg>
                    <span className="tab block text-xs">Aplikacje</span>
                    </button>
                    <button
                    onClick={(e) => buttonClicked('/contacts')}
                    className="w-full transition-all focus:text-royal hover:text-royal justify-center inline-block text-center pt-2 pb-1 hover:text-white relative"
                    >

                    <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 inline-block mb-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                    <span className="tab block text-xs">Kontakty</span>
                    </button>
                    <button
                    onClick={(e) => buttonClicked('/calls')}
                    className="w-full transition-all focus:text-royal hover:text-royal justify-center inline-block text-center pt-2 pb-1 hover:text-white relative"
                    >
                    {notifies.calls > 0 && <div className="absolute top-0.5 right-0 text-white bg-blue-500 rounded-full p-0.5 w-5 h-5 text-sm flex justify-center items-center text-ellipsis overflow-hidden text-center">{notifies.calls}</div>}
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 inline-block mb-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                    <span className="tab block text-xs">Telefon</span>
                    </button>
                </div>
            </section>
        </div>
    );
}
