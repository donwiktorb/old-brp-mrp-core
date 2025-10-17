import React from "react";
import sendMessage from "../../Api";

import "./inventory.css";

export default class Inventory extends React.Component {
    constructor(prosp) {
        super(prosp);
        this.state = {
            quantity: 1,
            show: false,
            currentDesc: {},
            inventories: [
                {
                    name: "inventory",
                    label: "Ekwipunek",
                    weight: 0.4,
                    maxWeight: 40,
                    items: [
                        {
                            description: [{ label: "Hello", value: "hello2" }],
                            slot: 2,
                            name: "sprunk",
                            count: 200,
                            weight: 0.2,
                            label: "Flara",
                        },
                        {
                            description: [{ label: "Hello", value: "hello2" }],
                            slot: 4,
                            name: "sprunk",
                            count: 2,
                            weight: 0.2,
                            label: "Flara",
                        },
                    ],
                },
                {
                    name: "drop",
                    label: "Ziemia",
                    weight: 0.4,
                    slots: 10,
                    maxWeight: 40,
                    items: [
                        {
                            slot: 2,
                            name: "sprunk",
                            label: "Flara",
                            // value: "<span style='color:green'>x d</span>",
                            price: 24,
                        },
                    ],
                },
            ],
        };
        this.current = null;
        this.close = this.close.bind(this);
        this.open = this.open.bind(this);
    }

    changeQuantity = (e) => {
        let { value } = e.target;
        if (!isNaN(value)) {
            if (value >= 1) {
                this.setState({ quantity: value });
            }
        }
    };

    onKey(e) {
        if (e.key === "Escape") {
            this.cancel();
        }
    }

    getItemBySlot(inv, slot) {
        let [item, itemIdx] = [null, null];
        this.state.inventories[inv].items.forEach((v, i) => {
            if (v.slot === slot) [item, itemIdx] = [v, i];
        });
        return [item, itemIdx];
    }

    onImageError(e, { name }) {
        e.preventDefault();
        let parent = e.target.parentElement;
        let el = document.createElement("div");
        let content = document.createTextNode(name);
        el.className =
            "text-center flex justify-center p items-center border-2 rounded-full leading-loose w-full h-full text-lg break-all";
        el.appendChild(content);
        parent.append(el);
        e.target.remove();
    }

