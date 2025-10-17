import React from "react";

import { motion } from "framer-motion";
export default class Hud extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    if (true) return <></>;
    return (
      <div
        className="w-full h-screen absolute z-40 "
        style={{
          backgroundImage:
            "url('https://cdn.discordapp.com/attachments/678339577110462479/1327287724939411456/FiveM_b2699_GTAProcess_6WIdhGAszo.jpg?ex=67828485&is=67813305&hm=5e930898577dcdda002b97517ea1244ecd01a45e2a0c7b7911d7a728db52c484&')",
          backgroundRepeat: "no-repeat",
          backgroundSize: "auto",
        }}
      >
        <div className="w-full h-full relative  ">
          <div className="w-1/6 h-1/5 bg-blue-400 absolute left-10 bottom-10 bg-opacity-50"></div>
        </div>
      </div>
    );
  }
}
