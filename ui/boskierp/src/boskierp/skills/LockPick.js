
import React from 'react'
import sendMessage from '../../Api'

export default class LockPick extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
        }
        this.currentRot = 0

        this.classes = {
            top: {
                class: "absolute border-blue-500 border-t-4 w-full h-full rounded-tl-full rounded-tr-full"
            }
        }
    }

    open() {
        this.setState({
            show: true
        })
    }

    componentDidMount() {
        let elem = document.getElementById("lockpickme")
        if (!elem) return
        document.addEventListener("mousemove", function(event) {
            var mouseX = event.clientX
            var mouseY = event.clientY

            let elem = document.getElementById("lockpickme")
            var divRect = elem.getBoundingClientRect()

            let divCenterX = divRect.left + (divRect.width/2)
            let divCenterY = divRect.top + (divRect.height/2)

            let diffx = mouseX - divCenterX
            let diffY = mouseY - divCenterY
            let divRota = Math.atan2(diffY, diffx)*180/Math.PI
            elem.style.transform = "rotate("+divRota+"deg)"
        })
        document.addEventListener("mousedown", function(event) {
            console.log(event)
        })
    }

    close() {
        this.setState({
            show: false
        })
    }

    render() {
        return <div className="w-full h-full flex justify-center items-center absolute z-40 ">
            <div className="w-96 h-64 border-8 border-none rounded-full flex justify-center items-start relative pl-10">
                <img id="" src="https://boskierp.pl/img/ss/dwb_ORY3.png" alt="LOCk" className="w-full h-full" /> 
                <div className="absolute h-full w-full flex justify-center">
                    <img id="lockpickme" src="https://boskierp.pl/img/ss/dwb_pfWN.png" alt="LOCk" className="absolute left-1/3 px-2 top-32  origin-top" /> 
                    {/* <img id="" src="https://images.vexels.com/media/users/3/314717/isolated/preview/b6e6f0048f20aa3d995d3e9d7716497a-heavy-duty-lock-pick-for-challenging-locks.png" alt="LOCk" className="absolute top-52 origin-top" />  */}
                </div>
            </div>
        </div>
    }
}
