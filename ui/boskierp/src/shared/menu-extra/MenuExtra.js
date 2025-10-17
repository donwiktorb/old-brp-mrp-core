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
import './extra.css'
import React from 'react'
import Elements from './Elements'
import ExtraElements from './ExtraElements'
import sendMessage from '../../Api'

export default class MenuExtra extends React.Component {
  constructor(props) {
    super(props)

    this.alignTypes = {
      'left': 'justify-start',
      'right': 'justify-end',
      'center': 'justify-center',
      'middle': 'items-center',
      'top': 'items-start',
      'bottom': 'items-end'
    }

    this.state = {
      opened: [
        // {
        //     name: 'dwb',
        //     title: 'dwb',
        //     align: 'justify-end items-center',
        //     extraElements: [
        //         {
        //             label: 'hi',
        //             value: 2,
        //             max: 200,
        //             min: 1,
        //             step:1,
        //             type: 'slider'
        //         },
        //         {
        //             label: 'hi',
        //             value: 2,
        //             disableNumber: true,
        //             description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //             max: 10,
        //             min: -1,
        //             step:1,
        //             type: 'slider'
        //         }
        //     ],
        //     elements: [
        //         {
        //             label: 'hi',
        //             value: 2,
        //             max: 200,
        //             min: 1,
        //             step:1,
        //             type: 'slider'
        //         },
        //          {
        //             label: 'hi',
        //             description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //             value: 2
        //         },
        //         {
        //             label: 'hi',
        //             description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //             value: 2
        //         },    {
        //             label: 'hi',
        //             description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //             value: 2
        //         },
        //         {
        //             label: 'hi',
        //             description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //             value: 2
        //         },

        //         {
        //             label: 'hi',
        //             value: 2,

        //             description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //             max: 10,
        //             min: -1,
        //             step:1,
        //             type: 'slider'
        //         }
        //     ]
        // }
      ],
      active: 0
    }

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.cancel = this.cancel.bind(this)
    this.submit = this.submit.bind(this)
  }

  changeElements(elements) {
    this.setState(state => {
      const opened = state.opened
      opened[0].elements = elements
      return {
        opened
      }
    })
  }

  cancel() {
    let menu = this.state.opened[0]
    let selected = this.Elements.getSelected()
    // this.close(menu.name) 
    sendMessage('menu_cancel', {
      current: selected,
      menu: menu
    })
  }

  submit() {
    let selected = this.Elements.getSelected()
    sendMessage('menu_submit', {
      current: selected,
      menu: this.state.opened[0]
    })
  }

  menuChanged(selected, type) {
    sendMessage('menu_change', {
      current: selected,
      menu: this.state.opened[0],
      type: type
    })
  }

  getAlign(align) {
    let newAlign = ''

    if (align.includes('-')) align = align.split('-')
    else newAlign = this.alignTypes[align] + ' items-center'

    if (newAlign === '')
      for (let val of align) {
        let newAl = this.alignTypes[val]
        if (newAl) newAlign += newAl + ' '
      }
    return newAlign
  }

  close(data) {
    this.setState(state => {
      const opened = state.opened

      for (let menu of opened) {
        if (menu.name === data.name) {
          this.Elements.clear()
          let number = opened.indexOf(menu)
          opened.splice(number, 1)
        }
      }

      return {
        opened
      }
    })
  }

  open(data) {
    let { title, name, align, elements, extraElements, update, oldupdate } = data

    if (!update && !oldupdate) {
      let fixedAlign = this.getAlign(align)
      let menu = {
        name: name,
        title: title,
        align: fixedAlign,
        elements: elements,
        extraElements: extraElements
      }
      // this.Elements.set(elements)
      this.setState(state => {
        const opened = [menu, ...state.opened]
        return {
          opened
        }
      })
    } else {
      if (oldupdate) {
        this.setState((state) => {
          const opened = state.opened
          opened.forEach((v) => {
            if (v.name === name) {
              let key = data.key
              let value = data.value
              let updates = data.data
              v.elements.forEach((nv) => {
                if (nv[key] === value) {
                  for (let u in updates) {
                    let uv = updates[u]
                    nv[u] = uv
                  }
                }
              })
            }
          })
          return {
            opened
          }
        })
      } else if (name === this.state.opened[0].name) {
        this.setState((state) => {
          const opened = state.opened
          if (title) opened[0].title = title
          if (elements) opened[0].elements = elements

          return {
            opened
          }
        })
      } else {
        this.setState(state => {
          const opened = state.opened
          opened.forEach((v) => {
            if (v.name === name) {
              if (title) v.title = title
              if (elements) v.elements = elements
            }
          })
          return {
            opened
          }
        })
      }
    }
  }

  render() {
    return (
      <div style={{ display: this.state.opened.length > 0 ? '' : 'none' }} className={`flex relative z-20 h-screen ${this.state.opened[this.state.active]?.align}`} >
        <div className="m-6 w-1/5 max-h-96 text-center font-sans rounded-lg bg-black bg-opacity-80">
          <div className="flex justify-center items-center">
            <div className="min-w-full flex flex-col max-h-96">

              <div id="nav" className="w-full rounded-t-lg bg-green-400">
                <div dangerouslySetInnerHTML={{ __html: this.state.opened[this.state.active]?.title }}></div>
              </div>

              <div className="overflow-auto h-full text-green-400 animate-fade text-lg" >
                <Elements submit={() => this.submit()} menuChanged={(selected) => this.menuChanged(selected)} onSubmit={(selected) => this.menuChanged(selected, 'submit')} elements={this.state.opened[this.state.active]?.elements} ref={ref => (this.Elements = ref)} />
              </div>
            </div>
          </div>
          <div className="text-green-800">
            <ExtraElements menuChanged={(selected) => this.menuChanged(selected, 'extra')} elements={this.state.opened[this.state.active]?.extraElements} ref={ref => (this.ExtraElements = ref)} />
          </div>
          <div className="grid grid-cols-2 gap-4 my-4">
            <button type="submit" className=" bg-green-400 outline-none slider-thumb rounded-lg appearance-none cursor-pointer" onClick={(e) => this.submit()}>Akceptuj</button>
            <button type="cancel" className=" bg-red-400 outline-none slider-thumb rounded-lg appearance-none cursor-pointer" onClick={(e) => this.cancel()}>Anuluj</button>
          </div>
        </div>
      </div>

    );
  }
}
