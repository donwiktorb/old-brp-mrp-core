

import React, { useState, useEffect } from 'react'
import sendMessage from '../../../../../Api'
import {useParams} from 'react-router-dom'
import Messages from '../../../components/Messages'
export default function Home(props) {
    const {number} = useParams()
    const [messages, setMessages] = useState(props.messages || [
        {
            number: '3333',

            content: 'Twoj kod weryfikacyjny',
            time: (new Date()).getTime(),
            read: true,

            name: 'John Black',
            isOwner: true
        },
        {
            number: '3333',

            content: 'Twoj kod weryfikacyjny',
            time: (new Date()).getTime(),
            read: 3,

            name: 'John Black',
            isOwner: false
        },
        {
            number: '3333',

            content: 'Twoj kod weryfikacyjny',
            time: (new Date()).getTime(),
            read: 3,

            name: 'John Black',
            isOwner: false
        },
    ])




    useEffect(() => {
        setMessages(props.messages)
    }, [props.messages])
    useEffect(() => {
        sendMessage('phone_get_number_messages', {
            number: number
        })
    }, [])

    const onSubmit = (e) => {
        e.preventDefault()
        let target = e.currentTarget.elements.content
        let value = e.currentTarget.elements.content.value
        e.target.reset()
        sendMessage('phone_send_message', {
            message: value,
            number: number
        })
    }

    useEffect(() => {
        let childs = document.getElementById('phone-messages')
        if (childs && childs.lastChild) 
            childs.lastChild.scrollIntoView({
                behavior: "instant",
                block: "center"
            })
    }, [messages])

    return (
        <div className="w-full h-full">
            <div className="w-full h-full flex flex-col gap-4 p-2">
                <Messages messages={messages} onSubmit={onSubmit} style={{ownerAuthor: 'bg-orange-500', author: 'bg-blue-500', contentAuthor: 'bg-orange-500 after:border-t-orange-500', content: 'bg-blue-500 after:border-t-blue-500', main: '', input:'', buttons:''}} />
            </div>
        </div>
    )
}
