
import React from 'react'

import { useParams } from "react-router-dom";
import sendMessage from '../../Api'

export default function Jail(props) {
    const submit = (e) => {
        e.preventDefault()
        let target = e.target
        let id = target[0]
        let time = target[1]
        let fine = target[2]
        let reason = target[3]
        sendMessage('police_tablet_jail', {
            id: id,
            time: time,
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
                                        {/* <label for="default-search" className="mb-2 text-sm font-medium  sr-only text-gray-300 grid grid-cols-1 gap-4">Szukaj</label> */}
                                        <div className="w-full grid grid-cols-3 gap-4">
                                            <input type="text" id="default-search" className="p-4 pl w-full text-sm rounded-lg border  bg-gray-700 border-gray-600 placeholder-gray-400 text-white focus:ring-gray-500 focus:border-blue-500" placeholder="Wpisz pesel"/>
                                            <input type="text" id="month" className="p-4 pl w-full text-sm rounded-lg border  bg-gray-700 border-gray-600 placeholder-gray-400 text-white focus:ring-gray-500 focus:border-blue-500" placeholder="Ilość miesięcy"/>
                                            <input type="text" id="money" className="p-4 pl w-full text-sm rounded-lg border  bg-gray-700 border-gray-600 placeholder-gray-400 text-white focus:ring-gray-500 focus:border-blue-500" placeholder="Ilość grzywny"/>
                                        </div>

                                        <div className="w-full">
                                                <textarea className="
                                                w-full max-h-96 bg-gray-700 text-white
                                                "placeholder="Wpisz wyrok">

                                                </textarea>
                                        </div>

                                        <div className="
                                            w-full h-full
                                            flex justify-center items-center
                                        ">
                                            <button type="submit" className="text-white mx-2  focus:ring-4 focus:outline-none  font-medium rounded-lg text-sm px-4 py-2 bg-gray-600 hover:bg-gray-400 focus:ring-gray-800 w-fit h-fit">Wystaw wyrok</button>
                                            
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

