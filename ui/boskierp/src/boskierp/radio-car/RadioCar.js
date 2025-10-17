
import React from 'react'
import sendMessage from '../Api'

export default class Radio extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: true,
        }

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
    }

    open(data) {
        this.setState(data)
    }

    close() {
        this.setState({
            show: false
        })
    }

    cancel() {
        sendMessage("menu_cancel", {
            name: this.state.name
        })
    }


    render() {
        return <div className="w-full h-full absolute">
            <div className="w-full h-full">

            </div>

        </div>
    }
}