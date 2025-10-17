import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";

import Window from "./components/Window";
export default class Laptop extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    if (true) return;
    return (
      <div className="w-full h-full absolute z-20">
        <div
          className="w-full h-full flex flex-col"
          style={{
            backgroundImage:
              "url('https://i.pinimg.com/originals/03/44/7b/03447be73c5b73a3f66b411eaf05ff67.jpg')",
            backgroundRepeat: "no-repeat",
          }}
        >
          <div className="w-full h-[95%] ">
            <BrowserRouter>
              <Routes>
                <Route path="/" element={<Window />} />
              </Routes>
            </BrowserRouter>
          </div>
          <div className="w-full h-[5%] ">
            <div className="h-full flex gap-1 items-center bg-black bg-opacity-90">
              <div className="h-full transition-[filter] hover:grayscale">
                <img
                  src="https://media.discordapp.net/attachments/678339577110462479/1278024308433621055/userlmn_dd372ce6835a1943eb8368fe46e6ea1a.png?ex=66dfc723&is=66de75a3&hm=48817c2778233a0b06733b8670ca7ffbccf1588b434f7033a0b19b1fc24d5605&=&format=webp&quality=lossless"
                  alt=""
                  className="object-scale-down w-full h-full"
                />
              </div>
              <div className="h-full flex items-center">
                <div className="h-full">
                  <div className="relative w-fit rounded-lg h-full flex items-center">
                    <input
                      placeholder={"Wyszukaj"}
                      type="search"
                      className="peer block font-normal max-w-full pl-6 w-full h-3/5 text-sm text-white  rounded-lg border border-black bg-gray-700 bg-opacity-70 focus:outline-none"
                    />

                    <div className="flex absolute left-1 top-1/2 -translate-y-1/2 items-center pointer-events-none">
                      <svg
                        aria-hidden="true"
                        className="w-4 h-4 text-gray-400 object-scale-down origin-center"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth="2"
                          d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                        ></path>
                      </svg>
                    </div>
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
