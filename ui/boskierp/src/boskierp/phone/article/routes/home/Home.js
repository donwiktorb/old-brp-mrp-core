
import React from 'react'
import {Navigate} from 'react-router-dom'

export default class Home extends React.Component {
    constructor(props) {
        super(props)
        this.state = props.state

    }
    static getDerivedStateFromProps(nextProps, state) {
        if (nextProps.state !== state && nextProps) {

            
            return nextProps.state ? nextProps.state : []
        } else return null
    }

    componentDidUpdate() { console.log(this.state) }

    render() {
        return (
            <div className="w-full h-full"> 
                
                {(this.state.callStateManager.isCalling && this.state.callStateManager.caller) && <Navigate to={`/call/${this.state.callStateManager.caller}`} replace={true} />}
            </div>
        )
    }
}