


import React from 'react'
import sendMessage from '../../Api'

export default class Mortar extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
    }

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.classes = {
      'text': "flex justify-center items-center w-10 h-10 text-white text-lg font-sans font-semibold",
      'number': "flex justify-center items-center w-10 h-10 text-white text-md font-sans font-semibold"
    }
  }

  open(data) {
    this.setState({ show: true })
  }

  close() {
    this.setState({ show: false, currentHeading: 200 })
  }

  render() {


    if (!this.state.show) return <></>
    return <div className="w-full h-full absolute">
      <div className="w-full h-full ">


        <div className="w-full h-full  relative  flex justify-center items-center ">
          <div className="w-1/4 h-full bg-black text-white flex flex-col justify-center items-center gap-4">

          </div>
          <div style={{ background: "radial-gradient(transparent 390px, rgba(0, 0, 0, 1) 400px)" }} className=" w-1/2 h-full relative">
            {/* <div className="h-1/2 bg-blue-500 w-1/2 absolute left-1/4 rounded-full" style={{background:"radial-gradient(circle, transparent 40%, gray 40%)"}}>
                            
                        </div> */}

            {/* <div id="mortar-scroller" className="w-28 h-full bg-gray-500 absolute left-20 rounded-full flex flex-col items-center text-xl overflow-hidden justify-center">
                            {Array(1000).fill().map((v, i) => {
                                i = 1000-i


                                return <div id={`mortar-heading-${i}`}>


                                    {i}
                                </div>
                            })}
                        </div> */}
            <div className="w-0.5 h-full bg-black absolute left-1/2">

            </div>
            <div className="w-full h-0.5 bg-black absolute top-1/2 right-0 flex items-center">
            </div>
          </div>

          <div className="w-1/4 h-full bg-black">

          </div>
        </div>
      </div>
    </div>
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
