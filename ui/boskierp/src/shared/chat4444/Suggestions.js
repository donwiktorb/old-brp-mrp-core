import React from "react";

export default class Suggestions extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      suggestions: [
        {
          name: "car",
          args: [{ name: "modelHash" }, { name: "pedId" }],
          desc: "Zresp auto",
        },

        {
          name: "car4444",
          args: [{ name: "modelHash" }, { name: "pedId" }],
          desc: "Zresp auto",
        },

        {
          name: "car4",
          args: [{ name: "modelHash" }, { name: "pedId" }],
          desc: "Zresp auto",
        },
      ],
      currentSuggestions: [],
    };

    this.lastSuggestions = [];
    this.lastCommand = null;
    this.index = -1;

    this.update = this.update.bind(this);
    this.clear = this.clear.bind(this);
    this.scroll = this.scroll.bind(this);
  }

  scroll(value) {
    this.index = this.index + value;

    if (this.index < 0) {
      this.index = this.lastSuggestions.length - 1;
    } else if (this.index >= this.lastSuggestions.length) {
      this.index = 0;
    }

    return this.lastSuggestions[this.index]?.name;
  }

  clear() {
    this.index = -1;
    this.lastSuggestions = [];
    this.setState({ currentSuggestions: [] });
  }

  __update__(content) {
    let value = content.slice(1);
    let sValue = value.split(" ");
    let command = sValue[0].toLowerCase();
    sValue.splice(0, 1);
    const argsLength = sValue.length - 1;
    console.log(command);
    this.setState((state) => {
      const suggestions = state.suggestions;
      const currentSuggestions = suggestions
        .filter((v) => v.name.toLowerCase().includes(command))
        .slice(0, 3)
        .map((v) => {
          const crnt = { ...v };
          console.log(argsLength, sValue);
          crnt.args = crnt.args.map((arg, argId) => {
            if (arg.current && argsLength < argId) {
              arg.current = undefined;
            } else if (!arg.current && argsLength === argId) {
              arg.current = true;
            }
            return arg;
          });

          return crnt;
        });
      this.lastSuggestions = currentSuggestions;
      return { currentSuggestions };
    });
  }

  update(content) {
    clearTimeout(this.timeout);
    //this.timeout = setTimeout(() => { this.__update__(content); }, 300);
    this.__update__(content);
  }

  render() {
    return (
      <div className="flex flex-col gap-0.5">
        {this.state.currentSuggestions.map((v, i) => {
          return (
            <div
              key={`chat-suggestion-${i}`}
              className="bg-black bg-opacity-70 backdrop-blur rounded-lg text-white px-0.5 flex gap-1 animate-toRight"
            >
              <div>/{v.name}</div>
              {v.args?.map((arg, argId) => {
                return (
                  <div
                    className={`${arg.current && "text-purple-400"} transition-all`}
                  >
                    [{arg.name}]
                  </div>
                );
              })}
              {v.desc && <div>➤ {v.desc}</div>}
            </div>
          );
        })}
      </div>
    );
  }
}
