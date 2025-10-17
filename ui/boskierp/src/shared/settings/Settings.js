import React from 'react'
import sendMessage from '../../Api'

export default class Radio extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      settings: []
    }




  }

  render() {
    if (!this.state.show) return <></>
    return <div className="w-full h-full z-40 absolute">
      <div className="w-full h-full p-2 flex justify-center items-center">
        <div className="w-3/4 h-3/4 bg-black bg-opacity-50 rounded-lg">

        </div>

      </div>
    </div>
  }
}
