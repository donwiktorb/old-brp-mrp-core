import React from 'react'
import Header from './header/Header'
import Article from './article/Article'
import Footer from './footer/Footer'
import sendMessage from '../Api'
export default class Phone extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show:false,
            currentX: 0,
            currentY: 0,
            battery: 50,
            chats: {
                twitter: [

                ]
            },
            candidate: "",
            stopCall: false,
            candidate: false,
            stop: false,
            offer: {
                number: "6666",
                sdp: null
            },
            answer: {
                number: "6666",
                sdp: null
            },
            messages: [],
            lastMessages: [],
            contacts: [
                
            ],
            notifications: [
                // // {
                // //     title: "x d",
                // //     content: "x d",
                // //     redirect:"xd"
                // // },
                // // ...Array(48).fill({title:"x d", content:"x d", redirect:"x d"})
            ],
            calls: [
                // {
                //     number: '48484',
                //     type: 'tried',
                // },
                // {
                //     number: '48484',
                //     type: 'missed'
                // },
                // {
                //     number: '48484',
                //     type: 'answered'
                // },
                // {
                //     number: '48484',
                //     type: 'answer',
                // },
                
            ]
        }
        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
        this.article = this.article.bind(this)
        
        this.clearNotifiesByType = this.clearNotifiesByType.bind(this)
        this.addNotify = this.addNotify.bind(this)
        this.setAnswer = this.setAnswer.bind(this)
        this.setOffer  = this.setOffer.bind(this)
        this.setMessages = this.setMessages.bind(this)
        this.setLastMessages = this.setLastMessages.bind(this)
        this.addCandidate = this.addCandidate.bind(this)
        this.setChatMessages = this.setChatMessages.bind(this)
        this.setNotifies = this.setNotifies.bind(this)
        this.setBattery = this.setBattery.bind(this)
        this.stopCall = this.stopCall.bind(this)
        this.onKey = this.onKey.bind(this)
        this.currentTab = 0 
        this.currentPlace = 0
        this.types = [
            'tabs',
            'article'
        ]
        this.currentType = 0
    }

    stopCall() {
        this.setState({stopCall: true}, () => {
            setTimeout(() => {
                this.setState({stopCall: false})
            }, 5000)
        })
        // this.setState({
        //     offer: {
        //         sdp: {
        //             stop: true
        //         }
        //     },
        //     answer: {
        //         sdp: {
        //             stop: true
        //         }
        //     }
        // }, () => {
        //     this.setState({
        //         answer: null,
        //         offer: null
        //     })
        // })
    }    

    open() {
        this.setState({show: true})
    }
    
    close() {
        this.setState({show: false})
    }
    cancel= () => {
        sendMessage("menu_cancel", {
            name: 'phone'
        })
    }   
    article(data) {
        if (this[data.action])
            return this[data.action](data)
    }
    setBattery(battery) {
        this.setState({battery: battery})
    }
    setChatMessages(data) {
        this.setState((state) => {
            const chats = state.chats
            chats[data.type] = data.messages
            return {
                chats
            }
        })
    }

    addCandidate(data) {
        // this.rtc.addCandidate(data.candidate)
        this.setState({
            candidate: data.candidate
        }, () => {
            setTimeout(() => {
                this.setState({
                    candidate: false
                })
            }, 10000)
        })
    }

    setOffer(data) {
        // this.rtc.init(data.number, () => {
        //     this.rtc.setOffer(data.offer)
        // })
        this.setState({
            offer: {
                number: data.number,
                offer: data.offer
            }
        }, () => {
            setTimeout(() => {
                this.setState({
                    offer: {
                        offer: false
                    }
                })
            }, 10000)
        })
    }

    setAnswer(data) {
        // this.rtc.setAnswer(data.answer)
        this.setState({
            answer: {
                number: data.number,
                answer: data.answer
            }
        }, () => {
            setTimeout(() => {
                this.setState({
                    answer: {
                        answer: false
                    }
                })
            }, 10000)
        })
    }

    removeNotify = (id)=>{
        this.setState((state) => {
            const notifications = state.notifications
            notifications.splice(id, 1)
            return {
                notifications
            }
        }) 
    }
    clearNotifiesByType(data) {
        let {type} = data
        this.setState((state) => {
            const notifications = state.notifications
            notifications.forEach((v, i) => {
                if (v.type === type) {
                    notifications.splice(i, 1)
                }
            })            
            return {
                notifications
            }
        })
    }
    addNotify(data) {
        let {title, content, redirect} = data
        this.setState((state) => {
            const notify = {
                title: title,
                content: content,
                redirect: redirect
            }
            const notifications = [notify, ...state.notifications]
            return {
                notifications
            }
        }) 
    }
    clearNotifies = () => {
        this.setState({
            notifications: []
        })
    }
    setNotifies = (data) => {
        this.setState({
            notifications: data
        })
    }
    setMessages(data) {
        this.setState({
            messages: data.messages
        })
    }
    setLastMessages(data) {
        this.setState({
            lastMessages: data.messages
        })
    }

    componentDidUpdate() {
        console.log('x d', this.state.currentX)
    }

    onKey(e) {

        if (e.key === 'Escape') {
            this.cancel()
        } 
        // // else if (e.key === 'ArrowLeft') {
        // //     this.setState((state) => {
        // //         const currentX = state.currentX - 1
        // //         return {
        // //             currentX
        // //         }
        // //     })
        // // } else if (e.key === 'ArrowRight') {
        // //     this.setState((state) => {
        // //         const currentX = state.currentX+1
        // //         return {
        // //             currentX
        // //         }
        // //     })
        // // } else if (e.key === 'ArrowDown') {
        // //     this.setState((state) => {
        // //         const currentY = state.currentY-1
        // //         return {
        // //             currentY
        // //         }
        // //     })
        // // } else if (e.key === 'ArrowUp') {
        // //     this.setState((state) => {
        // //         const currentY = state.currentY+1
        // //         return {
        // //             currentY
        // //         }
        // //     })
        // // }

        // // } else if (e.key === 'Backspace') {
        // // }
        // // } else if (e.key === 'ArrowLeft') {
        // //     let elems = document.getElementById(this.types[this.currentType]).childNodes
        // //     if (this.currentType === 1) {
        // //         elems = elems[0].childNodes[0].childNodes
        // //     }
        // //     const elem2 = elems[1]?.querySelector('form');
        // //     if (elem2) {
        // //         // elem2.firstChild.focus()
        // //         elems = elem2
        // //     } else {
        // //         const elem3 = elems[0]?.querySelector('form');
        // //         if (elem3) {
        // //             elems = elem3
        // //         }
        // //     }
        // //     this.currentTab -= 1
        // //     if (this.currentTab < 0) {
        // //         this.currentTab = elems.length-1
        // //     }
        // //     elems[this.currentTab].focus()
        // // } else if (e.key === 'ArrowDown') {
        // //     this.currentType -= 1
        // //     if (this.currentType < 0) {
        // //         this.currentType = this.types.length-1
        // //     }
        // //     this.currentTab = 0
        // //     let elems = document.getElementById(this.types[this.currentType]).childNodes
        // //     if (this.currentType === 1) {
        // //         elems = elems[0].childNodes[0].childNodes
        // //     }
          
        // //     if (this.currentTab >= elems.length) {
        // //         this.currentTab = 0
        // //     }
        // //     elems[this.currentTab].focus()
        // //     // let elems = document.getElementById('article').childNodes[0].childNodes[0].childNodes
        // //     // this.currentPlace-=1
        // //     // if (this.currentPlace < 0) {
        // //     //     this.currentPlace = elems.length-1
        // //     // }
        // //     // elems[this.currentPlace].focus()
        // // } else if (e.key === 'ArrowUp') {
        // //     this.currentType += 1
        // //     if (this.currentType >= this.types.length) {
        // //         this.currentType = 0
        // //     }
        // //     this.currentTab = 0
        // //     let elems = document.getElementById(this.types[this.currentType]).childNodes
        // //     if (this.currentType === 1) {
        // //         elems = elems[0].childNodes[0].childNodes
        // //     }
          
        // //     if (this.currentTab >= elems.length) {
        // //         this.currentTab = 0
        // //     }
        // //     elems[this.currentTab].focus()
        // //     // let elems = document.getElementById('article').childNodes[0].childNodes[0].childNodes
        // //     // this.currentPlace-=1
        // //     // if (this.currentPlace < 0) {
        // //     //     this.currentPlace = elems.length-1
        // //     // }
        // //     // elems[this.currentPlace].focus()
        // // } else if (e.key === 'ArrowRight') {
        // //     let elems = document.getElementById(this.types[this.currentType]).childNodes
        // //     if (this.currentType === 1) {
        // //         elems = elems[0].childNodes[0].childNodes
        // //     }
        // //     this.currentTab += 1
        // //     const elem2 = elems[1]?.querySelector('form');
        // //     console.log(elems)
        // //     if (elem2) {
        // //         // elem2.firstChild.focus()
        // //         elems = elem2
        // //     } else {
        // //         const elem3 = elems[0]?.querySelector('form');
        // //         if (elem3) {
        // //             elems = elem3
        // //         }
        // //     }
        // //     if (this.currentTab >= elems.length) {
        // //         this.currentTab = 0
        // //     }
        // //     var elem = document.activeElement;
        // //     if (elem.form) {
        // //         elems = elem.form 
        // //     }
        // //     elems[this.currentTab].focus()
        // // }
    }
    render() {
        if (!this.state.show) return <div></div>
        if (this.state.battery <= 1) return <div>
            <div 
            // onKeyDown={(e) => this.onKey(e)}
             className={`flex absolute h-full justify-end items-end z-20 w-full `} >
                <div
                className="h-3/6 w-1/6 text-center rounded-md  m-4 relative "
                    >
                {/* <img alt="x d" src="https://freepngimg.com/thumb/telephone/73161-golden-samsung-mobile-s7-telephone-phone-border.png" className="absolute w-max h-max" /> */}
                    <div
                    id="phonebg"
                    className=" phonebg h-full w-full flex flex-col rounded-md bg-gradient-to-t bg-black text-white shadow-2xl shadow-black border-black border-double border-4 items-center justify-center font-bold ">
                        <div className="h-full w-full flex justify-center items-center text-white animate-scale">
                            <svg className="w-full h-1/2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 10V14M9 10L13 14M13 10L9 14M4 9V15C4 15.5523 4.44772 16 5 16H17C17.5523 16 18 15.5523 18 15V9C18 8.44772 17.5523 8 17 8H5C4.44772 8 4 8.44772 4 9Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/></svg>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
        return (    
            <div 
            // // onKeyDown={(e) => this.onKey(e)}
             className={`flex h-full absolute justify-end items-end z-20 w-full `} >
                <div
                className="h-[65%] w-1/6 max-w-full max-h-full text-center rounded-md  m-4 relative"
                    >
                    <img draggable="false" alt = 'dwb' src = 'https://boskierp.pl/img/ss/dwb_CHlU.png' className="absolute h-full w-full scale-[1.035]"></img>
                    {/* <img draggable="false" alt = 'dwb' src = 'https://boskierp.pl/img/ss/dwb_qYe2.png' className="absolute h-full w-full scale-[1.035]"></img> */}
                    <div
                    id="phonebg"
                    className="phonebg h-full w-full flex flex-col rounded-3xl bg-gradient-to-t from-pink-500 to-purple-500 shadow-2xl shadow-black border-black border-double border-1 pr-0.5 z-10 ">
                        <Header battery={this.state.battery}/>
                        <Article state={this.state} ref={ref => (this.Article = ref)} clearNotifies={this.clearNotifies} rtc={this.rtc} removeNotify={this.removeNotify}/>
                        <Footer state={this.state} /> 
                    </div> 
                </div>
            </div>
        );
    }
}