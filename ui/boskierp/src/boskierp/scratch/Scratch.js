
import React from 'react'
import sendMessage from '../../Api'

export default class Scratch extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            text: "x d"
        }

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
        this.onKey = this.onKey.bind(this)
    }

    getPos(xRef, yRef) {
        let bridge = document.getElementById('scratch')
        var bridgeRect = bridge.getBoundingClientRect();
        return {
            x: Math.floor((xRef-bridgeRect.left)/(bridgeRect.right-bridgeRect.left)*bridge.width),
            y: Math.floor((yRef-bridgeRect.top)/(bridgeRect.bottom-bridgeRect.top)*bridge.height)
        };
    } 

    drawDot(mouseX,mouseY){

        let elem = document.getElementById('scratch')
        let bridgeCanvas = elem.getContext('2d')

        const imageData = bridgeCanvas.getImageData(0, 0, 1, 1).data;
        bridgeCanvas.beginPath();
        bridgeCanvas.arc(mouseX, mouseY, 20.0, 0, 2*Math.PI, true);
        bridgeCanvas.fillStyle = '#000';
        bridgeCanvas.globalCompositeOperation = "destination-out";
        bridgeCanvas.fill();
        if (imageData[3] === 0) {

            sendMessage("menu_cancel", {
                name: this.state.name
            })
        }
    }

    onMouseMove = (e) => {
        var brushPos = this.getPos(e.clientX, e.clientY);
        if (e.buttons === 1) {
            this.drawDot(brushPos.x, brushPos.y);
        }
    }

    onKey = (e) => {
        if (e.key === 'Escape')
            sendMessage("menu_cancel", {
                name: this.state.name
            })
    }

    open(data) {
        this.setState(data, () => {
            let elem = document.getElementById('scratch')
            let canv = elem.getContext('2d')
            canv.globalCompositeOperation = 'destination-over'
            canv.rect(0, 0, elem.width, elem.height)
            canv.fillStyle = "gray"
            canv.fill()
            canv.fillStyle = "black"
            canv.font = "48px serif";
            canv.fillText("Hello world", 10, 50);
        })
    }

    close() {
        this.setState({show:false})
    }

    render() {
        if (!this.state.show) return
        return <div className="w-full h-full flex justify-center items-center absolute z-40 ">
            <div className="w-full h-full flex justify-center items-center relative">
                <div
                style={{backgroundImage: "url('https://boskierp.pl/img/ss/dwb_xD0V.png')", backgroundSize:"cover", backgroundRepeat:"no-repeat"
                }} 
                 className="object-cover w-1/4 h-1/4 absolute -z-10 flex justify-center items-center text-2xl font-bold rounded-lg text-opacity-70">
                    {this.state.text}
                </div>
                <canvas onMouseMove={this.onMouseMove} style={{
                    // // backgroundImage: "url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/calgary-bridge-1943.jpg')"
                }} id="scratch" className="w-1/4 h-1/4 rounded-lg">
                </canvas>
            </div>
        </div>
    }
}
