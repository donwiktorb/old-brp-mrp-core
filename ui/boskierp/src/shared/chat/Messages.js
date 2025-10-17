import React from "react";

export default class Messages extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      messages: [] || [
        {
          content: "DWB",
        },

        ...Array(343).fill({ content: "dwb4" }),
      ],
    };

    this.oldMessages = [];
    this.oldIndex = 0;

    this.send = this.send.bind(this);
    this.add = this.add.bind(this);
    this.clear = this.clear.bind(this);
    this.addOld = this.addOld.bind(this);
    this.getOldMessage = this.getOldMessage.bind(this);
    this.clearIndex = this.clearIndex.bind(this);
  }

  clearIndex() {
    this.oldIndex = this.oldMessages.length;
  }

  componentDidUpdate() {
    this.updateScroll();
  }

  getOldMessage(up) {
    if (up) this.oldIndex -= 1;
    else this.oldIndex += 1;

    if (this.oldIndex >= this.oldMessages.length) this.oldIndex = 0;
    else if (this.oldIndex < 0) this.oldIndex = this.oldMessages.length - 1;

    let msg = this.oldMessages[this.oldIndex];

    return msg.content;
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

  clear() {
    this.setState({ messages: [] });
  }

  add(data) {
    let message = this.formatString(data.html, data.args);
    // let args = message.split(' ')
    // for (let i in args) {
    //     if (args[i].includes('boskierp.pl/img')) {
    //         args[i] = `<img width="70%" src=${args[i].split('.jpg')[0]+".jpg"} alt='hello' />`
    //     }
    // }

    // message = args.join(' ')

    let messages = this.state.messages;

    if (messages.length > 80) messages.splice(0, 1);

    messages.push({ content: message, name: data.name });

    this.setState({ messages: messages });
    this.clearIndex();
  }

  edit(data) {
    let message = this.formatString(data.html, data.args);
    const msgs = this.state.messages;

    msgs.forEach((v) => {
      if (v.name && v.name === data.name) {
        v.content = message;
      }
    });

    this.setState({ messages: msgs });
  }

  addOld(content) {
    let messages = this.oldMessages;

    for (let msg of messages) {
      if (msg.content === this.escape(content)) return;
    }

    if (messages.length > 40) {
      messages.splice(0, 1);
    }
    messages.push({
      content: this.escape(content),
    });
    this.oldMessages = messages;
    this.clearIndex();
  }

  send(content) {
    let messages = this.state.messages;
    if (messages.length > 40) {
      messages.splice(0, 1);
    }
    messages.push({
      content: this.escape(content),
    });
    this.setState({
      messages: messages,
    });
  }

  updateScroll() {
    var element = document.getElementById("messages");
    element.scrollTop = element.scrollHeight;
  }

  render() {
    return this.state.messages.map((v, i, a) => {
      return (
        <div
          className="animate-fade"
          key={i}
          dangerouslySetInnerHTML={{ __html: v.content }}
        ></div>
      );
    });
  }
}
