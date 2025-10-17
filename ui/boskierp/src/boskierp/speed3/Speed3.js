import React from "react";

export default class Speed4 extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: true,
      road: {
        name: "Hello",
        second: null,
      },
      scale: 100,
      speed: 200,
      gear: 8,
      rpm: 1000,
      fuel: 50,
      lights: "long",
      signal: {
        left: true,
        right: true,
      },
      gps: "NE",
      main: 4,
    };
    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
    this.updateData = this.updateData.bind(this);
    this.classes = [
      "w-full h-full flex justify-end items-end absolute p-2 ",
      "w-full h-full flex justify-center items-end absolute p-2 ",
      "w-full h-full flex justify-center items-start absolute p-2 ",
      "w-full h-full flex justify-center items-center absolute p-2 ",
      "w-full h-full flex justify-start items-end absolute p-2 ",
      "w-full h-full flex justify-start items-start absolute p-2 ",
      "w-full h-full flex justify-start items-center absolute p-2 ",
      "w-full h-full flex justify-end items-center absolute p-2 ",
      "w-full h-full flex justify-end items-start absolute p-2 ",
    ];
  }

  open() {
    this.setState({ show: true });
  }

  close() {
    this.setState({ show: false });
  }

  updateData(data) {
    // // let rpm = (data.rpm/1000)*15
    // // data.rpm = rpm
    this.setState(data);
  }

  render() {
    if (!this.state.show) return <div> </div>;
    const ticks = Array.from({ length: 16 }, (_, i) => i * 20); // Create an array [0, 10, 20, ..., 100]
    const ticks4 = Array.from({ length: 10 }, (_, i) => i * 1000); // Create an array [0, 10, 20, ..., 100]
    return (
      <div className="w-full h-full absolute text-white top-0">
        <div className={this.classes[this.state.main]}>
          <div className="w-1/5 h-1/5 bg-blue-400 flex justify-center items-center ">
            <svg className="w-full h-full" viewBox="0 -5 100 60">
              <defs>
                <marker
                  id="arrow"
                  viewBox="0 -5 10 10"
                  refX="5"
                  refY="0"
                  markerWidth="4"
                  markerHeight="4"
                  orient="auto"
                  fill="red"
                >
                  <path class="cool" d="M0,-5L10,0L0,5"></path>
                </marker>
              </defs>
              <path
                d="M 10 50.5 A 40 40 0 0 1 90 50.5"
                fill="none"
                stroke="black"
                strokeWidth="2"
              />

              {ticks.map((tick, index) => {
                const angle = (tick / 300) * 180 - 180; // Calculate angle for each tick
                const x1 = 50 + 40 * Math.cos((angle * Math.PI) / 180); // Inner tick x
                const y1 = 50 + 40 * Math.sin((angle * Math.PI) / 180); // Inner tick y
                const x2 = 50 + 45 * Math.cos((angle * Math.PI) / 180); // Outer tick x
                const y2 = 50 + 45 * Math.sin((angle * Math.PI) / 180); // Outer tick y
                const labelX = 50 + 50 * Math.cos((angle * Math.PI) / 180); // Label x
                const labelY = 50 + 50 * Math.sin((angle * Math.PI) / 180); // Label y

                return (
                  <g key={index}>
                    {/* Tick mark */}
                    <line
                      x1={x1}
                      y1={y1}
                      x2={x2}
                      y2={y2}
                      stroke="black"
                      strokeWidth="1"
                    />

                    {/* Label */}
                    <text
                      className="cool font-bold font-sans slashed-zero"
                      x={labelX}
                      y={labelY}
                      fill="black"
                      fontSize="5"
                      textAnchor="middle"
                      dominantBaseline="middle"
                      //transform={`rotate(${angle + 90}, ${labelX}, ${labelY})`}
                    >
                      {tick}
                    </text>
                  </g>
                );
              })}

              <line
                marker-end="url(#arrow)"
                x1="50"
                y1="50"
                x2="50"
                y2="5"
                stroke="red"
                strokeWidth="1"
                transform={`rotate(34, 50, 50)`}
              />
            </svg>
          </div>
          <div className="h-1/5 bg-orange-400"></div>
          <div className="w-1/5 h-1/5 bg-blue-400 flex justify-center items-center ">
            <svg className="w-full h-full" viewBox="0 -5 100 60">
              <defs>
                <marker
                  id="arrow"
                  viewBox="0 -5 10 10"
                  refX="5"
                  refY="0"
                  markerWidth="4"
                  markerHeight="4"
                  orient="auto"
                  fill="red"
                >
                  <path class="cool" d="M0,-5L10,0L0,5"></path>
                </marker>
              </defs>
              <path
                d="M 10 50.5 A 40 40 0 0 1 70 14"
                fill="none"
                stroke="black"
                strokeWidth="2"
              />

              <path
                d="M 70 14 A 40 40 0 0 1 90 50.5"
                fill="none"
                stroke="red"
                strokeWidth="2"
              />

              {ticks4.map((tick, index) => {
                const angle = (tick / 9000) * 180 - 180; // Calculate angle for each tick
                const x1 = 50 + 40 * Math.cos((angle * Math.PI) / 180); // Inner tick x
                const y1 = 50 + 40 * Math.sin((angle * Math.PI) / 180); // Inner tick y
                const x2 = 50 + 45 * Math.cos((angle * Math.PI) / 180); // Outer tick x
                const y2 = 50 + 45 * Math.sin((angle * Math.PI) / 180); // Outer tick y
                const labelX = 50 + 51 * Math.cos((angle * Math.PI) / 180); // Label x
                const labelY = 50 + 50 * Math.sin((angle * Math.PI) / 180); // Label y

                return (
                  <g key={index}>
                    {/* Tick mark */}
                    <line
                      x1={x1}
                      y1={y1}
                      x2={x2}
                      y2={y2}
                      stroke={tick > 5000 ? "red" : "black"}
                      strokeWidth="1"
                    />

                    {/* Label */}
                    <text
                      className="cool font-bold font-sans slashed-zero"
                      x={labelX}
                      y={labelY}
                      fill={tick > 5000 ? "red" : "black"}
                      fontSize="5"
                      textAnchor="middle"
                      dominantBaseline="middle"
                      //transform={`rotate(${angle + 90}, ${labelX}, ${labelY})`}
                    >
                      {tick}
                    </text>
                  </g>
                );
              })}

              <line
                marker-end="url(#arrow)"
                x1="50"
                y1="50"
                x2="50"
                y2="5"
                stroke="red"
                strokeWidth="1"
                transform={`rotate(34, 50, 50)`}
              />
            </svg>
          </div>
        </div>
      </div>
    );
  }
}
