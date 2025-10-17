

import React from "react";
import sendMessage from '../../Api'

export default class MenuSide extends React.Component {
  constructor(props) {
    super(props);

    this.sides = {
      right: "w-full z-20 absolute h-full flex justify-end items-center text-white",
      left: "w-full z-20 absolute h-full flex justify-start items-center text-white",
      center: "w-full z-20 absolute h-full flex justify-center items-center text-white"
    }

    this.categories = {
      2: "grid-cols-2 gap-4 justify-items-center peer-checked:grid hidden",
      3: "grid-cols-3 gap-4 justify-items-center peer-checked:grid hidden",
      4: "grid-cols-2 gap-4 justify-items-center content-center peer-checked:grid grid",
      5: "gap-4 flex h-full flex-col items-center justify-center",
    }

    this.main = {
      0: "overflow-y-scroll overflow-x-hidden flex flex-col justify-between gap-4 p-2 w-full h-full",
      2: "overflow-y-scroll overflow-x-hidden grid grid-cols-2 gap-4 p-2",
      3: "overflow-y-scroll overflow-x-hidden grid grid-cols-3 gap-4 p-2"
    }

    this.state = {
      show: false,
      title: "Menu",
      type: "pages",
      // messages: [
      //     {
      //         type: "info",
      //         label: "Cena",
      //         content: "Aktualna cena to "
      //     }
      // ],
      pages: [
        [
          {
            inline: true,
            category: 4,
            name: "Custom",
            label: "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            checked: true,
            img: "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/gettyimages-636854346-b77d32f44cbe0b6103225fb7d93778fd.jpg",
            elements: [
              {
                type: "radio",
                name: "xd55",
                value: "xd5",
                label: "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach"
              },
              {
                type: "radio",
                name: "xd55",
                value: "xd55",
                label: "Oznaczają ograniczenie prędkości do 80mph "
              },
              {
                type: "radio",
                name: "xd55",
                value: "xd555",
                label: "Oznaczają ograniczenie prędkości do 50mph "
              },
              {
                type: "radio",
                name: "xd55",
                value: "xd5555",
                label: "Rozdzielają pasy ruchu prowadzące w tym samym kierunku "
              },
              // {
              //     type: "checkbox",
              //     name: "xd2 asdadasdadasdsadasd",
              //     label: "MP_Bea_F_Stom_002"
              // },

            ]
          },
        ],

        [
          {
            inline: true,
            category: 4,
            name: "Custom5",
            label: "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
            checked: true,
            img: "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/gettyimages-636854346-b77d32f44cbe0b6103225fb7d93778fd.jpg",
            elements: [
              {
                type: "radio",
                name: "xd55",
                value: "xd555555",
                label: "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach"
              },
              {
                type: "radio",
                name: "xd55",
                value: "xd55555555",
                label: "Oznaczają ograniczenie prędkości do 80mph "
              },
              {
                type: "radio",
                name: "xd55",
                value: "xd555555555",
                label: "Oznaczają ograniczenie prędkości do 50mph "
              },
              {
                type: "radio",
                name: "xd55",
                value: "xd555555557",
                label: "Rozdzielają pasy ruchu prowadzące w tym samym kierunku "
              },
              // {
              //     type: "checkbox",
              //     name: "xd2 asdadasdadasdsadasd",
              //     label: "MP_Bea_F_Stom_002"
              // },

            ]
          },
        ],
      ],
      elements: [
        // {
        //     type: "textarea",
        //     name: "xd",
        //     label: "X d"
        // },
        // {
        //     type: "select",
        //     options: [
        //         {
        //             label: "hello",
        //             value:" x d"
        //         },
        //         {
        //             label: "hello2",
        //             value:" x d2"
        //         }
        //     ],
        //     name: "xd",
        //     label: "X d"
        // },
        // {
        //     type: "input",
        //     name: "xd2",
        //     label: "X d2"
        // },
        // {
        //     type: "button",
        //     name: "xd2",
        //     label: "X d2"
        // },
        // {
        //     type: "color",
        //     name: "xd2",
        //     label: "X d2"
        // },
        {
          inline: true,
          category: 4,
          name: "Custom",
          label: "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach",
          checked: true,
          img: "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/gettyimages-636854346-b77d32f44cbe0b6103225fb7d93778fd.jpg",
          elements: [
            {
              type: "radio",
              name: "xd55",
              value: "xd5",
              label: "Rozdzielają pasy ruchu biegnące w przeciwnych kierunkach"
            },
            {
              type: "radio",
              name: "xd55",
              value: "xd55",
              label: "Oznaczają ograniczenie prędkości do 80mph "
            },
            {
              type: "radio",
              name: "xd55",
              value: "xd555",
              label: "Oznaczają ograniczenie prędkości do 50mph "
            },
            {
              type: "radio",
              name: "xd55",
              value: "xd5555",
              label: "Rozdzielają pasy ruchu prowadzące w tym samym kierunku "
            },
            // {
            //     type: "checkbox",
            //     name: "xd2 asdadasdadasdsadasd",
            //     label: "MP_Bea_F_Stom_002"
            // },

          ]
        },
        //         {
        //             type: "checkbox",
        //             name: "xd2 asdadasdadasdsadasd",
        //             label: "MP_Bea_F_Stom_002"
        //         },

        // {
        //     type: "radio",
        //     name: "radio",
        //     label: "Radio"
        // },
        // {
        //     type: "radio",
        //     name: "radio",
        //     label: "Radio"
        // },

        // {
        //     type: "checkbox",
        //     name: "checkbox",
        //     label: "Checkbox"
        // },
        // {
        //     type: "number",
        //     name: "checkbox",
        //     label: "Checkbox",
        //     min: 0,
        //     max: 2
        // },
        // // ...Array(22).fill({
        // //     type: "input",
        // //     name: "x d",
        // //     label: " x d"
        // // })
      ],
      side: "center",
      main: 0,
      currentPage: 0,
      pageLabels: [
        'Co oznaczają żółte linie w oznakowaniu poziomym?',
        'x d'
      ],
    };
    this.close = this.close.bind(this)
    this.open = this.open.bind(this)
    this.updatePageElement = this.updatePageElement.bind(this)
    this.updateMessage = this.updateMessage.bind(this)
  }

