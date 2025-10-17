
import React from 'react'
import { useNavigate, useParams } from 'react-router-dom';
import sendMessage from '../../../../Api'

export default function Contact(props) {
    const navigate = useNavigate()
    const {number} = useParams();
    const submit = (e) => {
        e.preventDefault()
        let name = e.target[0].value
        let number = e.target[1].value
        sendMessage('phone_manage_contact', {
            name: name,
            number: number
        })

        navigate('/')
    }

    return (
        <div className="w-full h-full text-white relative">
            <div className="w-full h-fit"> 
                <div>
                    Utwórz kontakt
                </div>
                <form onSubmit={submit} id="createcontact" className="grid grid-cols-1 gap-2 justify-between text-white w-full  p-2 items-end">
                    <div className="w-full">
                        <input type="text" 
                        placeholder={`Nazwa`}
                        defaultValue="Nowy Kontakt"
                        className="
                        bg-black
                        text-center
                        bg-opacity-20
                        placeholder:text-white
                        focus:outline-none
                        min-w-full
                        block p-2 w-full text-white  rounded-lg sm:text-xs "/>
                    </div>
                    <div className="w-full">
                        <input type="text" 
                        defaultValue={number}
                        placeholder={`Numer telefonu`}
                        className="
                        bg-black
                        bg-opacity-20
                        placeholder:text-white
                        text-center
                        focus:outline-none
                        min-w-full
                        block p-2 w-full text-white  rounded-lg sm:text-xs "/>
                    </div>
                        <div className="
                            h-fit
                            bg-blue-700
                            bg-opacity-40
                            text-center
                            transition-all
                            hover:bg-opacity-80
                            placeholder:text-white
                            p-2  text-white  rounded-lg sm:text-xs
                            flex">
                            <input type="submit" className="text-center w-full"
                            value="Zapisz" />
                        </div>
                </form>
            </div>
        </div>
    )
}

