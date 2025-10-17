
import React from "react";
import sendMessage from '../../Api'

export default class MenuDialogLarge extends React.Component {
  constructor(props) {
    super(props);

    this.state = {};

  }



  render() {
    if (!this.state.show) return
    return (
      <div className="w-full z-20 absolute h-full flex justify-center items-center text-white">
        <div className="w-1/2 h-1/2 bg-gray-700 bg-opacity-90 rounded-lg">
          <div className="w-full h-full flex flex-col p-2 gap-4 ">
            <textarea type="text" className="w-full h-full p-2 bg-gray-700 rounded-lg" />
            <div className="flex justify-between gap-4 font-bold">
              <button className="rounded-lg bg-gray-700 w-min p-2">
                Zapisz
              </button>
              <button className="rounded-lg text-purple-500 bg-gray-700 w-min p-2">
                Wyczysc
              </button>
              <button className="rounded-lg text-red-500 bg-gray-700 w-min p-2">
                Anuluj
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
