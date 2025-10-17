import React, {
  useState,
  useEffect,
  useImperativeHandle,
  forwardRef,
} from "react";

export default class MouseFollow extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      position: { x: 0, y: 0 },
    };
  }

  setPosition = (event) => {
    this.setState({ position: { x: event.clientX, y: event.clientY } });
  };

  setDisplay = (src) => {
    this.setState({ src: src });
    if (src) {
      document.addEventListener("mousemove", this.setPosition);
    } else {
      document.removeEventListener("mousemove", this.setPosition);
    }
  };

  componentWillUnmount() {
    document.removeEventListener("mousemove", this.setPosition);
  }

  render() {
    if (this.state.src)
      return (
        <img
          className="pointer-events-none"
          src={this.state.src}
          alt="mouse follower"
          style={{
            position: "absolute",

            top: this.state.position.y,
            left: this.state.position.x,
            transform: "translate(-50%, -50%)",
            pointerevents: "none", // prevents the image from blocking mouse events
          }}
        />
      );
  }
}
