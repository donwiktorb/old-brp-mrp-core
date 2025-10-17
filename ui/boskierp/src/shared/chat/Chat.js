import React from "react";
import Messages from "./Messages";
import Suggestion from "./Suggestion";
import sendMessage from "../../Api";
import { Transition } from "react-transition-group"; // ES6

const duration = 300;

const defaultStyle = {
  transition: `opacity ${duration}ms ease-in-out`,
  opacity: 0,
};

const transitionStyles = {
  entering: { opacity: 1 },
  entered: { opacity: 1 },
  exiting: { opacity: 0 },
  exited: { opacity: 0 },
};
export default class Chat extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      hidden: true,
      hideInput: true,
      hideMessages: false,
    };

    this.timer = false;
    this.hideTimer = false;

    this.close = this.close.bind(this);
    this.open = this.open.bind(this);
    this.manage = this.manage.bind(this);
    this.messages = this.messages.bind(this);
    this.suggestions = this.suggestions.bind(this);
    this.currentTabIdx = 0;
  }

  onTimeoutEnd() {
    this.timer = false;
    this.hideChat(true);
    this.hideInput(true);
  }

  onHideTimeoutEnd() {
    this.hideTimer = false;
    this.hideChat(true);
    this.hideInput(true);
  }

  hideTimeout(action) {
    if (action === "set") {
      if (this.hideTimer) clearTimeout(this.hideTimer);
      this.hideInput(true);
      this.hideTimer = setTimeout(() => this.onHideTimeoutEnd(), 8000);
    } else if (action === "clear") {
      this.hideInput(false);
      if (this.hideTimer) clearTimeout(this.hideTimer);
    }
  }

  timeout(action) {
    if (action === "set") {
      if (this.timer) clearTimeout(this.timer);
      this.timer = setTimeout(() => this.onTimeoutEnd(), 8000);
    } else if (action === "clear") {
      if (this.timer) clearTimeout(this.timer);
    }
  }

  hideInput(state) {
    if (!state) this.timeout("clear");
    this.setState({
      hideInput: state,
    });
  }

  onMessage(e) {
    if (this.state.hideMessages && e.forced)
      this.setState({ hideMessages: false });

    if (this.state.hidden) {
      this.hideChat(false);
      this.timeout("set");
    }
  }

  hideChat(state) {
    if (state) {
      // this.Messages.clearIndex()
      this.setState({
        hidden: state,
      });
    } else {
      this.setState({
        hidden: !this.state.hidden,
      });
    }

    if (!this.state.hidden) document.getElementById("text").focus();
    else document.getElementById("text").blur();
  }

  componentDidMount() {
    document.onkeyup = (data) => {
      if (!this) return;
      // if (data.code === 'KeyT') {
      //     this.timeout('clear')
      //     this.setState({hidden:false, hideInput: false})
      //     document.getElementById("text").focus()
      // }else
      if (data.code === "PageUp") {
        //document.getElementById("messages").scrollTop -= 100;
      } else if (data.code === "PageDown") {
        //document.getElementById("messages").scrollTop += 100;
      }
    };
  }

  componentDidUpdate() {
    document.getElementById("text").focus();
  }

  open() {
    this.hideTimeout("clear");
    this.timeout("clear");
    this.setState({ hidden: false, hideInput: false }, () => {
      this.Messages.clearIndex();
    });
    // this.Messages.clearIndex()
  }

  close(data) {
    this.setState({ hideMessages: data.forcedHidden });
  }

  manage(data) {
    this.hideChat(data.enable);
  }

  messages(data) {
    if (data.action === "add") this.onMessage(data);

    let func = this.Messages[data.action];
    if (func) func(data);
  }

  suggestions(data) {
    let fnc = this.Suggestions[data.action];
    if (fnc) fnc(data);
  }

  onChange = (e) => {
    let value = e.target.value;
    if (value && value.startsWith("/") && value.length > 1) {
      this.Suggestions.getSuggestions(value);
    } else {
      this.Suggestions.removeSuggestions();
    }
  };

  cancel = (e) => {
    sendMessage("chat_state", {
      active: false,
    });

    this.hideTimeout("set");
  };

  onEnterPress = (e) => {
    if (e.keyCode === 13 && e.shiftKey === false) {
      e.preventDefault();
      let value = e.target.value;
      if (value === "") return;
      // this.Messages.send(value)
      sendMessage("chat_send", {
        message: value,
      });

      this.Messages.addOld(value);

      this.Suggestions.removeSuggestions();
      e.target.value = "";

      sendMessage("chat_state", {
        active: false,
      });

      this.hideTimeout("set");
    } else if (e.code === "Escape") {
      sendMessage("chat_state", {
        active: false,
      });

      this.hideTimeout("set");

      // e.target.blur()
    } else if (e.code === "ArrowUp" || e.code === "ArrowDown") {
      e.preventDefault();
      let msg = this.Messages.getOldMessage(e.code === "ArrowUp");
      if (msg) {
        e.target.value = msg;
      }
    } else if (e.code === "PageDown" || e.code === "PageUp") {
      console.log(e);
      if (e.code === "PageUp") {
        document.getElementById("messages").scrollTop -= 100;
      } else if (e.code === "PageDown") {
        document.getElementById("messages").scrollTop += 100;
      }
    } else if (e.code === "Tab") {
      e.preventDefault();
      let sugg = this.Suggestions.getCurrentSuggestions(e.target.value);
      let currentSugg = sugg[this.currentTabIdx];
      if (currentSugg) {
        this.Suggestions.updateLastValue(e.target.value);
        e.target.value = currentSugg.name;
        this.currentTabIdx += 1;
      } else {
        this.currentTabIdx = 0;
        this.Suggestions.updateLastValue(false);
      }
    }
  };

  render() {
    return (
      <Transition in={!this.state.hidden} timeout={duration}>
        {(state) => (
          <div
            style={{
              ...defaultStyle,
              ...transitionStyles[state],
            }}
            // style={{display: this.state.hidden ? 'none' : 'block'}}
            className="rounded w-1/3  h-72 flex flex-col mt-10 ml-4 font-sans "
          >
            <div
              style={{ display: this.state.hideMessages ? "none" : "block" }}
              id="messages"
              className="flex justify-left  w-full h-full flex-col  overflow-hidden "
            >
              <Messages ref={(ref) => (this.Messages = ref)} />
            </div>
            <div
              className="flex flex-col h-4"
              style={{ display: this.state.hideInput ? "none" : "block" }}
            >
              <input
                id="text"
                className="text-white rounded focus:outline-none bg-opacity-20 w-full bg-black placeholder-white"
                onChange={this.onChange}
                style={{ resize: "none" }}
                placeholder="➤"
                autoFocus
                type="text"
                spellCheck="false"
                onKeyDown={this.onEnterPress}
                onBlur={this.cancel}
              />
              <Suggestion ref={(ref) => (this.Suggestions = ref)} />
            </div>
          </div>
        )}
      </Transition>
    );
  }
}
