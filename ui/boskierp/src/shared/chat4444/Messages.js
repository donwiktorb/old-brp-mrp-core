import React from "react";
export default class Messages extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      messages: [
        {
          type: "user",
          avatar:
            "https://avatars.akamai.steamstatic.com/21275ffda620fc58f655348d45a7e5f944a1e7ec_full.jpg",
          author: "donwiktorb",
          tags: [
            { label: "BoskieRP", color: "bg-orange-500" },
            { label: "System", color: "bg-blue-500" },
          ],
          content: "Hej Lorem ddddddddddddddddd",
        },
      ],
    };
    this.limit = 40;

    this.sentMessages = [
      {
        content: "dddd",
      },

      {
        content: "dddd4444",
      },

      {
        content: "4444dddd",
      },
    ];

    this.index = -1;

    this.scroll = this.scroll.bind(this);
    this.addSent = this.addSent.bind(this);
    this.resetScroll = this.resetScroll.bind(this);
  }

  resetScroll() {
    this.index = -1;
  }

  scroll(value) {
    this.index += value;

    if (this.index >= this.sentMessages.length) {
      this.index = 0;
    } else if (this.index < 0) {
      this.index = this.sentMessages.length - 1;
    }

    return this.sentMessages[this.index]?.content;
  }

  addSent(data) {
    this.sentMessages.push(data);
    if (this.sentMessages.length > this.limit) {
      this.sentMessages.splice(this.limit, 1);
    }
  }

  add(data) {
    switch (data.type) {
      case "user":
        data.color = this.generateColorFromNickname(data.author);
        break;
      default:
        data.content = this.formatString(data.html, data.args);
        break;
    }

    this.setState({ messages: [...this.state.messages, data] });

    if (data.sender) {
      this.addSent(data);
    }
  }

  set(data) {
    this.setState({ messages: data.messages || [] });
  }

  remove() {}

  edit() {}

  generateColorFromNickname(nickname) {
    // Generate a hash from the nickname
    let hash = 0;
    for (let i = 0; i < nickname.length; i++) {
      hash = nickname.charCodeAt(i) + ((hash << 5) - hash);
    }

    // Convert the hash to a hexadecimal color
    let color = "#";
    for (let j = 0; j < 3; j++) {
      let value = (hash >> (j * 8)) & 0xff;
      color += ("00" + value.toString(16)).substr(-2);
    }

    return color;
  }

  escape(str) {
    return String(str)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;");
  }

  formatString(str, ...args) {
    let nargs = args;
    if (typeof args[0] != "string") {
      let oldargs = nargs[0];
      let newargs = {};

      for (let index in oldargs) {
        let arg = oldargs[index];
        newargs[index] = this.escape(arg);
      }

      nargs = newargs;
    }

    return str.replace(/{(\d+)}/g, function (match, number) {
      return typeof nargs[number] != "undefined" ? nargs[number] : match;
    });
  }

  render() {
    return (
      <div
        id="messages"
        className="w-full h-full overflow-y-scroll flex flex-col gap-1 font-sans transition-all"
      >
        {this.state.messages.map((v, i) => {
          switch (v.type) {
            case "user": {
              return (
                <div className="flex gap-1 items-center flex-wrap animate-toRight">
                  <img
                    src={v.avatar}
                    alt="STEAM"
                    className="w-7 h-7 rounded-full"
                  />
                  {v.tags.map((tag, tagId) => {
                    return (
                      <div className={`px-0.5 rounded-lg ${tag.color} `}>
                        {tag.label}
                      </div>
                    );
                  })}
                  <div className="rounded-lg " style={{ color: v.color }}>
                    {v.author} :
                  </div>
                  <div className="break-all ">{v.content}</div>
                </div>
              );
            }
            default:
              return (
                <div
                  className={"animate-toRight"}
                  dangerouslySetInnerHTML={{
                    __html: v.content,
                  }}
                ></div>
              );
          }
        })}
      </div>
    );
  }
}
