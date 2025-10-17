


import React from 'react'
import sendMessage from '../../Api'

export default class DefuseMine extends React.Component {
  constructor(props) {
    super(props)

    this.count = 0
    this.proper = [
      "green",
      "yellow",
      "darkred",
      "red"
    ]

    this.colors = [
      {
        name: "red",
        color: "h-full w-8 bg-red-500 shadow-lg shadow-red-500",
        decolor: "h-full w-8 bg-red-500 flex justify-center items-center"

      },
      {
        name: "darkred",
        color: "h-full w-8 bg-red-700 shadow-lg shadow-red-700",
        decolor: "h-full w-8 bg-red-700 flex justify-center items-center"

      },
      {
        name: "yellow",
        color: "h-full w-8 bg-yellow-500 shadow-lg shadow-yellow-500",
        decolor: "h-full w-8 bg-yellow-500 flex justify-center items-center"

      },
      {
        name: "green",
        color: "h-full w-8 bg-green-500 shadow-lg shadow-green-500",
        decolor: "h-full w-8 bg-green-500 flex justify-center items-center"

      }
    ]

    this.heights = [
      'h-3/5',
      'h-2/5',
      'h-4/6',
      'h-3/6',
      'h-4/5',
    ]

    this.state = {
      show: false,
      message: "Przetnij kable według schematu ze szkoleń!",
      warn: "Pamiętaj, możesz pomylić się tylko raz...",
      colors: [
      ]
    }
    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
  }

  randomColors() {
    let chosen = []
    while (chosen.length < 4) {
      let color = this.colors[Math.floor(Math.random() * this.colors.length)]
      if (!chosen.find(el => el === color)) {
        chosen.push(color)
      }
    }

    this.setState({
      show: true,
      colors: chosen
    })
  }

  open() {
    this.randomColors()
    // this.setState({show:true, colors: []})
  }

  close() {
    this.colors.forEach((v) => {
      v.destroyed = undefined
    })
    this.setState({ show: false, colors: [] })
  }

  // componentDidMount() {
  //     this.randomColors()
  // }

  randomHeight() {
    return this.heights[Math.floor(Math.random() * this.heights.length)]
  }

  generateColor(v, i) {
    if (!v.destroyed)
      return <div onClick={(e) => this.destroy(e)} data-name={v.name} data-index={i} className={v.color}></div>
    else
      return <div data-name={v.name} data-index={i} className={v.decolor}><div className={`w-full ${v.height} bg-slate-800 rounded-lg`}></div></div>
  }

  destroy(e) {
    e.preventDefault()
    const { index } = e.target.dataset
    const currentColor = this.state.colors[index]
    const proper = this.proper[this.count]
    console.log(proper, currentColor.name)
    if (currentColor.name === proper) {
      this.count += 1
      if (this.count >= 4) {
        this.count = 0
        sendMessage('mine_success', {})

      } else {
        this.setState((state) => {
          const colors = state.colors
          if (!colors[index].destroyed) {
            colors[index].destroyed = true
            colors[index].height = this.randomHeight()
          }
          return {
            colors
          }
        })
      }
    } else {
      this.count = 0
      sendMessage('mine_fail', {})
    }

  }

  render() {
    if (!this.state.show) return <></>
    return (
      <div className="w-full h-full z-20  flex justify-center items-center">
        <div className="w-1/2 h-1/2 bg-gray-900 bg-opacity-90 rounded-lg  relative">
          <div className="text-white text-center h-[8%] p-2 bg-slate-900 rounded-lg text-lg">
            <p>{this.state.message}</p>
          </div>
          <div className="w-full h-[84%] bg-slate-800 bg-opacity-90 rounded-lg">
            <div className="grid grid-cols-4 justify-items-center gap-2 h-full w-full"> {this.state.colors.map((v, i) => {
              return this.generateColor(v, i)
            })}
            </div>

          </div>
          <div className="text-yellow-500 text-center h-[8%] p-2 bg-slate-900 rounded-lg text-lg">
            <p>{this.state.warn}</p>
          </div>

        </div>
      </div>
    );
  }
}
