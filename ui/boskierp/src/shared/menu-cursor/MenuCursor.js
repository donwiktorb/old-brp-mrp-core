import React from "react"
import sendMessage from '../../Api'

export default class MenuCursor extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      display: false,
      name: "dwb",
      title: "DWB",
      elements: [
        {
          label: "HI",
          value: "HI",
          sub: [
            {
              label: "hi2",
              value: "hi2",
              sub: [
                {
                  label: "hi4",
                  value: "hi4",
                  sub: [
                    {
                      label: "hi8",
                      value: "hi8"
                    },
                  ]
                },
                {
                  label: "hi8-nosub",
                  value: "hi8-nosub"
                }
              ]
            },
            {
              label: "hi9",
              value: "hi9",
              sub: [
                {
                  label: "no",
                  value: "no"
                }
              ]
            },
            ...Array(20).fill({ label: "x d", value: "x d2" })
          ]
        },
        {
          label: "HI2",
          value: "HI2"
          // sub: [
          //     {
          //         label: "hi4",
          //         value: "hi4",
          //         sub: [{
          //             label: "hi8",
          //             value: "hi8",
          //             sub: [
          //                 {
          //                     label: "hi8",
          //                     value: "hi8"
          //                 }
          //             ]
          //         }]
          //     }
          // ]
        }
      ]
    }

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.cancel = this.cancel.bind(this)
  }

  isInViewport(element) {
    const rect = element.getBoundingClientRect();
    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
  }

  open(data) {
    this.setState({
      name: data.name,
      display: true,
      title: data.title || this.state.title,
      elements: data.elements || this.state.elements
    }, () => {

      let elem = document.getElementById('mymenu')
      let top = data.x
      let left = data.y


      if (elem) {
        elem.style.top = top + "px"
        elem.style.left = left + "px"
      }

      if (!this.isInViewport(elem)) {
        elem.style.left = left - elem.clientWidth + 'px'
      }

      if (!this.isInViewport(elem)) {
        elem.style.top = top - elem.clientHeight + 'px'
      }

      if (!this.isInViewport(elem)) {
        elem.style.left = left + 'px'
      }

    })
  }

  close() {
    this.setState({ display: false })
  }

  menu(e) {
    e.preventDefault()
    let elem = document.getElementById('mymenu')
    let elem2 = document.getElementsByTagName('ul')
    let elem7 = document.getElementsByTagName('li')
    let lastElem = elem2[elem2.length - 1]

    // let elem2 = document.getElementById('submenu')
    let top = e.clientY
    let left = e.clientX

    if (elem) {
      elem.style.top = top + "px"
      elem.style.left = left + "px"
    }

    for (let v of elem2) {
      if (v.classList.contains('left-full')) {
        v.style.left = '100%'
        v.style.right = 'unset'
        v.firstChild.style.marginLeft = "1rem"
        v.firstChild.style.marginRight = "0px"
        v.firstChild.style.paddingRight = "0px"


        v.style.top = 0
        v.style.bottom = 'unset'


        // v.firstChild.style.marginTop= "-1.5rem"
        // v.firstChild.style.marginBottom = "0px"
        // v.firstChild.style.paddingBottom = "0px"

      }
    }


    if (!this.isInViewport(elem) || !this.isInViewport(lastElem)) {
      elem.style.left = left - elem.clientWidth + 'px'
      for (let v of elem2) {
        if (v.classList.contains('left-full')) {
          v.style.left = 'unset'
          v.style.right = '100%'
          v.firstChild.style.marginLeft = "0px"
          v.firstChild.style.marginRight = "2rem"
          v.firstChild.style.paddingRight = "1rem"


        }
      }
    }

    // if (!this.isInViewport(elem) || !this.isInViewport(lastElem)) {
    //     elem.style.left = left-elem.clientWidth+'px'
    //     for (let v of elem2) {
    //         if (v.classList.contains('left-full')) {
    //             v.style.bottom = 'unset'
    //             v.style.top = '100%'
    //             // v.firstChild.style.marginBottom= "0px"
    //             // v.firstChild.style.marginTop = "2rem"
    //             // v.firstChild.style.paddingTop = "1rem"


    //         }
    //     } 
    //     console.log(this.isInViewport(elem))
    // }

    // if (!this.isInViewport(elem) || !this.isInViewport(lastElem)) {
    //     elem.style.left = left-elem.clientWidth+'px'
    //     for (let v of elem2) {
    //         if (v.classList.contains('left-full')) {
    //             v.style.top = 'unset'
    //             v.style.bottom = '100%'
    //             // v.firstChild.style.marginTop= "0px"
    //             // v.firstChild.style.marginBottom = "2rem"
    //             // v.firstChild.style.paddingBottom = "1rem"


    //         }
    //     } 
    //     console.log(this.isInViewport(elem))
    // }

    if (!this.isInViewport(elem) || !this.isInViewport(lastElem)) {
      elem.style.top = top - elem.clientHeight + 'px'
      for (let v of elem2) {
        if (v.classList.contains('left-full')) {
          v.style.top = 'unset'
          v.style.bottom = 0
          // v.firstChild.style.marginTop= "0px"
          // v.firstChild.style.marginBottom = "2rem"
          // v.firstChild.style.paddingBottom = "1rem"


        }
      }


    }

    if (!this.isInViewport(elem) || !this.isInViewport(lastElem)) {
      elem.style.left = left + 'px'
    }

    // sendMessage('menu_context', {
    //     current: {},
    //     menu: this.state
    // })
  }

  change(e, sub) {
    const { index, subindex, point, part } = e.target.dataset

    let elem = this.state.elements[Number(index)]

    if (subindex) {
      let indexes = subindex.split('-')
      indexes.splice(0, 1)
      for (let idx of indexes) {
        elem = elem.sub[Number(idx)]
      }
    }

    if (elem) {
      sendMessage('menu_change', {
        current: elem,
        menu: this.state,
        sub: sub ? elem.sub[sub] : null
      })
    }
  }

  submit(e, sub) {
    e.preventDefault()
    const { index, subindex, point, part } = e.target.dataset

    let elem = this.state.elements[Number(index)]

    if (subindex) {
      let indexes = subindex.split('-')
      indexes.splice(0, 1)
      for (let idx of indexes) {
        elem = elem.sub[Number(idx)]
      }
    }

    if (elem) {
      sendMessage('menu_submit', {
        current: elem,
        menu: this.state,
        sub: sub ? elem.sub[sub] : null
      })
    }
  }

  cancel(e) {
    let index = Number(e.target.dataset.index)
    let elem = this.state.elements[index]
    sendMessage('menu_cancel', {
      current: elem || {},
      menu: this.state
    })
  }

  getSub(v, menuIndex, subIndex, fixedSub, counter) {
    /* 
        ni - element index (menu)
        ind - nii - submenu id
    */
    let defaultClass = {
      li: 'w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group/itemd',
      ul: 'absolute hidden group-hover/itemd:inline-block left-full w-full'
    }
    let classes = [
      {
        li: 'w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group/item',
        ul: 'absolute hidden group-hover/item:inline-block left-full w-full'
      },
      {
        li: 'w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group/item2',
        ul: 'absolute hidden group-hover/item2:inline-block left-full w-full'
      },
      {
        li: 'w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group/item3',
        ul: 'absolute hidden group-hover/item3:inline-block left-full w-full'
      },
      {
        li: 'w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group/item4',
        ul: 'absolute hidden group-hover/item4:inline-block left-full w-full'
      }
    ]
    let cntr = (counter + 1 || 0)
    let obj = classes[subIndex] || defaultClass
    // console.log(v, ni, ind, p, ip)
    if (!obj) return <div>{subIndex}</div>
    return <li key={'sub-' + menuIndex + '-' + subIndex + '-' + counter} onClick={(e) => this.submit(e)} data-index={menuIndex}
      // data-point={p}
      data-subindex={fixedSub} onMouseOver={(e) => { this.change(e) }} className={obj.li}>
      {v.icon &&
        <img className="w-8 h-7 absolute " fill="currentColor" fillRule="currentColor" src={v.icon} alt={v.label} />
      }
      {v.label}
      <ul className={obj.ul}>
        <li className="mx-4 w-full h-fit text-lg bg-opacity-80 rounded break-words transition-all">
          <ul className="relative grid grid-cols-1 gap-2">
            {v.sub.map((nv, i) => {
              console.log(nv, menuIndex, subIndex, counter)
              if (!nv.sub)
                return <li data-index={menuIndex} data-subindex={`${fixedSub || menuIndex}-${i}`} onChange={(e) => this.submit(e)} onMouseOver={(e) => this.change(e)} key={i} className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">{nv.label}</li>
              else
                return this.getSub(nv, menuIndex, i, `${fixedSub || menuIndex}-${i}`, cntr)
            })}
          </ul>
        </li>
      </ul>
    </li>
  }

  render() {
    if (!this.state.display) return <div></div>

    // return <div className="w-full h-full z-20 absolute">
    //     <div id="contextMenu" className="absolute">
    //     <ul className="relative">
    //         <li className="font-medium">Item 1</li>
    //         <li className="relative font-medium group">Item 2
    //             <ul className="absolute group-hover:inline-block hidden">
    //                 <li className="px-4 py-2">Subitem 2.1</li>
    //                 <li className="px-4 py-2">Subitem 2.2</li>
    //             </ul>
    //         </li>
    //         <li className="relative font-medium group">Item 4
    //             <ul className="absolute group-hover:inline-block hidden">
    //                 <li className="px-4 py-2">Subitem 2.1</li>
    //                 <li className="px-4 py-2">Subitem 2.2</li>
    //             </ul>
    //         </li>
    //     </ul>
    //     </div>
    // </div>
    return <div onContextMenu={(e) => this.menu(e)} className="w-full h-full z-40 relative">
      <div id="mymenu" className="w-64 absolute text-center font-sans grid grid-cols-1 gap-2 select-none">
        <div className="bg-green-400 text-lg w-64 bg-opacity-80 rounded truncate">
          {this.state.title}
        </div>


        <ul className="relative grid grid-cols-1 gap-2">

          {this.state.elements.map((v, i) => {
            if (!v.sub)
              return <li onClick={(e) => this.submit(e)} onMouseOver={(e) => this.change(e)} data-index={i} key={i} className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative">
                {v.icon &&
                  <img className="w-8 h-7 absolute " fill="currentColor" fillRule="currentColor" src={v.icon} alt={v.label} />
                }
                {v.label}
              </li>
            else
              return this.getSub(v, i)


          })}
          {/* <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all">Item 1</li>
                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 2
                        <ul className="absolute hidden group-hover:inline-block left-full w-full">
                            <li className="mx-4 w-full h-fit text-lg bg-opacity-80 rounded break-words transition-all">
                                <ul className="relative grid grid-cols-1 gap-2">
                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 4</li>
                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group/item">Item 4
                                        <ul className="absolute hidden group-hover/item:inline-block left-full w-full">
                                            <li className="mx-4 w-full h-fit text-lg bg-opacity-80 rounded break-words transition-all">
                                                <ul className="relative grid grid-cols-1 gap-2">
                                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 4</li>
                                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 4</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li> */}
        </ul>
        {/* 
                <ul className="relative grid grid-cols-1 gap-2">
                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all">Item 1</li>
                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 2
                        <ul className="absolute hidden group-hover:inline-block left-full w-full">
                            <li className="mx-4 w-full h-fit text-lg bg-opacity-80 rounded break-words transition-all">
                                <ul className="relative grid grid-cols-1 gap-2">
                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 4</li>
                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group/item">Item 4
                                        <ul className="absolute hidden group-hover/item:inline-block left-full w-full">
                                            <li className="mx-4 w-full h-fit text-lg bg-opacity-80 rounded break-words transition-all">
                                                <ul className="relative grid grid-cols-1 gap-2">
                                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 4</li>
                                                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 4</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li className="w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all relative group">Item 4
                        <ul className="absolute group-hover:inline-block hidden">
                            <li className="px-4 py-2">Subitem 2.1</li>
                            <li className="px-4 py-2">Subitem 2.2</li>
                        </ul>
                    </li>
                </ul> */}
        {/* 
                <div className="flex w-full h-full">
                    
                    <div className=" bg-black w-64 h-64 flex transition-all peer">
                    </div> 

                    <div className="peer-hover:flex bg-blue-500 w-max h-max hover:flex z-40 hidden">
                        <div className="flex w-full h-full">
                            <div className=" bg-green-500 w-64 h-64 flex transition-all peer">
                            </div> 

                            <div className="peer-hover:flex bg-black w-max h-max hover:flex z-40 hidden">

                                <div className="flex w-full h-full">
                                    <div className=" bg-blue-500 w-64 h-64 flex transition-all peer">
                                    </div> 

                                    <div className="peer-hover:flex bg-orange-500 hover:flex w-64 h-64 z-40 hidden">

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    
                </div>
                 */}
        <div onClick={(e) => this.cancel(e)} className="bg-green-400 w-64 text-lg bg-opacity-80 rounded truncate">
          Zamknij
        </div>
      </div>
    </div>
    // return <div onContextMenu={(e) => this.menu(e)} className="w-full h-full relative z-20">
    //     <div id="mymenu" className="w-64 absolute text-center overflow-hidden font-sans grid grid-cols-1 gap-2 select-none">
    //         <div className="bg-green-400 text-lg bg-opacity-80 rounded truncate">
    //             {this.state.title}
    //         </div>
    //         {this.state.elements.map((v,i ) => {
    //             return <div className="w-full h-full flex">
    //                 <div onClick={(e)=>this.submit(e)} onMouseOver={(e) => this.change(e)} data-index={i} className={`peer w-full h-fit bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all grow`} dangerouslySetInnerHTML={{__html: v.label}}/>
    //                 {v.sub && <div className={` peer-hover:flex hover:flex flex-col w-full h-full gap-4 justify-center items-center transition-all hidden float-right`}>
    //                     {v.sub.map((nv, ni) => {
    //                         return <div onClick={(e)=>this.submit(e, ni)} onMouseOver={(e) => this.change(e, ni)} data-index={i} className={`bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all h-fit`} dangerouslySetInnerHTML={{__html: nv.sub ? nv.label + ">" : nv.label}}/>
    //                     })}
    //                 </div>}
    //             </div>
    //         })}
    //         <div onClick={(e) => this.cancel(e)} className="bg-green-400 text-lg bg-opacity-80 rounded truncate">
    //             Zamknij
    //         </div>
    //     </div>
    // </div>
    // return <div onContextMenu={(e) => this.menu(e)} className="w-full h-full relative z-20">
    //     <div id="mymenu" className="w-64 absolute text-center overflow-hidden font-sans grid grid-cols-1 gap-2 select-none">
    //         <div className="bg-green-400 text-lg bg-opacity-80 rounded truncate">
    //             {this.state.title}
    //         </div>
    //         {this.state.elements.map((v,i ) => {
    //             return <div className="w-full h-full ">
    //                 <div onClick={(e)=>this.submit(e)} onMouseOver={(e) => this.change(e)} data-index={i} className={`peer bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all grow`} dangerouslySetInnerHTML={{__html: v.label}}/>
    //                 {v.sub && <div className={` peer-hover:flex hover:flex w-full h-full gap-4 justify-center items-center transition-all hidden pb-4 px-4`}>
    //                     {v.sub.map((nv, ni) => {
    //                         return <div onClick={(e)=>this.submit(e, ni)} onMouseOver={(e) => this.change(e, ni)} data-index={i} className={`bg-green-600 text-lg bg-opacity-80 rounded break-words hover:bg-green-300 transition-all grow h-fit`} dangerouslySetInnerHTML={{__html: nv.sub ? nv.label + ">" : nv.label}}/>
    //                     })}
    //                 </div>}
    //             </div>
    //         })}
    //         <div onClick={(e) => this.cancel(e)} className="bg-green-400 text-lg bg-opacity-80 rounded truncate">
    //             Zamknij
    //         </div>
    //     </div>
    // </div>
  }
}
