import React from 'react'
import { Link} from "react-router-dom";

import sendMessage from '../../../../Api'


export default class Home extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            notifications: props.notifications
        }
    }

    componentDidUpdate(prevProps) {
        if (prevProps.notifications !== this.props.notifications) {
            this.setState({notifications: this.props.notifications})
        }
    }

    submit(e) {
        this.props.clearNotifies()
    } 

    clicked(e,i) {
        this.props.removeNotify(i)
      sendMessage('phone_notify_remove', {
            id:i,
            notify:this.state.notifications[i]
    })
    }

    render() {
        return (
            <div className="w-full h-full p-2 flex relative"> 
                <div className="h-full w-full grid grid-cols-1 gap-2 content-start">
                    <button className="w-full transition-all focus:text-royal hover:text-royal justify-center inline-block text-center pt-2 pb-1 hover:text-green-200 text-white bg-purple-800 bg-opacity-50 rounded-lg" onClick={(e) => this.submit(e)}>
                            Wyczyść Powiadomenia
                    </button>
                    {
                        this.state.notifications.map((v,i) => {
                            return <Link onClick={(e) => this.clicked(e,i)} to={v.redirect}
                                className="w-full transition-all animate-pulse focus:text-royal hover:text-royal justify-center inline-block text-center pt-2 pb-1 hover:text-green-200 text-white bg-purple-800 bg-opacity-50 rounded-lg"
                                >
                                {v.title}

                                <span className="tab block text-xs text-blue-500">{v.content}</span>
                            </Link>
                        })
                    }
                </div>
            </div>
        )
    }
}