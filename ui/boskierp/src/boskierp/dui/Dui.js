
import React from 'react'
import { Routes, Route} from "react-router-dom";
import Drill from './Drill'

export default class DUI extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false
        }

        this.open = this.open.bind(this)
    }

    open() {
        this.setState({show: true})
    }

    render() {
        if (!this.state.show) return <></>
        return <div className="w-full h-full absolute">
            <Drill />
        </div>
    }
}