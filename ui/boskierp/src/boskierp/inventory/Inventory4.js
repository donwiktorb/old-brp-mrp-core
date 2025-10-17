import React from "react";
import "./inventory.css";

import sendMessage from "../Api";

export default class Inventory extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      showDropdown: false,
      currentDesc: [],
      Inventories: [
        {
          name: "inventory",
          label: "Ekwipunek",
          weight: 0.4,
          maxWeight: 40.0,
          items: [
            {
              slot: 1,
              name: "weapon_flare",
              ammo: 200000000,
              weight: 0.2,
              label: "Flara",
              // description: `
              //     Amunicja do pistoletu na flary.
              // `
              description: [
                {
                  label: "Amunicja do pistoletu",
                },
                {
                  label: "Tłumik",
                },
              ],
            },
          ],
        },
        {
          name: "drop",
          label: "Ziemia",
          weight: 0.0,
          maxWeight: 100.0,
          items: [],
        },
      ],
    };
    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
    this.updateItems = this.updateItems.bind(this);
    this.quantity = 1;
    this.current = null;
    this.currentDescItem = null;
  }

  onImageError(e, name) {
    e.preventDefault();
    let parent = e.target.parentElement;
    let el = document.createElement("div");
    let content = document.createTextNode(name);
    el.className =
      "text-center flex justify-center p items-center border-2 rounded-full leading-loose w-10 h-10 text-lg";
    el.appendChild(content);
    parent.append(el);
    e.target.remove();
  }

  updateItems(data) {
    this.setState((state) => {
      const Inventories = state.Inventories;
      data.forEach((v, i) => {
        if (v.name === data.name) {
          Inventories[i].items = data.items;
        }
      });

      return {
        Inventories,
      };
    });
  }

  open(data) {
    if (!data.update)
      this.setState((state) => {
        const Inventories = data.inventories;
        const show = true;
        return {
          Inventories,
          show,
        };
      });
    else {
      this.setState((state) => {
        const Inventories = state.Inventories;

        Inventories.forEach((v, i) => {
          data.inventories.forEach((nv) => {
            if (v.name === nv.name) {
              Inventories[i] = nv;
            }
          });
        });

        return {
          Inventories,
        };
      });
    }
  }

  close() {
    this.setState({
      show: false,
    });
    sendMessage("menu_cancel", {
      name: "inventory",
    });
  }

  isInViewport(element) {
    const rect = element.getBoundingClientRect();
    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <=
        (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
  }

  tool(e, item) {
    e.preventDefault();
    let elem = document.getElementById("inventory-pop");
    let top = e.clientY;
    let left = e.clientX;
    console.log(top, left);

    if (elem) {
      elem.style.top = top + "px";
      elem.style.left = left + "px";
    }

    if (!this.isInViewport(elem)) {
      elem.style.left = left - elem.clientWidth + "px";
    }

    if (!this.isInViewport(elem)) {
      elem.style.top = top - elem.clientHeight + "px";
    }

    if (!this.isInViewport(elem)) {
      elem.style.left = left + "px";
    }

    // elem.children.innerHTML = item.description
    // console.log(elem)

    this.currentDescItem = item;

    this.setState({
      showDropdown: !this.state.showDropdown,
      currentDesc: item.description,
    });
  }

  mouseDown(e) {
    e.preventDefault();
    if (e.button === 0) {
      if (this.current === e.target) {
        this.current.style.opacity = 1.0;
        this.current = null;
      } else {
        if (this.current) {
          let current = this.current;
          let currentTarget = e.target;

          let currentData = current.dataset;
          let targetData = currentTarget.dataset;

          let oldslot = Number(currentData.slot);
          let newslot = Number(targetData.slot);

          let inv = current.id.split("-")[1];
          let newinv = currentTarget.id.split("-")[1];

          // inventory changed
          sendMessage("menu_change", {
            name: "inventory",
            action: "item_change",
            item: {
              quantity: this.quantity,
              type: currentData.type,
              oldslot: oldslot,
              newslot: newslot,
              oldinv: inv,
              newinv: newinv,
              oldname: currentData.name,
              newname: targetData.name,
            },
          });

          this.current.style.opacity = 1.0;
          this.current = null;
          return;
        }
        this.current = e.target;
        this.current.style.opacity = 0.2;
      }
    }
  }

  mouseUp(e) {
    if (this.current) {
      this.current.style.opacity = 1.0;

      let current = this.current;
      let currentTarget = e.target;

      let currentData = current.dataset;
      let targetData = currentTarget.dataset;

      let { action } = targetData;

      if (action === "use") {
        let inv = current.id.split("-")[1];
        sendMessage("menu_submit", {
          name: "inventory",
          action: "use",
          item: {
            quantity: this.quantity,
            type: currentData.type,
            slot: currentData.slot,
            inv: inv,
            name: currentData.name,
            count: currentData.count,
          },
        });
      } else {
        let oldslot = Number(currentData.slot);
        let newslot = Number(targetData.slot);

        let inv = current.id.split("-")[1];
        let newinv = currentTarget.id.split("-")[1];

        if (inv !== newinv) {
          // inventory changed
          sendMessage("menu_change", {
            name: "inventory",
            action: "inventory_change",
            item: {
              quantity: this.quantity,
              type: currentData.type,
              oldInv: inv,
              newInv: newinv,
              oldslot: oldslot,
              newslot: newslot,
              name: currentData.name,
            },
          });
        } else {
          if (oldslot !== newslot) {
            // inventory slot change
            sendMessage("menu_change", {
              name: "inventory",
              action: "slot_change",
              item: {
                quantity: this.quantity,
                type: currentData.type,
                oldslot: oldslot,
                newslot: newslot,
              },
            });
          }
        }

        // handle slot change ui

        // this.setState(state => {
        //     const Inventories = state.Inventories
        //     Inventories.forEach((v,i,a) => {
        //         if (v.name === inv) {
        //             v.items.forEach((nv, ni) => {
        //                 if (nv.slot === oldslot) {
        //                     if (v.name === newinv) {
        //                         nv.slot = newslot
        //                     }
        //                 }
        //             })
        //         }
        //     })

        //     return {
        //         Inventories
        //     }
        // })
      }
      this.current = null;
    }
  }

  getSlotById(id, inv) {
    let itemId = id;
    this.state.Inventories.forEach((v, i) => {
      if (v.name === inv) {
        v.items.forEach((nv, ni) => {
          if (nv.slot === id) {
            itemId = ni;
          }
        });
      }
    });
    return itemId;
  }

  changeQuantity(e) {
    let target = e.target;
    let value = target.value;
    this.quantity = Math.floor(value);
    target.value = Math.floor(value);
  }

  descButton(e, v) {
    e.preventDefault();
    if (v.value) {
      sendMessage("menu_change", {
        name: "inventory",
        action: "inventory_item_addon",
        item: this.currentDescItem,
        button: v,
      });
    }
  }

  render() {
    const [main, second] = this.state.Inventories;
    return (
      <div
        id="inv"
        style={{ display: this.state.show ? "" : "none" }}
        className={`flex absolute h-screen justify-center items-center z-20 w-screen `}
      >
        <div
          id="inventory-pop"
          style={{ display: this.state.showDropdown ? "block" : "none" }}
          className="w-64 z-10 absolute text-center overflow-hidden font-sans grid grid-cols-1 gap-2"
        >
          <div className="bg-gray-800 text-white text-lg bg-opacity-80 rounded truncate flex flex-col gap-4 p-2">
            {this.state.currentDesc.map((v) => {
              return (
                <button
                  className="bg-black bg-opacity-50 rounded"
                  onClick={(e) => this.descButton(e, v)}
                >
                  {v.label}
                </button>
              );
            })}
          </div>
        </div>
        <div className="h-5/6 w-5/6 text-center font-sans rounded-lg bg-gray-900 opacity-90">
          <div className="h-full w-full flex flex-col rounded-md">
            <div className="w-full h-full rounded overflow-auto">
              <div className="w-full h-full flex">
                <div className="w-1/2 h-full">
                  <div className="h-full p-2">
                    <div className="p-2 h-[8%]">
                      <div className="flex justify-between mb-1">
                        <span className="text-base font-medium text-white">
                          {main.label}
                        </span>
                        <span className="text-sm font-medium text-white">
                          {main.weight}/{main.maxWeight}kg
                        </span>
                      </div>
                      <div className="w-full rounded-full h-2.5 bg-gray-700">
                        <div
                          className="bg-blue-600 h-2.5 rounded-full"
                          style={{
                            width:
                              (main.maxWeight
                                ? (100 * main.weight) / main.maxWeight
                                : 0) + "%",
                          }}
                        ></div>
                      </div>
                    </div>
                    <div className="w-full h-[92%] p-4 grid grid-cols-5 gap-5 justify-items-center overflow-auto">
                      {Array(main.slots || 45)
                        .fill()
                        .map((v, i) => {
                          i += 1;
                          const slot = this.getSlotById(i, main.name);
                          const item = main.items[slot]
                            ? main.items[slot].slot === i
                              ? main.items[slot]
                              : null
                            : null;
                          return item ? (
                            <div
                              onContextMenu={(e) => this.tool(e, item)}
                              onMouseDown={(e) => this.mouseDown(e)}
                              id={`slot-${main.name}-${slot}`}
                              data-type={item.type}
                              data-slot={i}
                              data-name={item.name}
                              data-count={item.count ? item.count : item.ammo}
                              data-inv={0}
                              key={i}
                              className="
                                                            group
                                                            select-none
                                                            w-28 h-28 bg-black rounded-lg
                                                            hover:bg-gray-400
                                                            transition-all
                                                            text-center
                                                            text-white
                                                            relative
                                                        "
                            >
                              {/* <span className="pointer-events-none absolute -bottom-10 z-40 left-1/2 -translate-x-1/2 whitespace-nowrap rounded bg-black px-2 py-1 text-white opacity-0 transition before:absolute before:left-1/2 before:top-full before:-translate-x-1/2 before:border-4 before:border-transparent before:border-t-black before:content-[''] group-hover:opacity-100">
                                                                {item.description}
                                                        </span> */}
                              <div className="pointer-events-none flex justify-center items-center h-full ">
                                <p className="absolute top-0 left-1">
                                  {item.label}
                                </p>
                                <img
                                  draggable="false"
                                  className="
                                                                select-none
                                                                object-scale-down
                                                                object-center
                                                                w-28 h-28
                                                                p-2
                                                                "
                                  onError={(e) =>
                                    this.onImageError(e, item.name)
                                  }
                                  src={`${process.env.PUBLIC_URL}/img/${item.name}.png`}
                                  alt={item.name}
                                />
                                <p className="absolute bottom-0 left-1">
                                  {item.ammo || item.count}x
                                </p>
                                <p className="absolute bottom-0 right-1">
                                  {item.weight}kg
                                </p>
                              </div>
                            </div>
                          ) : (
                            <div
                              id={`slot-${main.name}-${i + 1}`}
                              key={i}
                              onMouseUp={(e) => this.mouseUp(e)}
                              data-type="slot"
                              data-inv={0}
                              data-slot={i}
                              className="
                                                            w-28 h-28 bg-black rounded-lg
                                                            hover:bg-gray-400
                                                            transition-all
                                                            text-center
                                                            text-white
                                                            relative
                                                        "
                            ></div>
                          );
                        })}
                    </div>
                  </div>
                </div>

                <div className="w-1/6 h-full bg-black">
                  <div className="h-full w-full flex justify-center items-center">
                    <div className="w-full h-1/3 p-2">
                      <div className="w-full h-full bg-black flex flex-col justify-evenly p-2 select-none">
                        <input
                          inputMode="numeric"
                          step="1"
                          min="0"
                          defaultValue="1"
                          onChange={(e) => this.changeQuantity(e)}
                          placeholder="Ilość"
                          type="number"
                          id="default-input"
                          className="appearance-none  border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 text-center"
                        ></input>
                        <div
                          onMouseUp={(e) => this.mouseUp(e)}
                          data-action="use"
                          type="button"
                          className=" w-full text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800"
                        >
                          Użyj
                        </div>
                        <button
                          onClick={() => this.close()}
                          data-action="close"
                          type="button"
                          className=" w-full text-gray-900 hover:text-white border border-gray-800 hover:bg-gray-900 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-gray-600 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-800"
                        >
                          Zamknij
                        </button>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="w-1/2 h-full">
                  <div className="h-full p-2">
                    <div className="p-2 h-[8%]">
                      <div className="flex justify-between mb-1">
                        <span className="text-base font-medium text-white">
                          {second.label}
                        </span>
                        <span className="text-sm font-medium text-white">
                          {second.weight && second.maxWeight
                            ? `${second.weight}/${second.maxWeight}kg`
                            : ""}
                        </span>
                      </div>
                      <div className="w-full  rounded-full h-2.5 bg-gray-700">
                        <div
                          className="bg-blue-600 h-2.5 rounded-full"
                          style={{
                            width:
                              (second.weight
                                ? 100 * second.weight
                                : 0 / second.maxWeight
                                  ? second.maxWeight
                                  : 0) + "%",
                          }}
                        ></div>
                      </div>
                    </div>
                    <div className="w-full h-[92%] p-4 grid grid-cols-5 gap-5 justify-items-center overflow-auto">
                      {Array(second.maxSlots || second.slots || 45)
                        .fill()
                        .map((v, i) => {
                          i += 1;
                          const slot = this.getSlotById(i, second.name);
                          const item = second.items[slot]
                            ? second.items[slot].slot === i
                              ? second.items[slot]
                              : null
                            : null;
                          return item ? (
                            <div
                              onMouseDown={(e) => this.mouseDown(e)}
                              id={`slot-${second.name}-${slot}`}
                              data-type={item.type}
                              data-inv={0}
                              data-name={item.name}
                              data-count={item.count ? item.count : item.ammo}
                              data-slot={i}
                              key={i}
                              className="
                                                            select-none
                                                            w-28 h-28 bg-black rounded-lg
                                                            hover:bg-gray-400
                                                            transition-all
                                                            text-center
                                                            text-white
                                                            relative
                                                        "
                            >
                              <div className="pointer-events-none flex justify-center items-center h-full">
                                <p className="absolute top-0 left-1">
                                  {item.label}
                                </p>
                                <img
                                  className="
                                                                object-scale-down
                                                                object-center
                                                                w-28 h-28
                                                                p-2
                                                                "
                                  onError={(e) =>
                                    this.onImageError(e, item.name)
                                  }
                                  src={`${process.env.PUBLIC_URL}/img/${item.name}.png`}
                                  alt={item.name}
                                />
                                <p className="absolute bottom-0 left-1">
                                  {item.ammo || item.count
                                    ? `${item.ammo || item.count}x`
                                    : ""}
                                </p>
                                <p
                                  className="absolute bottom-0 right-1"
                                  dangerouslySetInnerHTML={{
                                    __html: item.weight
                                      ? `${item.weight}kg`
                                      : item.value,
                                  }}
                                ></p>
                              </div>
                            </div>
                          ) : (
                            <div
                              id={`slot-${second.name}-${i + 1}`}
                              key={i}
                              onMouseUp={(e) => this.mouseUp(e)}
                              data-type="slot"
                              data-inv={0}
                              data-slot={i}
                              className="
                                                            w-28 h-28 bg-black rounded-lg
                                                            hover:bg-gray-400
                                                            transition-all
                                                            text-center
                                                            text-white
                                                            relative
                                                        "
                            ></div>
                          );
                        })}
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div className="rounded-b-md"></div>
          </div>
        </div>
      </div>
    );
  }
}
