


import React from "react";
import sendMessage from '../../Api'

export default class Bar extends React.Component {
  constructor(props) {
    super(props);

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.state = {};
    this.queue = []
  }

  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  async open(data) {
    if (this.state.task)
      return this.queueBar(data)

    let time = data.time;
    let width = 0;
    let sleepTime = (time * 1000) / 100

    this.setState({
      time: data.time,
      name: data.name,
      task: data.task,
      cancel: false
    })

    for (width; width <= 100; width++) {
      if (this.state.cancel) break;
      await this.sleep(sleepTime);
      this.setState({
        width: width + '%'
      })

    }

    this.setState({
      task: false,

      name: ' ',
      time: 0,
      // width: 0
    })

    let queued = this.queue[0]
    if (queued) {
      this.queue.splice(0, 1)
      this.open(queued)
    }

    sendMessage('menu_submit', {
      current: this.state.task,
      name: this.state.name
    });
  }

  close(data) {
    if (this.state.name == data.name) {
      this.setState({ cancel: true, task: false })
    } else {
      this.queue.forEach((v, i) => {
        if (v.name === data.name) {
          this.queue.splice(i, 1)
        }
      })
    }
  }

  queueBar(data) {
    this.queue.push(data)
  }

  render() {
    return (
      <div style={{ display: this.state.task ? '' : 'none' }} className={`flex justify-center items-end h-screen`}>
        {/* <div className="relative pt-1 w-1/4"> */}
        <div className="w-1/4 mb-10 overflow-hidden">
          <div className="flex mb-2 items-center justify-between">
            <div>
              <span
                className="
                    text-xs
                    font-semibold
                    inline-block
                    py-1
                    px-2
                    uppercase
                    rounded-full
                    text-white
                    bg-blue-900
                    break-words
                    max-w-prose
                    "
              >
                {this.state.task}
              </span>
            </div>
            <div className="text-right">
              <span className="text-xs font-semibold inline-block text-white">
                {this.state.width}
              </span>
            </div>
          </div>
          <div className="overflow-hidden h-2 mb-4 text-xs flex rounded bg-gray-200">
            <div
              style={{ width: this.state.width }}
              className="
                    shadow-none
                    flex flex-col
                    text-center
                    whitespace-nowrap
                    text-white
                    justify-center
                    bg-blue-500
                "
            ></div>
          </div>
          {/* </div> */}
        </div>
      </div>

    );
  }
}
