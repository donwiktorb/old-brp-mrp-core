import React from "react";
export default class Window extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      apps: [
        {
          label: "IE",
          img: "https://upload.wikimedia.org/wikipedia/commons/1/18/Internet_Explorer_10%2B11_logo.svg",
        },
      ],
    };
  }
  render() {
    return (
      <div className="w-full h-full ">
        <div className="w-full h-full">
          <div className="w-full h-full flex justify-center items-center p-1">
            <div className="w-full h-full flex flex-wrap gap-1 overflow-scroll">
              {this.state.apps.map((v, i) => {
                return (
                  <div
                    className="w-14 h-14 text-white text-lg text-center drop-shadow-md"
                    style={{
                      textShadow: "1px 1px 1px black",
                    }}
                  >
                    <img
                      name={`laptop-apps-${i}`}
                      id={`laptop-apps-${i}`}
                      src={v.img}
                      alt={v.label}
                      className="w-full h-full object-scale-down drop-shadow-md"
                    />
                    <label for={`laptop-apps-${i}`}>{v.label}</label>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>
    );
  }
}
