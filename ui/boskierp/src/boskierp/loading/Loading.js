
import React from 'react'
export default class Loading extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show:false
        }
    }

    render() {
        if (!this.state.show) return
        return <div className="absolute z-40 w-full h-full animate-fadeIn ">
            <div className="w-full h-full flex flex-col bg-gradient-to-r from-orange-700 to-orange-900 p-2 animate-rainbow select-none relative">
                <div className="text-2xl text-white font-bold">
                    BoskieRP
                </div>

                <div className="w-48 h-48 absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none">
                    <img alt="brp" src="https://cdn.discordapp.com/attachments/1020433320934379612/1024767726104870933/xd8_digital_art_x4.png" className="animate-scale"></img>
                </div>

                <div className="w-full h-fit self-end mt-auto text-lg font-semibold text-right text-white">
                    <div className="flex justify-between">
                        <div>Wczytywanie</div>
                        {/* <div>50%</div> */}
                    </div>
                    <div className="w-full h-2.5 bg-gray-500 bg-opacity-50 rounded-lg">
                        <div className="bg-gradient-to-r from-yellow-500 to-yellow-700 animate-rainbow h-full rounded-lg" style={{width: "50%"}}>

                        </div>

                    </div>
                </div> 
            </div>
        </div>
    }
}