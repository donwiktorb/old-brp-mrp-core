
/*
    Opened: [
        {
            name: 'dwb',
            title: 'dwb,
            align: 'justify-center items-center',
            elements: -> Elements.js
        }
    ]    
*/
import React from 'react'
import sendMessage from '../../Api'

export default class MenuExtra extends React.Component {
  constructor(props) {
    super(props)

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.cancel = this.cancel.bind(this)
    this.submit = this.submit.bind(this)
    this.alignTypes = {
      'left': 'justify-start',
      'right': 'justify-end',
      'center': 'justify-center',
      'middle': 'items-center',
      'top': 'items-start',
      'bottom': 'items-end'
    }

    this.state = {
      show: false,
      title: "x d",
      actions: [
        "accept",
        "cancel"
      ],
      buttons: [
        {
          label: "Spawn",
          type: "spawn",
          color: "green"
        },
        {
          label: "Usuń",
          type: "delete"
        }
      ],
      elements: [
        {
          label: "Sanchez",
          data: [
            'Silnik'
          ],
        }, ...Array(32).fill({ label: "Sanchez" })
      ]
    }
  }

  submit(v, v2) {
    sendMessage('menu_submit', {
      current: v,
      button: v2,
      menu: this.state
    })
  }

  cancel() {
    sendMessage('menu_cancel', {
      current: {},
      menu: this.state
    })
  }

  open(data) {
    this.setState(data)
  }

  close() {
    this.setState({ show: false })
  }

  render() {
    if (!this.state.show) return <div></div>
    else return <div className={`flex relative z-20 w-full h-full items-center justify-center`}>
      <div className="w-1/2 h-1/2 bg-gray-700 rounded-lg bg-opacity-70 flex flex-col">
        <div className="bg-gray-700 w-full h-[10%] rounded-t-lg flex justify-center items-center text-white">
          <div>
            {this.state.title}
          </div>
        </div>

        <div className="bg-green-900 w-full h-[80%] overflow-auto">
          <div className="w-full h-full grid grid-cols-4 place-items-center p-2 gap-4">
            {this.state.elements.map((v) => {
              return <div className="bg-green-700 p-2 w-full h-full rounded-lg text-center flex justify-between flex-col hover:bg-green-500 transition-all relative">
                <div className="text-center text-white">
                  {v.label}
                </div>
                {v.data && v.data.map((v2) => {
                  return <div className="  text-sm  animate-rainbow bg-gradient-to-r bg-clip-text  text-transparent from-yellow-500 via-purple-500 to-orange-500 font-bold ">
                    {v2}
                  </div>
                })}
                <div className="flex justify-center justify-between">
                  {this.state.buttons && this.state.buttons.map((v2) => {
                    return <button className="p-2 text-base font-bold bg-green-900 rounded-lg text-white">
                      {v2.label}
                    </button>
                  })}
                </div>
              </div>
            })}
          </div>
        </div>

        <div className="bg-gray-700 w-full h-[10%] rounded-b-lg p-2 flex gap-4">
          {this.state.actions.map((v) => {
            if (v === "accept") {
              return <button type="cancel" className="animate-rainbow bg-gradient-to-r from-green-400 via-green-600 to-green-800 w-full outline-none slider-thumb rounded-lg appearance-none cursor-pointer" onClick={(e) => this.cancel()}>Akceptuj</button>
            } else {
              return <button type="cancel" className="animate-rainbow bg-gradient-to-r from-red-400 via-red-600 to-red-800 w-full outline-none slider-thumb rounded-lg appearance-none cursor-pointer" onClick={(e) => this.cancel()}>Zamknij</button>
            }
          })}
        </div>
      </div>

    </div>
  }
}
