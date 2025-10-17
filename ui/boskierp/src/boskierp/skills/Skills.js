import React from "react"
import sendMessage, { getBase64Image } from '../../Api'
import Circle from './Circle'
import Combination from './Combination'
import Hacking from './Hacking'
import FastClick from './FastClick'
import LeafCollect from './LeafCollect'
import LeafClear from './LeafClear'
import LeafLight from './LeafLight'
import LeafZip from './LeafZip'
import Weight from './Weight'
import LockPick from './LockPick'

export default class Skills extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      docType: "fastClick",
      type: "coke"
    }

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    this.submit = this.submit.bind(this)
    this.onKey = this.onKey.bind(this)
  }

  onKey = (e) => {
    if (e.key === 'Escape')
      sendMessage("menu_cancel", {
        name: this.state.name
      })
  }

  // componentDidMount() {
  //     let rpm = 1000
  //     let xd = rpm / 1000
  //     let one = 15
  //     let xd2 = xd * one
  //     this.setState({
  //         rpm: xd2
  //     })
  //

  // }

  open(data) {
    this.setState(data)
  }

  close() {
    this.setState({ show: false })
  }

  submit(value) {
    sendMessage('menu_submit', {
      current: value || this.state,
      name: this.state.name
    });
  }

  render() {
    if (!this.state.show) return <></>
    switch (this.state.docType) {
      case 'hacking':
        return <Hacking data={this.state} submit={this.submit} />
      case 'combination':
        return <Combination data={this.state} submit={this.submit} />
      case 'circle':
        return <Circle submit={this.submit} data={this.state} />
      case 'fastClick':
        return <FastClick submit={this.submit} data={this.state} />
      case 'leafCollect':
        return <LeafCollect submit={this.submit} data={this.state} />
      case 'leafClear':
        return <LeafClear submit={this.submit} data={this.state} />
      case 'leafZip':
        return <LeafZip type={this.state.type} submit={(v) => this.submit(v)} data={this.state} />
      case 'leafLight':
        return <LeafLight submit={this.submit} data={this.state} />
      case 'weight':
        return <Weight submit={this.submit} data={this.state} />
      case 'lockPick':
        return <LockPick submit={this.submit} data={this.state} />
      default:
        return <></>
    }
    // if (!this.state.show) return <></>
    // else if (this.state.docType === "hacking")
    //     return <Hacking />
    // else if (this.state.docType === "combination")
    //     return <Combination />
    // else if (this.state.docType === "circle")
    //     return <Circle />
    // else if (this.state.docType === "fastClick")
    //     return <FastClick />
    // else if (this.state.docType === 'leafCollect')
    //     return <LeafCollect />
    // else if (this.state.docType === 'leafClear')
    //     return <LeafClear />
    // else if (this.state.docType === 'leafZip')
    //     return <LeafZip type={this.state.type} />
    // else if (this.state.docType === 'leafLight')
    //     return <LeafLight />
  }
}
