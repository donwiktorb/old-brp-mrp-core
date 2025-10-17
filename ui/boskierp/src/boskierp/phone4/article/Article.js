import React from 'react'
import Home from './routes/home/Home'
import Apps from './routes/apps/Apps'
import Messages from './routes/messages/Messages'
import Message from './routes/messages/Message'
import Contacts from './routes/contacts/Contacts'
import Contact from './routes/contacts/Contact'
import Call from './routes/contacts/Call'
import Calling from './routes/contacts/Calling'
import Calls from './routes/calls/Calls'
import Settings from './routes/apps/settings/Settings'
import Twitter from './routes/apps/twitter/Twitter'
import Darkweb from './routes/apps/darkweb/Darkweb'
import Gallery from './routes/apps/gallery/Gallery'
import {Navigate, Routes, Route} from "react-router-dom";
export default class Article extends React.Component {
    constructor(props) {
        super(props)
        this.state = props.state  || {}
        // this.state = {
        //     chats: {
        //         twitter: []
        //     },
        //     candidate: "",
        //     offer: {
        //         number: "6666",
        //         sdp: {}
        //     },
        //     answer: {
        //         number: "6666",
        //         sdp: {}
        //     },
        //     messages: [],
        //     lastMessages: [],
        //     contacts: [
               
        //     ],
        //     notifications: [],
        //     calls: [
               
        //     ]
        // }
    }
    clearNotifies = () => {
        this.props.clearNotifies()
    }
    removeNotify = (id) => {
        this.props.removeNotify(id)
    }

    // // componentDidUpdate() {
    // //     if (this.state.currentY >= 0) {
    // //         let art = document.getElementById('article').children[0].children
    // //         let childs = art[this.state.currentY]?.children
    // //         console.log(art)
    // //         if (childs) {
    // //             let obj = childs[this.state.currentX]
    // //             if (obj) {
    // //                 obj.focus()
    // //             }
    // //         }
    // //     }
    // // }

    static getDerivedStateFromProps(nextProps, state) {
        if (nextProps.state !== state && nextProps) {
            return nextProps.state ? nextProps.state : []
        } else return null
    }
    render() {
        return (
            <div className="w-full h-full overflow-auto" id="article">
                <Routes> 
                    <Route path={`/`} element={<Home removeNotify={this.removeNotify} clearNotifies={this.clearNotifies} notifications={this.state.notifications} />} />
                    <Route path={``} element={<Home removeNotify={this.removeNotify} clearNotifies={this.clearNotifies} notifications={this.state.notifications} />} />
                    <Route path={`/apps`} element={<Apps />} />
                    <Route path={`/contacts`} element={<Contacts contacts={this.state.contacts} />} />
                    <Route path={`/contact/:number?`} element={<Contact />} />
                    <Route path={`/messages`} element={<Messages lastmsgs={this.state.lastMessages} />} />
                    <Route path={`/messages/:number`} element={<Message messages={this.state.messages} />} />
                    <Route path={`/call/:number`} element={<Call rtc={this.props.rtc} offer={this.state.offer} answer ={this.state.answer} candidate={this.state.candidate} stopCall={this.state.stopCall} stopCallFn={() => this.stopCall()} />} />
                    <Route path={`/call/:number/:state`} element={<Call offer={this.state.offer} rtc={this.props.rtc} answer ={this.state.answer} />} stopCall={this.state.stopCall} stopCallFn={() => this.stopCall()} />
                    <Route path={`/calling/:number`} element={<Calling number={this.state.offer.number} />} />
                    <Route path={`/calls`} element={<Calls calls={this.state.calls} />} />
                    <Route path={`/apps/twitter`} element={<Twitter tweets={this.state.chats.twitter} />} />
                    <Route path={`/apps/darkweb`} element={<Darkweb chats={this.state.chats.darkweb} />} />
                    <Route path={`/apps/settings`} element={<Settings />} />
                    <Route path={`/apps/gallery`} element={<Gallery />} />
                </Routes>
            </div>
        )
    }
}