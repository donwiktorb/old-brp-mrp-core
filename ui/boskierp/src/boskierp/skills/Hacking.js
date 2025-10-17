import React from 'react'
import sendMessage from '../../Api'

export default class Hacking extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            code: [],
            retries:4,
            timer: 0
        }
        this.currentRot = 0
        this.code = [
            2,
            4,
            3,
            4
        ]
        this.timer = 30
        this.retries = 4
        this.keys = [
            "*",
            0,
            "#"
        ]
        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
    }

    open(data) {
        this.timer = data.timer
        this.retries = data.retries
        this.setState(data)
    }


    close() {
        this.setState({
            show: false
        })
    }

    timerLoop() {
        if (this.state.timer === 0)
            return this.setState({retries: this.retries})
        this.setState({timer: this.state.timer-1})
        setTimeout(() => this.timerLoop(), 1000)
    }

    startTimer() {
        this.setState({timer: this.timer}, () => {

        this.timerLoop()     
        })
    }

    addCode = (e,n) => {
        e.preventDefault()
        if (this.state.timer > 0)
            return
        
        if (this.state.code.length >= this.code.length) {
            if (this.state.retries > 0)
                return this.clearCode(this.state.retries-1)
            else
                return this.startTimer()
        }
        this.setState({code: [
            ...this.state.code,
            n
        ]})
    }

    clearCode(retr) {
        this.setState({code:[], retries:retr})
    }

    action = (e, n) => {
        e.preventDefault()
        if (n === 0) {
            return this.addCode(e, n)
        } else if (n === '*') {
            return this.setState({code: []})
        }

        // if (n === "*") {
        //     return this.clearCode()
        // }
    }

    render() {
        if (!this.state.show) return <></>
        return <div className="w-full h-full flex justify-center items-center absolute z-40 ">
            <div className="w-1/5 h-1/2 bg-black rounded" style={{backgroundImage: "url('https://i.stack.imgur.com/FzoNL.jpg')"}}>
                <div className="w-full h-full ">
                    <div className="w-full h-full p-4 flex flex-col gap-4  ">
                    
                        <div className="bg-gray-500 bg-opacity-50 rounded-lg w-full h-1/5 text-4xl font-bold text-center flex justify-center items-center text-white tracking-widest overflow-y-scroll outline bg-blend-hue relative">
                    <div className="text-white absolute text-center right-2 font-normal text-lg top-0">
                        {this.state.retries}
                    </div>
                        
                        {this.state.timer === 0 ? this.state.code.map((v,i) => {
                            if (this.code[i] === v) {
                                return <div className="text-green-500">
                                    {v}
                                </div>
                            }
                            return v
                        }) : <div>{this.state.timer}</div>}
                        </div>
                        <div className="w-full h-full bg-opacity-50 bg-gray-500 grid grid-cols-3 gap-4 text-center rounded-lg">
                            {Array(9).fill().map((v, i) => {
                                return <button onClick={(e) => this.addCode(e,i+1)} className="w-full h-full flex justify-center items-center select-none p-2">
                                    <div className="w-full h-full bg-gray-700 text-white rounded-lg flex justify-center items-center font-bold text-2xl outline outline-blue-500 shadow-2xl shadow-black">
                                        {i+1}
                                    </div>
                                </button> 
                            })} 
                            {this.keys.map((v) => {
                                return <button onClick={(e) => this.action(e, v)} className="w-full h-full flex justify-center items-center select-none p-2">
                                    <div className="w-full h-full bg-gray-700 text-white rounded-lg flex justify-center items-center font-bold text-2xl outline outline-blue-500 shadow-2xl shadow-black">
                                    {v}
                                </div>
                            </button> 
                            })}
                                
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }
}
