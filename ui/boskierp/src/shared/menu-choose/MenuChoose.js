
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
      name: 'dwb',
      title: 'dwb',
      align: 'justify-center items-center',
      elements: [
        // {
        //     label: 'hi',
        //     value: 2,
        //     max: 200,
        //     min: 1,
        //     step: 1,
        //     type: 'slider'
        // },
        // {
        //     label: 'hi',
        //     description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //     value: 2
        // },
        // {
        //     label: 'hi',
        //     description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //     value: 2
        // }, {
        //     label: 'hi',
        //     description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //     value: 2
        // },
        // {
        //     label: 'hi',
        //     description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //     value: 2
        // },

        // {
        //     label: 'hi',
        //     value: 2,

        //     description: "HHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essaHi to służy do czeogs napewno essai to służy do czeogs napewno essa",
        //     max: 10,
        //     min: -1,
        //     step: 1,
        //     type: 'slider'
        // }
        [
          {
            label: "Emperor",
            value: "emperor",
            img: "https://static.wikia.nocookie.net/gtawiki/images/4/4c/Emperor-GTAV-front.png",
            data: [
              '200$'
            ]
          },
          {
            label: "Cheburek",
            value: "cheburek",
            img: "https://static.wikia.nocookie.net/gtawiki/images/8/8e/Cheburek-GTAO-front.png",
            data: [
              '200$'
            ]
          },
          {
            label: "Panto",
            value: "panto",
            img: "https://static.wikia.nocookie.net/gtawiki/images/a/ad/Panto-GTAV-front.png",
            data: [
              '200$'
            ]
          },
          {
            label: "Blista Compact",
            value: "blista2",
            img: "https://static.wikia.nocookie.net/gtawiki/images/0/06/BlistaCompact-GTAV-front.png",
            data: [
              '200$'
            ]
          }
        ],
        [
          {
            label: "Woda",
            value: "water",
            item: "water",
            img: "https://static.wikia.nocookie.net/gtawiki/images/4/4c/Emperor-GTAV-front.png",
            data: [
              '200$'
            ]
          },
          {
            label: "Wódka",
            value: "vodka",
            item: "vodka,",
            img: "https://static.wikia.nocookie.net/gtawiki/images/8/8e/Cheburek-GTAO-front.png",
            data: [
              '200$'
            ]
          },
          {
            label: "Energetyk",
            value: "energetic",
            item: "energetic",
            img: "https://static.wikia.nocookie.net/gtawiki/images/a/ad/Panto-GTAV-front.png",
            data: [
              '200$'
            ]
          },
          {
            label: "Cola",
            value: "cola",
            item: "cola",
            img: "https://static.wikia.nocookie.net/gtawiki/images/0/06/BlistaCompact-GTAV-front.png",
            data: [
              '200$'
            ]
          }
        ]
        // ...Array(3).fill().map(() => {
        //     let v = {}
        //     v.label = Math.random()
        //     v.item = 'water'
        //     v.data = [
        //         `Cena: ${Math.random()}`
        //     ]
        //     return v
        // })
      ],
      page: 0,
      items: 4,
      data: [
        {
          label: "Hajs",
          value: "4000$"
        }
      ]
    }
    this.chosen = []
    this.grids = [
      'grid grid-cols-1 gap-4',
      'grid grid-cols-2 gap-4',
      'grid grid-cols-3 gap-4',
      'grid grid-cols-4 gap-4'
    ]
    this.close = this.close.bind(this)
    this.open = this.open.bind(this)
  }


  componentDidMount() {
    this.setState({
      grid: this.grids[this.state.items - 1]
    })
  }

  accept = (e, v) => {
    this.chosen = this.chosen.filter((v) => v.page !== this.state.page)
    v.page = this.state.page
    this.chosen.push(v)
  }

  submit = (e, v) => {
    e.preventDefault()
    sendMessage('menu_submit', {
      current: v,
      menu: this.state
    })
    // let menus = this.state.menus
    // menus.splice(this.state.menus.length-1, 1)
    // this.setState({menus:menus})

  }

  back() {
    sendMessage('menu_cancel', {
      menu: this.state
    })

    let newPage = this.state.page - 1
    if (this.state.elements[newPage])
      this.setState({ page: this.state.page - 1 })
  }

  skip() {
    sendMessage('menu_change', {
      menu: this.state
    });
    let newPage = this.state.page + 1
    if (this.state.elements[newPage])
      this.setState({ page: this.state.page + 1 })
  }

  open(data) {
    data.grid = this.grids[data.items - 1]
    this.setState(data)
  }

  close() {
    this.setState({ show: false })
  }

  render() {
    if (!this.state.show) return <div></div>
    return (
      <div className={`flex relative z-20 h-screen ${this.state?.align}`} >
        <div className="m-6 w-2/5 h-96 flex flex-col text-center font-sans rounded-lg bg-black bg-opacity-80">
          <div className="flex justify-center items-center h-full">
            <div className="min-w-full flex flex-col h-full p-2">
              <div id="nav" className="w-full rounded-t-lg from-green-400 via-green-800 to-green-400 bg-gradient-to-r animate-rainbow text-white font-bold text-lg">
                <div dangerouslySetInnerHTML={{ __html: this.state?.title }}></div>
              </div>

              <div className="overflow-auto h-full text-green-400 animate-fade text-lg p-2" >
                <div className={this.state.grid}>
                  {this.state.elements[this.state.page].map((v, i) => {
                    return <div onClick={(e) => this.accept(e, v, i)} className="hover:bg-green-800 transition-colors select-none rounded-lg justify-center items-center flex flex-col">
                      <img
                        draggable="false"
                        className=" rounded-lg
                                                                select-none
                                                                object-scale-down
                                                                object-center
                                                                w-full h-full
                                                                p-2
                                                                "
                        src={v.item ? `${process.env.PUBLIC_URL}/img/${v.item}.png` : v.img}
                        alt={v.label}
                      />
                      <div>
                        {v.label}
                      </div>
                      <div className="  text-sm  animate-rainbow
                                        bg-gradient-to-r bg-clip-text  text-transparent 
            from-yellow-500 via-purple-500 to-orange-500 font-bold
                                        ">
                        {v.data && v.data.map((v2) => {
                          return <div>
                            {v2}
                          </div>
                        })}
                      </div>
                    </div>
                  })}
                </div>
              </div>
            </div>
          </div>

          <div className="w-full h-full p-2 text-white flex gap-4 justify-center">
            {this.state.data.map((v) => {
              return <div className="bg-blue-500 rounded-lg p-2 w-full">
                <div className="text-lg font-semibold">
                  {v.label}
                </div>
                <div>
                  {v.value}
                </div>
              </div>
            })}

          </div>

          <div className="w-full h-full p-2 flex justify-between gap-4">
            {this.state.page > 0 &&
              <button type="cancel" className="animate-rainbow bg-gradient-to-r from-green-400 via-green-600 to-green-800 w-full outline-none slider-thumb rounded-lg appearance-none cursor-pointer text-white" onClick={(e) => this.back(e)}>Powrót</button>
            }
            {this.state.page + 1 < this.state.elements.length ?
              <button type="cancel" className="animate-rainbow bg-gradient-to-r from-red-400 via-red-600 to-red-800 w-full outline-none slider-thumb rounded-lg appearance-none cursor-pointer text-white" onClick={(e) => this.skip(e)}>Następna</button> :
              <button type="cancel" className="animate-rainbow bg-gradient-to-r from-red-400 via-red-600 to-red-800 w-full outline-none slider-thumb rounded-lg appearance-none cursor-pointer text-white" onClick={(e) => this.submit(e)}>Akceptuj</button>
            }
          </div>
        </div>
      </div>

    );
  }
}
