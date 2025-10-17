import React from "react";
import sendMessage from "../../Api";

export default class Documents extends React.Component {
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
    this.setState(data);
  }

  render() {
    if (!this.state.show) return <></>;
    return (
      <div className="w-full h-full flex justify-end items-center absolute p-2 opacity-90 overflow-hidden">
        <div className="w-fit h-fit bg-black rounded-lg relative flex justify-end items-center">
          <img
            src={`${process.env.PUBLIC_URL}/img/other/id.jpg`}
            className="select-none pointer-events-none rounded-lg"
            alt="RADIO"
          />

          <div className="absolute w-28 left-0 px-2 opacity-90 flex justify-center items-center">
            <img className="profileimg" src={this.state.avatar} alt="XD" />
          </div>
          <div
            className="bottom-2 left-0 absolute flex justify-center w-1/3 h-8 "
            style={{ fontFamily: "Signme" }}
          >
            {this.state.fn} {this.state.ln}
          </div>

          <div className="text-gray-500 absolute right-10 bottom-10 w-20 h-20 opacity-50 grayscale">
            <img className="profileimg" src={this.state.avatar} alt="XD" />
          </div>

          <div className="text-gray-500 absolute right-2 top-10">
            {this.state.dob}
          </div>

          <div className="w-1/2 h-28 absolute top-8 left-1/3 mx-2 flex flex-col text-sm">
            <div className="flex gap-2 font-bold items-center text-center">
              <div className="text-blue-500 text-sm">ID</div>
              <div className="text-red-500 ">{this.state.id}</div>
            </div>

            <div className="flex gap-2 font-bold items-center text-center">
              <div className="text-blue-500 text-sm">EXP</div>
              <div className="text-red-500">{this.state.exp}</div>
            </div>

            <div className="flex flex-col">
              <div className="flex gap-2 font-bold items-center text-center">
                <div className="text-blue-500 text-sm">LN</div>
                <div className="text-black ">{this.state.ln}</div>
              </div>

              <div className="flex gap-2 font-bold items-center text-center">
                <div className="text-blue-500 text-sm">FN</div>
                <div className="text-black">{this.state.fn}</div>
              </div>
              <div className="flex gap-2 font-bold items-center text-center">
                <div className="text-black text-sm">{this.state.country}</div>
              </div>
            </div>

            <div className="flex gap-2 font-bold items-center text-center">
              <div className="text-blue-500 text-sm">DOB</div>
              <div className="text-red-500">{this.state.dob}</div>
            </div>
          </div>

          <div className=" right-7  bottom-0 absolute flex gap-2 text-xs">
            <div className="flex flex-col w-full h-full">
              <div className="flex gap-2 font-bold items-center text-center">
                <div className="text-blue-500 text-sm">SEX</div>
                <div className="text-black">{this.state.sex}</div>
              </div>
              <div className="flex gap-2 font-bold items-center text-center">
                <div className="text-blue-500 text-sm">HGT</div>
                <div className="text-black">{this.state.hgt}cm</div>
              </div>
            </div>

            <div className="flex flex-col w-full h-full">
              <div className="flex gap-2 font-bold items-center text-center">
                <div className="text-blue-500 text-sm">HAIR</div>
                <div className="text-black">BLK</div>
              </div>
              <div className="flex gap-2 font-bold items-center text-center">
                <div className="text-blue-500 text-sm">WGT</div>
                <div className="text-black">{this.state.wgt}kg</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
