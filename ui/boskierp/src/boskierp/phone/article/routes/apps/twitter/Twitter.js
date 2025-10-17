


import sendMessage from '../../../../../../Api'
import React, { useState, useEffect } from 'react'
import Messages from '../../../../components/Messages'

export default function Twitter(props) {
  const [messages, setMessages] = useState(props.messages)

  useEffect(() => {
    let childs = document.getElementById('phone-messages')
    if (childs && childs.lastChild)
      childs.lastChild?.scrollIntoView({ behavior: "instant", block: "center" })
  }, [messages])

  useEffect(() => {
    sendMessage('phone_chat_get_messages', {
      type: 'twitter'
    })
  }, [])

  useEffect(() => {
    setMessages(props.messages)
  }, [props.messages])

  useEffect(() => {
    let bg = document.getElementById('phone-bg-main').style.background
    let bgElem = document.getElementById('phone-bg-main')
    if (bgElem)
      bgElem.style.background = 'rgb(0,177,255,50)'
    return () => {
      let bgElem4 = document.getElementById('phone-bg-main')
      if (bgElem4)
        bgElem4.style.background = bg
    }

  }, [])

  const onSubmit = (e) => {
    e.preventDefault()
    let target = e.currentTarget.elements.content
    let value = e.currentTarget.elements.content.value
    e.target.reset()
    sendMessage('phone_chat_send_message', {
      message: value,
      type: 'twitter'
    })
  }

  return (
    <Messages messages={messages} onSubmit={onSubmit} style={{ ownerAuthor: 'bg-blue-900', author: 'bg-blue-500', contentAuthor: '', content: '', main: '' }} />
  )
}
