

import React, {useEffect, useState} from 'react'
import { useParams } from 'react-router-dom';
import sendMessage from '../../../../../Api'

export default function Darkweb(props) {
    const [chats, setChats] = useState(props.messages || [])

    useEffect(() => {
        let elem = document.getElementById('chats')
        if (elem && elem.lastChild)
            elem.lastChild.scrollIntoView({block:"end", behaviour: "smooth"})
    }, [chats])

    useEffect(() => {
        setChats(props.chats || [
            {
                content: "hello",
                name: "x d"
            },
            {
                content: "hello",
                name: "x d"
            }
        ])
    }, [props.chats])

    useEffect(() => {
        sendMessage('phone_chat_get_messages', {
            type: 'darkweb'
        })
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [])

    const submit = (e) => {
        e.preventDefault()
        let target = e.target[0]
        let {value} = target
        target.value = ''
        sendMessage('phone_chat_send_message', {
            message: value,
            type: 'darkweb'
        })
        // setChats([
        //     {
        //         content: value,
        //         name: 'hello'
        //     }
        // ])
    }
      const showImage = (e)=>{
        if (e.target.classList.contains('fixed'))
            e.target.classList.remove('fixed', 'top-0', 'z-40', 'w-auto', 'h-auto', 'left-0')
        else
            e.target.classList.add('fixed', 'z-40', 'top-0', 'w-auto', 'h-auto', 'left-0')
    }
    const msgAction = (e, i) => {
        e.preventDefault()
        let msg = chats[i]
        sendMessage('phone_message_action', {
            message: msg,
            type: 'darkweb'
        })
    }

    const getFormat = (v, i) => {
               const regex = /(https?:\/\/[^\s]+)/g;
        const matches = v.content.match(regex);
        if (v.owned) {
            return <div onClick={(e) => msgAction(e,i)} key={i} className=" bg-slate-500 bg-opacity-50 justify-self-end h-fit max-w-[80%] px-1 rounded ">
        <div className="flex">
            <div className="flex text-white justify-center items-center text-center w-full">
                {v.name}
            </div>
        </div>
            <div className="text-white">
                {v.content}
                   {matches && <div className="grid grid-cols-2 gap-2">
                    {matches.map((v, i) => {
                        return <img onClick={showImage} src={v} alt={i} />
                    })}
                </div>}
            </div>
            <p className="text-sm text-blue-400 font-medium italic text-center ">{new Date(v.time).toLocaleString()}</p>
            </div>
        } else
            return <div key={i} onClick={(E) =>msgAction(E,i)} className=" bg-slate-500 bg-opacity-50 justify-self-center h-fit max-w-[90%] px-1 rounded ">
        <div className="flex">
            <div className="flex text-white justify-center items-center text-center w-full">
                {v.name}
            </div>
        </div>
            <div className="text-white">
                {v.content}
                   {matches && <div className="grid grid-cols-2 gap-2">
                    {matches.map((v, i) => {
                        return <img onClick={showImage} src={v} alt={i} />
                    })}
                </div>}
            </div>
            <p className="text-sm text-blue-400 font-medium italic text-center ">{new Date(v.time).toLocaleString()}</p>
            </div>
    }

    const [gps, setGps] = useState('')

    const getGps = (e) => {
        async function fn() {
            const coords = await sendMessage('phone_get_gps', {
                type: 'twitter'
            })
            setGps(coords)
        }
        fn()
    }

    return (
        <div className="w-full h-full text-white bg-black bg-opacity-70 relative px-2 
         ">
            <div id="chats" className="w-full h-4/5 grid  grid-cols-1 gap-4 overflow-auto content-start break-words text-left py-2 px-2 text-blue-500">
                {chats.map((v, i) => {
                    return getFormat(v, i)
                })} 
            </div>
            <div className="w-full h-fit"> 
                <form id="sendmsg" className="grid grid-cols-1 gap-2 justify-between text-white w-full  p-2 items-end" onSubmit={(e)=>submit(e)}>
                    <div className="w-full">
                        <input type="text" defaultValue={gps} 
                        placeholder={`Napisz wiadomosc`}
                        className="
                        text-center
                        bg-black
                        bg-opacity-20
                        placeholder:text-white
                        focus:outline-none
                        min-w-full
                        block p-2 w-full text-white  rounded-lg sm:text-xs "/>
                    </div>
                    <div className="w-full h-full grid grid-cols-3 gap-2 ">
                        <div className="
                            h-fit
                            bg-blue-700
                            bg-opacity-40
                            transition-all
                            hover:bg-opacity-80
                            placeholder:text-white
                            p-2  text-white  rounded-lg sm:text-xs
                            flex">
                            <svg fill="currentColor" className="w-8 h-4 " viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M20 2H4c-1.103 0-2 .897-2 2v12c0 1.103.897 2 2 2h3v3.767L13.277 18H20c1.103 0 2-.897 2-2V4c0-1.103-.897-2-2-2zm0 14h-7.277L9 18.233V16H4V4h16v12z"/></svg>
                            <button type="button"
                            value="gps" onClick={(e) => getGps(e)} >GPS</button>
                        </div>
                        <div className="
                            h-fit
                            bg-blue-700
                            bg-opacity-40
                            transition-all
                            hover:bg-opacity-80
                            placeholder:text-white
                            p-2  text-white  rounded-lg sm:text-xs
                            flex">
                            <svg fill="currentColor" className="w-8 h-4 " viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M20 2H4c-1.103 0-2 .897-2 2v12c0 1.103.897 2 2 2h3v3.767L13.277 18H20c1.103 0 2-.897 2-2V4c0-1.103-.897-2-2-2zm0 14h-7.277L9 18.233V16H4V4h16v12z"/></svg>
                            <input type="submit"
                            value="Wyślij" />
                        </div>
                        <div className="
                            h-fit
                            bg-blue-700
                            bg-opacity-40
                            transition-all
                            hover:bg-opacity-80
                            placeholder:text-white
                            p-2  text-white  rounded-lg sm:text-xs
                            flex">
                            <svg fill="currentColor" className="w-8 h-4 " viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M20 2H4c-1.103 0-2 .897-2 2v12c0 1.103.897 2 2 2h3v3.767L13.277 18H20c1.103 0 2-.897 2-2V4c0-1.103-.897-2-2-2zm0 14h-7.277L9 18.233V16H4V4h16v12z"/></svg>
                            <button type="button"
                            value="emoji" >Emoji</button>
                        </div>
                    </div>
                </form>
            </div>
            
        </div>
    )
}

