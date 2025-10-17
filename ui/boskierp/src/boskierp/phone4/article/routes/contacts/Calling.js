
import React, {useEffect, useState} from 'react'
import sendMessage from '../../../../Api'
import { Link, useParams, useNavigate } from "react-router-dom";
import {getMedia, createPeerConnection, createOffer, setOffer, createAnswer, setAnswer} from '../../../../Api'

export default function Calling(props) {
    const {number} = useParams();
    const navigate = useNavigate()
    const [numb, setNumber] = useState(number || 0)

    useEffect(() => {
        setNumber(props.number || number)
    }, [props.number])

    const answer = async (e) => {
        e.preventDefault()
        navigate(`/call/${numb}`)
    }

    const decline = async (e) => {
        e.preventDefault()
        navigate('/')
    }
    
    return (
        <div className="w-full h-full p-2 flex relative"> 
            <div className="h-full w-full ">
                <div className="w-full h-full">
                    <div className="w-full h-full grid grid-cols-1 gap-4 ">
                        <div className="text-5xl text-white w-full h-full flex justify-center items-center select-none">{numb}</div>  
                        <div className="text-lg text-white w-full h-full flex justify-center items-center relative">
                            <svg className="animate-spin h-14 w-14 border-t-pink-500 border-yellow-500 border-b-pink-500 border-2 rounded-full " viewBox="0 0 48 48">
                            </svg>
                        </div>  
                        <div className="w-full h-full grid grid-cols-2 gap-4">
                            <button onClick={answer} className=" w-full h-full flex justify-center items-center">
                                <svg className="rounded-full text-green-500 hover:text-green-700 transition-all" fill="currentColor" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="52px" height="52px" viewBox="0 0 52 52" enableBackground="new 0 0 52 52">
                                <path d="M48.5,37.9L42.4,33c-1.4-1.1-3.4-1.2-4.8-0.1l-5.2,3.8c-0.6,0.5-1.5,0.4-2.1-0.2l-7.8-7l-7-7.8  c-0.6-0.6-0.6-1.4-0.2-2.1l3.8-5.2c1.1-1.4,1-3.4-0.1-4.8l-4.9-6.1c-1.5-1.8-4.2-2-5.9-0.3L3,8.4c-0.8,0.8-1.2,1.9-1.2,3  c0.5,10.2,5.1,19.9,11.9,26.7S30.2,49.5,40.4,50c1.1,0.1,2.2-0.4,3-1.2l5.2-5.2C50.5,42.1,50.4,39.3,48.5,37.9z"/>
                                </svg>
                            </button>  
                            <button onClick={decline} className=" w-full h-full flex justify-center items-center">
                                <svg className="rounded-full text-red-600 hover:text-red-500 transition-all" fill="currentColor" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="52px" height="52px" viewBox="0 0 52 52" enableBackground="new 0 0 52 52">
                                <path d="M48.5,37.9L42.4,33c-1.4-1.1-3.4-1.2-4.8-0.1l-5.2,3.8c-0.6,0.5-1.5,0.4-2.1-0.2l-7.8-7l-7-7.8  c-0.6-0.6-0.6-1.4-0.2-2.1l3.8-5.2c1.1-1.4,1-3.4-0.1-4.8l-4.9-6.1c-1.5-1.8-4.2-2-5.9-0.3L3,8.4c-0.8,0.8-1.2,1.9-1.2,3  c0.5,10.2,5.1,19.9,11.9,26.7S30.2,49.5,40.4,50c1.1,0.1,2.2-0.4,3-1.2l5.2-5.2C50.5,42.1,50.4,39.3,48.5,37.9z"/>
                                </svg>
                            </button>  
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )

}
