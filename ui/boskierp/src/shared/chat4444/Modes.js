import React from "react";
export default class Modes extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      currentModeId: 0,
      modes: props.modes || [],
    };

    this.index = -1;

    this.switch = this.switch.bind(this);
  }

  __switch__(value) {
    this.index += value;
    if (this.index < 0) this.index = this.state.modes.length - 1;
    else if (this.index >= this.state.modes.length) this.index = 0;

    this.setState({ currentModeId: this.index });
  }

  switch(value) {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.__switch__(value);
    }, 300);
  }

  render() {
    if (this.state.modes.length === 0) return;

    return (
      <div className=" h-auto flex gap-4 items-center">
        {this.state.modes.map((v, i) => {
          return (
            <button
              className={`${this.state.currentModeId === i && "text-blue-500 border-b-4 border-blue-500"}`}
            >
              {v.label}
            </button>
          );
        })}
      </div>
    );
  }
}
