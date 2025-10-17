
import React from 'react'
import Tariff from './lspd/Tariff'
import { Routes, Route, Link } from "react-router-dom";
import sendMessage from '../Api'
export default class Tablet extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            name: "tablet",
            announce: "",
            buttons: [
                {
                    label: "Home",
                    redirect: "/"
                } ,
                {
                    label: "Taryfikator",
                    redirect: "/tariff"
                }
            ]
        }


        this.onKey = this.onKey.bind(this)
    }

    onKey(e) {
        if (e.key === 'Escape') {
            sendMessage("menu_cancel", {
                name: this.state.name
            })
        }
    }

    render() {
        return <div className="absolute z-20 w-full h-full">
            <div className="w-full h-full flex justify-center items-center text-white">
                <div className="w-3/4 h-3/4 bg-black bg-opacity-70 rounded-lg">
                    <div className="w-full h-full flex flex-col gap-0.5">
                        <div className="w-full bg-opacity-70 bg-black h-1/6 rounded-t-lg">
                            <div className="w-full h-full flex justify-between items-center px-4">
                                <div className="w-full h-full rounded-full flex justify-start items-center text-xl">
                                    John Black
                                </div>
                                <div className="w-full h-full flex justify-center items-center gap-4 text-xl">
                                    {this.state.buttons.map((v, i) => {
                                        return <Link to={v.redirect}>
                                            <button className="bg-gray-700 p-2 rounded-lg">
                                                {v.label}
                                            </button>
                                        </Link>
                                    })}
                                </div>
                                <div className="w-full h-full rounded-full flex justify-end items-center">
                                    <img className="w-24 rounded-full h-24" src="https://boskierp.pl/img/ss/dwb_yowb.png" alt="x d"/>
                                </div>
                            </div>
                        </div>

                        <div className="w-full h-4/6">
                            <Routes>
                                <Route path={'/tariff'} element={<Tariff />} />
                            </Routes>
                        </div>

                        <div className="w-full h-1/6 bg-black bg-opacity-70 rounded-b-lg">
                            <div className="w-full h-full flex justify-center items-center text-xl">
                                {this.state.announce}
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    }
}