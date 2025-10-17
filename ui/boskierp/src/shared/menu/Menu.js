/*
    Opened: [
        {
            name: 'dwb',
            title: 'dwb,
            align: 'justify-center items-center',
            elements: -> Elements.js
        }
    ]    
*/

import React from "react";
import Elements from "./Elements";
import sendMessage from "../../Api";

export default class Menu extends React.Component {
  constructor(props) {
    super(props);

    this.alignTypes = {
      left: "justify-start",
      right: "justify-end",
      center: "justify-center",
      middle: "items-center",
      top: "items-start",
      bottom: "items-end",
    };

    this.state = {
      opened: [
        // {
        //     name: 'dwb',
        //     title: 'dwb',
        //     align: 'justify-center items-center',
        //     elements: []
        // }
      ],
      active: 0,
    };

    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
    this.scroll = this.scroll.bind(this);
    this.cancel = this.cancel.bind(this);
    this.scrollSide = this.scrollSide.bind(this);
    this.submit = this.submit.bind(this);
  }

  changeElements(elements) {
    this.setState((state) => {
      const opened = state.opened;
      opened[0].elements = elements;
      return {
        opened,
      };
    });
  }

  cancel() {
    let menu = this.state.opened[0];
    let selected = this.Elements.getSelected();
    // this.close(menu.name)
    sendMessage("menu_cancel", {
      current: selected,
      menu: menu,
    });
  }

  submit() {
    let selected = this.Elements.getSelected();
    sendMessage("menu_submit", {
      current: selected,
      menu: this.state.opened[0],
    });
  }

  menuChanged(selected) {
    sendMessage("menu_change", {
      current: selected,
      menu: this.state.opened[0],
    });
  }

  scroll(data) {
    this.Elements.scroll(data?.up);
    this.setState((state) => {
      const opened = state.opened;
      opened[0].elements = this.Elements.getCurrent();
      return {
        opened,
      };
    });
  }

  scrollSide(data) {
    this.Elements.scrollSide(data?.right);
    this.setState((state) => {
      const opened = state.opened;
      opened[0].elements = this.Elements.getCurrent();
      return {
        opened,
      };
    });
  }

  getAlign(align) {
    let newAlign = "";

    if (align.includes("-")) align = align.split("-");
    else newAlign = this.alignTypes[align] + " items-center";

    if (newAlign === "")
      for (let val of align) {
        let newAl = this.alignTypes[val];
        if (newAl) newAlign += newAl + " ";
      }
    return newAlign;
  }

  close(data) {
    this.setState((state) => {
      const opened = state.opened;

      for (let menu of opened) {
        if (menu.name === data.name) {
          this.Elements.clear();
          let number = opened.indexOf(menu);
          opened.splice(number, 1);
        }
      }

      return {
        opened,
      };
    });
  }

  open(data) {
    let { title, name, align, elements, update, oldupdate } = data;

    if (!update && !oldupdate) {
      let fixedAlign = this.getAlign(align);
      let menu = {
        name: name,
        title: title,
        align: fixedAlign,
        elements: elements,
      };
      // this.Elements.set(elements)
      this.setState((state) => {
        const opened = [menu, ...state.opened];
        return {
          opened,
        };
      });
    } else {
      if (oldupdate) {
        this.setState((state) => {
          const opened = state.opened;
          opened.forEach((v) => {
            if (v.name === name) {
              let key = data.key;
              let value = data.value;
              let updates = data.data;
              v.elements.forEach((nv) => {
                if (nv[key] === value) {
                  for (let u in updates) {
                    let uv = updates[u];
                    nv[u] = uv;
                  }
                }
              });
              // for (let i in data.keys) {
              //     let v = data.keys[i]
              //     if (v.elements[i] === v) {
              //        for (let k in data.values) {
              //             let v = data.values[k]
              //             v.elements[i][k] = v
              //        }
              //     }
              // }
            }
          });
          return {
            opened,
          };
        });
      } else if (name === this.state.opened[0].name) {
        this.setState((state) => {
          const opened = state.opened;
          if (title) opened[0].title = title;
          if (elements) opened[0].elements = elements;

          return {
            opened,
          };
        });
      } else {
        this.setState((state) => {
          const opened = state.opened;
          opened.forEach((v) => {
            if (v.name === name) {
              if (title) v.title = title;
              if (elements) v.elements = elements;
            }
          });
          return {
            opened,
          };
        });
      }
    }
  }

  render() {
    return (
      <div
        style={{ display: this.state.opened.length > 0 ? "" : "none" }}
        className={`flex select-none h-screen ${this.state.opened[this.state.active]?.align}`}
      >
        <div
          id="Elements"
          className="m-6 w-1/5 max-h-80 text-center overflow-hidden font-sans rounded-lg bg-black bg-opacity-80 "
        >
          <table className="table-fixed  min-w-full">
            <thead id="nav" className="sticky top-0 text-lg">
              <tr>
                <th
                  className="w-1/2 bg-green-400 sticky top-0"
                  dangerouslySetInnerHTML={{
                    __html: this.state.opened[this.state.active]?.title,
                  }}
                ></th>
              </tr>
            </thead>
            <tbody className="break-words text-green-400 animate-fade text-lg">
              <Elements
                menuChanged={(selected) => this.menuChanged(selected)}
                changeElements={(elements) => this.changeElements(elements)}
                elements={this.state.opened[this.state.active]?.elements}
                ref={(ref) => (this.Elements = ref)}
              />
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}
