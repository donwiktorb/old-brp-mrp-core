import React from "react";
import sendMessage from "../../Api";

export default class PoliceRadar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      front: {
        plateStyle: "white",
        plate: "DWB4444",
        speed: 55,
        limit: 50,
        diff: 5,
        locked: true,
      },
      rear: {
        plateStyle: "yellow",
        plate: "DWB888",
        speed: 55,
        limit: 50,
        diff: 5,
        locked: false,
      },
      class: 0,
    };
    this.plates = {
      ["blue"]:
        "https://cdn.discordapp.com/attachments/678339577110462479/1159129629546790952/2.png",
      ["white"]:
        "https://cdn.discordapp.com/attachments/678339577110462479/1159129629982990417/3.png",
      ["yellow"]:
        "https://cdn.discordapp.com/attachments/678339577110462479/1159129631266455552/1.png",
    };
    this.styles = {
      [true]: "text-red-500",
      [false]: "text-green-500",
    };
    this.locked = {
      [true]: "text-red-500",
      [false]: "text-green-500",
    };

    this.classes = [
      "w-full h-full flex justify-end items-end absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-center items-end absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-center items-start absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-center items-center absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-start items-end absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-start items-start absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-start items-center absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-end items-center absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-end items-start absolute p-2 opacity-90 overflow-hidden",
    ];

    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
  }

  open(data) {
    this.setState(data);
  }

  close() {
    this.setState({ show: false });
  }

  render() {
    if (!this.state.show) return <></>;
    return (
      <div className="w-full h-full">
        <div class={this.classes[this.state.class]}>
          <div className="w-1/5 h-1/5 bg-black opacity-90 rounded-lg">
            <div className="w-full h-full flex items-center gap-4 p-2 text-white text-center font-semibold">
              <div>
                <div className="">FRONT</div>
                <div className="relative">
                  <img
                    src={this.plates[this.state.front.plateStyle]}
                    alt="plate"
                  />
                  <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-white font-['Plate'] text-3xl w-full tracking-wide my-2">
                    {this.state.front.plate}
                  </div>
                </div>
                <div className="font-mono flex gap-1 justify-center">
                  <p class={this.styles[this.state.front.diff > 0]}>
                    {this.state.front.speed}
                  </p>
                  <p className="text-yellow-500">{this.state.front.limit}</p>
                  <p class={this.styles[this.state.front.diff > 0]}>
                    {this.state.front.diff}
                  </p>
                  <p>(km/h)</p>
                </div>
                <div className="text-sm text-white">
                  <p class={this.locked[this.state.front.locked]}>LOCKED</p>
                </div>
              </div>

              <div>
                <div className="">REAR</div>
                <div className="relative">
                  <img
                    src={this.plates[this.state.rear.plateStyle]}
                    alt="plate"
                  />
                  <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-white font-['Plate'] text-3xl w-full tracking-wide my-2">
                    {this.state.rear.plate}
                  </div>
                </div>
                <div className="font-mono flex gap-1 justify-center">
                  <p class={this.styles[this.state.rear.diff > 0]}>
                    {this.state.rear.speed}
                  </p>
                  <p className="text-yellow-500">{this.state.rear.limit}</p>
                  <p class={this.styles[this.state.rear.diff > 0]}>
                    {this.state.rear.diff}
                  </p>
                  <p>(km/h)</p>
                </div>
                <div className="text-sm text-white">
                  <p class={this.locked[this.state.rear.locked]}>LOCKED</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
