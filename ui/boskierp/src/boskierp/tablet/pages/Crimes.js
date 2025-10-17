
import React from 'react'
import { useState, useEffect } from 'react'
import { useParams, useNavigate, Link } from "react-router-dom";
import sendMessage from '../../../Api'

export default function Crimes(props) {
  const [Crimes, setCrimes] = useState([])
  const [msg, setMsg] = useState('')
  const [aCrimes, setACrimes] = useState([])
  const [money, setMoney] = useState(0)
  const [time, setTime] = useState(0)
  const nav = useNavigate()

  useEffect(() => {
    async function fn() {
      let people = await sendMessage('tablet_get_tariff')
      props.crimes = people
      setACrimes(people)
    }
    fn()
  }, [])

  const addCrime = (e) => {
    let { target } = e
    let { value } = target
    let split = value.split('-')
    let [catId, id] = split
    let crime = props.crimes[Number(catId)].elements[Number(id)]
    let obj = Crimes.find((v) => v.value === crime.value)
    if (obj) {
      const newState = Crimes.map((v) => {
        if (v.value === obj.value) {
          return { ...v, count: (v.count || 0) + 1 }
        }

        return v
      })
      setCrimes(newState)
    } else {
      crime.count = 1
      setCrimes([
        ...Crimes,
        crime
      ])
    }
  }

  useEffect(() => {
    let value = 0
    let value2 = 0
    let items = Crimes.map((v) => {
      value += v.money * v.count
      value2 += v.time * v.count
      return v.label + " x" + v.count
    })
    setMsg(items.join(', '))
    setMoney(value)
    setTime(value2)
  }, [Crimes])

  const removeCrime = (e) => {
    let { target } = e
    let { value } = target
    let split = value.split('-')
    let [catId, id] = split
    let val = Number(value)
    let crime = Crimes.find((v, i) => i === val)
    if (crime.count > 1) {
      const newState = Crimes.map((v, i) => {
        if (i === val) {
          return { ...v, count: (v.count || 0) - 1 }
        }

        return v
      })
      setCrimes(newState)
    } else
      setCrimes(Crimes.filter((v, i) => i !== val))
  }

  const clearAll = () => {
    setCrimes([])
  }

  const sortIt = (e) => {
    let value = e.target.value.toLowerCase()
    let newCrimes = props.crimes.map((v) => {
      let elements = v.elements.filter((nv) => nv.label.toLowerCase().includes(value))
      return { ...v, elements: elements }
    })
    newCrimes = newCrimes.filter((v) => v.elements.length > 0)
    setACrimes(newCrimes)
  }

  const jump = (e) => {
    props.setCrimeMsg(msg)
    nav('/jail')
  }

  return (
    <div className=" w-full h-full text-white">
      <div className="h-full w-full">
        <div className="w-full h-full">
          <div className="h-full w-full flex flex-col gap-4">
            <div className="w-full h-1/4 flex justify-center items-center gap-4">
              <div className="flex justify-center items-center flex-col w-full h-full p-2 gap-4">
                <textarea className="w-2/4 h-2/4 appearance-none p-2 border-black bg-gray-500 rounded-lg" value={msg} onChange={(e) => setMsg(e.target.value)}  >
                </textarea>
                <div className="w-2/4 gap-4 justify-center items-center grid grid-cols-7">
                  <input type='text' value={money} className="bg-gray-500 p-2 rounded-lg text-center"></input>
                  <input type='text' value={time} className="bg-gray-500 p-2 rounded-lg text-center"></input>
                  <button className="bg-gray-500 p-2 rounded-lg" onClick={clearAll}>
                    Wyczyść
                  </button>
                  <Link to="/jail" state={{
                    crimes: Crimes, money: money, time: time, crimeMsg: msg
                  }} className="bg-gray-500 p-2 rounded-lg">
                    Jail
                  </Link>
                  <Link to="/ticket" state={{ crimes: Crimes, money: money, time: time, crimeMsg: msg }} className="bg-gray-500 p-2 rounded-lg">
                    Ticket
                  </Link>
                  <button className="bg-gray-500 p-2 rounded-lg">
                    Przedstaw
                  </button>

                  <div className='relative inline-block  '>
                    <input onChange={sortIt} defaultValue="" className="bg-gray-500 focus:outline-none text-black rounded-lg p-2  w-full h-full" />
                    <svg className="absolute top-0 right-0.5 p-1 object-center w-7 text-black" fill="currentColor" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 502.173 502.173">
                      <g>
                        <g>
                          <g>
                            <path d="M494.336,443.646L316.402,265.713c20.399-31.421,30.023-68.955,27.189-106.632     C340.507,118.096,322.783,79.5,293.684,50.4C261.167,17.884,217.984,0,172.023,0c-0.222,0-0.445,0.001-0.668,0.001     C125.149,0.176,81.837,18.409,49.398,51.342c-66.308,67.316-65.691,176.257,1.375,242.85     c29.112,28.907,67.655,46.482,108.528,49.489c37.579,2.762,75.008-6.867,106.343-27.21l177.933,177.932     c5.18,5.18,11.984,7.77,18.788,7.77s13.608-2.59,18.789-7.769l13.182-13.182C504.695,470.862,504.695,454.006,494.336,443.646z      M480.193,467.079l-13.182,13.182c-2.563,2.563-6.73,2.561-9.292,0L273.914,296.456c-1.936-1.937-4.497-2.929-7.074-2.929     c-2.044,0-4.098,0.624-5.858,1.898c-60.538,43.788-143.018,37.3-196.118-15.425C5.592,221.146,5.046,124.867,63.646,65.377     c28.67-29.107,66.949-45.222,107.784-45.376c0.199,0,0.392-0.001,0.591-0.001c40.617,0,78.785,15.807,107.52,44.542     c53.108,53.108,59.759,135.751,15.814,196.509c-2.878,3.979-2.441,9.459,1.032,12.932l183.806,183.805     C482.755,460.35,482.755,464.517,480.193,467.079z" />
                            <path d="M259.633,84.449c-48.317-48.316-126.935-48.316-175.253,0c-23.406,23.406-36.296,54.526-36.296,87.627     c0,33.102,12.89,64.221,36.296,87.627S138.906,296,172.007,296c33.102,0,64.222-12.891,87.627-36.297     C307.951,211.386,307.951,132.767,259.633,84.449z M245.492,245.561C225.863,265.189,199.766,276,172.007,276     c-27.758,0-53.856-10.811-73.484-30.44c-19.628-19.628-30.438-45.726-30.438-73.484s10.809-53.855,30.438-73.484     c20.262-20.263,46.868-30.39,73.484-30.39c26.61,0,53.227,10.133,73.484,30.39C286.011,139.112,286.011,205.042,245.492,245.561z     " />
                            <path d="M111.017,153.935c1.569-5.296-1.452-10.861-6.747-12.43c-5.294-1.569-10.86,1.451-12.429,6.746     c-8.73,29.459-0.668,61.244,21.04,82.952c1.952,1.952,4.512,2.929,7.071,2.929s5.118-0.977,7.071-2.928     c3.905-3.906,3.905-10.238,0-14.143C110.506,200.544,104.372,176.355,111.017,153.935z" />
                            <path d="M141.469,94.214c-10.748,4.211-20.367,10.514-28.588,18.735c-3.905,3.906-3.905,10.238,0,14.143     c1.952,1.952,4.512,2.929,7.071,2.929s5.118-0.977,7.07-2.929c6.26-6.26,13.575-11.057,21.741-14.255     c5.143-2.015,7.678-7.816,5.664-12.959C152.413,94.735,146.611,92.202,141.469,94.214z" />
                          </g>
                        </g>
                      </g>
                    </svg>
                  </div>
                </div>
              </div>
            </div>
            <div className="w-full h-3/4 flex">
              <div className="w-1/4 h-fit max-h-full flex flex-wrap gap-4 px-2 overflow-y-scroll pb-2">
                {Crimes.map((v, i) => {
                  return <button className="bg-gray-500 border-red-500 border-2 grow p-2 w-fit h-fit rounded-lg" value={i} onClick={removeCrime}>
                    {v.label} x{v.count}
                  </button>
                })}
              </div>
              <div className="w-3/4 h-full flex flex-col gap-4 overflow-y-scroll ">
                {aCrimes.map((v, i) => {
                  return <div className="w-full h-fit flex flex-col gap-4 ">
                    <div className="w-full text-xl text-left">
                      {v.label}
                    </div>
                    <div className="w-full h-full grid grid-cols-4 gap-4 pr-4 overflow-y-scroll pb-2 ">
                      {v.elements && v.elements.map((nv, ni) => {
                        return <button className="bg-gray-500 p-2 rounded-lg w-full h-fit" onClick={addCrime} value={`${i}-${ni}`}>
                          {nv.label}
                        </button>
                      })}
                    </div>
                  </div>
                })}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

