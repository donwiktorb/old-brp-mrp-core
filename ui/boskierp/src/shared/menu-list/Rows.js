import React from "react";
import sendMessage from '../../Api'

export default class Rows extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      currentMenu: {

      },
      Rows: [

      ],
      oldRows: [

      ]
    };

    this.Index = 0;
    this.set = this.set.bind(this);
    this.getRows = this.getRows.bind(this);

  }

  getRows() {
    if (this.state.Rows.length > 0) {
      return this.state.Rows
    } else return {}
  }

  set(Rows, currentMenu) {
    this.setState({ Rows: Rows, currentMenu: currentMenu })
  }

  submit(id, value) {
    sendMessage('menu_submit', {
      current: this.state.Rows[id],
      menu: value
    })

    // let oldRows = this.state.oldRows;
    // let newRows = []

    // if (oldRows.length > 0) {
    //     let Row = oldRows[oldRows.length-1]
    //     oldRows.splice(oldRows.length-1, 1)   
    //     newRows = Row;
    // }

    // this.setState({
    //     Rows: newRows,
    //     oldRows: oldRows
    // })
  }

  onClick = (e) => {
    e.preventDefault()
    this.submit(e.target.id, e.target.value)
  }

  getHtml(itemRowIndex, itemIndex, item) {
    if (item.startsWith('{{')) {
      let replacedItem = item.replaceAll('}}', '')
      // // console.log(replacedItem)
      let items = replacedItem.split('{{')
      let buttons = []
      for (let newItem of items) {
        if (newItem !== '') {
          let splittedItem = newItem.split('|')
          let label = splittedItem[0]
          let value = splittedItem[1]
          buttons.push({
            label: label,
            value: value
          })
        }

      }
      return <div className="flex m-2">
        {buttons.map((item, k, arr) => {
          return <button id={itemRowIndex} className="flex-grow mx-1 bg-green-800 text-green-200 border border-green-200 px-1 rounded" onClick={this.onClick} value={item.value}>{item.label}</button>

        })}
      </div>
    } else
      return item
  }

  render() {
    return (
      this.state.Rows.map((v, i, a) => {
        return <tr key="2">
          {v.cols.map((nv, ni, na) => {
            return <td id={'item-' + ni} className={i % 2 === 0 ? ' ' : 'bg-green-900'} key={i}>
              {this.getHtml(i, ni, nv)}
            </td>
          })}
        </tr>


      })

    );
  }
}
