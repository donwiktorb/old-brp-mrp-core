import React from "react";
import sendMessage from "../../Api";

export default class MenuExtended extends React.Component {
  constructor(props) {
    super(props);

    this.state = {};
  }

  render() {
    if (!this.state.show) return <div></div>;
    return (
      <div className="w-full z-20 absolute h-full flex justify-center items-center text-white">
        <div className="w-1/2 h-1/2 bg-green-700 bg-opacity-90 rounded-lg">
          <div className="w-full h-full flex flex-col p-2 gap-4 overflow-auto ">
            <div className="text-center font-bold text-lg">Menu</div>
            <div className="grid grid-cols-3 gap-4">
              <input
                placeholder="small input"
                className="bg-green-900 rounded-lg p-2"
                type="text"
              />

              <input
                placeholder="small input"
                className="bg-green-900 rounded-lg p-2"
                type="text"
              />

              <input
                placeholder="small input"
                className="bg-green-900 rounded-lg p-2"
                type="text"
              />
            </div>

            <textarea
              placeholder="large input"
              type="text"
              className="w-full h-auto p-2 bg-green-900 rounded-lg"
            />

            <div className="grid grid-cols-3 gap-4 justify-items-center">
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-4 h-4 rounded-lg"
                  type="radio"
                  name="fav_language"
                  value="JavaScript"
                />
                <label for="javascript">JavaScript</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-4 h-4 rounded-lg"
                  type="radio"
                  name="fav_language"
                  value="JavaScript"
                />
                <label for="javascript">JavaScript</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-4 h-4 rounded-lg"
                  type="radio"
                  name="fav_language"
                  value="JavaScript"
                />
                <label for="javascript">JavaScript</label>
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4 justify-items-center">
              <div className="flex gap-2 items-center">
                <input
                  className="customSelector appearance-none rounded-lg bg-green-500 px-0.5"
                  type="range"
                  id="vol"
                  name="vol"
                  min="0"
                  max="50"
                />
                <label for="vol">x d</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="customSelector appearance-none rounded-lg bg-green-500 px-0.5"
                  type="range"
                  id="vol"
                  name="vol"
                  min="0"
                  max="50"
                />
                <label for="vol">x d</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="customSelector appearance-none rounded-lg bg-green-500 px-0.5"
                  type="range"
                  id="vol"
                  name="vol"
                  min="0"
                  max="50"
                />
                <label for="vol">x d</label>
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4 justify-items-center">
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-4 h-4 rounded"
                  type="checkbox"
                  id="vehicle1"
                  name="vehicle1"
                  value="Bike"
                />
                <label for="vehicle1"> I have a bike</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-4 h-4 rounded"
                  type="checkbox"
                  id="vehicle1"
                  name="vehicle1"
                  value="Bike"
                />
                <label for="vehicle1"> I have a bike</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-4 h-4 rounded"
                  type="checkbox"
                  id="vehicle1"
                  name="vehicle1"
                  value="Bike"
                />
                <label for="vehicle1"> I have a bike</label>
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4 justify-items-center">
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none text-center bg-green-900 border-green-900 border-2 w-14 h-7 rounded out-of-range:text-red-500"
                  type="number"
                  id="quantity"
                  name="quantity"
                  min="1"
                  max="5"
                />
                <label for="quantity">x d</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none text-center bg-green-900 border-green-900 border-2 w-14 h-7 rounded out-of-range:text-red-500"
                  type="number"
                  id="quantity"
                  name="quantity"
                  min="1"
                  max="5"
                />
                <label for="quantity">x d</label>
              </div>
              <div className="flex gap-2 items-center">
                <input
                  className="appearance-none text-center bg-green-900 border-green-900 border-2 w-14 h-7 rounded out-of-range:text-red-500"
                  type="number"
                  id="quantity"
                  name="quantity"
                  min="1"
                  max="5"
                />
                <label for="quantity">x d</label>
              </div>
            </div>

            <div className="flex justify-between gap-4 font-bold">
              <button className="rounded-lg bg-green-700 w-min p-2">
                Zapisz
              </button>
              <button className="rounded-lg text-purple-500 bg-green-700 w-min p-2">
                Wyczysc
              </button>
              <button className="rounded-lg text-red-500 bg-green-700 w-min p-2">
                Anuluj
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
