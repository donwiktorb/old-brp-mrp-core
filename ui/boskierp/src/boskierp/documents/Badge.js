import React from "react";
import sendMessage from "../../Api";

export default class Drive extends React.Component {
  constructor(props) {
    super(props);
    this.state = props.state;

    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
    this.updateData = this.updateData.bind(this);
    this.max = 200 - 20;
  }

  // componentDidMount() {
  //     let rpm = 1000
  //     let xd = rpm / 1000
  //     let one = 15
  //     let xd2 = xd * one
  //     this.setState({
  //         rpm: xd2
  //     })

  // }

  open() {
    this.setState({ show: true });
  }

  close() {
    this.setState({ show: false });
  }

  updateData(data) {
    let rpm = (data.rpm / 1000) * 15;
    data.rpm = rpm;
    this.setState(data);
  }

  render() {
    if (!this.state.show) return <></>;
    return (
      <div className="w-full h-full flex justify-end items-center absolute p-2 opacity-90 overflow-hidden">
        <div className="w-fit h-fit rounded-lg relative flex justify-end items-center">
          <img
            src={`${process.env.PUBLIC_URL}/img/other/badg.png`}
            className="select-none pointer-events-none w-3/4 h-3/4"
            alt="RADIO"
          />
          <div className="absolute top-3/4 right-1/3 -mx-1.5 py-3.5 text-2xl font-bold text-black text-center">
            {this.state.badge}
          </div>
        </div>
      </div>
    );
  }
}
