import React from "react";
import sendMessage from "../../Api";

export default class Radio extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      hz: "",
      ppl: 0,
    };

    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
  }

  open(data) {
    this.setState(data);
  }

  close() {
    this.setState({
      show: false,
    });
  }

  cancel() {
    sendMessage("menu_cancel", {
      name: "radio",
    });
  }

  addHz(e, number) {
    e.preventDefault();
    this.setState(
      {
        hz: Number(String(this.state.hz) + String(number)),
      },
      () => {
        sendMessage("menu_change", {
          hz: Number(this.state.hz),
          name: "radio",
        });
      },
    );
  }

  resetHz(e) {
    e.preventDefault();
    this.setState({
      hz: "",
    });
    sendMessage("menu_submit", {
      hz: "",
      name: "radio",
    });
  }

  applyHz(e) {
    e.preventDefault();
    sendMessage("menu_submit", {
      hz: Number(this.state.hz),
      name: "radio",
    });
  }

  upHz(e) {
    e.preventDefault();
    let numb = Number(this.state.hz);
    this.setState(
      {
        hz: (numb + 1).toString(),
      },
      () => {
        sendMessage("menu_change", {
          hz: Number(this.state.hz),
          name: "radio",
        });
      },
    );
  }

  downHz(e) {
    e.preventDefault();
    let numb = Number(this.state.hz);
    if (numb <= 0) return;
    this.setState(
      {
        hz: (numb - 1).toString(),
      },
      () => {
        sendMessage("menu_change", {
          hz: Number(this.state.hz),
          name: "radio",
        });
      },
    );
  }

  left(e) {
    e.preventDefault();
    let elem = document.getElementById("currenthz");
    elem.scrollBy({
      left: -100,
      behavior: "smooth",
    });
  }

  right(e) {
    e.preventDefault();
    let elem = document.getElementById("currenthz");
    elem.scrollBy({
      left: 100,
      behavior: "smooth",
    });
  }

  render() {
    if (!this.state.show) return <></>;
    return (
      <div className="w-full h-full flex justify-end items-end z-40 absolute p-2">
        <div className="flex relative h-fit w-fit items-end justify-center select-none">
          <img
            src={`${process.env.PUBLIC_URL}/img/other/radio.png`}
            className="select-none pointer-events-none"
            alt="RADIO"
          />
          <div className="absolute top-2/3 left-10 w-8 h-8 text-orange-500 text-opacity-50 font-bold text-xs py-3.5">
            {this.state.ppl}
          </div>
          <div className="absolute top-2/3 right-6 w-8 h-8 text-orange-500 text-opacity-50 font-bold text-xs py-3.5">
            hz
          </div>
          <svg
            className="
                absolute 
                top-2/3 left-10
                    w-8
                    h-8
                    text-gray-400
                "
            viewBox="0 0 48 48"
            fill="currentColor"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M10 11C10 10.4477 10.4477 10 11 10H13C13.5523 10 14 10.4477 14 11V19C14 19.5523 13.5523 20 13 20H11C10.4477 20 10 19.5523 10 19V11Z"
              stroke="#000000"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
            <path
              d="M4 15C4 14.4477 4.44772 14 5 14H7C7.55228 14 8 14.4477 8 15V19C8 19.5523 7.55228 20 7 20H5C4.44772 20 4 19.5523 4 19V15Z"
              stroke="#000000"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
            <path
              d="M16 7C16 6.44772 16.4477 6 17 6H19C19.5523 6 20 6.44772 20 7V19C20 19.5523 19.5523 20 19 20H17C16.4477 20 16 19.5523 16 19V7Z"
              stroke="#000000"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          </svg>
          <svg
            className="
                absolute
                top-2/3 right-9
                    w-5
                    h-5
                    text-gray-400
                "
            viewBox="0 0 48 48"
            fill="currentColor"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              xmlns="http://www.w3.org/2000/svg"
              d="M12.563 1c-0.937 0-1.25 0.211-1.25 1.25v0.937h-2.813c-1.847 0-2.187 0.341-2.187 2.187v23.438c0 1.847 0.341 2.187 2.187 2.187h15c1.847 0 2.187-0.341 2.187-2.187v-23.438c0-1.847-0.341-2.187-2.187-2.187h-2.813v-0.937c0-1.038-0.312-1.25-1.25-1.25h-6.875zM8.5 7.563c0-2.5-0.312-2.187 2.187-2.187 1.25 0 9.688 0 10.625 0 2.5 0 2.187-0.312 2.187 2.187 0 1.25 0 17.813 0 19.063 0 2.5 0.312 2.187-2.187 2.187-1.25 0-9.375 0-10.625 0-2.5 0-2.187 0.312-2.187-2.187 0-1.251 0-17.813 0-19.063zM10.062 6.313h11.875c0.345 0 0.625 0.28 0.625 0.625v3.438c0 0.345-0.28 0.625-0.625 0.625h-11.875c-0.345 0-0.625-0.28-0.625-0.625v-3.438c0-0.345 0.28-0.625 0.625-0.625zM10.062 11.938h11.875c0.345 0 0.625 0.28 0.625 0.625v3.438c0 0.345-0.28 0.625-0.625 0.625h-11.875c-0.345 0-0.625-0.28-0.625-0.625v-3.438c0-0.345 0.28-0.625 0.625-0.625zM10.062 17.563h11.875c0.345 0 0.625 0.28 0.625 0.625v3.438c0 0.345-0.28 0.625-0.625 0.625h-11.875c-0.345 0-0.625-0.28-0.625-0.625v-3.438c0-0.345 0.28-0.625 0.625-0.625zM10.062 23.188h11.875c0.345 0 0.625 0.28 0.625 0.625v3.438c0 0.345-0.28 0.625-0.625 0.625h-11.875c-0.345 0-0.625-0.28-0.625-0.625v-3.438c0-0.345 0.28-0.625 0.625-0.625z"
            />
          </svg>
          <div className="bg-orange-500 bg-opacity-40 w-[6.95rem] rounded-lg h-9 -ml-1 -rotate-[0.5deg] mb-2 absolute top-96 translate-y-1/2 text-black flex justify-center my-3 items-center font-bold text-2xl text-opacity-80 tracking-wide font-mono truncate">
            <div className="max-w-[4.5rem] overflow-hidden" id="currenthz">
              {this.state.hz}
            </div>
          </div>
          <div className="grid grid-cols-3 gap-y-0.5 bg-black w-full h-40 absolute bg-opacity-0 content-start justify-items-center px-7 opacity-0 ">
            <button
              onClick={(e) => this.cancel(e)}
              className="bg-blue-500 w-9 h-5.5 flex justify-center items-center"
            >
              x
            </button>

            <button
              onClick={(e) => this.upHz(e, 0)}
              className="bg-blue-500 w-9 h-5.5 flex justify-center items-center"
            >
              s
            </button>

            <button
              onClick={(e) => this.applyHz(e)}
              className="bg-blue-500 w-9 h-5.5 flex justify-center items-center"
            >
              d
            </button>

            <button
              onClick={(e) => this.left(e)}
              className="bg-blue-500 w-9 h-5.5 flex justify-center items-center"
            >
              x
            </button>

            <button
              onClick={(e) => this.downHz(e, 0)}
              className="bg-blue-500 w-9 h-5.5 flex justify-center items-center"
            >
              s
            </button>

            <button
              onClick={(e) => this.right(e)}
              className="bg-blue-500 w-9 h-5.5 flex justify-center items-center"
            >
              d
            </button>
          </div>
          <div className="grid grid-cols-3 bg-black w-full h-1/5 absolute bg-opacity-0 justify-items-center py-4 px-7 opacity-0">
            {Array(9)
              .fill()
              .map((v, i) => {
                return (
                  <button
                    onClick={(e) => this.addHz(e, i + 1)}
                    className="bg-blue-500 w-9 h-5 flex justify-center items-center"
                    key={i}
                  >
                    {i}
                  </button>
                );
              })}

            <button
              onClick={(e) => this.applyHz(e)}
              className="bg-blue-500 w-9 h-5 flex justify-center items-center"
            >
              *
            </button>

            <button
              onClick={(e) => this.addHz(e, 0)}
              className="bg-blue-500 w-9 h-5 flex justify-center items-center"
            >
              0
            </button>

            <button
              onClick={(e) => this.resetHz(e)}
              className="bg-blue-500 w-9 h-5 flex justify-center items-center"
            >
              #
            </button>
          </div>
        </div>
        {/* <div className="w-1/5 h-1/4 bg-black flex text-white relative justify-center items-center">
            </div> */}
      </div>
    );
  }
}
