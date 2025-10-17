
import React, {useState, useEffect } from 'react'
import sendMessage from '../../Api'

const Input = ({type, placeholder, value}) => {
    return <input type={type} placeholder={placeholder} className="p-2 rounded-lg bg-gray-700 text-white text-center appearance-none" value={value}>

    </input>
}

export default function Ticket(props) {

    
    const onSubmit = (e) => {
        e.preventDefault()
        let id = e.target[0].value
        let money = e.target[1].value
    }

    return <div className="w-full h-full">
        <div className="w-full h-full flex justify-center items-center">
            <form className="flex flex-col gap-4" onSubmit={onSubmit}>
                <Input type="text" placeholder="Pesel" />
                <Input type="number" placeholder="Ilość" />
                <Input type="submit" placeholder="Ilość" value="Wystaw" />
            </form> 
        </div>
    </div>
}