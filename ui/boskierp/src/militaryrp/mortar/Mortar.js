

import React from 'react'
import sendMessage from '../../Api'

export default class Mortar extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      currentHeading: 1579
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
    this.squadTable = [
      [50, 1579],
      [100, 1558],
      [150, 1538],
      [200, 1517],
      [250, 1496],
      [300, 1475],
      [350, 1453],
      [400, 1431],
      [450, 1409],
      [500, 1387],
      [550, 1364],
      [600, 1341],
      [650, 1317],
      [700, 1292],
      [750, 1267],
      [800, 1240],
      [850, 1212],
      [900, 1183],
      [950, 1152],
      [1000, 1118],
      [1050, 1081],
      [1100, 1039],
      [1150, 988],
      [1200, 918],
      [1250, 800],
    ];



    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.classes = {
      'text': "flex justify-center items-center w-10 h-10 text-white text-lg font-sans font-semibold",
      'number': "flex justify-center items-center w-10 h-10 text-white text-md font-sans font-semibold"
    }
  }

  open(data) {
    data.currentHeading = this.calculateMilliradianForRange(data.currentHeading)
    this.setState(data)
  }

  close() {
    this.setState({ show: false, currentHeading: 200 })
  }

  update(data) {
    this.setState(data)
  }

  // // componentDidMount() {
  // //     this.setState({show: true, currentHeading:359.0})
  // // }

  convertToPercentage(value, maxValue) {
    let percentage = value
    if (percentage > 1000) {
      percentage = percentage / 100
    }
    // if (percentage > 100) {
    //     percentage = percentage/10
    // }
    // if (percentage > 10) {
    //     percentage = percentage/10
    // }
    // if (percentage > 1000) {
    //     percentage = percentage/10
    // }
    // if (percentage> 100) {
    //     percentage = percentage/100
    // }
    return percentage / 10
  }

  calculateRangeForMilliradian(milliradian) {


    const lastIndex = this.squadTable.length - 1;
    if (milliradian >= this.squadTable[0][1]) {



      return this.squadTable[0][0];

    } else if (milliradian <= this.squadTable[lastIndex][1]) {
      return this.squadTable[lastIndex][0];
    } else {
      for (let i = 1; i < this.squadTable.length; i++) {
        const prevRange = this.squadTable[i - 1][0];
        const nextRange = this.squadTable[i][0];
        const prevMils = this.squadTable[i - 1][1];
        const nextMils = this.squadTable[i][1];

        if (milliradian <= prevMils && milliradian >= nextMils) {
          const milDiff = nextMils - prevMils;
          const rangeDiff = nextRange - prevRange;
          const milsRatio = (milliradian - prevMils) / milDiff;
          const interpolatedRange = prevRange + milsRatio * rangeDiff;
          return interpolatedRange;
        }
      }
    }
  }
  componentDidUpdate() {
    if (this.state.show) {
      const radius = -17;
      const numDivs = 10;
      let elem = document.getElementById("mortar-scroller")
      let offsetBetween = Math.abs((elem?.children[0].offsetTop - elem?.children[1].offsetTop))
      let heading = this.state.currentHeading
      let normalHeading = Math.floor(heading)
      let offset = heading - normalHeading
      let elem2 = document.getElementById(`mortar-heading-${normalHeading}`)
      let elem4 = document.getElementById(`mortar-heading-${normalHeading + 1}`)
      elem2?.scrollIntoView({ behavior: "instant", block: "center", inline: "center" })
      let dist = elem4?.offsetTop - elem2?.offsetTop
      let newOffset = Math.abs(offset * dist)
      elem?.scrollBy({ top: -newOffset })

      // let startElem = document.getElementById(`mortar-heading-${normalHeading-10}`)
      // let endElem = document.getElementById(`mortar-heading-${normalHeading+10}`)

      let id = -1
      let newId = 5
      for (let i = normalHeading - 10; i <= normalHeading + 10; i++) {
        id = id + 1
        // let x = (Math.PI)/(10*i)-i/2
        // const angle = (id / (numDivs - 1)) * Math.PI;
        // // console.log(id)
        const angle = (id) / (Math.PI)
        // // console.log(angle)
        let x = radius * Math.cos(angle) / Math.sin(-4);
        let startElem = document.getElementById(`mortar-heading-${i}`)

        startElem.style.transform = `translate(${x}px, 0px)`

      }

      // elem.childNodes.forEach((v,i) => {
      //     let id = this.convertToPercentage(i, 100)
      //     // let x = (Math.PI)/(10*i)-i/2
      //     // const angle = (id / (numDivs - 1)) * Math.PI;
      //     console.log(id)
      //     const angle = (id)*(Math.PI)
      //     console.log(angle)
      //     const x = radius * Math.cos(angle);

      //     v.style.transform = `translate(${x}px, 0px)`

      // })


    }


  }

  calculateMilliradianForRange(range) {
    const lastIndex = this.squadTable.length - 1;
    if (range <= this.squadTable[0][0]) {
      return this.squadTable[0][1];
    } else if (range >= this.squadTable[lastIndex][0]) {
      return this.squadTable[lastIndex][1];
    } else {
      for (let i = 1; i < this.squadTable.length; i++) {
        const prevRange = this.squadTable[i - 1][0];
        const nextRange = this.squadTable[i][0];
        const prevMils = this.squadTable[i - 1][1];
        const nextMils = this.squadTable[i][1];

        if (range >= prevRange && range <= nextRange) {
          const rangeDiff = nextRange - prevRange;
          const milDiff = nextMils - prevMils;
          const rangeRatio = (range - prevRange) / rangeDiff;
          const interpolatedMils = prevMils + rangeRatio * milDiff;
          return interpolatedMils;
        }
      }
    }
  }
  render() {


    if (!this.state.show) return <></>
    return <div className="w-full h-full absolute">
      <div className="w-full h-full ">


        <div className="w-full h-full  relative  flex justify-center items-center ">
          <div className="w-1/4 h-full bg-black text-white flex flex-col justify-center items-center gap-4">
            <div className="w-full h-auto flex justify-center items-center gap-4">
              <div className="flex justify-center items-center flex-col">
                <div className="font-bold">
                  RANGE
                </div>
                {this.squadTable.map((v, i) => {
                  return <div>{v[0]}</div>
                })}
                {/* {Array(30).fill().map((v, i) => {
                                    i = i +1
                                    return <div>{i*50}m</div>
                                })}  */}
              </div>
              <div className="flex justify-center items-center flex-col">
                <div className="font-bold">
                  MILLIRADIAN (mil)
                </div>


                {this.squadTable.map((v, i) => {
                  return <div>{v[1]}</div>
                })}
                {/* {Array(30).fill().map((v, i) => {

                                    
                                    i = i +1
                                    let m =  i * 50

                                    let mmrd = Math.floor((78.95/m)*1000)
                                    
                                    
                                    
                                    return <div>{mmrd}</div>
                                })}  */}
              </div>
            </div>
            <div className=" flex justify-center items-center">
              AVERAGE FLIGHT TIME - 20 SECONDS
            </div>

          </div>
          <div style={{ background: "radial-gradient(transparent 390px, rgba(0, 0, 0, 1) 400px)" }} className=" w-1/2 h-full relative">
            {/* <div className="h-1/2 bg-blue-500 w-1/2 absolute left-1/4 rounded-full" style={{background:"radial-gradient(circle, transparent 40%, gray 40%)"}}>
                            
                        </div> */}
            <div className="h-full w-1/2 absolute -left-1/4 rounded-r-full flex  justify-end overflow-hidden bg-gray-400 -z-10 bg-opacity-70 border-2 border-black " id="mortar-scroller-2">
              <div id="mortar-scroller" className="flex flex-col px-5 overflow-hidden text-xl">
                {Array(1700).fill().map((v, i) => {
                  i = 1700 - i

                  if (i % 10 === 0) {
                    return <div id={`mortar-heading-${i}`} className="flex justify-center items-center font-semibold">
                      {i} <div className="w-7 h-0.5 bg-black"></div>

                    </div>
                  } else if (i % 5 === 0) {
                    return <div id={`mortar-heading-${i}`} className="flex justify-center items-center font-bold">
                      {i} <div className="w-5 h-0.5 bg-black"></div>
                    </div>
                  } else
                    return <div id={`mortar-heading-${i}`} className="flex justify-center items-center text-lg">
                      {i} <div className="w-4 h-0.5 bg-black"></div>
                    </div>
                })}

              </div>

            </div>
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
            <div className="w-3/4 h-0.5 bg-black absolute top-1/2 right-0 flex items-center">
              <div className="w-10 h-full p-5 border-4 border-black inline-block border-t-0 border-r-3 border-b-3 border-l-0 rotate-[135deg]">

              </div>
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
