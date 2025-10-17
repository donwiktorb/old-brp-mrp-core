

import React from "react"
import sendMessage from '../Api'

export default class Drive extends React.Component {
    constructor(props) {
        super(props)
        this.state = props.state

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
        this.updateData = this.updateData.bind(this)        
        this.max = 200 - 20
    }

    open() {
        this.setState({show: true})        
    }

    close() {
        this.setState({show:false})
    }

    updateData(data) {
        let rpm = (data.rpm/1000)*15
        data.rpm = rpm
        this.setState(data)
    }    

    render() {
        if (!this.state.show) return <></>
        return <div className="w-full h-full opacity-90">
            <div className="w-full h-full flex justify-end items-center p-2">
                <div className="w-1/5 h-2/5 border-2 shadow-2xl bg-black rounded-lg flex flex-col gap-4 text-white justify-center items-center">
                    <div className="w-4/5 h-1/4 p-2 text-center flex justify-center items-center border-b-2 font-bold text-xl">
                        {this.state.job}
                    </div>
                    
                    <div className="w-full h-3/4 relative z-10 flex flex-col p-2">
                        <div className="w-full h-full">
                            <div className="w-full h-full flex justify-center items-center flex-col">
                                <div className="text-xl font-bold uppercase">
                                    <div className="w-full flex gap-5">
                                        {this.state.fullName}
                                    </div>
                                </div>
                                <div className="flex gap-5 justif-center">
                                    <p>
                                        {this.state.grade}
                                    </p>
                                    <p>
                                        {this.state.badge}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div className="w-full h-1/2 flex justify-between">
                            <img src={this.state.avatar} alt="LOGO" />
                            <img src={this.state.logo} alt="LOGO" />
                        </div>
                        {/* <img className='absolute bottom-0 p-2' src={this.state.avatar} alt="LOGO" />
                        <img className='absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-2/4 opacity-50 -z-10' src={this.state.logo} alt="LOGO" /> */}
                        <img className='absolute top-0 left-1/2 -translate-x-1/2 w-2/4 opacity-10 -z-10' src={this.state.logo} alt="LOGO" /> 
                    </div>
                </div>
            </div>
        </div>
    }
}