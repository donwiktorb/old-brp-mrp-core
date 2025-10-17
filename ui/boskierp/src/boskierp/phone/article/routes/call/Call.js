

import React, { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import sendMessage from '../../../../../Api';
import rtc from '../../../../../WebRTC';

export default function Call(props) {
  const navigate = useNavigate()
  const params = useParams()
  const { number, caller } = params
  const [started, setStarted] = useState(false)
  const [startDate, setStartDate] = useState(new Date())
  const [currentSeconds, setCurrentSeconds] = useState(0)

  useEffect(() => {
    async function startCall() {
      const shouldStart = await sendMessage('phone_try_call', {
        number: number
      })
      if (!shouldStart) return navigate('/')
      rtc.start(number, () => {
        rtc.createOffer()
      })
    }

    if (caller) {
      startCall()
    }

    return () => {
      rtc.hangup()
    }
  }, [])

  useEffect(() => {
    if (caller && props.manager.offer) {
      rtc.setOffer(props.manager.offer)
      props.callFn({
        action: 'setCallState',
        offer: false
      })
    }
    // rtc.start(number, () => {
    // })
  }, [props.manager.offer])

  useEffect(() => {
    if (props.manager.candidate) {
      rtc.addCandidate(props.manager.candidate)
      props.callFn({
        action: 'setCallState',
        candidate: false
      })
    }
  }, [props.manager.candidate])

  useEffect(() => {
    if (props.manager.answer) {
      rtc.setAnswer(props.manager.answer)
      props.callFn({
        action: 'setCallState',
        answer: false
      })

      setStarted(true)
    }
  }, [props.manager.answer])

  useEffect(() => {
    if (props.manager.stopCall) {
      props.callFn({
        action: 'setCallState',
        stopCall: false
      })
      navigate('/')
    }
  }, [props.manager.stopCall])

  useEffect(() => {
    let interval = setInterval(() => {
      let newDate = new Date()
      let timeDifference = newDate.getTime() - startDate.getTime()
      setCurrentSeconds(timeDifference)
    }, 1000)

    return () => {
      clearInterval(interval)
    }
  })

  const fixTime = (time) => {
    const timeStr = time.toString()
    if (timeStr.length < 2) {
      return `0${timeStr}`
    } else return timeStr
  }

  const answerButton = async (e) => {
    e.preventDefault()

    rtc.start(number, () => {
      rtc.setOffer(props.manager.offer)
      setStarted(true)
    })
    props.callFn({
      action: 'setCallState',
      isCalling: false
    })

    // sendMessage('phone_stop_call', {
    //     number: number
    // })

    // rtc.hangup()

    // navigate('/')

  }

  const hangupButton = async (e) => {
    e.preventDefault()

    sendMessage('phone_stop_call', {
      number: number
    })

    rtc.hangup()

    props.callFn({
      action: 'setCallState',
      isCalling: false
    })

    navigate('/')

  }

  return <div className="w-full h-full">
    <div className="w-full h-full flex justify-evenly items-center flex-col gap-4">
      <div id="audio" className="h-2">
        <div className="text-white">
          <audio id="localAudio" autoPlay muted ></audio>
          <audio id="remoteAudio" autoPlay ></audio>
        </div>
      </div>


      {number} {caller}
      {caller && !started && <div className="w-full h-auto text-lg font-bold font-mono ">
        <div className="animate-bounce">Dzwonisz do</div><div>{number}</div>
      </div>}

      {!caller && !started && <div className="w-full h-auto text-lg font-bold font-mono ">
        <div className="animate-bounce">Połączenie przychodzące</div><div>{number}</div>
      </div>}

      {started && <div className="w-20 h-20  border-4 animate-rainbowborder rounded-full text-xl flex justify-center items-center">
        <p>
          {fixTime(Math.floor(currentSeconds / 1000 / 60))}
        </p><p className="animate-ping4">:</p><p>
          {fixTime(Math.floor(currentSeconds / 1000) % 60)}
        </p>
      </div>}


      <div className="w-full h-1/4 flex gap-4 justify-evenly items-center">
        {(!caller && !started) && <button onClick={answerButton} className="w-20 h-20 transition-all -rotate-90 text-green-500 border-4 rounded-full p-3 border-green-500 hover:border-blue-500 transition-all group/accept hover:-rotate-180">
          <svg fill="currentColor" className="w-full group-hover/accept:scale-110 h-full transition-all" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
            <path d="M29.563 14.037c-3.473-3.465-8.267-5.607-13.562-5.607s-10.088 2.143-13.562 5.608l0-0c-1.031 1.042-1.668 2.476-1.668 4.059 0 1.58 0.635 3.011 1.663 4.053l-0.001-0.001 0.003 0.004c0.223 0.23 0.468 0.436 0.733 0.615l0.016 0.010c0.457 0.335 0.992 0.595 1.57 0.75l0.034 0.008c0.091 0.024 0.195 0.037 0.302 0.037 0.276 0 0.53-0.089 0.737-0.241l-0.003 0.002 5.891-4.277c0.314-0.23 0.515-0.597 0.516-1.012v-0c-0-0.686-0.126-1.343-0.354-1.949l0.013 0.038c1.223-0.46 2.636-0.725 4.111-0.725s2.889 0.266 4.194 0.753l-0.083-0.027c-0.216 0.568-0.341 1.225-0.342 1.911v0c0 0.414 0.202 0.782 0.512 1.009l0.003 0.002 5.891 4.277c0.203 0.149 0.458 0.238 0.734 0.238 0 0 0 0 0.001 0h-0c0.001 0 0.001 0 0.002 0 0.106 0 0.209-0.014 0.307-0.039l-0.008 0.002c0.588-0.153 1.103-0.4 1.557-0.726l-0.014 0.009c0.306-0.202 0.573-0.422 0.813-0.669l0.001-0.001c1.027-1.042 1.661-2.473 1.661-4.053 0-1.582-0.637-3.016-1.668-4.059l0.001 0.001zM27.793 20.387c-0.127 0.133-0.268 0.25-0.421 0.35l-0.009 0.006c-0.076 0.055-0.164 0.111-0.256 0.161l-0.014 0.007-4.764-3.459c0.098-0.466 0.283-0.877 0.54-1.233l-0.007 0.010c0.142-0.2 0.227-0.449 0.227-0.718 0-0.491-0.284-0.916-0.697-1.12l-0.007-0.003c-1.864-0.933-4.061-1.479-6.386-1.479s-4.522 0.546-6.47 1.518l0.084-0.038c-0.42 0.207-0.704 0.633-0.704 1.124 0 0.268 0.084 0.517 0.228 0.72l-0.003-0.004c0.249 0.348 0.435 0.759 0.53 1.203l0.004 0.021-4.764 3.459c-0.13-0.073-0.238-0.142-0.341-0.217l0.011 0.008c-0.138-0.093-0.257-0.195-0.365-0.308l-0.001-0.001c-0.583-0.59-0.943-1.401-0.943-2.296 0-0.893 0.359-1.703 0.94-2.292l-0 0c3.020-3.014 7.189-4.877 11.793-4.877s8.773 1.864 11.793 4.878l-0-0c0.581 0.589 0.94 1.398 0.94 2.291s-0.359 1.702-0.94 2.291l0-0z" />
          </svg>

        </button>}
        <button onClick={hangupButton} className="w-20 h-20 transition-all rotate-90 text-red-500 border-4 rounded-full p-3 border-red-500 hover:border-blue-500 transition-all group/decline hover:rotate-0">
          <svg fill="currentColor" className="w-full h-full group-hover/decline:scale-110 transition-all" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
            <path d="M29.563 14.037c-3.473-3.465-8.267-5.607-13.562-5.607s-10.088 2.143-13.562 5.608l0-0c-1.031 1.042-1.668 2.476-1.668 4.059 0 1.58 0.635 3.011 1.663 4.053l-0.001-0.001 0.003 0.004c0.223 0.23 0.468 0.436 0.733 0.615l0.016 0.010c0.457 0.335 0.992 0.595 1.57 0.75l0.034 0.008c0.091 0.024 0.195 0.037 0.302 0.037 0.276 0 0.53-0.089 0.737-0.241l-0.003 0.002 5.891-4.277c0.314-0.23 0.515-0.597 0.516-1.012v-0c-0-0.686-0.126-1.343-0.354-1.949l0.013 0.038c1.223-0.46 2.636-0.725 4.111-0.725s2.889 0.266 4.194 0.753l-0.083-0.027c-0.216 0.568-0.341 1.225-0.342 1.911v0c0 0.414 0.202 0.782 0.512 1.009l0.003 0.002 5.891 4.277c0.203 0.149 0.458 0.238 0.734 0.238 0 0 0 0 0.001 0h-0c0.001 0 0.001 0 0.002 0 0.106 0 0.209-0.014 0.307-0.039l-0.008 0.002c0.588-0.153 1.103-0.4 1.557-0.726l-0.014 0.009c0.306-0.202 0.573-0.422 0.813-0.669l0.001-0.001c1.027-1.042 1.661-2.473 1.661-4.053 0-1.582-0.637-3.016-1.668-4.059l0.001 0.001zM27.793 20.387c-0.127 0.133-0.268 0.25-0.421 0.35l-0.009 0.006c-0.076 0.055-0.164 0.111-0.256 0.161l-0.014 0.007-4.764-3.459c0.098-0.466 0.283-0.877 0.54-1.233l-0.007 0.010c0.142-0.2 0.227-0.449 0.227-0.718 0-0.491-0.284-0.916-0.697-1.12l-0.007-0.003c-1.864-0.933-4.061-1.479-6.386-1.479s-4.522 0.546-6.47 1.518l0.084-0.038c-0.42 0.207-0.704 0.633-0.704 1.124 0 0.268 0.084 0.517 0.228 0.72l-0.003-0.004c0.249 0.348 0.435 0.759 0.53 1.203l0.004 0.021-4.764 3.459c-0.13-0.073-0.238-0.142-0.341-0.217l0.011 0.008c-0.138-0.093-0.257-0.195-0.365-0.308l-0.001-0.001c-0.583-0.59-0.943-1.401-0.943-2.296 0-0.893 0.359-1.703 0.94-2.292l-0 0c3.020-3.014 7.189-4.877 11.793-4.877s8.773 1.864 11.793 4.878l-0-0c0.581 0.589 0.94 1.398 0.94 2.291s-0.359 1.702-0.94 2.291l0-0z" />
          </svg>

        </button>
      </div>
    </div>
  </div>
}
