


import React from 'react'


import sendMessage from '../../Api'
export default class MenuCat extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      grid: 3,
      main: 0,
      title: "x d",
      type: "xd",
      elements: [
        {
          show: true,
          isCat: true,
          label: "x d",
          elements: [
            {
              label: "x d",
              img: "https://img.gta5-mods.com/q75/images/emperor-stock-car/27cd0b-41.png"
            }
          ]
        },
        {
          show: true,
          isCat: true,
          label: "x d",
          elements: [
            {
              img: "https://img.gta5-mods.com/q75/images/emperor-stock-car/27cd0b-41.png",
              label: "x d"
            }
          ]
        }
      ]
    }

    this.grids = [
      'flex flex-col items-center w-3/5 justify-center',
      'grid grid-cols-1 gap-2 justify-items-center',
      'grid grid-cols-2 gap-2 justify-items-center',
      'grid grid-cols-3 gap-2 justify-items-center',
      'grid grid-cols-4 gap-2 justify-items-center',
    ]

    this.mainGrids = [
      'flex flex-col overflow-y-scroll gap-4 h-full',
      'grid grid-cols-1 overflow-y-scroll gap-4 h-full w-full',
      'grid grid-cols-2 overflow-y-scroll gap-4 h-full w-full',
      'grid grid-cols-3 overflow-y-scroll gap-4 h-full w-full',
      'flex flex-col overflow-y-scroll gap-4 h-full',
      'flex flex-col overflow-y-scroll gap-4 h-full',
      'flex flex-col overflow-y-scroll gap-4 h-full',
      'flex flex-col overflow-y-scroll gap-4 h-full',
    ]



    this.static = JSON.parse(JSON.stringify(this.state.elements))

    this.classes = {
      defaultButton: "rounded-lg p-0.5 bg-gray-700 hover:bg-gray-800 hover:scale-90 transition-all w-full h-full",
      selectedButton: "rounded-lg p-0.5 bg-gray-500 hover:bg-gray-700 hover:scale-100 scale-90 transition-all w-full h-full"
    }

    this.close = this.close.bind(this)
    this.open = this.open.bind(this)
  }

  open(data) {
    this.static = JSON.parse(JSON.stringify(data.elements))
    this.setState(data)
  }

  close() {
    this.setState({ show: false })
  }

  onSearch(e) {
    let { value } = e.target
    value = value.toLowerCase()
    const elems = JSON.parse(JSON.stringify(this.static))
    elems.forEach((v) => {
      v.elements = v.elements.filter(v2 => v2.label.toLowerCase().includes(value))
    })
    this.setState({ elements: elems })
  }

  showCat(e, i, show) {
    this.setState((state) => {
      const elements = state.elements
      elements[i].show = !show
      return elements
    })
  }

  clicked(e, i, i2, selected) {
    e.preventDefault()
    if (this.state.type === 'select') {
      this.setState((state) => {
        const elements = state.elements
        elements[i].elements[i2].selected = !selected
        return { elements }
      })
    } else {
      sendMessage('menu_submit', {
        menu: this.state,
        current: this.state.elements[i]?.elements[i2],
        currentCat: this.state.elements[i]
      })
    }
  }

  cancel(e) {
    sendMessage('menu_cancel', {
      menu: this.state,
      current: this.state.elements
    })
  }

  save(e) {
    const elements = [...this.state.elements]
    sendMessage('menu_submit', {
      menu: this.state,
      current: elements.map((v) => {
        v.elements = v.elements.filter(v2 => v2.selected)
        return v
      })
    })
  }

  render() {
    if (!this.state.show) return <></>
    return <div className="w-full h-full absolute z-20">
      <div className="w-full h-full flex justify-center items-center">
        <div className="w-1/2 h-3/5 bg-black rounded-lg bg-opacity-70 flex flex-col gap-4 text-white p-2 select-none">
          <div className="text-3xl font-bold text-center bg-black bg-opacity-40 rounded-lg animate-rainbowtxt">
            {this.state.title}
          </div>
          <div className="">
            <input className="rounded-lg bg-black bg-opacity-50 text-white outline-none hover:outline-none p-0.5" stype="search" onChange={(e) => this.onSearch(e)}></input>
          </div>
          <div className={this.mainGrids[this.state.main]}>
            {this.state.elements.map((v, i) => {
              return <div className="flex flex-col gap-2">
                <div onClick={(e) => this.showCat(e, i, v.show)} className="text-2xl font-semibold flex gap-2">
                  {!v.show ? <div>
                    ⬇️
                  </div> : <div>
                    ⬆️
                  </div>}
                  {v.label}
                </div>
                {v.show && <div className={this.grids[this.state.grid]}>
                  {v.elements.map((v2, i2) => {
                    return <div onClick={(e) => this.clicked(e, i, i2, v2.selected)} className={v2.selected ? this.classes.selectedButton : this.classes.defaultButton}>
                      <img className="rounded-lg transition-all" alt={v2.label} src={v2.img}></img>
                      <p>{v2.label}</p>
                    </div>
                  })}
                </div>}
              </div>
            })}
            {/* {Array(255).fill().map((v, i) => {
                        return <div onClick={console.log} className="w-fit h-fit hover:scale-75 transition-all">
                            <div className="w-full h-full pointer-events-none">
                                <img alt="hello" src="https://img.gta5-mods.com/q75/images/emperor-stock-car/27cd0b-41.png"></img>
                                {i}
                            </div>
                        </div>
                    })} */}
          </div>
          {this.state.type === 'select' ? <div className="w-full bg-black bg-opacity-40 rounded-lg flex justify-between p-2 gap-4">
            <button onClick={(e) => this.save(e)} className="w-full h-full bg-green-500 rounded-lg hover:bg-opacity-50 transtion-all">Zapisz</button>
            <button onClick={(E) => this.cancel(E)} className="w-full h-full bg-red-500 rounded-lg hover:bg-opacity-50 transition-all">Anuluj</button>
          </div> : <div className="w-full bg-black bg-opacity-40 rounded-lg flex justify-between p-2 gap-4">
            <button onClick={(E) => this.cancel(E)} className="w-full h-full bg-red-500 rounded-lg hover:bg-opacity-50 transition-all">Zamknij</button>
          </div>}
        </div>

      </div>
    </div>
  }
}
