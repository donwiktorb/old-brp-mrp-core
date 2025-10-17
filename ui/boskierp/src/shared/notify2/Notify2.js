import React from "react";
import { Transition } from "react-transition-group"; // ES6

const duration = 300;

const defaultStyle = {
  transition: `left ${duration}ms ease-in-out`,
  left: "300px",
};

const transitionStyles = {
  //   entering: { opacity: 1 },
  //   entered:  { opacity: 1 },
  //   exiting:  { opacity: 0 },
  //   exited:  { opacity: 0 },

  entering: { left: "0px" },
  entered: { left: "0px" },
  exiting: { left: "400px" },
  exited: { left: "400px" },
};

export default class Notify2 extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      content: "Naciśnij <k>test</k>",
      keys: ["spacja", "enter"],
      align: "right",
    };
    this.aligns = {
      right: "flex w-full h-full justify-end p-2 items-center text-white",
      "top-right": "flex w-full h-full justify-end p-2 items-start text-white",
      bottom: "flex w-full h-full justify-center p-2 items-end text-white",
    };

    this.kbdClass =
      "p-0.5 border-2 rounded-sm shadow-md shadow-white text-black bg-white";
    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
  }

  kB = (key) => {
    return (
      <kbd class="p-0.5 border-2 rounded-sm shadow-md shadow-white text-black bg-white">
        {key}
      </kbd>
    );
  };

  open(data) {
    this.setState(data);
  }

  close() {
    this.setState({ show: false });
  }

  render() {
    if (!this.state.show) return <div></div>;
    return (
      <Transition in={this.state.show} timeout={duration}>
        {(state) => (
          <div
            style={{
              ...defaultStyle,
              ...transitionStyles[state],
            }}
            className="w-full h-full absolute z-20"
          >
            <div className="w-full h-full">
              <div className={this.aligns[this.state.align]}>
                <div className="w-fit h-fit bg-black bg-opacity-50 rounded-lg">
                  <div className="w-full h-full bg-black opacity-70 rounded-lg flex justify-center items-center text-xl p-2">
                    <p
                      className="w-72 break-words leading-loose"
                      dangerouslySetInnerHTML={{
                        __html: this.state.content
                          .replaceAll(
                            "<k>",
                            '<kbd class="p-0.5 border-2 rounded-sm shadow-md shadow-white text-black bg-white">',
                          )
                          .replaceAll("</k>", "</kbd>"),
                      }}
                    >
                      {/* Naciśnij <kbd className={}>Spacja</kbd>, aby x d */}
                      {/* {this.formatString(this.state.content, ...this.state.keys)} */}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}
      </Transition>
    );
  }
}

