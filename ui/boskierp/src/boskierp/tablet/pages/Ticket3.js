


import React from 'react'

import { useParams, useLocation } from "react-router-dom";
import sendMessage from '../../../Api'

export default function Ticket(props) {
    const {state} = useLocation()
    const submit = (e) => {
        e.preventDefault()
        let target = e.target
        let id = target[0].value
        let fine = target[1].value
        let reason = target[2].value
        sendMessage('tablet_fine', {
            id: id,
            fine: fine,
            reason: reason
        })
    }
  
    return (
            <div className=" w-full h-full text-white">
                <div className="h-full w-full">
                    <div className="w-full h-full">
                            <div className="h-full w-full">
                                <div className="w-full h-full">
                                    <div className="w-full h-full grid grid-cols-1 gap-8 px-8 py-8">
                                    <form onSubmit={submit} className="w-full h-full flex flex-col gap-8">   
                                        {/* <label for="default-search" className="mb-2 text-sm font-medium  sr-only text-yellow-300 grid grid-cols-1 gap-4">Szukaj</label> */}
                                        <div className="w-full grid grid-cols-2 gap-4">
                                            <input type="text" id="default-search" className="p-4 pl w-full text-sm rounded-lg border  bg-yellow-700 border-gray-600 placeholder-gray-400 text-white focus:ring-gray-500 focus:border-blue-500" placeholder="Wpisz pesel"/>
                                            <input type="text" defaultValue={state?.money} id="money" className="p-4 pl w-full text-sm rounded-lg border  bg-yellow-700 border-gray-600 placeholder-gray-400 text-white focus:ring-gray-500 focus:border-blue-500" placeholder="Ilość grzywny"/>
                                        </div>

                                        <div className="w-full">
                                                <textarea defaultValue={state?.crimeMsg} className="
                                                w-full max-h-96 bg-yellow-700 text-white rounded-lg p-2
                                                "placeholder="Wpisz powód">

                                                </textarea>
                                        </div>

                                        <div className="
                                            w-full h-full
                                            flex justify-center items-center
                                        ">
                                            <button type="submit" className="text-white mx-2  focus:ring-4 focus:outline-none  font-medium rounded-lg text-sm px-4 py-2 bg-yellow-600 hover:bg-gray-400 focus:ring-gray-800 w-fit h-fit">Wystaw mandat</button>
                                            
                                        </div>
                                        
                                            </form>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
    )
}


