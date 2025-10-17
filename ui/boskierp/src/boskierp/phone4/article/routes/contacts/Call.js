import React, {useEffect, useState} from 'react'
import sendMessage from '../../../../Api'
import { useParams, useNavigate } from "react-router-dom";
// import {getMedia, createPeerConnection, createOffer, setOffer, createAnswer, setAnswer, hangup, AddCandidate} from '../../../../Api'
import {initPeer, createOffer, setOffer, createAnswer, setAnswer, getMedia, AddCandidate, hangup} from '../../../../Api'
// // import {initPeer, createOffer, setOffer, createAnswer, setAnswer, getMedia, AddCandidate, hangup} from '../../../../Api'


import rtc from '../../../../WebRTC';
export default function Call(props) {
    const {number, state} = useParams();


    const navigate = useNavigate()
    const [time, setTime] = useState('0')
    // // const [call, setCall] = useState(false)
    // // const [myOffer, setMyOffer] = useState(props.offer)
    // // const [myAnswer, setMyAnswer] = useState(props.answer)
    // const rtc = new WebRTC();

    const timeUpdate = (e) => {
        let date = new Date(e.timeStamp)
        setTime(`${date.toLocaleTimeString()}`)        
    }

    useEffect(() => {
        async function startCall() {
            // await getMedia()
            // await createPeerConnection()
            // const offer = await createOffer()
            // console.log(offer.sdp)
            // // await setOffer(offer.sdp, 'local') 

            // if (offer) {
            //     await setOffer(offer.sdp, 'local')
            //     const answer = await createAnswer()
            //     console.log(answer, 'x d')
            //     if (answer) {
            //         await setAnswer(answer.sdp, 'local')
            //     }
            // }

            // await initPeer()
            // const offer = await createOffer()
            // console.log(offer, 'x d')
            // if (offer) {
            //     await setOffer(offer.sdp)
            //     const answer = await createAnswer()
            //     console.log(answer, 'x d')
            //     if (answer) {
            //         await setAnswer(answer.sdp)
            //     }
            //     // sendMessage('phone_start_call', {
            //     //     sdp: offer.sdp,
            //     //     number: number
            //     // })
            // }
            // const shouldStart = await sendMessage('phone_try_call', {
            //     number: number
            // })
            // if (!shouldStart) return navigate('/')
            // await initPeer(number)
            // getMedia(() => {
            //     createOffer((offer) => {
            //         console.log('started')            
            //         sendMessage('phone_start_call', {
            //             sdp: offer.sdp,
            //             number: number
            //         })
            //     })
            // })
            const shouldStart = await sendMessage('phone_try_call', {
                number: number
            })
            if (!shouldStart) return navigate('/')
            rtc.start(number, () => {
                rtc.createOffer()
            })
        }

        if (state) {
            startCall()
        }
        return () => {
            rtc.hangup();
        };
    }, [])

    useEffect(() => {
        if (props.offer.offer)
            rtc.start(props.offer.number, () => {
                rtc.setOffer(props.offer.offer)
            })

    }, [props.offer])

    useEffect(() => {
        if (props.candidate)
            rtc.addCandidate(props.candidate)
    }, [props.candidate])

    useEffect(() => {
        if (props.answer.answer)
            rtc.setAnswer(props.answer.answer)
    }, [props.answer])
    // // useEffect(() => {
    // //     if (typeof(props.candidate) == 'string') return
    // //     AddCandidate(props.candidate)
    // // }, [props.candidate])

    // useEffect(() => {
    //     async function startCall() {
    //         await getMedia()
    //         await createPeerConnection()
    //         const offer = await createOffer()
    //         await setOffer(offer.sdp) 
    useEffect(() => {
        if (props.stopCall)
            navigate('/')
    }, [props.stopCall])

    // // useEffect(() => {
    // //     console.log('accepted', typeof(props.offer.sdp))            
    // //     // if (typeof(props.offer.sdp) == 'object') {
    // //     //     if (props.offer.sdp.stop) {

    // //     //         hangup()

    // //     //         navigate('/')
    // //     //     }
    // //     //     return
    // //     // }
    // //     async function acceptCall() {
    // //         await initPeer(number)
    // //         getMedia(() => {
    // //             setOffer(props.offer.sdp, () => {
    // //                 createAnswer((answer) => {
    // //                     sendMessage('phone_accept_call', {
    // //                         sdp: answer.sdp,
    // //                         number: number
    // //                     })
    // //                     setCall(true) 
    // //                 })
    // //             })
    // //         })
    // //     }

    // //     if (props.offer.sdp)
    // //         acceptCall()
    // // }, [props.offer.sdp])


    //         sendMessage('phone_start_call', {
    //             sdp: offer.sdp,
    //             number: number
    //         })
    //     }
    // // useEffect(() => {
    // //     console.log('accepted answer', typeof(props.answer.sdp))            
    // //     if (typeof(props.answer.sdp) == 'object') return
    // //     async function acceptCall() {
    // //         await setAnswer(props.answer.sdp)
    // //     }

    //     startCall()
    // }, [])
    // //     if (props.answer.sdp)
    // //         acceptCall()
    // // }, [props.answer.sdp])

    const submit = async (e) => {
        e.preventDefault()
        
        sendMessage('phone_stop_call', {
            number: number
        })

        rtc.hangup()

        navigate('/')

    }
    
    return (
        <div className="w-full h-full p-2 flex animate-pulse relative"> 
            <div className="h-full w-full ">
                <div className="w-full h-full">
                    <div id="audio" className="h-2">
                        <div className="text-white">
                            {/* <audio id="audio2" controls onTimeUpdate={timeUpdate} autoPlay></audio> */}
                            <audio id="localAudio" autoPlay muted onTimeUpdate={timeUpdate} ></audio>
                            <audio id="remoteAudio" autoPlay ></audio>
                        </div>
                    </div>
                    <div className="w-full h-full grid grid-cols-1 gap-4 ">
                        <div className="text-5xl text-white w-full h-full flex justify-center items-center select-none">{number}</div>  
                        <div className="text-lg text-white w-full h-full flex justify-center items-center relative">
                            <svg className="animate-spin h-14 w-14 border-t-pink-500 border-yellow-500 border-b-pink-500 border-2 rounded-full " viewBox="0 0 48 48">
                            </svg>
                            <div className="w-full h-full text-lg text-white absolute top-14 left-0">
                                {time}
                            </div>
                        </div>  
                        <button onClick={submit} className=" w-full h-full flex justify-center items-center">
                            <svg className="rounded-full text-red-700 hover:text-purple-700 transition-all" fill="currentColor" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="52px" height="52px" viewBox="0 0 52 52" enableBackground="new 0 0 52 52">
                            <path d="M48.5,37.9L42.4,33c-1.4-1.1-3.4-1.2-4.8-0.1l-5.2,3.8c-0.6,0.5-1.5,0.4-2.1-0.2l-7.8-7l-7-7.8  c-0.6-0.6-0.6-1.4-0.2-2.1l3.8-5.2c1.1-1.4,1-3.4-0.1-4.8l-4.9-6.1c-1.5-1.8-4.2-2-5.9-0.3L3,8.4c-0.8,0.8-1.2,1.9-1.2,3  c0.5,10.2,5.1,19.9,11.9,26.7S30.2,49.5,40.4,50c1.1,0.1,2.2-0.4,3-1.2l5.2-5.2C50.5,42.1,50.4,39.3,48.5,37.9z"/>
                            </svg>
                        </button>  
                    </div>
                </div>
            </div>
        </div>
    )
}