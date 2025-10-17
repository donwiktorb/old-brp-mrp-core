import React from 'react'



export default class MilitaryHud extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            data: {
                ammo: 0,
                maxammo: 0,
                hp: 0,
                armor: 0,
                grenades: 0,

                main: 0
            }
        }

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
        this.update = this.update.bind(this)


        this.classes = [
            'w-full h-full flex justify-end items-end absolute ',
            'w-full h-full flex justify-center items-end absolute ',
            'w-full h-full flex justify-center items-start absolute ',
            'w-full h-full flex justify-center items-center absolute ',
            'w-full h-full flex justify-start items-end absolute ',
            'w-full h-full flex justify-start items-start absolute ',
            'w-full h-full flex justify-start items-center absolute ',
            'w-full h-full flex justify-end items-center absolute ',
            'w-full h-full flex justify-end items-start absolute ',
        ]
    }
    

    update(ndata) {
        this.setState((state) => {
            const data = state.data
            // ndata.forEach((v) => {
            //     data[v.type] = v.value
            // })
            for (let i in ndata) {
                data[i] = ndata[i]
            }

            return {
                data
            }
        })
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

    render() {
        if (!this.state.show) return <></>
        return (
            <div  className={`flex h-screen justify-end items-end w-screen `} >
                <div className={this.classes[this.state.data.main]}>
                    <div className="h-28 w-72
                        bg-black
                        bg-opacity-80
                        skew-y-[3.7deg]
                        rounded
                        text-center  my-7 mx-7">
                        <div className="h-full w-full flex flex-col rounded-md p-0.5 place-items-center gap-1 text-gray-400
                            font-mono 
                        ">
                            <div className="w-full h-full flex">
                                <div
                                className="w-full h-full text-7xl relative -my-1.5">
                                    <p 
                                    style={{textShadow: "0px 0px 4px gray"}} 
                                    className="absolute z-10 right-0">{this.state.data.ammo}</p>
                                    <p className="text-gray-600 opacity-30 flex justify-end">000</p>
                                </div>
                                <div
                                className="w-full h-full text-2xl relative -my-1.5 ">
                                    <p className="absolute left-0 mx-5 my-2 text-3xl font-extrabold italic"
                                    style={{textShadow: "0px 0px 4px gray"}} 
                                    >/</p>
                                    <p className="absolute z-10 right-0 tracking-widest text-5xl my-0.5"
                                    style={{textShadow: "0px 0px 4px gray"}} 
                                    >{this.state.data.maxammo}</p>
                                    <p className="text-gray-600 opacity-30 text-5xl tracking-widest flex justify-end">000</p>
                                    <p className="absolute -my-2.5 left-0 mx-4 text-lg"
                                    >[</p>
                                    <p className="absolute -my-2.5 right-0 mx-2 text-lg"
                                    >]</p>
                                    <p className="-my-2.5 text-2xl tracking-widest ml-2 "
                                    >AUTO</p>
                                </div>
                            </div>
                            <div className="w-full h-full flex">
                                <div
                                    style={{textShadow: "0px 0px 4px gray"}} 
                                className="w-auto h-full border-2 border-gray-500 text-4xl px-5 -my-1">
                                    <div className="w-full h-full flex justify-center">
                                        <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" viewBox="0 0 297 297" fill="currentColor" className="
                                        text-gray-400
                                        p-1.5
                                        w-12
                                        " >
                                        <g>
                                            <path d="M258.591,170.705c0-39.765-15.888-74.738-39.919-94.955L202.756,32h3.986c8.837,0,16-7.163,16-16s-7.163-16-16-16h-72   c-8.837,0-16,7.163-16,16c0,6.914,4.393,12.785,10.533,15.021c0.268-0.006,0.532-0.021,0.801-0.021   c19.482,0,35.333,15.851,35.333,35.333s-15.851,35.333-35.333,35.333c-8.88,0-16.999-3.301-23.213-8.729   c-14.858,20.291-23.97,47.656-23.97,77.768c0,41.271,17.113,77.383,42.686,97.189c-4.13,2.894-6.837,7.68-6.837,13.105   c0,8.837,7.163,16,16,16h72c8.837,0,16-7.163,16-16c0-5.426-2.707-10.211-6.836-13.104   C241.478,248.088,258.591,211.976,258.591,170.705z"/>
                                            <path d="M103.555,42.834L38.409,70.017V181c0,8.837,7.163,16,16,16s16-7.163,16-16V91.317l26.963-11.21   c-1.799-4.234-2.796-8.89-2.796-13.773C94.577,57.317,97.976,49.083,103.555,42.834z"/>
                                            <path d="M130.076,85.667c10.66,0,19.333-8.673,19.333-19.333c0-10.66-8.673-19.333-19.333-19.333   c-10.66,0-19.333,8.673-19.333,19.333C110.743,76.994,119.416,85.667,130.076,85.667z"/>
                                        </g>
                                        </svg>{this.state.data.grenades}
                                    </div>
                                </div>
                                <div
                                    style={{textShadow: "0px 0px 4px gray"}} 
                                className="grow h-full border-2 border-gray-500 text-4xl ml-2 tracking-widest -my-1 ">
                                    <div className="w-full h-full flex justify-center">
                                    <svg version="1.1" id="Capa_1" x="0px" y="0px" width="22.354px" height="22.354px" viewBox="0 0 22.354 22.354" fill="currentColor"
                                    className="h-11 w-7 mx-4 -ml-5">
                                    <g>
                                        <polygon points="8.61,22.354 13.744,22.354 13.744,13.744 22.354,13.744 22.354,8.611 13.744,8.611 13.744,0 8.61,0 8.61,8.611    0,8.611 0,13.744 8.61,13.744  "/>
                                    </g>

                                    </svg>{this.state.data.hp}
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        )
    }
}