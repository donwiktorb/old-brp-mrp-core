import React, {useEffect, useState} from 'react'
import sendMessage from '../../../../Api'
import { Link, useNavigate } from "react-router-dom";

import {getMedia, createPeerConnection, createOffer, setOffer, createAnswer, setAnswer, hangup} from '../../../../Api'

export default function Contacts(props) {
    const navigate = useNavigate();
    const [toolShow, showTool] = useState(true)
    const [contacts, setContacts] = useState([])
    const [defaultContacts, setDefaultContacts] = useState([{
        name: "LSPD",
        value: "lspd",
        number: 997
    }, {
        name: "EMS",
        value: "ems",
        number: 999
    }, {
        name: "LSC",
        value: "lsc",
        number: 944
    }])

    // useEffect(() => {
    //     setContacts(props.contacts)
    // }, [props.contacts])

    useEffect(() => {
        const fn = async () => {
            const [contacts2, defaultContacts2] = await sendMessage('phone_get_contacts')
            await setDefaultContacts(defaultContacts2)
            await setContacts(contacts2)
        }
        fn()
    }, [])

    // useEffect(() => {
    //     sendMessage('phone_get_last_messages')
    // }, []) 

    // useEffect(() => {
    //     sendMessage('phone_chat_get_messages', {
    //         type: 'twitter'
    //     })
    //     // eslint-disable-next-line react-hooks/exhaustive-deps
    // }, [])

    const onImageError = (e, txt) => {
        e.preventDefault()
        let parent = e.target.parentElement
        let el = document.createElement('div')
        let content = document.createTextNode(txt)
        el.className = 'text-center border-2 rounded-full leading-loose w-10 h-10 text-lg'
        el.appendChild(content)
        parent.append(el)
        e.target.remove()
    }

    const submit = (e) => {
        e.preventDefault()
        let {value} = e.target[0]

        navigate('/contact/'+value) 
    }

    const deleteContact = async(e,i) => {
        e.preventDefault()
        let item = contacts[i]
        sendMessage('phone_contact_delete', {
            contact:item,
            id: i
        })
        // const contacts2 = await sendMessage('phone_get_contacts')
        // setContacts(contacts2)
        navigate('/')
        
    }

    return (
        <div className="w-full h-full p-2 flex relative"> 
            <div className="h-full w-full ">
                <div className="w-full h-full">
                    <form className="flex text-white w-full justify-between pb-2" onSubmit={(e)=> submit(e)}>
                        <div className="w-full relative">
                            <input type="text" id="small-input" 
                            placeholder="Wpisz numer telefonu"
                            className="
                            bg-black
                            bg-opacity-20
                            placeholder:text-white
                            focus:outline-none
                            block p-2 w-full text-white  rounded-lg sm:text-xs "/>
                            <div className="
                                bg-blue-700
                                bg-opacity-40
                                transition-all
                                hover:bg-opacity-80
                                placeholder:text-white
                                p-2  text-white  rounded-lg sm:text-xs
                            absolute right-0 top-0 flex">
                                <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" className="w-8 h-4
                                " viewBox="0 0 100 100" enable-background="new 0 0 100 100" >
                                    <path d="M77.7,63.9l-6.2-5c-2.1-1.7-5.1-1.801-7.3-0.2L58.3,63c-0.8,0.6-1.899,0.5-2.6-0.2L46,54l-8.9-9.8  c-0.7-0.7-0.8-1.8-0.2-2.6l4.3-5.9c1.6-2.2,1.5-5.2-0.2-7.3l-5-6.2c-2.2-2.8-6.4-3-8.9-0.5l-5.4,5.4c-1.2,1.2-1.8,2.9-1.8,4.5  c0.7,12.7,6.5,24.8,15,33.3s20.5,14.3,33.3,15c1.7,0.1,3.3-0.601,4.5-1.801L78.1,72.7C80.8,70.3,80.5,66.1,77.7,63.9z"/>
                                </svg>
                                <input type="submit"
                                value="Dodaj" />
                            </div>
                        </div>
                    </form>
                    <div className="w-full h-fit grid grid-cols-1 gap-2 select-none">
                        {defaultContacts.map((v, i) => {
                            return <div
                                to={`/call/${v.number}`}
                                className="w-full text-white group transition-all">
                                <div className="w-full h-auto relative">
                                    <div className="bg-slate-900 bg-opacity-50 text-slate-100 px-2 py-0.5 rounded-lg shadow hover:shadow-xl max-w-sm mx-auto transform hover:-translate-y-[0.125rem] transition duration-100 ease-linear">
                                        <div className="flex items-center rounded-lg cursor-pointer">
                                                <div className="w-full flex items-center justify-center">
                                                <div className='w-1/4'>
                                                    {/* <img className=" w-auto rounded-full" src="https://cdn.discordapp.com/attachments/1020433320934379612/1024767726104870933/xd8_digital_art_x4.png" alt="" onError={(e) => onImageError(e, v.name[0])}/> */}
                                                    <div className="text-center border-2 rounded-full leading-loose w-10 h-10 text-lg">
                                                        {v.name[0]}
                                                    </div>
                                                </div>
                                                <div className="w-3/4 ">
                                                    <p className="text-md truncate">{v.name}</p>
                                                    <p className="text-sm text-blue-500 truncate">{v.number}</p>
                                                </div>
                                            </div>
                                            {/* <div className="relative flex flex-shrink-0 items-end">
                                                <img className="h-16 w-16 rounded-full" src="https://i.pravatar.cc/300" alt=""/>
                                                <span className="absolute h-4 w-4 bg-green-400 rounded-full bottom-0 right-0 border-2 border-slate-900"></span>
                                            </div> */}
                                            {/* <div className="ml-3.5">
                                                <span className="font-semibold tracking-tight text-xs">John Doe</span>
                                                <p className="text-xs leading-4 pt-2 italic opacity-70">"This is the comment..."</p>
                                                <span className="text-[10px] text-blue-500 font-medium leading-4 opacity-75">a few seconds ago</span>
                                            </div> */}
                                        </div>
                                        <div className="hidden gap-4 justify-center p-2 group-hover:flex">
                                            {/* <Link to={`/call/${v.number}`} className="w-full border-b-2 h-full text-green-700 hover:border-green-500 transition-all flex justify-center hover:text-green-500">
<svg className="w-2/5 h-1/2" viewBox="0 0 24 24" fillRule="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M9 16C2.814 9.8133.11 5.134 5.94 3.012l.627-.467a1.483 1.483 0 0 1 2.1.353l1.579 2.272a1.5 1.5 0 0 1-.25 1.99L8.476 8.474c-.38.329-.566.828-.395 1.301.316.88 1.083 2.433 2.897 4.246 1.814 1.814 3.366 2.581 4.246 2.898.474.17.973-.015 1.302-.396l1.314-1.518a1.5 1.5 0 0 1 1.99-.25l2.276 1.58a1.48 1.48 0 0 1 .354 2.096l-.47.633C19.869 21.892 15.188 22.187 9 16z" fill="currentColor"/></svg>
                                            </Link> */}
                                            <Link to={`/messages/${v.number}`} className="w-1/4 border-b-2 hover:border-orange-500 transition-all text-orange-700 h-full flex justify-center hover:text-orange-500">
<svg className="w-2/5 h-1/2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 3C5.11765 3 3 4.64706 3 10C3 13.7383 4.0328 15.6692 7 16.4939V21L11.0124 16.9876C11.3301 16.996 11.6592 17 12 17C18.8824 17 21 15.3529 21 10C21 4.64706 18.8824 3 12 3Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

                                            </Link>
                                            {/* <button onClick={(e) => deleteContact(e, i)} className="w-full peer border-b-2 hover:border-red-500 transition-all h-full flex justify-center text-red-700 hover:text-red-500">
<svg className="w-2/5 h-1/2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M4 7H20" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M6 7V18C6 19.6569 7.34315 21 9 21H15C16.6569 21 18 19.6569 18 18V7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M9 5C9 3.89543 9.89543 3 11 3H13C14.1046 3 15 3.89543 15 5V7H9V5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
                                            </button> */}
                                            
                                       </div>
                                    </div>
                                </div>
                            </div>
                        })}
                        {contacts.map((v, i) => {
                            return <div
                                to={`/call/${v.number}/true`}
                                className="w-full text-white group transition-all">
                                <div className="w-full h-auto relative">
                                    <div className="bg-slate-900 bg-opacity-50 text-slate-100 px-2 py-0.5 rounded-lg shadow hover:shadow-xl max-w-sm mx-auto transform hover:-translate-y-[0.125rem] transition duration-100 ease-linear">
                                        <div className="flex items-center rounded-lg cursor-pointer">
                                                <div className="w-full flex items-center justify-center">
                                                <div className='w-1/4'>
                                                    {/* <img className=" w-auto rounded-full" src="https://cdn.discordapp.com/attachments/1020433320934379612/1024767726104870933/xd8_digital_art_x4.png" alt="" onError={(e) => onImageError(e, v.name[0])}/> */}
                                                    <div className="text-center border-2 rounded-full leading-loose w-10 h-10 text-lg">
                                                        {v.name[0]}
                                                    </div>
                                                </div>
                                                <div className="w-3/4 ">
                                                    <p className="text-md truncate">{v.name}</p>
                                                    <p className="text-sm text-blue-500 truncate">{v.number}</p>
                                                </div>
                                            </div>
                                            {/* <div className="relative flex flex-shrink-0 items-end">
                                                <img className="h-16 w-16 rounded-full" src="https://i.pravatar.cc/300" alt=""/>
                                                <span className="absolute h-4 w-4 bg-green-400 rounded-full bottom-0 right-0 border-2 border-slate-900"></span>
                                            </div> */}
                                            {/* <div className="ml-3.5">
                                                <span className="font-semibold tracking-tight text-xs">John Doe</span>
                                                <p className="text-xs leading-4 pt-2 italic opacity-70">"This is the comment..."</p>
                                                <span className="text-[10px] text-blue-500 font-medium leading-4 opacity-75">a few seconds ago</span>
                                            </div> */}
                                        </div>
                                        <div className="hidden gap-4 justify-center p-2 group-hover:flex">
                                            <Link to={`/call/`+v.number+"/true"} className="w-full border-b-2 h-full text-green-700 hover:border-green-500 transition-all flex justify-center hover:text-green-500">
<svg className="w-2/5 h-1/2" viewBox="0 0 24 24" fillRule="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M9 16C2.814 9.8133.11 5.134 5.94 3.012l.627-.467a1.483 1.483 0 0 1 2.1.353l1.579 2.272a1.5 1.5 0 0 1-.25 1.99L8.476 8.474c-.38.329-.566.828-.395 1.301.316.88 1.083 2.433 2.897 4.246 1.814 1.814 3.366 2.581 4.246 2.898.474.17.973-.015 1.302-.396l1.314-1.518a1.5 1.5 0 0 1 1.99-.25l2.276 1.58a1.48 1.48 0 0 1 .354 2.096l-.47.633C19.869 21.892 15.188 22.187 9 16z" fill="currentColor"/></svg>
                                            </Link>
                                            <Link to={`/messages/${v.number}`} className="w-full border-b-2 hover:border-orange-500 transition-all text-orange-700 h-full flex justify-center hover:text-orange-500">
<svg className="w-2/5 h-1/2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 3C5.11765 3 3 4.64706 3 10C3 13.7383 4.0328 15.6692 7 16.4939V21L11.0124 16.9876C11.3301 16.996 11.6592 17 12 17C18.8824 17 21 15.3529 21 10C21 4.64706 18.8824 3 12 3Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

                                            </Link>
                                            <button onClick={(e) => deleteContact(e, i)} className="w-full peer border-b-2 hover:border-red-500 transition-all h-full flex justify-center text-red-700 hover:text-red-500">
<svg className="w-2/5 h-1/2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M4 7H20" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M6 7V18C6 19.6569 7.34315 21 9 21H15C16.6569 21 18 19.6569 18 18V7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M9 5C9 3.89543 9.89543 3 11 3H13C14.1046 3 15 3.89543 15 5V7H9V5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
                                            </button>
                                            
                                       </div>
                                    </div>
                                </div>
                            </div>
                        })}
                    </div>
                </div>
            </div>
        </div>
    )

}
