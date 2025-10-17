
import React, {useEffect, useState} from 'react'
import { useParams } from 'react-router-dom';
import sendMessage from '../../../../../Api'

export default function Twitter(props) {
    const [tweets, setTweets] = useState(props.tweets || [
        {
            owned: true,
            name:" X D",
            content:"X D"
        }
    ])

    useEffect(() => {
        let elem = document.getElementById('tweets')
        if (elem && elem.lastChild)
            elem.lastChild.scrollIntoView({block:"end", behaviour: "smooth"})
    }, [tweets])

    useEffect(() => {
        setTweets(props.tweets)
    }, [props.tweets])

    useEffect(() => {
        sendMessage('phone_chat_get_messages', {
            type: 'twitter'
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
            type: 'twitter'
        })
    }
    
    const msgAction = (e, i) => {
        e.preventDefault()
        let msg = tweets[i]
        sendMessage('phone_message_action', {
            message: msg,
            type: 'twitter'
        })
    }

      const showImage = (e)=>{
        if (e.target.classList.contains('fixed'))
            e.target.classList.remove('fixed', 'top-0', 'z-40', 'w-auto', 'h-auto', 'left-0')
        else
            e.target.classList.add('fixed', 'z-40', 'top-0', 'w-auto', 'h-auto', 'left-0')
    }



    const getFormat = (v, i) => {
        const regex = /(https?:\/\/[^\s]+)/g;
        const matches = v.content.match(regex);
        if (v.owned) {
            return <button onClick={(e) => msgAction(e,i)} key={i} className=" bg-blue-700 w-full bg-opacity-50 justify-self-center h-fit max-w-[90%] px-1 rounded ">
        <div className="flex">
            <svg className="h-8 text-blue-500 transition-all hover:text-blue-800 w-8 inline-block " viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" ><path
            strokeLinecap="round" storkeLinejoin="round" strokeWidht="2"
            fill="currentColor" d="M13.567 5.144c.008.123.008.247.008.371 0 3.796-2.889 8.173-8.172 8.173v-.002A8.131 8.131 0 011 12.398a5.768 5.768 0 004.25-1.19 2.876 2.876 0 01-2.683-1.995c.431.083.875.066 1.297-.05A2.873 2.873 0 011.56 6.348v-.036c.4.222.847.345 1.304.36a2.876 2.876 0 01-.89-3.836 8.152 8.152 0 005.92 3 2.874 2.874 0 014.895-2.619 5.763 5.763 0 001.824-.697 2.883 2.883 0 01-1.262 1.588A5.712 5.712 0 0015 3.656a5.834 5.834 0 01-1.433 1.488z"/></svg>
            <div className="flex text-white justify-center items-center text-center w-full">
                {v.name}
            </div>
            <svg className="h-8 text-blue-500 transition-all hover:text-blue-800 w-8 inline-block -rotate-270 " viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" ><path
            strokeLinecap="round" storkeLinejoin="round" strokeWidht="2"
            fill="currentColor" d="M13.567 5.144c.008.123.008.247.008.371 0 3.796-2.889 8.173-8.172 8.173v-.002A8.131 8.131 0 011 12.398a5.768 5.768 0 004.25-1.19 2.876 2.876 0 01-2.683-1.995c.431.083.875.066 1.297-.05A2.873 2.873 0 011.56 6.348v-.036c.4.222.847.345 1.304.36a2.876 2.876 0 01-.89-3.836 8.152 8.152 0 005.92 3 2.874 2.874 0 014.895-2.619 5.763 5.763 0 001.824-.697 2.883 2.883 0 01-1.262 1.588A5.712 5.712 0 0015 3.656a5.834 5.834 0 01-1.433 1.488z"/></svg>
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
            </button>
        } else
            return <button key={i} onClick={(e) => msgAction(e,i)} className=" bg-blue-500 bg-opacity-50 justify-self-center h-fit max-w-[90%] px-1 rounded w-full">
        <div className="flex">
            <svg className="h-8 text-blue-500 transition-all hover:text-blue-800 w-8 inline-block " viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" ><path
            strokeLinecap="round" storkeLinejoin="round" strokeWidht="2"
            fill="currentColor" d="M13.567 5.144c.008.123.008.247.008.371 0 3.796-2.889 8.173-8.172 8.173v-.002A8.131 8.131 0 011 12.398a5.768 5.768 0 004.25-1.19 2.876 2.876 0 01-2.683-1.995c.431.083.875.066 1.297-.05A2.873 2.873 0 011.56 6.348v-.036c.4.222.847.345 1.304.36a2.876 2.876 0 01-.89-3.836 8.152 8.152 0 005.92 3 2.874 2.874 0 014.895-2.619 5.763 5.763 0 001.824-.697 2.883 2.883 0 01-1.262 1.588A5.712 5.712 0 0015 3.656a5.834 5.834 0 01-1.433 1.488z"/></svg>
            <div className="flex text-white justify-center items-center text-center w-full">
                {v.name}
            </div>
            <svg className="h-8 text-blue-500 transition-all hover:text-blue-800 w-8 inline-block -rotate-270 " viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" ><path
            strokeLinecap="round" storkeLinejoin="round" strokeWidht="2"
            fill="currentColor" d="M13.567 5.144c.008.123.008.247.008.371 0 3.796-2.889 8.173-8.172 8.173v-.002A8.131 8.131 0 011 12.398a5.768 5.768 0 004.25-1.19 2.876 2.876 0 01-2.683-1.995c.431.083.875.066 1.297-.05A2.873 2.873 0 011.56 6.348v-.036c.4.222.847.345 1.304.36a2.876 2.876 0 01-.89-3.836 8.152 8.152 0 005.92 3 2.874 2.874 0 014.895-2.619 5.763 5.763 0 001.824-.697 2.883 2.883 0 01-1.262 1.588A5.712 5.712 0 0015 3.656a5.834 5.834 0 01-1.433 1.488z"/></svg>
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
            </button>
    }

    const [gps, setGps] = useState('')

    const getGps = (e) => {
        // async function fn() {
        //     const coords = await sendMessage('phone_get_gps', {
        //         type: 'twitter'
        //     })
        //     setGps(coords || 'x d')
        // }
        // fn()
        sendMessage('phone_chat_send_message', {
            message: 'gps',
            type: 'twitter'
        })
    }

    return (
        <div className="w-full h-full text-white bg-opacity-70 relative px-1.5 
         ">
         <div className="w-full h-full bg-blue-500 bg-opacity-70 rounded-t-md">

            <div id="tweets" className="w-full h-4/5 grid  grid-cols-1 gap-4 overflow-auto break-words content-start text-left px-2 text-blue-500">
                {tweets.map((v, i) => {
                    return getFormat(v, i)
                })} 
            </div>
            <div className="w-full h-fit"> 
                <form id="sendmsg" className="grid grid-cols-1 gap-2 justify-between text-white w-full  p-2 items-end" onSubmit={(e)=>submit(e)}>
                    <div className="w-full">
                        <input type="text" defaultValue={gps} 
                        placeholder={`Napisz tweeta`}
                        className="
                        text-center
                        bg-blue-500
                        placeholder:text-white
                        focus:outline-none
                        min-w-full
                        block p-2 w-full text-white  rounded-lg sm:text-xs "/>
                    </div>
                    <div className="w-full h-full grid grid-cols-3 gap-2 ">
                        <div className="
                            h-fit
                            bg-blue-500
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
                            bg-blue-500
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
                            bg-blue-500
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
            
        </div>
    )
}

