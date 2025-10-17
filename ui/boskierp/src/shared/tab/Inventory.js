import React from "react";
export default class Inventory extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      crafting: false,
      secondInventory: true,
    };
  }

  render() {
    return (
      <div className="w-full h-full ">
        <div
          className={`w-full h-full flex gap-1 ${this.state.secondInventory && "flex-col"}`}
        >
          {this.state.crafting && (
            <div className="h-full w-1/4 bg-black rounded-lg"></div>
          )}
          {this.state.secondInventory && (
            <div className="w-full h-full bg-black rounded-lg"></div>
          )}

          <div className="h-full w-full bg-blue-500 rounded-lg"></div>
        </div>
      </div>
    );
  }
}
