import React from "react";
import sendMessage from "../../Api";
import Suggestions from "./Suggestions";
import Messages from "./Messages";
import Modes from "./Modes";
export default class Chat extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      modes: [
        { label: "Global", type: "global" },

        {
          label: "Tryb",
          type: "mode",
        },
        {
          label: "Party",

          type: "party",
        },
      ],
    };

    this.commandInput = false;
    this.emptyInput = false;
  }

  onInputChange(e) {
    let value = e.target.value;

    if (value && value.startsWith("/") && value.length > 1) {
      this.Suggestions.update(value);

      this.commandInput = true;
    } else {
      this.Suggestions.clear();
      this.Messages.resetScroll();

      this.commandInput = false;
    }
  }

  onInputKeyDown(e) {
    if (e.target.value.length > 0) this.emptyInput = false;
    else this.emptyInput = true;
    switch (e.code) {
      case "Enter":
        if (!e.shiftKey) {
          this.handleEnterKey(e);
        }
        break;
      case "Escape":
        this.handleEscapeKey();
        break;
      case "ArrowUp":
      case "ArrowDown":
        this.handleArrowKeys(e);
        break;
      case "PageUp":
      case "PageDown":
        this.handlePageKeys(e);
        break;
      case "Tab":
        if (this.commandInput) this.handleCommandSwitch(e);
        else if (this.emptyInput) this.handleModeSwitch(e);
        break;
      default:
        break;
    }
  }

  handleEnterKey(e) {
    e.preventDefault();
    let value = e.target.value;
    if (value === "") return;
    this.Messages.addSent({ content: value });
    this.Messages.add({ html: "{0}", args: value });
    e.target.value = "";
  }

  handleEscapeKey() {
    sendMessage("chat_state", {
      active: false,
    });
  }

  handleArrowKeys(e) {
    e.preventDefault();
    let msg = this.Messages.scroll(e.code === "ArrowUp" ? -1 : 1);
    if (msg) {
      e.target.value = msg;
    }
  }

  handlePageKeys(e) {
    const messagesElement = document.getElementById("messages");
    if (!messagesElement) return;

    if (e.code === "PageUp") {
      messagesElement.scrollTop -= 100;
    } else if (e.code === "PageDown") {
      messagesElement.scrollTop += 100;
    }
  }

  handleCommandSwitch(e) {
    e.preventDefault();
    let name = this.Suggestions.scroll(e.shiftKey ? -1 : 1);
    if (name) e.target.value = "/" + name;
  }

  handleModeSwitch(e) {
    e.preventDefault();

    this.Modes.switch(e.shiftKey ? -1 : 1);
  }

  render() {
    if (true) return <></>;
    return (
      <div className="w-full h-full select-none">
        <div className="w-full h-full flex justify-start items-start p-0.5 flex-col gap-1">
          <div className="rounded-lg bg-black bg-opacity-70 backdrop-blur w-1/4 h-1/4 flex flex-col p-0.5 text-white z-20 resize relative overflow-auto max-h-full ">
            <div className="w-full h-auto flex  items-center py-0.5 justify-between">
              <Modes
                modes={this.state.modes}
                ref={(ref) => (this.Modes = ref)}
              />

              <div className=" h-auto flex gap-4 items-center">
                <button className="text-white w-5 h-5">
                  <svg
                    className="w-full h-full "
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M12 3V9M12 3L9 6M12 3L15 6M12 15V21M12 21L15 18M12 21L9 18M3 12H9M3 12L6 15M3 12L6 9M15 12H21M21 12L18 9M21 12L18 15"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                </button>
                <button className="text-white w-5 h-5">
                  <svg
                    className="w-full h-full "
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M12 3V9M12 3L9 6M12 3L15 6M12 15V21M12 21L15 18M12 21L9 18M3 12H9M3 12L6 15M3 12L6 9M15 12H21M21 12L18 9M21 12L18 15"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                </button>
                <button className="text-white w-5 h-5">
                  <svg
                    className="w-full h-full "
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M12 3V9M12 3L9 6M12 3L15 6M12 15V21M12 21L15 18M12 21L9 18M3 12H9M3 12L6 15M3 12L6 9M15 12H21M21 12L18 9M21 12L18 15"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                </button>
              </div>
            </div>

            <Messages ref={(ref) => (this.Messages = ref)} />

            <div className="w-full flex gap-0.5 flex-col">
              <input
                type="text"
                className="appearance-none bg-transparent focus:outline-none placeholder:font-bold w-full border-t border-gray-400"
                placeholder="➤"
                onChange={(e) => this.onInputChange(e)}
                onKeyDown={(e) => this.onInputKeyDown(e)}
              />
            </div>
          </div>
          <Suggestions ref={(ref) => (this.Suggestions = ref)} />
        </div>
      </div>
    );
  }
}