  // // componentDidMount() {
  // //     setTimeout(() => {
  // //         this.updatePageElement(1, 2, {
  // //             options: [
  // //                 {
  // //                     label: "X d",
  // //                     value:" x d"
  // //                 }
  // //             ]
  // //         })
  // //     }, 5000)
  // // }

  open(data) {
    if (data.pages) {
      data.elements = data.pages[data.currentPage || 0]
      data.currentPage = data.currentPage || 0
    }
    if (!data.update)
      this.setState(data)
    else
      this.setState({ ...this.state, ...data })
  }

  close(data) {
    this.setState({
      show: false
    })
  }

  updatePageElement({ pageId, elementId, data }) {
    this.setState((state) => {
      const elements = state.elements
      const pages = state.pages
      pages[pageId][elementId] = { ...pages[pageId][elementId], ...data }
      console.log(pages[pageId][elementId])
      if (this.state.currentPage === pageId) {
        elements[elementId] = { ...elements[elementId], ...data }
        return {
          elements,
          pages
        }
      } else {
        return { pages }
      }
    })
  }

  updateMessage({ messageId, data }) {
    this.setState((state) => {
      const messages = state.messages
      messages[messageId] = data
      return { messages }
    })
  }

  compToHex(c) {
    let hex = c.toString(16)
    return hex.length === 1 ? "0" + hex : hex
  }

  rgbToHex(rgb) {
    if (!rgb) return
    return `#${this.compToHex(rgb.r) + this.compToHex(rgb.g) + this.compToHex(rgb.g)}`
  }

