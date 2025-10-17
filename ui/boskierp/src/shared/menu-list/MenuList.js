import React from "react";
import sendMessage from '../../Api'
import Head from './Head'
import Rows from './Rows'

export default class MenuList extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      hidden: false,
      menus: [

      ],
      currentMenu: {
      }
    };

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

  open(data, update) {
    if (!update) {
      let menus = this.state.menus

      menus.push({
        title: data.data.title,
        namespace: data.namespace,
        name: data.name,
        rows: data.data.rows,
        head: data.data.head
      })

      this.setState({
        menus: menus
      })

    }

    let currentMenu = {
      title: data.data.title,
      name: data.name,
      namespace: data.namespace
    }

    this.Rows.set(data.data.rows, currentMenu)

    this.Head.set(data.data.head)

    this.setState({
      currentMenu: currentMenu
    })

  }

  close(data) {
    let menus = this.state.menus
    for (let value of menus) {
      if (value.namespace === data.namespace && value.name === data.name) {
        menus.splice(menus.indexOf(value), 1)
      }
    }

    this.Rows.set([], {})

    this.Head.set([])

    let currentMenu = {}

    if (menus.length > 0) {
      let menu = menus[menus.length - 1]
      currentMenu = {
        title: menu.title,
        align: menu.align,
        namespace: menu.namespace,
        name: menu.name
      }
      this.Head.set(menu.head)
      this.Rows.set(menu.rows, currentMenu)
    }

    this.setState({
      menus: menus,
      currentMenu: currentMenu
    })

  }

  cancel() {
    sendMessage('menu_cancel', {
      menu: this.state.currentMenu
      // current: this.state.currentMenu
    })
  }

  componentDidMount() {
    document.onkeyup = (data) => {

      if (data.code === 'Escape') {
        this.cancel()
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


  render() {
    return (
      <div style={{ display: this.state.menus.length > 0 ? '' : 'none' }} className={`flex h-screen w-screen justify-center `} >
        <div id="Rows" className="m-12 text-center overflow-auto font-sans rounded-lg bg-black bg-opacity-80 ">

          <div className="text-xl text-green-400">
            {this.state.currentMenu.title}
          </div>

          <table className="table-fixed w-full">
            <thead id="nav" className="sticky top-0 text-lg">
              <tr key="2">
                <Head ref={ref => (this.Head = ref)} />
              </tr>
            </thead>
            <tbody className="break-words text-green-400 animate-fade text-lg" >
              <Rows ref={ref => (this.Rows = ref)} />
            </tbody>
          </table>

        </div>
      </div>

    );
  }
}
