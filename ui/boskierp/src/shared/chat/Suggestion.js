import React from "react";

export default class Suggestion extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      suggestions: [],
      currentSuggestions: [],
    };

    this.clear = this.clear.bind(this);

    this.set = this.set.bind(this);

    this.getCurrentSuggestions = this.getCurrentSuggestions.bind(this);

    this.getSuggestions = this.getSuggestions.bind(this);

    this.updateLastValue = this.updateLastValue.bind(this);
  }

  clear() {
    this.setState({ suggestions: [] });
  }

  set(data) {
    data.suggestions.forEach((v) => {
      if (!v.args) v.args = [];
    });
    this.setState({ suggestions: data.suggestions });
  }

  removeSuggestions() {
    this.setState({ currentSuggestions: [] });
  }

  updateLastValue(value) {
    if (!this.lastValue) this.lastValue = value;
  }

  getCurrentSuggestions(content) {
    content = this.lastValue || content;
    let suggestions = this.state.suggestions;
    let newCurrentSuggestions = [];
    let command = content.split(" ");
    let cmd = command[0];
    let cmdLength = command.length - 2;
    let counter = 0;
    suggestions.forEach((v) => {
      if (counter < 3) {
        if (v.name.startsWith(cmd)) {
          let crnt = v;

          crnt.args.map((nv, ni, na) => {
            if (nv.current && cmdLength < ni) nv.current = undefined;
            else if (!nv.current && cmdLength === ni) nv.current = true;
            return true;
          });

          newCurrentSuggestions.push(crnt);
          counter += 1;
        }
      }
    });

    return newCurrentSuggestions;
  }

  getSuggestions(content) {
    let suggestions = this.state.suggestions;
    let newCurrentSuggestions = [];
    let command = content.split(" ");
    let cmd = command[0];
    let cmdLength = command.length - 2;
    let counter = 0;
    suggestions.map((v) => {
      if (counter < 3) {
        if (v.name.startsWith(cmd)) {
          let crnt = v;

          crnt.args.map((nv, ni, na) => {
            if (nv.current && cmdLength < ni) nv.current = undefined;
            else if (!nv.current && cmdLength === ni) nv.current = true;
            return true;
          });

          newCurrentSuggestions.push(crnt);
          counter += 1;
        }
        return true;
      } else return false;
    });

    this.setState({ currentSuggestions: newCurrentSuggestions });
  }

  render() {
    if (this.state.currentSuggestions.length > 0)
      return (
        <div className=" h-48 max-h-full md:max-h-screen rounded mt-1">
          {this.state.currentSuggestions.map((v, i) => {
            return (
              <div key={i} className="m-1 rounded text-white ">
                <span>
                  {v.name}
                  {v.args.map((ne, ni, na) => {
                    return (
                      <span
                        key={ni}
                        className={ne.current ? "text-purple-600" : ""}
                      >
                        {" "}
                        [{ne.name}]
                      </span>
                    );
                  })}
                  {v.help && " -> " + v.help}
                </span>
              </div>
            );
          })}
        </div>
      );
    else return <div></div>;
  }
}

