import React from 'react'
import sendMessage from '../../Api'

export default class Circle extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: true,
    }
    this.currentRot = 0

    this.classes = {
      top: {
        class: "absolute border-blue-500 border-t-4 w-full h-full rounded-tl-full rounded-tr-full"
      }
    }
    this.speed = 2
    this.timer = 0
    this.times = 0
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

  loop() {
    let elem = document.getElementById('circlePointer')
    if (!elem) return clearTimeout(this.timer)
    this.currentRot += 1
    if (this.currentRot >= 360) {
      this.currentRot = 0
    }
    elem.style.rotate = this.currentRot + 'deg'
    this.timer = setTimeout(() => this.loop(), this.speed) // 8
  }

  componentWillUnmount() {
    clearTimeout(this.timer)
  }

  componentDidMount() {
    let elem2 = document.getElementById('bbc')
    if (!elem2) return
    elem2.style.rotate = Math.floor(Math.random() * 360) + 'deg';
    this.loop()
    window.addEventListener('keydown', (e) => {
      e.preventDefault()
      if (e.key === " ") {
        let elem = document.getElementById('circlePointer')
        let elem2 = document.getElementById('bbc')
        let elem5 = document.getElementById('bbc2')
        let pointer = parseInt(elem.style.rotate.split('deg')[0])
        let box = parseInt(elem2.style.rotate.split('deg')[0])
        let offset = parseInt(elem5.style.width.split('rem')[0] * 5)
        if (pointer >= box - offset / 2 && pointer <= box + offset / 2) {
          elem2.style.rotate = Math.floor(Math.random() * 360) + 'deg';
          elem2.style.width = Math.floor(Math.random() * 9) + "rem"
          // elem5.style.width = Math.floor(Math.random() * 4)+'rem';
          this.speed -= 1
          this.props.submit({
            value: this.currentRot,
            type: "found"
          })
        }
      }
    })
  }

  render() {
    if (!this.state.show) return <></>
    return <div className="w-full h-full flex justify-center items-center absolute z-40 ">
      <div className="w-64 h-64 border-8 border-2 rounded-full flex justify-center items-start relative shadow-none shadow-black outline-none bg-gradient-to-t bg-black animate-rainbow bg-opacity-40 animate-rainbowborder">

        <div className="absolute h-full w-full flex justify-center" id="bbc">
          <div id="bbc2" style={{ width: "2.5rem" }} className="h-5 -m-2.5 border-gray-500  rounded border-2 bg-black">

          </div>
        </div>

        <div className="absolute w-full h-full flex justify-center items-center">
          <div className="bg-black bg-opacity-50 text-gray-400 py-0.5 px-2 border-2 border-gray-500 rounded-lg z-10 ">
            Space
          </div>
        </div>

        <div className="w-2 h-1/2 origin-bottom rotate-0 transition-transform flex items-end" id="circlePointer">
          <div className="w-2 h-full bg-black border-2 border-gray-500 rounded-t-lg">

          </div>
        </div>
      </div>
      {/* <div id="skillcheck" className="w-96 h-96 transition-all m-auto">
                <div id="zone" style={{backgroundImage: "url('https://www.mistersyms.com/tools/gitgud/circlezone.png')"}} className="fixed w-96 h-96 -rotate-90"></div>

                <div id="tick" className="fixed w-10 h-96 bg-black transition-all origin-top">
                    <div id="redtick"></div>
                </div>

                <div id="customkeyoverlay">
                    <p class="customkeytxt">Space</p>
                </div>
            </div> */}
    </div>
  }
}
