
import React from 'react'
import sendMessage from '../../Api'

export default class Compass extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      currentHeading: 0.0
    }

    this.fixedHeading = 359 + 1
    this.maxHeading = 720
    this.maxHeading2 = 1080

    this.pos = {
      0: 'N',
      225: 'SW',

      270: 'W'

      ,

      315: 'NW',

      45: 'NE',
      90: 'E',
      135: 'SE',
      180: 'S',
    }

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.classes = {
      'text': "flex justify-center items-center w-10 h-10 text-white text-lg font-sans font-semibold",
      'number': "flex justify-center items-center w-10 h-10 text-white text-md font-sans font-semibold"
    }
  }

  open(data) {
    this.setState(data)
  }

  close() {
    this.setState({ show: false, currentHeading: 0 })
  }

  update(data) {
    this.setState(data)
  }

  // // componentDidMount() {
  // //     this.setState({show: true, currentHeading:359.0})
  // // }

  componentDidUpdate() {
    if (this.state.show) {
      let elem = document.getElementById("scroller")
      let offsetBetween = Math.abs((elem?.children[0].offsetLeft - elem?.children[1].offsetLeft))
      let heading = this.state.currentHeading
      let normalHeading = Math.floor(heading)
      let offset = heading - normalHeading
      let elem2 = document.getElementById(`head-${normalHeading}`)
      let elem4 = document.getElementById(`head-${normalHeading + 1}`)
      elem2?.scrollIntoView({ behavior: "instant", block: "center", inline: "center" })
      let dist = elem4?.offsetLeft - elem2?.offsetLeft
      let newOffset = Math.abs(offset * dist)
      elem?.scrollBy({ left: newOffset })
    }

  }

  render() {
    if (!this.state.show) return <></>
    return <div className="w-full h-full absolute">
      <div className="w-full h-full flex justify-center items-start relative">
        <div className="w-2 h-3 bg-black absolute rounded-b-lg opacity-70">

        </div>
        <div className="w-1/4 h-14  overflow-hidden flex gap-4" id="scroller">

          {Array(1080).fill().map((v, i) => {
            let headingId = i - 360
            let fixedHeading = i - 360
            if (fixedHeading > 359) {
              if (fixedHeading < 720) {
                fixedHeading = fixedHeading - 360
              } else {
                fixedHeading = fixedHeading - 722
              }
            }

            if (fixedHeading < 0) {
              fixedHeading = Math.abs(i)
            }

            let pos = this.pos[fixedHeading]

            return <div style={{ textShadow: "2px 2px 4px #000000" }} id={`head-${headingId}`} className={pos ? this.classes.text : this.classes.number}>
              <div>
                {pos ? pos : fixedHeading}
              </div>
            </div>
          })}
        </div>

      </div>

    </div>

  }
}
