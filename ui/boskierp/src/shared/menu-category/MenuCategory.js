import MenuCatChosen from "./MenuCatChosen";
import MenuCatSelect from "./MenuCatSelect";
import React from "react";
import sendMessage from "../../Api";

export default class MenuCategory extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      noButtons: false,
      tunes: [
        // {
        //     label: "Kolor główny",
        //     value: "color-main",
        //     type: "color"
        // },
        // {
        //     label: "Kolor dodatkowy",
        //     value: "color-2",
        //     type: "color"
        // },
        // {
        //     label: "Neony lewo",
        //     value: "neon-left",
        //     type: "checkbox"
        // },
        // {
        //     label: "Neony prawo",
        //     value: "neon-right",
        //     type: "checkbox"
        // },
        // {
        //     label: "Neony przód",
        //     value: "neon-forward",
        //     type: "checkbox"
        // },
        // {
        //     label: "Neony tył",
        //     value: "neon-back",
        //     type: "checkbox"
        // },
        // {
        //     label: "Neony all",
        //     value: "neon-all",
        //     type: "checkbox"
        // },
        // {
        //     label: "Kolor neony",
        //     value: "neon-color",
        //     type: "color"
        // },
        // {
        //     label: "Xenony",
        //     value: "xenon",
        //     type: "checkbox"
        // },
        // {
        //     label: "Xenony Kolor",
        //     value: "xenon-color",
        //     type: "color"
        // }
      ],
      page: 1,
      chosen: {
        label: "Sanchez",
        value: "sanchez",
        price: 2000,
        elements: [
          {
            label: "Przyspieszenie",
            value: "1.0",
          },
          {
            label: "Masa",
            value: "5t",
          },
          {
            label: "Biegi",
            value: 2,
          },
          {
            label: "V-Max",
            value: "222km/h",
          },
        ],
      },
      elements: [
        {
          label: "SUV",
          value: "SUV",
          price: 2000,
          elements: [
            {
              label: "Sanchez",
              value: "sanchez4",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },

            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "1.0",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "0.9",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
            {
              label: "Sanchez",
              value: "sanchez",
              new: true,
              discount: 50,
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "0.9",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },

            {
              label: "Sanchez",
              value: "sanchez",
              new: true,
              elements: [
                {
                  label: "Przyspieszenie",
                  value: "0.9",
                },
                {
                  label: "Masa",
                  value: "5t",
                },
                {
                  label: "Biegi",
                  value: 2,
                },
                {
                  label: "V-Max",
                  value: "222km/h",
                },
              ],
            },
          ],
        },
      ],
    };
    this.setPage = this.setPage.bind(this);
    this.setAll = this.setAll.bind(this);

    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
  }

  // // componentDidMount() {
  // //     this.setState({
  // //         elements: [...this.state.elements, ...this.state.elements]
  // //     })
  // // }

  setPage = (page) => {
    this.setState({
      page: page,
    });
    sendMessage("menu_change", {
      name: this.state.name,
      current: page,
    });
  };

  setChosen = (chosen) => {
    this.setState({
      chosen: chosen,
    });
  };

  setAll = (obj, page) => {
    this.setState({
      chosen: obj,
      page: page,
    });
    sendMessage("menu_submit", {
      name: this.state.name,
      current: obj,
    });
  };

  open(data) {
    this.setState(data);
  }

  close = () => {
    sendMessage("menu_cancel", {
      name: this.state.name,
    });
    this.setState({ show: false });
  };

  changeColor = (val) => {
    sendMessage("menu_change", {
      name: this.state.name,
      current: val,
    });
  };

  submit = (val, type) => {
    sendMessage("menu_submit", {
      name: this.state.name,
      current: val,
      type: type,
    });
  };

  render() {
    if (!this.state.show) return <></>;
    if (this.state.page === 1)
      return (
        <MenuCatSelect
          noButtons={this.state.noButtons}
          elements={this.state.elements}
          setAll={this.setAll}
          close={this.close}
        />
      );
    else if (this.state.page === 2)
      return (
        <MenuCatChosen
          submit={this.submit}
          tunes={this.state.tunes}
          changeColor={this.changeColor}
          element={this.state.chosen}
          setPage={this.setPage}
        />
      );
  }
}
