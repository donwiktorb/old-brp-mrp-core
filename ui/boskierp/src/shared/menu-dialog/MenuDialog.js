import React from "react";
import sendMessage from '../../Api'

export default class MenuDialog extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      hidden: false,
      value: '',
      menus: [

      ]
    };

    this.alignTypes = {
      'left': 'justify-start',
      'right': 'justify-end',
      'center': 'justify-center',
      'middle': 'items-center',
      'top': 'items-start',
      'bottom': 'items-end'
    }

    this.close = this.close.bind(this)
    this.open = this.open.bind(this)
  }

  open(data, update) {
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



    let menus = this.state.menus

    menus.push({
      name: data.name,
      title: data.title,
      align: newAlign,
      big: data.type === 'big',
    })

    this.setState({
      menus: menus
    })

  }

  close(data) {
    let menus = this.state.menus

    for (let value of menus) {
      if (value.name === data.name) {
        menus.splice(menus.indexOf(value), 1)
      }
    }

    this.setState({
      menus: menus,
    })

  }

  componentDidMount() {

    document.onkeyup = (key) => {
      if (key.code === 'Escape') { // Escape key
        this.cancel()
      } else if (key.code === 'Enter') { // Enter key
        this.submit()
      }
    };


    // window.addEventListener('message', (event) => {
    //     if (!this) return
    //     let data = event.data;

    //     // // console.log(event, this.state.menus)

    //     // // console.log(event)

    //     switch(data.action) {
    //         case 'openMenu': {
    //             let found = false
    //             this.state.menus.forEach((v,i,a) => {
    //                 if (v.namespace === data.namespace && v.name === data.name) {
    //                     found = true
    //                 }
    //             })
    //             this.openMenu(data, found)
    //             break;
    //         }

    //         case 'closeMenu': {
    //             this.closeMenu(data)
    //             break;
    //         }

    //         default: break;
    //     }

    //     // // console.log(this.state.menus)
    // });

  }

  onChange = (e) => {
    this.setState({
      value: e.target.value
    })
    let data = this.state.menus[this.state.menus.length - 1]
    data.value = this.state.value
    sendMessage('menu_change', {
      current: data,
      menu: data
    });
  }

  submit = (e) => {
    if (e)
      e.preventDefault()
    let data = this.state.menus[this.state.menus.length - 1]
    data.value = this.state.value
    sendMessage('menu_submit', {
      current: data,
      menu: data
    })
    // let menus = this.state.menus
    // menus.splice(this.state.menus.length-1, 1)
    // this.setState({menus:menus})

  }

  cancel = (e) => {
    if (e)
      e.preventDefault()
    let data = this.state.menus[this.state.menus.length - 1]
    data.value = this.state.value
    sendMessage('menu_cancel', { menu: data, current: data });
    // let menus = this.state.menus
    // menus.splice(this.state.menus.length-1, 1)
    // this.setState({menus:menus})
  }


  render() {
    return (
      this.state.menus.map((v, i, a) => {
        return <div display={i === this.state.menus.length - 1 ? '' : 'none'} className={`flex ${v.align} h-screen`} >
          <div id="Elements" className="m-6 w-1/4 max-h-80 text-center font-sans rounded-lg bg-black bg-opacity-80 text-green-400 text-lg">
            <div className="text-xl m-4" dangerouslySetInnerHTML={{ __html: v.title }}>
            </div>
            <form>
              <div className="grid grid-cols-1 gap-4 m-4">
                {
                  v.big
                    ?
                    <textarea autoFocus onChange={this.onChange} className="outliine-none focus:outline-none bg-green-800 bg-opacity-80 max-h-24" type="text" />
                    :
                    <input autoFocus onChange={this.onChange} className="outliine-none focus:outline-none bg-green-800 bg-opacity-80" type="text" />

                }
              </div>
              <div className="grid grid-cols-2 gap-4 m-6 text-green-400">
                <button onClick={this.submit}>Zatwierdź</button>
                <button onClick={this.cancel}>Anuluj</button>
              </div>
            </form>


          </div>
        </div>
      })
    );
  }
}
