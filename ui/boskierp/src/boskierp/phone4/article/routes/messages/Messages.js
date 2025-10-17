import React, {useEffect, useState} from 'react'
import { Link, useNavigate } from "react-router-dom";
import sendMessage from '../../../../Api'


export default function Messages(props) {
    const navigate = useNavigate();
    const [messages, setMessages] = useState(
        props.lastmsgs || 
        [{number:"x d", isRead:false}])

    useEffect(() => {
        setMessages(props.lastmsgs)
    }, [props.lastmsgs])

    useEffect(() => {
        sendMessage('phone_get_last_messages')
    }, [])

    const submit = (e) => {
        e.preventDefault()
        let {value} = e.target[0]
        navigate(value) 
    }

    const readStyle = 'bg-slate-900 bg-opacity-50 text-slate-100 px-5 py-3.5 rounded-lg shadow hover:shadow-xl max-w-sm mx-auto transform hover:-translate-y-[0.125rem] transition duration-100 ease-linear'

    const unReadStyle = 'bg-slate-500 bg-opacity-50 text-slate-100 px-5 py-3.5 rounded-lg shadow hover:shadow-xl max-w-sm mx-auto transform hover:-translate-y-[0.125rem] transition duration-100 ease-linear'

    const deleteContact = async(e,i) => {
        e.preventDefault()
        let item = messages[i]
        sendMessage('phone_messages_delete', {
            contact:item,
            id:i
        })
        sendMessage('phone_get_last_messages')
    }

    const onImageError = (e) => {
        e.target.src = "https://cdn.discordapp.com/attachments/1020433320934379612/1024767726104870933/xd8_digital_art_x4.png"
    }



    return (
        <div className="w-full h-full p-2 flex"> 
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
                                <svg fill="currentColor" className="w-8 h-4 " viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M20 2H4c-1.103 0-2 .897-2 2v12c0 1.103.897 2 2 2h3v3.767L13.277 18H20c1.103 0 2-.897 2-2V4c0-1.103-.897-2-2-2zm0 14h-7.277L9 18.233V16H4V4h16v12z"/></svg>
                                <input type="submit"
                                value="Wiadomość" />
                            </div>
                        </div>
                    </form>
                    <div className="w-full h-fit place-content-start grid grid-cols-1 gap-2">
                        {messages.map((v, i) => {
                            return <Link key={`lastmsg-${i}`} to={v.number} className="w-full text-white ">
                                <div className="w-full h-auto relative group">
                                    <div className={v.isRead === 1 ? readStyle :unReadStyle}>
                                        <div className="flex items-center rounded-lg cursor-pointer">
                                                <div className="w-full flex items-center justify-center">
                                                <div className='w-1/4'>
                                                    <img onError={onImageError}className="w-auto rounded-full" src={v.img || "https://cdn.discordapp.com/attachments/1020433320934379612/1024767726104870933/xd8_digital_art_x4.png"} alt=""/>
                                                </div>
                                                <div className="w-3/4 ">
                                                    <p className="text-md truncate">{v.number}</p>
                                                    <p className="text-base text-gray-400  truncate p-1 italic">{v.lastMsg}</p>
                                                    <p className="text-sm text-blue-400 font-medium ">{new Date(v.time).toLocaleString()}</p>
                                                </div>
                                            </div>
                                        </div>
                                        {/* <div className="hidden gap-4 justify-center p-2 group-hover:flex">
                                            <Link to={`/messages/${v.number}`} className="w-full border-b-2 hover:border-orange-500 transition-all text-orange-700 h-full flex justify-center hover:text-orange-500">
<svg className="w-1/6 h-1/2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 3C5.11765 3 3 4.64706 3 10C3 13.7383 4.0328 15.6692 7 16.4939V21L11.0124 16.9876C11.3301 16.996 11.6592 17 12 17C18.8824 17 21 15.3529 21 10C21 4.64706 18.8824 3 12 3Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

                                            </Link>
                                            {/* <button onClick={(e) => deleteContact(e,i)} className="w-full peer border-b-2 hover:border-red-500 transition-all h-full flex justify-center text-red-700 hover:text-red-500">
<svg className="w-1/5 h-1/2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M4 7H20" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M6 7V18C6 19.6569 7.34315 21 9 21H15C16.6569 21 18 19.6569 18 18V7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M9 5C9 3.89543 9.89543 3 11 3H13C14.1046 3 15 3.89543 15 5V7H9V5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
                                            </button>
                                             
                                       </div> */}
                                    </div>
                                </div>
                            </Link>
                        })}
                    </div>
                </div>
            </div>
        </div>
    )
}