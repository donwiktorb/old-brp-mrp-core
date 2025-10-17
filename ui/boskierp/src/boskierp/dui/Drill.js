
import React, { useEffect, useState } from 'react'


export default function Drill(props) {

    const [time, setTime] = useState(props?.time || 0)
    return (
        <div className="w-full h-full bg-red-500 absolute text-center">
            <div className="w-full h-full flex justify-center items-center bg-yellow-500 text-center">
                {time}s 
            </div>
        </div>
    )
}