  hexToRgb(hex) {
    let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
      r: parseInt(result[1], 16),
      g: parseInt(result[2], 16),
      b: parseInt(result[3], 16)
    } : null;
  }

  change(e, v, i, ni) {
    let { target } = e
    console.log(e)
    this.setState((state) => {
      const elements = state.elements
      let pages = state.pages
      const element = ni ? elements[i].elements[ni] : elements[i]
      if (element.firstValue === undefined)
        element.firstValue = (element.type === 'select') ? v.options[Number(element.value)] : element.value
      if (element.firstValue === undefined && element.type === 'checkbox')
        element.firstValue = false
      if (element.firstIndexValue === undefined) {
        element.firstIndexValue = Number(element.value > 0 ? element.value : 0)
      }

      console.log(element)
      element.value = (element.type === 'checkbox') ? target.checked : (element.type === 'color') ? this.hexToRgb(target.value) : (element.type === 'select') ? v.options[Number(target.value)] : target.value

      console.log(target.value)

      if (element.type === 'radio' && ni) {
        elements[i].value = element.value
      }

      element.lastIndexValue = Number(element.indexValue || 0)
      element.indexValue = Number(target.value)

      let change = element.change || 'uknown'

      if (element.type === 'color' && element.firstValue) {
        if (change === 'new' || change === 'same') {
          if (element.value.r === element.firstValue.r && element.value.g === element.firstValue.g && element.value.b === element.firstValue.b) {
            change = 'back'
          } else {
            change = 'same'
          }
        } else if (change === 'back') {
          if (element.value.r !== element.firstValue.r && element.value.g !== element.firstValue.g && element.value.b !== element.firstValue.b) {
            change = 'new'
          }
        } else if (change === 'uknown') {
          if (element.value.r !== element.firstValue.r && element.value.g !== element.firstValue.g && element.value.b !== element.firstValue.b) {
            change = 'new'
          }
        }
      } else if (element.type === 'select' && element.firstIndexValue !== undefined) {
        if (change === 'new' || change === 'same') {
          if (element.firstIndexValue === element.indexValue) {
            change = 'back'
          } else {
            change = 'same'
          }
        } else if (change === 'back') {
          if (element.firstIndexValue !== element.indexValue) {
            change = 'new'
          }
        } else if (change === 'uknown') {
          if (element.firstIndexValue !== element.indexValue) {
            change = 'new'
          }
        }
      }

      element.change = change

      // not good idea to send each change so maybe {name :this.state.name}
      if (pages) {
        pages[state.currentPage] = elements
      }
      // // console.log({
      // //     current: element,
      // //     menu: state,
      // //     category: ni && elements[i],
      // //     pages: pages
      // // })
      sendMessage('menu_change', {
        current: element,
        menu: state,
        category: ni && elements[i],
        pages: pages
      })
      return {
        elements,
        pages
      }
    })
  }

  cancel(e) {
    e.preventDefault()
    let pages = this.state.pages
    if (pages) {
      pages[this.state.currentPage] = this.state.elements
    }

    sendMessage('menu_cancel', {
      current: e.target.value,
      menu: this.state,
      pages: pages
    })
  }

  submit(e) {
    e.preventDefault()
    let pages = this.state.pages
    if (pages) {
      pages[this.state.currentPage] = this.state.elements
    }
    sendMessage('menu_submit', {
      current: e.target.value,
      menu: this.state,
      pages: pages
    })
  }

  getItem(v, i, ni) {
    let itemId = ni ? `${v.type}-${i}-${ni}` : `${v.type}-${i}`
    switch (v.type) {
      case 'textarea': {
        return <textarea required={v.required} onChange={(e) => this.change(e, v, i, ni)} placeholder={v.label} type="text" className="w-full h-auto p-2 bg-gray-900 rounded-lg" />
      }
      case 'select': {
        return <div className="flex gap-2 items-center flex-col justify-center">
          <label className="w-full text-center truncate" for={v.name}>{v.label}</label>
          <select required={v.required} onChange={(e) => this.change(e, v, i, ni)} type="text" className="w-full h-auto p-2 bg-gray-900 rounded-lg" name={v.name} defaultValue={v.indexValue || v.value} id={v.name} >
            {v.options.map((nv2, ni2) => {
              return <option value={ni2}>
                {nv2.label}
              </option>
            })}
          </select>
        </div>
      }
      case 'input': {
        return <input onChange={(e) => this.change(e, v, i, ni)} placeholder={v.label} className="bg-gray-900 rounded-lg p-2 w-full" type="text" />
      }
      case 'date': {
        return <div className="flex gap-2 items-center w-full">
          <input required={v.required} onChange={(e) => this.change(e, v, i, ni)} className="bg-gray-900 rounded-lg p-2 w-full" type="date" name={v.name} value={v.value} min={v.min} max={v.max} id={v.name} />
          <label className="w-full break-words" for={v.name}>{v.label}</label>
        </div>
      }
      case 'radio': {
        let elem = this.state.elements[i]
        console.log(elem)
        return <div className="flex gap-2 items-center w-full" >
          <input required={v.required} onChange={(e) => this.change(e, v, i, ni)} className="appearance-none bg-gray-900 border-gray-900 checked:bg-gray-500 border-2 w-4 h-4 rounded-lg" type="radio" name={v.name} id={v.value} value={v.value} checked={v.value === elem.value} />
          <label className="w-full break-words" for={v.value}>{v.label}</label>
        </div>
      }
      case 'button': {
        return <div className="flex gap-2 items-center">
          <button onClick={(e) => this.change(e, v, i, ni)} className="appearance-none bg-gray-900 border-gray-900 checked:bg-gray-500 border-2 p-0.5 rounded-lg w-full" name={v.name} >{v.label}</button>
        </div>
      }
      case 'color': {
        return <div className="flex gap-2 items-center w-full">
          <input required={v.required} defaultValue={v.value && v.value.b && this.rgbToHex(v.value)} onChange={(e) => this.change(e, v, i, ni)} className="appearance-none bg-gray-900 border-gray-900 checked:bg-gray-500 border-2 w-5 h-5 rounded" type="color" id={`color-${i}`} name={v.name} />
          <label for={`color-${i}`}>{v.label}</label>
        </div>
      }
      case 'checkbox': {
        return <div className="flex gap-2 items-center w-full">
          <input required={v.required} onChange={(e) => this.change(e, v, i, ni)} defaultChecked={v.value} className="appearance-none bg-gray-900 border-gray-900 checked:bg-gray-500 border-2 w-4 h-4 rounded" type="checkbox" id={`checkbox-${i}`} name={v.name} />
          <label className="w-full" for={v.name}>{v.label}</label>
        </div>
      }
      case 'number': {
        return <div className="flex gap-2 items-center">
          <input required={v.required} onChange={(e) => this.change(e, v, i, ni)} className="appearance-none text-center bg-gray-900 border-gray-900 border-2 w-14 h-7 rounded out-of-range:text-red-500" type="number" name={v.name} min={v.min} max={v.max} defaultValue={v.value} id={v.name} />
          <label className="text-ellipsis w-20" for={v.name}>{v.label}</label>
        </div>
      }
      default: break
    }
  }

  // // static getDerivedStateFromProps(props, state) {
  // //     // Czy dodajemy nowe pozycje do listy?
  // //     // Przechowajmy pozycję scrolla, aby móc dostosować ją później.
  // //     // if (prevProps.list.length < this.props.list.length) {
  // //     //     const list = this.listRef.current;
  // //     //     return list.scrollHeight - list.scrollTop;
  // //     // }
  // //     // return null;
  // //     console.log(props.curentPage, state)
  // //     return null
  // // }


  // // componentDidMount() {
  // //     if (this.state.pages) {
  // //         this.setState({elements: this.state.pages[this.state.currentPage || 0], currentPage: this.state.currentPage || 0})
  // //     }
  // // }

  goPage(e, num) {
    let { target } = e
    let { value } = target
    let numb = num ? this.state.currentPage + num : Number(value)
    this.setState((state) => {
      const pages = state.pages
      let currentPage = state.currentPage
      if (pages[numb]) {
        pages[currentPage] = this.state.elements
        currentPage = numb
        const elements = pages[numb]
        return {
          pages,
          elements,
          currentPage
        }
      }

      return null
    })
  }

  showImage = (e) => {
    if (e.target.classList.contains('fixed'))
      e.target.classList.remove('fixed', 'top-0', 'z-40', 'w-auto', 'h-auto', 'left-0')
    else
      e.target.classList.add('fixed', 'z-40', 'top-0', 'w-full', 'h-full', 'left-0')
  }

  render() {
    if (!this.state.show) return <></>
    return (
      <div className={this.sides[this.state.side]}>
        <div className="w-full h-full p-8">
          <form id="menuside" className="w-full bg-gray-700 rounded-lg bg-opacity-90 h-full flex flex-col p-2 gap-4 justify-between select-none items-between">
            <div className="text-center font-bold text-lg">
              {this.state.title}
            </div>
            {this.state.pages && <div className="text-center font-bold text-lg">
              {this.state?.pageLabels[this.state.currentPage || 0] || ''}
            </div>}
            <div className={this.main[this.state.main]}>
              {this.state.elements.map((v, i) => {
                if (v.inline)
                  if (v.category)
                    return <div className="flex justify-between flex-col items-center break-all w-full h-full">
                      {v.check && <input defaultChecked={v.value || v.checked} className="appearance-none peer bg-gray-900 border-gray-900 checked:bg-gray-500 border-2 w-4 h-4 rounded" type="checkbox" id="category" name="category" value="category" />}
                      {v.check && v.img && <div className="w-1/2 object-scale-down object-contain hidden peer-checked:flex justify-center items-center rounded-lg">
                        <img onClick={this.showImage} className="w-full h-full rounded-lg" src={v.img} alt="x d" />
                      </div>}
                      {!v.check && v.img && <div className="w-1/2 object-scale-down object-contain flex peer-checked:flex justify-center items-center rounded-lg">
                        <img onClick={this.showImage} className="w-full h-full rounded-lg" src={v.img} alt="x d" />
                      </div>}
                      {v.check && <label for="category">{v.name}</label>}
                      <div className={this.categories[v.category]}>
                        {v.elements.map((v, ni) => {
                          return this.getItem(v, i, ni)
                        })}
                      </div>
                    </div>
                  else
                    return <div className="grid grid-cols-3 gap-4 justify-items-center">
                      {v.elements.map((v, ni) => {
                        return this.getItem(v, i, ni)
                      })}
                    </div>
                else
                  return this.getItem(v, i)
              })}
            </div>

            {this.state.messages && <div className="w-full">
              {this.state.messages.map((v) => {
                return <div className="w-full flex bg-blue-500 rounded p-2 flex-col break-words">
                  <div className="flex items-center gap-2 text-lg font-semibold">
                    <svg className="fill-current h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z" /></svg>
                    {v.label}
                  </div>
                  <div>
                    {v.content}
                  </div>
                </div>
              })}
            </div>}

            {this.state.pages && <div className="flex justify-between gap-4 font-bold">
              <button onClick={(e) => this.goPage(e, -1)} className="rounded-lg text-white bg-gray-700 w-min p-2" type="button">
                Poprzednia
              </button>

              <div className="flex gap-2 items-center">
                <input onChange={(e) => this.goPage(e)} value={this.state.currentPage || 0} className="appearance-none text-center bg-gray-900 border-gray-900 border-2 w-14 h-7 rounded out-of-range:text-red-500" type="number" name="page" min={0} defaultValue={this.state.currentPage || 0} max={this.state.pages.length} />
              </div>

              <button onClick={(e) => this.goPage(e, 1)} className="rounded-lg text-white bg-gray-700 w-min p-2" type="button">
                Następna
              </button>

            </div>}

            <div className="flex justify-between gap-4 font-bold">

              <button form="menuside" type="submit" onClick={(e) => this.submit(e)} className="rounded-lg bg-gray-700 w-min p-2">
                Zapisz
              </button>
              {this.state.pages && <div className="text-center flex gap-0.5">
                <div>
                  {this.state.currentPage}
                </div>
                <div>/</div>
                <div>
                  {this.state.pages.length - 1}
                </div>
              </div>}
              <button onClick={(e) => this.cancel(e)} className="rounded-lg text-red-500 bg-gray-700 w-min p-2">
                Anuluj
              </button>
            </div>
          </form>
        </div>
      </div>
    );
  }
}
