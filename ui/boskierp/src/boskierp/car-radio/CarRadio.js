
import React from 'react'
import sendMessage from '../../Api'

export default class CarRadio extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false, link: ""
        }



        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
    }

    open() {
        this.setState({
            show: true
        })
    }

    close() {
        this.setState({
            show: false
        })
    }

    cancel() {
        sendMessage("menu_cancel", {
            name: 'car-radio'
        })
    }

    updateLink(e) {
        this.setState({link: e.target.value})
    }

    onSubmit = (e) => {
        sendMessage("menu_submit", {
            name: 'car-radio', type:'play',
            url: this.state.link
        })
    }



    
    onStop = (e) => {
        sendMessage("menu_submit", {
            name: 'car-radio',
            url: this.state.link,
            type: 'stop'
        })
    }

    render() {
        if (!this.state.show) return <div></div>
        return <div className="w-full absolute h-full z-40">
            <div className="w-full h-full flex justify-center items-center">
                <div className="w-1/2 h-1/2 rounded-lg bg-black flex flex-col">
                    <div className="w-full h-full flex justify-center items-center flex-col" >
                        <input value={this.state.link} onChange={(e) => this.updateLink(e)} className="px-4 rounded-lg" placeholder="Link"></input>
                        <div className="w-full h-1/4 flex justify-around text-white items-center text-lg">

                            <button onClick={this.onSubmit
                            } className="p-0.5 rounded-lg border px-4 hover:bg-white hover:text-black transition-all">Play</button>
                            <button onSubmit={this.onStop} className="p-0.5 rounded-lg border px-4 hover:bg-white hover:text-black transition-all">Stop</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }
}
