import sendMessage from '../../../Api'
import { Link } from 'react-router-dom'
import React, { useState, useEffect } from 'react'
import Markdown from 'react-markdown'

export default function Messages(props) {
    const [messages, setMessages] = useState(props.messages)

    useEffect(() => {
        let childs = document.getElementById('phone-messages')
        if (childs && childs.lastChild)
            childs.lastChild?.scrollIntoView({ behavior: "instant", block: "center" })
    }, [messages])

    useEffect(() => {
        setMessages(props.messages)
    }, [props.messages])

    const onGpsButton = (e) => {
        e.preventDefault()
        let target = e.currentTarget.form.elements.content
        let val = target.value
        if (!val.includes('{GPS}'))
            target.value = target.value + ' {GPS} '
    }

    const showImage = (e)=>{
        // if (e.target.classList.contains('fixed'))
        //     e.target.classList.remove('fixed', 'top-0', 'z-40', 'w-auto', 'h-auto', 'left-0')
        // else
        //     e.target.classList.add('fixed', 'z-40', 'top-0', 'w-auto', 'h-auto', 'left-0')
        if (e.target.classList.contains('fixed')) { e.target.remove()
            // e.target.classList.remove('fixed', 'top-0', 'z-40', 'w-auto', 'h-auto', 'left-0')
        }
        else {
            let elem = e.target.cloneNode(true)
            elem.classList.add('fixed', 'z-40', 'top-0', 'w-auto', 'h-auto', 'left-0')
            let targetElem = document.getElementById('Phone')
            elem.onclick = showImage
            targetElem.appendChild(elem)
        }

    }

    const formatDate = (time) => {
        let date = new Date(time)
        const year = date.toLocaleString('default', {year: '2-digit'});
        const month = date.toLocaleString('default', { month: '2-digit', });
        const day = date.toLocaleString('default', {day: '2-digit'});
        let dateStr = `${year}/${month}/${day}`
        let timeStr = `${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`
        return [dateStr, timeStr]
    }

    const onSubmit = (e) => {
        props.onSubmit(e)
    }

    const actionButton = (e,action, msg) => {
        if (props.actionButton) props.actionButton(e)
        else {
            sendMessage('phone_message_action', {
                message: msg,
                action: action
            })
        }
    }

    return (
        <div className="w-full h-full">
            <div className="w-full h-full flex flex-col gap-4 p-2">
                <div className="w-full h-full flex flex-col gap-4 overflow-y-scroll px-3" id="phone-messages">
                    {messages.map((v, i) => {
                        const regex = /(https?:\/\/[^\s]+)/g;
                        const matches = v.content.match(regex);
                        const actionRegex = /{GPS}/g;
                        const actions = v.content.match(actionRegex);
                        let content = v.content.replaceAll(regex, '')
                        let fixedContent = content.replace(actionRegex, '')
                        const [dateStr, timeStr] = formatDate(v.time)
                        return <div className={`w-auto h-auto flex gap-3 flex-col ${v.isOwner ? 'self-end' : 'self-start'} relative`}>
                            {v.author && <div className={`${v.isOwner ? `self-end bg-blue-900 ${props.style.ownerAuthor}` : `self-start bg-blue-500 ${props.style.author}`} h-auto rounded-lg p-2 relative text-left text-xs `}>
                                {v.author}
                            </div>}
                            <div className={`${v.isOwner ? `self-end after:right-3 ${props.style.contentAuthor}` : `self-start bg-blue-500 after:left-3 after:border-t-blue-500 ${props.style.content}`} w-5/6 h-auto rounded-lg p-2 relative break-words after:block after:w-0 after:content-[''] after:border-8 after:border-transparent after:border-t-blue-500 text-left after:border-b-0 after:absolute after:-bottom-[7.7px] ${props.style.main}`}>
                                <Markdown components={{}}>
                                    {fixedContent}
                                </Markdown>
                                {matches && <div className="grid grid-cols-2 gap-2">
                                    {matches.map((v, i) => {
                                        return <img onClick={showImage} src={v} alt={i} />
                                    })}
                                </div>}

                                {actions && <div className="grid grid-cols-3 gap-2 py-0.5 truncate">
                                    {actions.map((v4, i) => {
                                        const label = v4.replace('{', '').replace('}', '')
                                        return <button onClick={(e) => actionButton(e,label,v)} className="px-3 p-0.5 bg-blue-900 rounded-lg flex items-center justify-center">
                                            {label}
                                        </button>
                                    })}
                                </div>}
                            </div>
                            <div className={`${v.isOwner ? 'self-end flex-row-reverse' : 'self-start'} px-2.5 flex gap-3 text-sm justify-center items-center`}>
                                {(props.defaultAvatar || v.avatar) && <img className="w-5 h-auto rounded-full" src={props.defaultAvatar || v.avatar} alt="AVATAR" />}
                                <div className="flex group text-sm w-full overflow-hidden text-left w-[3.75rem] justify-center items-center">
                                    <div className="group-hover:w-0 overflow-hidden ease-in-out duration-300 transition transition-[width] w-[3.75rem] truncate group-hover:delay-75 delay-300">
                                        {dateStr}
                                    </div>
                                    <div className="w-0 overflow-hidden group-hover:w-full ease-in-out duration-300 transition transition-[width] truncate group-hover:delay-300 delay-75">
                                        {timeStr}
                                    </div>
                                </div>
                                {v.isRead && <div className="w-5 h-auto peer">
                                    <svg width="800px" height="800px" className="w-5 h-5 text-blue-500" viewBox="0 0 16 16" version="1.1" xmlns="http://www.w3.org/2000/svg" >
                                        <rect width="16" height="16" id="icon-bound" fill="none" />
                                        <path d="M0,9.014L1.414,7.6L5.004,11.189L14.593,1.6L16.007,3.014L5.003,14.017L0,9.014Z" fill="currentColor" />
                                    </svg>
                                </div>}
                            </div>
                        </div>
                    })}
                </div>
                <div className="w-full h-auto self-end">
                    <form onSubmit={onSubmit} className="w-full h-full flex items-center justify-around">
                        <input id="content" className={`rounded-lg text-black focus:outline-none px-0.5 ${props.style.input}`} type="text" />
                        <button className={`rounded-lg p-0.5`} type="submit" >
                            <div className="flex justify-center items-center gap-1 w-full h-full">
                                <div className="h-full bg-orange-500 rounded-full p-1 block flex justify-center items-center hover:text-blue-500 transition-all hover:bg-orange-700 hover:animate-wiggle">
                                    <svg className=" w-full h-5 block" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M12.0004 18.5816V12.5M12.7976 18.754L15.8103 19.7625C17.4511 20.3118 18.2714 20.5864 18.7773 20.3893C19.2166 20.2182 19.5499 19.8505 19.6771 19.3965C19.8236 18.8737 19.4699 18.0843 18.7624 16.5053L14.2198 6.36709C13.5279 4.82299 13.182 4.05094 12.7001 3.81172C12.2814 3.60388 11.7898 3.60309 11.3705 3.80958C10.8878 4.04726 10.5394 4.8182 9.84259 6.36006L5.25633 16.5082C4.54325 18.086 4.18671 18.875 4.33169 19.3983C4.4576 19.8528 4.78992 20.2216 5.22888 20.394C5.73435 20.5926 6.55603 20.3198 8.19939 19.7744L11.2797 18.752C11.5614 18.6585 11.7023 18.6117 11.8464 18.5933C11.9742 18.5769 12.1036 18.5771 12.2314 18.5938C12.3754 18.6126 12.5162 18.6597 12.7976 18.754Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </div>
                            </div>
                        </button>
                        <button className={`rounded-lg p-0.5`} type="gps" onClick={onGpsButton} >
                            <div className="flex justify-center items-center gap-1 w-full h-full">
                                <div className={`h-full bg-blue-500 rounded-full p-1 block flex justify-center items-center hover:text-blue-500 transition-all hover:bg-orange-700 hover:animate-wiggle`}>
                                    <svg className="w-full h-5 block" fill="currentColor" width="800px" height="800px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M20.992,9.98A8.991,8.991,0,0,0,3.01,9.932a13.95,13.95,0,0,0,8.574,12.979A1,1,0,0,0,12,23a1.012,1.012,0,0,0,.419-.09A13.948,13.948,0,0,0,20.992,9.98ZM12,20.9A11.713,11.713,0,0,1,5.008,10a6.992,6.992,0,1,1,13.984,0c0,.021,0,.045,0,.065A11.7,11.7,0,0,1,12,20.9ZM12,6a4,4,0,1,0,4,4A4,4,0,0,0,12,6Zm0,6a2,2,0,1,1,2-2A2,2,0,0,1,12,12Z" /></svg>
                                </div>
                            </div>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    )
}
