import React from 'react'
import sendMessage from '../../Api'
import { Link, useNavigate } from "react-router-dom";

export default class Register extends React.Component {
    constructor(props) {
        super(props)
        this.state = {}

    }

    render() {
        return (    
            <div className="w-full h-full text-white">
                <div className="w-full h-full flex flex-col">
                    <div className="flex flex-col justify-center items-center w-full h-full">
                      <form className="w-full h-full flex flex-col gap-8 px-4 justify-center items-center">   
                        <input type="text" className="text-center
                        bg-transparent
                        border-b-2
                        border-blue-500
                        placeholder-white
                        appearance-none
                        outline-none
                        py-2
                        text-white
                        " placeholder="Wpisz login"/>
                        <input type="text" className="text-center
                        bg-transparent
                        border-b-2
                        border-blue-500
                        placeholder-white
                        appearance-none
                        outline-none
                        py-2
                        text-white
                        " placeholder="Wpisz email"/>
                        <input type="password" className="text-center
                        bg-transparent
                        border-b-2
                        border-blue-500
                        placeholder-white
                        appearance-none
                        outline-none
                        py-2
                        text-white
                        " placeholder="Wpisz hasło"/>
          
                        <div className="grid grid-cols-2 gap-4">
                            <Link to="/" type="button" className="
                            appearance-none
                            text-blue-800 
                            border-b-2
                            py-2
                            border-blue-800
                            hover:border-blue-200
                            hover:text-blue-200
                            transition-all
                            " >Powrót do logowania</Link>
                            <input type="submit" className="
                            appearance-none
                            text-blue-800 
                            border-b-2
                            py-2
                            border-blue-800
                            hover:border-blue-200
                            hover:text-blue-200
                            transition-all
                            " value="Zarejestruj się" />
                        </div>
                    </form>
                    </div>
                </div>
            </div>
        );
    }
}
