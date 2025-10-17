import React from 'react'
import sendMessage from '../../Api'

export default class Combination extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      tries: props.data.tries || 4,
      middleRot: props.data.middleRot || 90,
      offset: props.data.offset || 10,
      defaultTries: props.data.defaultTries || 4,
      defaultTimer: props.data.defaultTimer || 40,
      rot: 0,
      timer: 0
    }

    this.timer = 40

    this.currentRot = 0

    this.classes = [
      "h-8 border-black  rounded-b-lg border-2 bg-pink-500",
      "h-8 border-black  rounded-b-lg border-2 bg-orange-500",
      "h-8 border-black  rounded-b-lg border-2 bg-yellow-500",
      "h-8 border-black  rounded-b-lg border-2 bg-green-500",
      "h-8 border-black  rounded-b-lg border-2 bg-blue-500",
    ]
  }

  static getDerivedStateFromProps(nextProps, state) {
    if (nextProps.data.offset !== state.offset && nextProps) {
      nextProps.data.timer = 0
      return nextProps.data
    } else return null
  }

  open() {
    this.setState({
      show: true
    })
  }

  getClass() {
    let current = this.classes.length - 1
    if (this.state.offset >= 10) {
      current = this.classes.length - 1
    } else if (this.state.offset >= 5) {
      current = this.classes.length - 3
    } else if (this.state.offset >= 3) {
      current = this.classes.length - 4
    } else if (this.state.offset < 3) {
      current = 0
    }
    return this.classes[current]
  }

  clicked(e) {
    let currentRot = this.state.rot
    let minRot = this.state.middleRot - this.state.offset
    let maxRot = this.state.middleRot + this.state.offset
    if (currentRot >= minRot && currentRot <= maxRot) {
      this.props.submit({
        value: currentRot,
        type: "found"
      })
    } else {
      if (this.state.tries > 1) {
        this.setState({ tries: this.state.tries - 1 })
      } else {
        // this.props.submit({
        //     value: currentRot,
        //     type: "tried"
        // })
        this.setState({ tries: this.state.tries - 1 })
        this.startTimer()
      }
    }

  }

  timerLoop2() {
    if (this.state.timer === 0) {
      this.props.submit({
        value: this.state.timer,
        type: "tried"
      })
      return this.setState({ tries: this.state.defaultTries })
    }
    this.setState({ timer: this.state.timer - 1 }, () => {
      setTimeout(() => this.timerLoop2(), 1000)
    })
  }

  startTimer() {
    this.setState({
      timer: this.state.defaultTimer
    }, () => { this.timerLoop2() })
  }

  mouseMoved = (event) => {
    if (this.state.tries <= 0) {
      return
    }
    var mouseX = event.clientX
    var mouseY = event.clientY

    let elem = document.getElementById("lockme55")
    var divRect = elem.getBoundingClientRect()

    let divCenterX = divRect.left + (divRect.width / 2)
    let divCenterY = divRect.top + (divRect.height / 2)

    let diffx = mouseX - divCenterX
    let diffY = mouseY - divCenterY
    let divRota = Math.atan2(diffY, diffx) * 180 / Math.PI
    this.setState({ rot: divRota })
  }

  mouseDown = (event) => {
    if (this.state.timer <= 0)
      this.clicked(event)
  }

  close() {
    this.setState({
      show: false
    })
  }

  render() {
    return <div onMouseDown={(e) => this.mouseDown(e)} onMouseMove={(e) => this.mouseMoved(e)} className="w-full h-full flex justify-center items-center absolute z-40 ">
      <div className="w-64 h-64 border-8 border-none rounded-full flex justify-center items-start relative shadow-lg shadow-black outline bg-gradient-to-t from-gray-500 via-gray-600 to-gray-700 bg-opacity-0 select-none pointer-events-none">
        <p className="absolute -bottom-0.5 z-10">
          {this.state.tries > 0 ? this.state.tries : this.state.timer}
        </p>
        <img style={{ transform: `rotate(${this.state.rot}deg)` }} id="lockme55" src="https://static.vecteezy.com/system/resources/previews/009/391/649/original/safe-combination-lock-clipart-design-illustration-free-png.png" alt="LOCk" />
        <div className="absolute h-full w-full flex justify-center">
          <div id="bbc2" style={{ width: "0.5rem" }} className={this.getClass()}>

          </div>
        </div>

      </div>
      {}
    </div>
  }
}
