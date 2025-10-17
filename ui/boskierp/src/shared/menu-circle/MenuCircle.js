import React from 'react'
import sendMessage from '../../Api'

export default class MenuCircle extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      Menus: [
        // {
        //     title: "BoskieRP",
        //     name: 'dwb_menu',
        //     Elements: [
        //         {
        //             label: 'siea',
        //             value: 'siea'
        //         },
        //         {
        //             label: 'siea',
        //             value: 'siea'
        //         },
        //         {
        //             label: 'siea',
        //             value: 'siea'
        //         },
        //         {
        //             label: 'siea',
        //             value: 'siea'
        //         }
        //     ]
        // }
      ]
    }
    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
  }

  open(data) {
    this.setState(state => {
      const Menus = [data, ...state.Menus]

      return {
        Menus
      }
    })
  }

  close(data) {
    this.setState(state => {
      const Menus = state.Menus

      Menus.forEach((v, i) => {
        if (v.name === data.name) {
          Menus.splice(i, 1)
        }
      })

      return {
        Menus
      }
    })
  }


  componentDidMount() {
    let items = document.querySelectorAll('#circle button');

    for (var i = 0, l = items.length; i < l; i++) {
      items[i].style.left = (35 - 35 * Math.cos(-0.5 * Math.PI - 2 * (1 / l) * i * Math.PI)).toFixed(4) + "%";
      items[i].style.top = (35 + 35 * Math.sin(-0.5 * Math.PI - 2 * (1 / l) * i * Math.PI)).toFixed(4) + "%";
    }
  }

  onHover(e) {
    e.preventDefault()
    sendMessage('menu_change', {
      current: this.state.Menus[0].Elements[e.target.key],
      menu: this.state.Menus[0]
    })
  }

  onClick(e) {
    e.preventDefault()
    sendMessage('menu_submit', {
      current: this.state.Menus[0].Elements[e.target.key],
      menu: this.state.Menus[0]
    })
  }

  getElements() {
    return <div id="circle" className="">
      {this.state.Menus[0].Elements.map((v, i) => {
        return <button key={i} onHover={this.onHover} onClick={this.onClick} className="bg-black hover:bg-green-400 hover:text-black text-green-400 opacity-80 p-2 break-all text-center rounded-[50%] w-1/4 h-1/4 block absolute" href="/">{v.label}</button>
      })}
    </div>
  }

  render() {
    if (this.state.Menus.length <= 0)
      return <div></div>
    else
      return <div className="flex h-screen justify-center items-center z-20">
        <button className="bg-black h-20 w-20 border-2 border-green-200 text-green-200 opacity-80 -ml-4 -mt-4 break-all text-center rounded-[50%] block absolute ">BoskieRP</button>
        <div id="circular-menu" className="w-80 h-80 relative ">
          {this.getElements()}
        </div>
      </div>
  }
}
