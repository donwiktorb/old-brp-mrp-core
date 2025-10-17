import React from "react";
import Clothes from "./Clothes";
import Items from "./Items";
import Loadout from "./Loadout";
import MouseFollower from "./MouseItem";
import Ped from "./Ped";
export default class Inventory extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      current: false,
      leftInventories: [
        {
          size: [7, 4],
          label: "Skrzynka",
          icon: "water",

          items: [
            {
              name: "weapon_assaultrifle",
              slot: 4,
              size: [2],
              label: "AK",
            },

            {
              name: "weapon_assaultrifle",
              slot: 10,
              size: [2],
              label: "AK",
            },
          ],
        },
      ],
      rightInventories: [
        {
          size: [4, 7],
          label: "Kamizelka",
          icon: "water",
          colos: 4,
          items: [
            {
              name: "weapon_assaultrifle",
              slot: 5,
              size: [2],
              label: "AK",
            },
          ],
        },
        {
          size: [4, 7],
          label: "Plecak",
          icon: "water",

          items: [
            {
              name: "weapon_assaultrifle",
              slot: 5,

              size: [3, 3],
              label: "AK",
            },
          ],
        },
      ],
      loadout: [],
      clothes: [],
    };

    this.current = null;
    this.currentObj = null;
  }

  onMouseDown(e) {
    e.preventDefault();
    let { target } = e;
    let { dataset } = target;
    let { inv, item, slot } = dataset;
    console.log(dataset, target);
    if (e.button === 0) {
      if (this.current === target) {
        this.current.style.opacity = 1.0;
        this.current = null;
      } else {
        if (this.current) {
          this.current.style.opacity = 1.0;
          this.current = null;
        } else {
          this.current = target;
          let src = `${process.env.PUBLIC_URL}/img/weapon_assaultrifle.png`;
          this.MouseFollower.setDisplay(src);
        }
      }
    }
  }

  isBetween(point, pointA, pointB) {
    return point <= pointB && pointB <= pointA;
  }

  getOccupiedSlots(invSize, slot, size) {
    let [rows, columns] = invSize;
    let [width, height] = size;
    if (!width) width = 1;
    if (!height) height = 1;
    const occupiedSlotsItem = [];
    let newRow = false;

    for (let row = slot; row < slot + width; row++) {
      occupiedSlotsItem.push(row);
      let starterColumn = row;
      for (let col = 1; col < height; col++) {
        starterColumn = starterColumn + rows;
        if (starterColumn > columns * rows) {
          return false;
        }
        occupiedSlotsItem.push(starterColumn);
      }
    }

    return occupiedSlotsItem;
  }

  isOverlapping4(
    targetInv,
    targetSlots,
    bottomRightSlot,
    bottomLeftSlot,
    targetItem,
  ) {
    if (!targetSlots) return true;
    for (let row = 1; row <= targetInv.size[1]; row++) {
      let columnSlot = targetInv.size[0] * row;
      let startRowSlot = columnSlot - targetInv.size[0] - 1;
      if (
        !(
          this.isBetween(startRowSlot, columnSlot, bottomRightSlot) ||
          !this.isBetween(startRowSlot, columnSlot, bottomLeftSlot)
        ) ||
        !(
          this.isBetween(startRowSlot, columnSlot, bottomRightSlot) ||
          !this.isBetween(startRowSlot, columnSlot, bottomLeftSlot)
        )
      ) {
        return true;
      }
    }

    for (const item of targetInv.items) {
      const itemSlots = this.getOccupiedSlots(
        targetInv.size,
        item.slot,
        item.size,
      );
      if (itemSlots.some((slot) => targetSlots.includes(slot))) {
        return true;
      }
    }
    return false;
  }

  onMouseUp(e) {
    if (!this.current) return;
    e.preventDefault();
    this.MouseFollower.setDisplay();
    let { target } = e;
    let { dataset } = target;
    let { invtype, inv, slot, itemdix, type, action } = dataset;
    let currentData = this.current.dataset;

    if (!target || !inv) {
      return;
    }

    switch (invtype) {
      case "ped":
        break;
      case "loadout":
        break;
      case "clothes":
        break;

      default:
        break;
    }

    if (invtype === "clothes" || invtype === "loadout" || invtype === "ped") {
      return;
    }

    let currentInv =
      currentData.invtype === "left"
        ? this.state.leftInventories
        : this.state.rightInventories;

    let targetInv =
      invtype === "left"
        ? this.state.leftInventories
        : this.state.rightInventories;

    let item = currentInv[currentData.inv].items[Number(currentData.itemidx)];

    let changeType = currentData.invtype === invtype ? "same" : "different";

    let [columns, rows] = targetInv[inv].size;
    let [itemColumns, itemRows] = item.size;
    slot = Number(slot);
    let bottomLeftSlot = slot;
    let bottomRightSlot = slot + (itemColumns || 1) - 1;
    let topLeftSlot = slot - columns * ((itemRows || 1) - 1);
    let topRightSlot = topLeftSlot + (itemColumns || 1) - 1;
    const targetSlots = this.getOccupiedSlots(
      targetInv[inv].size,
      bottomLeftSlot,
      item.size,
    );
    if (
      this.isOverlapping4(
        targetInv[inv],
        targetSlots,
        bottomRightSlot,
        bottomLeftSlot,
        item,
      )
    ) {
    } else {
    }
    this.current = null;
  }

  onMouseMove(e) {
    if (!this.current) return;
    e.preventDefault();
    let { target } = e;
    let { dataset } = target;
    let { invtype, inv, slot, itemdix, type, action } = dataset;
    let currentData = this.current.dataset;

    if (!target || !inv) {
      this.current.style.border = "none";
      return;
    }

    switch (invtype) {
      case "ped":
        break;
      case "loadout":
        break;
      case "clothes":
        break;

      default:
        break;
    }

    if (invtype === "clothes" || invtype === "loadout" || invtype === "ped") {
      return;
    }

    let currentInv =
      currentData.invtype === "left"
        ? this.state.leftInventories
        : this.state.rightInventories;

    let targetInv =
      invtype === "left"
        ? this.state.leftInventories
        : this.state.rightInventories;

    let item = currentInv[currentData.inv].items[Number(currentData.itemidx)];

    let changeType = currentData.invtype === invtype ? "same" : "different";

    let [columns, rows] = targetInv[inv].size;
    let [itemColumns, itemRows] = item.size;
    slot = Number(slot);
    let bottomLeftSlot = slot;
    let bottomRightSlot = slot + (itemColumns || 1) - 1;
    let topLeftSlot = slot - columns * ((itemRows || 1) - 1);
    let topRightSlot = topLeftSlot + (itemColumns || 1) - 1;
    const targetSlots = this.getOccupiedSlots(
      targetInv[inv].size,
      bottomLeftSlot,
      item.size,
    );
    if (
      this.isOverlapping4(
        targetInv[inv],
        targetSlots,
        bottomRightSlot,
        bottomLeftSlot,
        item,
      )
    ) {
      this.current.style.border = "4px solid green";
    } else {
      this.current.style.border = "none";
    }
  }

  render() {
    if (true) return;
    return (
      <div className="w-full h-full relative z-20" id="inv-v4">
        <MouseFollower ref={(ref) => (this.MouseFollower = ref)} />
        <div
          className="w-full h-full "
          onMouseMove={(e) => this.onMouseMove(e)}
          onMouseUp={(e) => this.onMouseUp(e)}
          onMouseDown={(e) => this.onMouseDown(e)}
        >
          <div className="w-full h-full flex justify-center items-center p-4 gap-1 font-sans">
            <div className="basis-1/3 h-full shrink-0 flex flex-col gap-1 ">
              <div className="h-[5%]"></div>
              <div className="w-full h-[95%] overflow-scroll flex flex-col gap-1 gap-y-7 px-4">
                {this.state.leftInventories.map((v, i) => {
                  return <Items data={v} inv={i} invType="left" />;
                })}
              </div>
            </div>

            <div className="basis-1/3 h-full shrink-0 flex flex-col gap-1">
              <div className="h-[5%]"></div>
              <div className="w-full h-[95%] flex gap-1 overflow-auto px-1">
                <Ped ref={(ref) => (this.Ped = ref)} />
                <div className="h-full w-1/6 ">
                  <Clothes
                    data={this.state.clothes}
                    inv={0}
                    invType="clothes"
                  />
                </div>
              </div>
            </div>

            <div className="basis-1/3 h-full shrink-0 flex flex-col gap-1 ">
              <div className="h-[5%] self-end px-4 flex justify-center items-center gap-1">
                <div>
                  <svg
                    className="w-5 h-5"
                    fill="#000000"
                    viewBox="0 0 512 512"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M510.28 445.86l-73.03-292.13c-3.8-15.19-16.44-25.72-30.87-25.72h-60.25c3.57-10.05 5.88-20.72 5.88-32 0-53.02-42.98-96-96-96s-96 42.98-96 96c0 11.28 2.3 21.95 5.88 32h-60.25c-14.43 0-27.08 10.54-30.87 25.72L1.72 445.86C-6.61 479.17 16.38 512 48.03 512h415.95c31.64 0 54.63-32.83 46.3-66.14zM256 128c-17.64 0-32-14.36-32-32s14.36-32 32-32 32 14.36 32 32-14.36 32-32 32z" />
                  </svg>
                </div>
                <div>34kg</div>
              </div>
              <div className="w-full h-[70%] overflow-scroll grid grid-cols-2 gap-4 gap-y-7 px-4 ">
                {this.state.rightInventories.map((v, i) => {
                  return (
                    <Items
                      style={`xl:grid-cols-4`}
                      data={v}
                      inv={i}
                      invType="right"
                    />
                  );
                })}
              </div>
              <div className="w-full h-[20%] px-4 lg:mt-auto">
                <Loadout data={this.state.loadout} inv={0} invType="loadout" />
              </div>
            </div>
          </div>
        </div>
      </div>
    );
    return (
      <div className="w-full h-full relative z-20">
        <div className="w-full h-full flex flex-col justify-center items-center p-8 gap-1">
          <div className="w-full h-full flex items-evenly justify-evenly gap-3 ">
            <div className="w-full h-full text-white">
              <div className="w-full h-[5%] text-right">50kg</div>
              <div className="w-fit h-[75%] overflow-auto px-5">
                <div className="w-fit flex flex-col gap-3 justify-center gap-y-5 bg-green-400">
                  {Array(4)
                    .fill()
                    .map((v, i) => {
                      return (
                        <div className="h-min gap-1 justify-center bg-black w-fit">
                          <div className="h-16 bg-slate-900">
                            <div className="h-full flex items-center">
                              <div className="">
                                <img
                                  className="w-16 object-scale-down object-left"
                                  alt="WATER"
                                  src={`${process.env.PUBLIC_URL}/img/water.png`}
                                />
                              </div>
                              <div className="flex flex-col gap-1 px-0.5 h-full justify-center ">
                                <div>Water</div>
                                <div className="w-16 bg-black h-1 border border-gray-700"></div>
                                <div className="self-end text-right w-full text-sm">
                                  0.4kg
                                </div>
                              </div>
                            </div>
                          </div>
                          <div className="flex flex-wrap gap-1">
                            {Array(48)
                              .fill()
                              .map((v, i) => {
                                return (
                                  <div className="bg-black bg-opacity-90 border border-gray-400 w-20 h-20 "></div>
                                );
                              })}
                          </div>
                        </div>
                      );
                    })}
                </div>
              </div>
            </div>
            <div className="w-full h-full flex justify-end">
              <div className="h-full w-16 flex flex-col">
                <div className="w-full h-[5%] "></div>
                <div className="h-3/4 w-full ">
                  <div className="flex flex-col h-min gap-1 justify-items-center w-full ">
                    {Array(10)
                      .fill()
                      .map((v, i) => {
                        return (
                          <div className="bg-black bg-opacity-90 border-gray-400 w-[4.15rem] h-[4.15rem] p-0.5"></div>
                        );
                      })}
                  </div>
                </div>
              </div>
            </div>
            <div className="w-full h-full text-white">
              <div className="w-full h-[5%] text-right">50kg</div>
              <div className="w-full h-[75%] overflow-auto ">
                <div className="w-full grid grid-cols-2 gap-3 justify-center gap-y-7 ">
                  {Array(4)
                    .fill()
                    .map((v, i) => {
                      return (
                        <div className="h-min flex flex-col gap-1 justify-center w-fit">
                          <div className="h-16 bg-slate-900">
                            <div className="w-full h-full flex items-center">
                              <div className="">
                                <img
                                  className="w-16 object-scale-down object-left"
                                  alt="WATER"
                                  src={`${process.env.PUBLIC_URL}/img/water.png`}
                                />
                              </div>
                              <div className="flex flex-col gap-1 w-full px-0.5 h-full justify-center ">
                                <div>Water</div>
                                <div className="w-16 bg-black h-1 border border-gray-700"></div>
                                <div className="self-end text-right w-full text-sm">
                                  0.4kg
                                </div>
                              </div>
                            </div>
                          </div>
                          <div className="grid grid-cols-4 h-min gap-1 justify-items-center w-full ">
                            {Array(10 + 1 + 1)
                              .fill()
                              .map((v, i) => {
                                return (
                                  <div className="bg-black bg-opacity-90 border border-gray-400 w-[4.15rem] h-[4.15rem] p-0.5"></div>
                                );
                              })}
                          </div>
                        </div>
                      );
                    })}
                </div>
              </div>
              <div className="w-full h-[20%] ">
                <div className="w-full h-full flex flex-col gap-1">
                  <div className="grid grid-cols-6 w-full h-full gap-1">
                    {Array(5)
                      .fill()
                      .map((v, i) => {
                        return (
                          <div
                            className={`w-[4.15rem] h-[4.15rem] bg-black ${i === 0 && "col-span-2"}`}
                          ></div>
                        );
                      })}
                  </div>
                  <div className="grid grid-cols-6 w-full h-full gap-1">
                    {Array(6)
                      .fill()
                      .map((v, i) => {
                        return (
                          <div className="w-[4.15rem] h-[4.15rem] bg-black"></div>
                        );
                      })}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
