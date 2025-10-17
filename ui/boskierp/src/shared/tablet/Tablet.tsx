import React, { ReactPropTypes } from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";

import App from "./pages/App.tsx";
export default class Tablet extends React.Component {
  constructor(props: ReactPropTypes) {
    super(props);

    this.state = {};
  }

  render() {
    return <></>;
    return (
      <div className="w-full h-full z-40">
        <div className="w-full h-full flex justify-center items-center">
          <div className="w-5/6 h-5/6 rounded">
            <div className="bg-gradient-to-tr from-gray-400 via-gray-700 to-slate-400 w-full h-full rounded flex justify-center items-center p-2">
              <div className="bg-black w-full h-full rounded flex justify-center items-center">
                <BrowserRouter>
                  <Routes>
                    <Route index element={<App />} />
                  </Routes>
                </BrowserRouter>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
