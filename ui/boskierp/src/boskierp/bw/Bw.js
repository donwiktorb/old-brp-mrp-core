import React from "react"
import sendMessage from '../../Api'

export default class Bw extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            showTimer: true,
            time: 0,
            title: "Jesteś w stanie",
            desc: `
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat sapien nec erat pharetra faucibus. Praesent elementum nec metus maximus tempus. Ut venenatis felis a nunc finibus consequat. Integer consectetur venenatis massa non posuere. Fusce eu ante vestibulum, tempor arcu nec, iaculis lacus. Donec at blandit tortor. Cras ligula augue, porttitor sed consequat in, dictum non purus. Vestibulum dui quam, consequat rhoncus tincidunt id, finibus vel sapien. Sed volutpat convallis ipsum. Ut luctus, dolor id efficitur blandit, lacus ante suscipit tortor, in malesuada nibh tellus sed orci. Nullam vehicula dolor in pellentesque pellentesque. Mauris condimentum orci at convallis condimentum. Duis et dictum elit, et faucibus augue. Sed quis vulputate orci, quis ullamcorper leo. Vestibulum et ante sit amet lorem viverra condimentum eget sed lacus. 
            `,
            buttons: [
                {
                    label: "Wezwij EMS",
                    value: "call_ems",
                    onClickRemove: true
                },
                {
                    label: "Wezwij LSPD",
                    value: "call_lspd",
                    onClickRemove: true
                }
            ],
            afterTimer: {
                title: "Możesz się odrodzić",
                desc: "Uwaga, jeśli się odrdzoisz stracisz częśc przedmitów!",
                buttons: [
                    {
                        label: "Naciśnij, aby się odrzocić",
                        value: "respanw"
                    }
                ]
            }
        }
        this.open = this.open.bind(this)
        this.close  = this.close.bind(this)
        
    }

    open(data) {
        clearTimeout(this.timeout)
        data.show = true
        data.showTimer = true
        this.setState(data, () => {
            this.updateTime()
        })
        // this.setState({show:true, showTimer: true})
        
    }

    close() {
        clearTimeout(this.timeout)
        this.setState({show:false})
    }
    
    addZero(i) {
        if (i < 10) {i = "0" + i}
        return i;
    }

    getTime() {
        let minTime = Math.floor(this.state.time/60)
        let min = this.addZero(minTime);
        let seconds = this.addZero(Math.floor(-((minTime*60)-this.state.time)));
        return min+":"+seconds
    }


    updateTime() {
        if (this.state.time <= 0) {
            sendMessage('menu_submit', {
                name: this.state.name || 'bw',
                type: 'bw_timeout',
                value: {}
            })
            if (this.state.afterTimer) {
                this.setState({
                    showTimer: false,
                    title: this.state.afterTimer.title,
                    desc: this.state.afterTimer.desc,
                    buttons: this.state.afterTimer.buttons
                })
            }
        } else
            this.setState({
                time: this.state.time-1
            }, () => {
                this.timeout = setTimeout(() => this.updateTime(), 1000)
            })
    }

    submit(e,value, key) {
        e.preventDefault()
        const button = this.state.buttons[key]
        if (button.onClickRemove) {
            this.setState((state) => {
                const buttons = [...state.buttons]
                buttons.splice(key, 1)
                return {
                    buttons
                }
            })            
        }

        sendMessage('menu_submit', {
            value: value,
            type: 'button',
                name: this.state.name || 'bw',
        })
    }

    render() {
        if (!this.state.show) return <div></div>
        return <div className={`flex absolute h-screen justify-end items-end z-20 w-screen  `} >
            <div className="flex justify-center items-end w-full h-full p-4 select-none ">
                <div className="w-1/5 h-1/5 bg-red-800 bg-opacity-80 rounded-lg">
                    <div className="w-full h-full">
                        <div className="flex flex-col w-full h-full p-2">
                            <div className="text-center text-red-400 text-lg h-1/5 w-full">
                                {this.state.title}
                            </div>
                            <div className="flex gap-4 px-4 text-white w-full h-4/5">
                                <div className="flex flex-col">
                                    <div className="overflow-auto break-words w-full h-full">
                                        {this.state.desc}
                                    </div>
                                    <div className="flex gap-4 justify-center ">
                                        {this.state.buttons.map((v, i) => {
                                            return <button className="border rounded-lg bg-red-700 border-red-500 p-0.5 hover:bg-red-500 hover:text-red-700 transition-all" key={i} onClick={(e) => this.submit(e, v.value, i)}>{v.label}</button>
                                        })}
                                    </div>
                                </div> 
                                
                                {
                                    this.state.showTimer &&
                                        <div className="text-lg text-white w-full flex-1 h-full flex justify-center items-center relative">
                                            <svg className="animate-spin h-14 w-14 border-t-red-500 border-red-500 border-b-red-800 border-2 rounded-full " viewBox="0 0 48 48">
                                            </svg>
                                            <div className="absolute">
                                                {this.getTime()}
                                            </div>
                                        </div> 
                                }
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    }
}
