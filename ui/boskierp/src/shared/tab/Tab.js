import Inventory from "./Inventory";
import React from "react";
import { BrowserRouter, Route, Routes, Link } from "react-router-dom";
export default class Tab extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      panel: true,
    };
  }

  render() {
    if (true) return;
    return (
      <div className="w-full h-full relative z-30">
        <div className="w-full h-full flex flex-col items-center justify-evenly">
          {this.state.panel && (
            <div className="w-5/6 bg-black bg-opacity-70 text-white flex items-center justify-center rounded-lg p-0.5">
              <div className="w-full h-full flex justify-center items-center gap-4">
                <Link to={"/"} className="w-10 h-10">
                  <svg
                    className={
                      "w-full h-full text-blue-500 border rounded-full"
                    }
                    fill="currentColor"
                    viewBox="0 0 32 32"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M16 15.503A5.041 5.041 0 1 0 16 5.42a5.041 5.041 0 0 0 0 10.083zm0 2.215c-6.703 0-11 3.699-11 5.5v3.363h22v-3.363c0-2.178-4.068-5.5-11-5.5z" />
                  </svg>
                </Link>

                <Link to={"/inventory"} className="w-10 h-10">
                  <svg
                    className={
                      "w-full h-full text-blue-500 border rounded-full"
                    }
                    fill="currentColor"
                    viewBox="0 0 32 32"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M16 15.503A5.041 5.041 0 1 0 16 5.42a5.041 5.041 0 0 0 0 10.083zm0 2.215c-6.703 0-11 3.699-11 5.5v3.363h22v-3.363c0-2.178-4.068-5.5-11-5.5z" />
                  </svg>
                </Link>

                <Link to={"/map"} className="w-10 h-10">
                  <svg
                    className={
                      "w-full h-full text-blue-500 border rounded-full"
                    }
                    fill="currentColor"
                    viewBox="0 0 32 32"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M16 15.503A5.041 5.041 0 1 0 16 5.42a5.041 5.041 0 0 0 0 10.083zm0 2.215c-6.703 0-11 3.699-11 5.5v3.363h22v-3.363c0-2.178-4.068-5.5-11-5.5z" />
                  </svg>
                </Link>
              </div>
              <div className="w-full h-full flex justify-center items-center text-4xl font-[Smythe] border-4 rounded-lg border-opacity-90">
                Wytwarzanie
              </div>
              <div className="w-full h-full flex justify-center items-center gap-4">
                <Link to={"/map"} className="w-10 h-10">
                  <svg
                    className={
                      "w-full h-full text-blue-500 border rounded-full"
                    }
                    fill="currentColor"
                    viewBox="0 0 32 32"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M16 15.503A5.041 5.041 0 1 0 16 5.42a5.041 5.041 0 0 0 0 10.083zm0 2.215c-6.703 0-11 3.699-11 5.5v3.363h22v-3.363c0-2.178-4.068-5.5-11-5.5z" />
                  </svg>
                </Link>

                <Link to={"/map"} className="w-10 h-10">
                  <svg
                    className={
                      "w-full h-full text-blue-500 border rounded-full"
                    }
                    fill="currentColor"
                    viewBox="0 0 32 32"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M16 15.503A5.041 5.041 0 1 0 16 5.42a5.041 5.041 0 0 0 0 10.083zm0 2.215c-6.703 0-11 3.699-11 5.5v3.363h22v-3.363c0-2.178-4.068-5.5-11-5.5z" />
                  </svg>
                </Link>

                <Link to={"/map"} className="w-10 h-10">
                  <svg
                    className={
                      "w-full h-full text-blue-500 border rounded-full"
                    }
                    fill="currentColor"
                    viewBox="0 0 32 32"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M16 15.503A5.041 5.041 0 1 0 16 5.42a5.041 5.041 0 0 0 0 10.083zm0 2.215c-6.703 0-11 3.699-11 5.5v3.363h22v-3.363c0-2.178-4.068-5.5-11-5.5z" />
                  </svg>
                </Link>
              </div>
            </div>
          )}

          <div className="w-4/5 h-4/5 flex rounded-lg bg-opacity-70 overflow-scroll">
            <Routes>
              <Route path={"/inventory"} element={<Inventory />} />
            </Routes>
          </div>

          <div className="w-1/4 h-10 bg-black bg-opacity-70 rounded-lg"></div>
        </div>
      </div>
    );
  }
}
