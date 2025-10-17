
import React from 'react'
import sendMessage from '../../Api'
export default class Tut extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      title: "X d",
      content: [
        'Witaj w tutorialu, teraz przedstawimy ci najważniejsze funkcje potrzebne ci do poznania, aby mieć w pełni grywalną rozgrywkę!',
        'Zacznijmy do ALTA'
      ]
    }
    this.close = this.close.bind(this)
    this.open = this.open.bind(this)
  }

  open(data) {
    this.setState(data)
  }

  close() {
    this.setState({ show: false })
  }

  cancel() {
    sendMessage('menu_submit', {
      name: this.state.name
    })
  }

  render() {
    if (!this.state.show) return <div></div>
    return <div className="w-full h-full absolute z-20">
      <div className="w-full h-full flex justify-center items-center">
        <div className="w-3/4 h-3/4 bg-gray-700 bg-opacity-50 rounded-lg flex flex-col p-2 font-semibold text-white gap-4 justify-start items-start">
          <div className="text-2xl" dangerouslySetInnerHTML={{ __html: this.state.title }}>
          </div>
          <div className="text-xl w-full h-full">
            {this.state.content.map((v, i) => {
              return <p dangerouslySetInnerHTML={{ __html: v }}></p>
            })}
          </div>
          <div className=" w-full flex justify-center items-center p-2">
            <button onClick={(e) => this.cancel(e)} className="p-2 border-2 rounded-lg hover:bg-blue-500 transition-all">Kontynuuj</button>
          </div>
        </div>
      </div>
    </div>
  }
}
