
import React, {useState, useEffect } from 'react'
import sendMessage from '../../Api'
import Input from './Elements'


export default function Tariff(props) {
    const [time, setTime] = useState(0)

    const [price, setPrice] = useState(0)

    const [element, setElements] = useState([
        {
            label: "Hello",
            elements: [
                {
                    label: "Hello",
                    value: "Hello",
                    time: 0,
                    price: 0
                }
            ]
        }
    ]) 

    return <div className="w-full h-full">
        <div className="w-full p-2">
            <div className="w-full h-full flex justify-center items-center gap-4 text-lg">
                <Input type="number" placeholder="0" value={price}>
                </Input>
                <Input type="number" placeholder="0" value={time}>
                </Input>
            </div>
        </div>
        <div className="w-full h-full overflow-auto">

        </div>
    </div>
}