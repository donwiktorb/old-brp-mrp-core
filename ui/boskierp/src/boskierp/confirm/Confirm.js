
/*
    Opened: [
        {
            name: 'dwb',
            title: 'dwb,
            align: 'justify-center items-center',
            elements: -> Elements.js
        }
    ]    
*/
import React from 'react'
import sendMessage from '../../Api'

export default class MenuExtra extends React.Component {
    constructor(props) {
        super(props)

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
        this.cancel = this.cancel.bind(this)
        this.submit = this.submit.bind(this)
        this.alignTypes = {
            'left': 'justify-start',
            'right': 'justify-end',
            'center': 'justify-center',
            'middle': 'items-center',
            'top': 'items-start',
            'bottom': 'items-end'
        }

        this.state = {
            show: false,
            title: "Napewno chcesz usunac pojazd o nazwie?dsadasdadasdadasdasda",
            actions: [
                "accept",
                "cancel"
            ],
            buttons: [
                {
                    label: "Spawn",
                    type: "spawn",
                    color: "green"
                },
                {
                    label: "Usuń",
                    type: "delete"
                }
            ],
            elements: [
                {
                    label: "Sanchez",
                    data: [
                        'Silnik'
                    ],
                }, ...Array(32).fill({label: "Sanchez"})
            ]
        }
    }

    submit(v, v2) {
        sendMessage('menu_submit', {
            button: v,
            current: this.state,
            menu: this.state
        })
    }

    cancel() {
        sendMessage('menu_cancel', {
            current: {},
            menu: this.state
        })
    }

    open(data) {
        this.setState(data)
    }

    close() {
        this.setState({show: false})
    }

    render() {
        if (!this.state.show) return <div></div>
        else return <div className={`flex absolute z-40 w-full h-full items-center justify-center`}>
            <div className="w-1/5 h-1/5 bg-gray-700 rounded-lg bg-opacity-70 flex flex-col justify-between">
                <div className="bg-gray-700 w-full h-full rounded-t-lg flex justify-center items-center text-white text-center">
                    <div>
                        {this.state.title}
                    </div>
                </div>

                <div className="bg-gray-700 w-full h-1/4 rounded-b-lg p-2 flex gap-4">
                    {this.state.actions.map((v) => {
                        if (v === "accept") {
                            return <button onClick={(e) => this.submit(v)} type="cancel" className="animate-rainbow bg-gradient-to-r from-green-400 via-green-600 to-green-800 w-full outline-none slider-thumb rounded-lg appearance-none cursor-pointer">Akceptuj</button>  
                        } else {
                            return <button onClick={(e) => this.cancel(e)} type="cancel" className="animate-rainbow bg-gradient-to-r from-red-400 via-red-600 to-red-800 w-full outline-none slider-thumb rounded-lg appearance-none cursor-pointer">Zamknij</button>  
                        }
                    })}
                </div>
            </div>

        </div> 
    }
}