    descButton(e, i) {
        if (this.state.currentDesc && this.state.currentDesc.description[i]) {
            sendMessage("menu_change", {
                name: "inventory",
                action: "inventory_item_desc",
                item: this.state.currentDesc,
                value: this.state.currentDesc.description[i],
            });
        }
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

    tool(e, inv, itemIdx) {
        e.preventDefault();
        if (this.state.currentDesc.description) {
            return this.setState({ currentDesc: {} });
        }
        if (this.state.inventories[inv].items[itemIdx]) {
            let elem = document.getElementById("inventory-pop");
            let top = e.clientY;
            let left = e.clientX;

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
            this.setState({
                currentDesc: this.state.inventories[inv].items[itemIdx],
            });
        }
    }

    mouseDown(e) {
        // // function sendMessage(name, value) {
        // //     console.log(name, value)
        // // }
        e.preventDefault();
        let { target } = e;
        let { dataset } = target;
        let { inv, item, slot } = dataset;

        if (e.button === 0) {
            if (this.current === target) {
                this.current.style.opacity = 1.0;
                this.current = null;
            } else {
                if (this.current) {
                    // // let currentData = this.current.dataset
                    // // let [inv2, item2, slot2] = [currentData.inv, currentData.item, currentData.slot]

                    // // let currentItem = this.state.inventories[Number(inv2)]?.items[Number(item2)]
                    // // let targetItem = this.state.inventories[Number(inv)]?.items[Number(item)]

                    // // sendMessage('menu_change', {
                    // //     name: "inventory",
                    // //     action: "item_change",
                    // //     current: currentItem,
                    // //     target: targetItem,
                    // //     targetSlot: Number(slot),
                    // //     currentSlot: Number(slot2),
                    // //     quantity: this.state.quantity,
                    // //     oldInv: this.state.inventories[Number(inv2)].name,
                    // //     newInv: this.state.inventories[Number(inv)].name,
                    // // })

                    this.current.style.opacity = 1.0;
                    this.current = null;
                } else {
                    this.current = target;
                    this.current.style.opacity = 0.2;
                }
            }
        }
    }

    mouseUp(e) {
        e.preventDefault();
        // // function sendMessage(name, value) {
        // //     console.log(name, value)
        // // }
        if (this.current) {
            this.current.style.opacity = 1.0;
            let { target } = e;
            let { dataset } = target;
            let { inv, item, slot, action } = dataset;
            let currentData = this.current.dataset;
            let [inv2, item2, slot2] = [
                currentData.inv,
                currentData.item,
                currentData.slot,
            ];
            let currentItem =
                this.state.inventories[Number(inv2)]?.items[Number(item2)];
            if (action && action === "use") {
                sendMessage("menu_submit", {
                    name: "inventory",
                    action: "use",
                    quantity: this.state.quantity,
                    targetSlot: Number(slot),
                    currentSlot: Number(slot2),
                    current: currentItem,
                    oldInv: this.state.inventories[Number(inv2)]?.name,
                    newInv: this.state.inventories[Number(inv)]?.name,
                });
            } else {
                let targetItem =
                    this.state.inventories[Number(inv)]?.items[Number(item)];
                if (inv && inv2 && inv !== inv2) {
                    sendMessage("menu_change", {
                        name: "inventory",
                        action: "inventory_change",
                        quantity: this.state.quantity,
                        current: currentItem,
                        target: targetItem,
                        targetSlot: Number(slot),
                        currentSlot: Number(slot2),
                        oldInv: this.state.inventories[Number(inv2)]?.name,
                        newInv: this.state.inventories[Number(inv)]?.name,
                    });
                } else if (inv && inv2) {
                    if (slot !== slot2) {
                        if (!targetItem) {
                            sendMessage("menu_change", {
                                name: "inventory",
                                action: "slot_change",
                                quantity: this.state.quantity,
                                targetSlot: Number(slot),
                                currentSlot: Number(slot2),
                                current: currentItem,
                                oldInv: this.state.inventories[Number(inv2)]?.name,
                                newInv: this.state.inventories[Number(inv)]?.name,
                            });
                        } else {
                            sendMessage("menu_change", {
                                name: "inventory",
                                action: "item_change",
                                current: currentItem,
                                target: targetItem,
                                targetSlot: Number(slot),
                                currentSlot: Number(slot2),
                                quantity: this.state.quantity,
                                oldInv: this.state.inventories[Number(inv2)].name,
                                newInv: this.state.inventories[Number(inv)].name,
                            });
                        }
                    }
                }
            }
            this.current = null;
        }
    }

    cancel() {
        sendMessage("menu_cancel", {
            name: "inventory",
        });
    }

    close() {
        this.setState({ show: false });
    }

    open(data) {
        data.show = data.show || true;
        this.setState(data);
    }

    render() {
        let [main, second] = this.state.inventories;
        if (!this.state.show) return <></>;
        return (
            <div className="w-full h-full absolute z-20">
                <div
                    className="w-full h-full flex justify-center items-center "
                    onMouseUp={(e) => this.mouseUp(e)}
                >
                    <div
                        style={{
                            backgroundImage:
                                "url('HERE_REPLACE_IMAGE_YOURSphoto-1578662996442-48f60103fc96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80')",
                        }}
                        className="w-4/5 h-4/5 bg-black bg-opacity-90 opacity-90 rounded-lg p-2 flex justify-center gap-4 text-white select-none font-sans"
                    >
                        <div
                            style={{
                                display: this.state.currentDesc.description ? "flex" : "none",
                            }}
                            className="absolute flex flex-col gap-2 p-2 bg-black rounded-lg z-10 w-64"
                            id="inventory-pop"
                        >
                            {this.state.currentDesc.description?.map((v, i) => {
                                return (
                                    <button
                                        className="w-full text-lg break-all bg-gray-700 my-0.5"
                                        onClick={(e) => this.descButton(e, i)}
                                    >
                                        {v.label}
                                    </button>
                                );
                            })}
                        </div>
                        <div className="w-full bg-opacity-50 bg-gray-700 h-full rounded-lg p-2">
                            <div className="w-full flex-col gap-4 flex h-full">
                                <div className="flex justify-between text-lg font-semibold">
                                    <div>{main.label}</div>
                                </div>
                                <div className="w-full h-2.5 rounded-lg bg-gray-500">
                                    <div
                                        className="bg-green-500 h-2.5 rounded-lg max-w-full"
                                        style={{
                                            width: (100 * main.weight) / main.maxWeight + "%",
                                        }}
                                    ></div>
                                </div>
                                <div className="w-full h-full overflow-y-scroll rounded-lg p-2 grid grid-cols-5 gap-4  justify-items-center overflow-x-hidden text-black">
                                    {Array(main.slots || 50)
                                        .fill()
                                        .map((v, i) => {
                                            i += 1;
                                            let [item, itemIdx] = this.getItemBySlot(0, i);
                                            return item ? (
                                                <div
                                                    key={i}
                                                    data-inv={0}
                                                    data-item={itemIdx}
                                                    data-slot={i}
                                                    onMouseDown={(e) => this.mouseDown(e)}
                                                    onMouseUp={(e) => this.mouseUp(e)}
                                                    className="w-full h-28 text-white bg-black rounded-lg flex justify-center items-center bg-opacity-70 text-lg truncate relative group"
                                                    onContextMenu={(e) => this.tool(e, 0, itemIdx)}
                                                >
                                                    <div className="w-full h-full pointer-events-none text-base ">
                                                        <p className="absolute top-0 left-1 break-words">
                                                            {item.label}
                                                        </p>
                                                        <img
                                                            draggable="false"
                                                            onError={(e) => this.onImageError(e, item)}
                                                            className="w-full h-full object-scale-down object-center"
                                                            src={`${process.env.PUBLIC_URL}/img/inv/${item.name}.png`}
                                                            alt={item.name}
                                                        />
                                                        {!item.isMoney && (
                                                            <p className="absolute bottom-0 right-1">
                                                                {item.ammo || item.count}x
                                                            </p>
                                                        )}
                                                        {item.isMoney && (
                                                            <p className="absolute bottom-0 right-1 text-green-500">
                                                                {item.count}$
                                                            </p>
                                                        )}
                                                        {/* <p className="absolute bottom-0 left-1">{item.weight}kg</p> */}
                                                    </div>
                                                </div>
                                            ) : (
                                                <div
                                                    onMouseUp={(e) => this.mouseUp(e)}
                                                    data-slot={i}
                                                    data-inv={0}
                                                    className="min-w-28 min-h-28 text-white bg-black rounded-lg w-full h-28 flex justify-center items-center bg-opacity-70 text-lg"
                                                >
                                                    {i <= 5 && i}
                                                </div>
                                            );
                                        })}
                                </div>
                            </div>
                        </div>

                        <div className="w-1/4 bg-gray-700 rounded-lg bg-opacity-20 h-full flex justify-center items-center flex-col gap-5 p-2">
                            <button
                                onMouseUp={(e) => this.mouseUp(e)}
                                data-action="use"
                                className="bg-black bg-opacity-70 rounded-lg p-2 w-full"
                            >
                                Użyj
                            </button>
                            <input
                                onChange={this.changeQuantity}
                                className="w-full bg-black p-2 rounded-lg bg-opacity-70 text-center outline-none"
                                value={this.state.quantity}
                                inputMode="numeric"
                                step="1"
                                min="0"
                                defaultValue="1"
                                placeholder="Ilość"
                                type="number"
                                id="default-input"
                            ></input>

                            <button
                                onClick={this.cancel}
                                className="bg-black bg-opacity-70 rounded-lg p-2 w-full"
                            >
                                Zamknij
                            </button>
                        </div>

                        <div className="w-full bg-opacity-50 bg-gray-700 h-full rounded-lg p-2">
                            <div className="w-full flex-col gap-4 flex h-full">
                                <div className="flex justify-between text-lg font-semibold">
                                    <div>{second.label}</div>
                                </div>
                                <div className="w-full h-2.5 rounded-lg bg-gray-500">
                                    <div
                                        className="bg-green-500 h-2.5 rounded-lg max-w-full"
                                        style={{
                                            width: (100 * second.weight) / second.maxWeight + "%",
                                        }}
                                    ></div>
                                </div>
                                <div className="w-full h-full overflow-y-scroll rounded-lg p-2 grid grid-cols-5 gap-4  justify-items-center content-start overflow-x-hidden text-black">
                                    {Array(second.slots || 50)
                                        .fill()
                                        .map((v, i) => {
                                            i += 1;
                                            let [item, itemIdx] = this.getItemBySlot(1, i);
                                            return item ? (
                                                <div
                                                    key={i}
                                                    data-inv={1}
                                                    data-item={itemIdx}
                                                    data-slot={i}
                                                    onMouseDown={(e) => this.mouseDown(e)}
                                                    onMouseUp={(e) => this.mouseUp(e)}
                                                    className="w-full h-28 bg-black rounded-lg flex justify-center items-center bg-opacity-70 text-lg truncate relative group text-white"
                                                    onContextMenu={(e) => this.tool(e, 1, itemIdx)}
                                                >
                                                    <div className="w-full h-full pointer-events-none text-base">
                                                        <p className="absolute top-0 left-1 break-words">
                                                            {item.label}
                                                        </p>
                                                        <img
                                                            draggable="false"
                                                            onError={(e) => this.onImageError(e, item)}
                                                            className="w-full h-full object-scale-down object-center"
                                                            src={`${process.env.PUBLIC_URL}/img/inv/${item.name}.png`}
                                                            alt={item.name}
                                                        />
                                                        {/* {item.weight && <p className="absolute bottom-0 left-1">{item.weight}kg</p>} */}
                                                        {!item.price && item.count && (
                                                            <p className="absolute bottom-0 right-1">
                                                                {item.ammo || item.count}x
                                                            </p>
                                                        )}
                                                        {item.price && item.count && (
                                                            <p className="absolute bottom-0 left-1">
                                                                {item.ammo || item.count}x
                                                            </p>
                                                        )}
                                                        {item.value && (
                                                            <p
                                                                className="absolute bottom-0 right-1"
                                                                dangerouslySetInnerHTML={{ __html: item.value }}
                                                            />
                                                        )}
                                                        {item.price && (
                                                            <p className="absolute bottom-0 right-1 text-green-500">
                                                                {item.price}$
                                                            </p>
                                                        )}
                                                    </div>
                                                </div>
                                            ) : (
                                                <div
                                                    onMouseUp={(e) => this.mouseUp(e)}
                                                    data-slot={i}
                                                    data-inv={1}
                                                    className="w-full h-28 bg-black rounded-lg flex justify-center items-center bg-opacity-70 text-lg text-white"
                                                >
                                                    {i <= 5 && i}
                                                </div>
                                            );
                                        })}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}
