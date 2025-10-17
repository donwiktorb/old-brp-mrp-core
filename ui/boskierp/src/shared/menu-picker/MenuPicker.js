import React from 'react'
import sendMessage from '../../Api'

export default class MenuPicker extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      title: 'hi',
      name: '',
      align: 'justify-center items-center'
    }

    this.alignTypes = {
      'left': 'justify-start',
      'right': 'justify-end',
      'center': 'justify-center',
      'middle': 'items-center',
      'top': 'items-start',
      'bottom': 'items-end'
    }



    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
  }

  open(data) {
    let align = data.align

    let newAlign = ''

    if (align) {
      if (align.includes('-')) align = align.split('-')
      else newAlign = this.alignTypes[align] + ' items-center'

      if (newAlign === '')
        for (let val of align) {
          let newAl = this.alignTypes[val]
          if (newAl) newAlign += newAl + ' '
        }
    } else {
      newAlign = 'justify-center items-center';
    }



    this.setState({
      show: true,
      title: data.title,
      name: data.name,
      align: newAlign
    })
  }

  close(data) {
    this.setState({
      show: false
    })
  }

  hexToRgb(hex) {
    let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
      r: parseInt(result[1], 16),
      g: parseInt(result[2], 16),
      b: parseInt(result[3], 16)
    } : null;
  }

  setColor(e) {
    let color = this.hexToRgb(e.target.value)
    if (color) {
      sendMessage('menu_change', {
        current: {
          value: color
        },
        menu: this.state
      })
    }

  }

  submit = (e) => {
    e.preventDefault()
    let color = this.hexToRgb(document.getElementById('colorPicker').value)
    sendMessage('menu_submit', {
      current: {
        value: color
      },
      menu: this.state
    })
  }

  cancel = (e) => {
    e.preventDefault()
    let color = this.hexToRgb(document.getElementById('colorPicker').value)
    sendMessage('menu_cancel', {
      current: {
        value: color
      },
      menu: this.state
    })
  }

  render() {
    if (!this.state.show) return <div></div>
    return <div className={`flex ${this.state.align} h-screen absolute w-screen`} >
      <div id="Elements" className="m-6 w-1/4 max-h-40 text-center font-sans rounded-lg bg-black bg-opacity-80 text-green-400 text-lg">
        <div className="text-xl m-4" dangerouslySetInnerHTML={{ __html: this.state.title }}>
        </div>
        <form>
          <div className="grid grid-cols-1 gap-4 m-4">
            <input className="opacity-90" type="color" id="colorPicker" defaultValue onChange={(e) => this.setColor(e)} />
          </div>
          <div className="grid grid-cols-2 gap-4 m-6 text-green-400">
            <button onClick={this.submit}>Zatwierdź</button>
            <button onClick={this.cancel}>Anuluj</button>
          </div>
        </form>
      </div>
    </div>
  }
}
