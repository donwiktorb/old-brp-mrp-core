import React from "react";
export default class Ped extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  render() {
    return <div className="w-full h-full" data-invtype={"ped"}></div>;
  }
}
