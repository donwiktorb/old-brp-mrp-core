

import React, { useState, useEffect } from 'react'
import sendMessage from '../../../../../Api'
import { Link } from 'react-router-dom'

export default function Messages(props) {
  const [messages, setMessages] = useState(props.lastMessages || [])

  useEffect(() => {
    setMessages(props.lastMessages || [])
  }, [props.lastMessages])

  useEffect(() => {
    sendMessage('phone_get_last_messages')
  }, [])

  return (
    <div className="w-full h-full relative">
      <div className="w-full h-full flex flex-col gap-4 p-2">
        {/* <div className="w-full h-[10%] flex justify-center items-center">
                        <input className="text-black" placeholder='Szukaj' />
                    </div>  */}
        <div className="w-full h-full flex flex-col gap-4">
          {messages.map((v, i) => {
            return <Link to={`/message/${v.number}`} className="w-full h-14 flex justify-center items-center gap-3 px-0.5 border-b" >
              <div className="h-9 p-3 w-9 flex justify-center items-center border-2 rounded-full text-lg">
                {v.name ? v.name[0] : "U"}
              </div>
              <div className="w-full h-full flex flex-col overflow-hidden text-left justify-center ">
                <div className="" title={v.name}>
                  {v.name || v.number}
                </div>
                <div className="text-sm truncate flex gap-1 items-center text-white">
                  <div className="text-orange-500">
                    {v.isOwner ?
                      <svg className="h-5" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M14 10L12 8M12 8L10 10M12 8V14M21 20L17.6757 18.3378C17.4237 18.2118 17.2977 18.1488 17.1656 18.1044C17.0484 18.065 16.9277 18.0365 16.8052 18.0193C16.6672 18 16.5263 18 16.2446 18H6.2C5.07989 18 4.51984 18 4.09202 17.782C3.71569 17.5903 3.40973 17.2843 3.21799 16.908C3 16.4802 3 15.9201 3 14.8V7.2C3 6.07989 3 5.51984 3.21799 5.09202C3.40973 4.71569 3.71569 4.40973 4.09202 4.21799C4.51984 4 5.0799 4 6.2 4H17.8C18.9201 4 19.4802 4 19.908 4.21799C20.2843 4.40973 20.5903 4.71569 20.782 5.09202C21 5.51984 21 6.0799 21 7.2V20Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />

                      </svg>
                      :
                      <svg className="h-5 " viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M10 12L12 14M12 14L14 12M12 14V8M21 20L17.6757 18.3378C17.4237 18.2118 17.2977 18.1488 17.1656 18.1044C17.0484 18.065 16.9277 18.0365 16.8052 18.0193C16.6672 18 16.5263 18 16.2446 18H6.2C5.07989 18 4.51984 18 4.09202 17.782C3.71569 17.5903 3.40973 17.2843 3.21799 16.908C3 16.4802 3 15.9201 3 14.8V7.2C3 6.07989 3 5.51984 3.21799 5.09202C3.40973 4.71569 3.71569 4.40973 4.09202 4.21799C4.51984 4 5.0799 4 6.2 4H17.8C18.9201 4 19.4802 4 19.908 4.21799C20.2843 4.40973 20.5903 4.71569 20.782 5.09202C21 5.51984 21 6.0799 21 7.2V20Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                      </svg>
                    }
                  </div>
                  <div className="truncate" title={v.content}>
                    {v.content}
                  </div>
                </div>
              </div>
              {/* <div className="bg-orange-500 w-7 h-7">
                                    3
                                </div> */}
              <div className="w-3/5 h-full flex flex-col overflow-hidden justify-center items-end ">
                <div className="flex-none w-6 h-6">
                  <div className="rounded-full bg-orange-500 w-full h-full text-center text-sm flex justify-center items-center " style={{ display: v.unread > 0 ? 'block' : 'hidden' }}>
                    {v.unread}
                  </div>
                </div>
                <div className="text-sm">
                  {(new Date(v.time).toLocaleDateString())}
                </div>
              </div>

            </Link>

          })}
        </div>
      </div>

    </div>
  )
}
