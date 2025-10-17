import React from "react"
import sendMessage from '../../Api'

import { Transition } from 'react-transition-group'; // ES6

const duration = 300;

const defaultStyle = {
  transition: `opacity ${duration}ms ease-in-out`,
  opacity: 0,
}

const transitionStyles = {
  entering: { opacity: 1 },
  entered: { opacity: 1 },
  exiting: { opacity: 0 },
  exited: { opacity: 0 },
};
export default class Bg extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false
    }

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
  }

  open() {
    this.setState({
      show: true
    })
  }

  close() {
    this.setState({
      show: false
    })
  }

  render() {
    return <Transition in={this.state.show} timeout={duration}>
      {state => (
        <div
          style={{
            ...defaultStyle,
            ...transitionStyles[state]
          }}
          className='flex absolute h-screen justify-end items-end z-20 w-screen  bg-black bg-opacity-80 saturate-0 grayscale-0'
        >

        </div>

      )}
    </Transition>
    // if (!this.state.show) return <div></div>
    // return <div className={`flex absolute h-screen justify-end items-end z-20 w-screen  bg-black bg-opacity-80 saturate-0 grayscale-0`} >
    // </div>
  }
}
