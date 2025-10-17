import React from "react";
import sendMessage from "../../Api";

export default class Speed extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      speed: 200,
      gear: 10,
      time: "22:22",
      fuel: 10,
      rpm: 200,
      signal: {
        left: true,
        right: true,
      },
      lights: "long",
      doorLock: true,
      engine: true,
      seatBelt: true,
      scale: 100,
      main: 0,
    };

    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
    this.updateData = this.updateData.bind(this);
    this.max = 200 - 20;
    this.classes = [
      "w-full h-full flex justify-end items-end absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-center items-end absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-center items-start absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-center items-center absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-start items-end absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-start items-start absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-start items-center absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-end items-center absolute p-2 opacity-90 overflow-hidden",
      "w-full h-full flex justify-end items-start absolute p-2 opacity-90 overflow-hidden",
    ];
  }

  // componentDidMount() {
  //     let rpm = 1000
  //     let xd = rpm / 1000
  //     let one = 15
  //     let xd2 = xd * one
  //     this.setState({
  //         rpm: xd2
  //     })

  // }

  open() {
    this.setState({ show: true });
  }

  close() {
    this.setState({ show: false });
  }

  updateData(data) {
    let rpm = (data.rpm / 1000) * 15;
    data.rpm = rpm;
    this.setState(data);
  }

  render() {
    if (!this.state.show) return <></>;
    return (
      <div class={this.classes[this.state.main]}>
        <div
          className="flex relative h-fit w-fit items-end justify-center select-none"
          style={{ scale: this.state.scale + "%" }}
        >
          <img
            src={`${process.env.PUBLIC_URL}/img/other/speed.png`}
            className="select-none pointer-events-none"
            alt="RADIO"
          />
          <div className="w-7 h-28 bg-black absolute top-1/4 mx-0.5 left-12 my-2 rounded-lg flex justify-between items-center flex-col">
            {this.state.signal.left && (
              <svg
                className="w-10 animate-pulse   h-5 text-green-500"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path d="M10 2.5V6h7v8h-7v3.5L2.5 10 10 2.5z" />
              </svg>
            )}

            {this.state.lights === "long" && (
              <svg
                className="w-10 rotate-180 h-5 text-blue-500"
                fill="currentColor"
                version="1.1"
                id="Layer_1"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 504.657 504.657"
              >
                <g>
                  <g>
                    <g>
                      <path d="M252.878,76.041c-82.315,0.059-159.82,27.824-207.201,75.063C15.796,180.9,0,215.959,0,252.488     c0,96.709,113.437,175.725,252.861,176.128h0.017c3.693,0,7.16-3.072,8.234-6.606c33.951-111.322,33.868-228.914-0.235-340.035     C259.802,78.458,256.554,76.049,252.878,76.041z" />
                      <path d="M496.263,201.602H311.607c-4.633,0-8.393,3.76-8.393,8.393s3.76,8.393,8.393,8.393h184.656     c4.633,0,8.393-3.76,8.393-8.393S500.896,201.602,496.263,201.602z" />
                      <path d="M496.263,285.537H311.607c-4.633,0-8.393,3.76-8.393,8.393s3.76,8.393,8.393,8.393h184.656     c4.633,0,8.393-3.76,8.393-8.393S500.896,285.537,496.263,285.537z" />
                      <path d="M496.263,369.471H311.607c-4.633,0-8.393,3.76-8.393,8.393c0,4.633,3.76,8.393,8.393,8.393h184.656     c4.633,0,8.393-3.76,8.393-8.393C504.657,373.232,500.896,369.471,496.263,369.471z" />
                      <path d="M311.607,134.455h184.656c4.633,0,8.393-3.76,8.393-8.393s-3.76-8.393-8.393-8.393H311.607     c-4.633,0-8.393,3.76-8.393,8.393S306.974,134.455,311.607,134.455z" />
                    </g>
                  </g>
                </g>
              </svg>
            )}
            {!this.state.doorLock ? (
              <svg
                className="w-10 h-5 text-green-500"
                viewBox="0 0 24 24"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M16 3.25C14.7402 3.25 13.532 3.75045 12.6412 4.64124C11.7504 5.53204 11.25 6.74022 11.25 8V10.25H6C5.27065 10.25 4.57118 10.5397 4.05546 11.0555C3.53973 11.5712 3.25 12.2707 3.25 13V18C3.25 18.7293 3.53973 19.4288 4.05546 19.9445C4.57118 20.4603 5.27065 20.75 6 20.75H13C13.7293 20.75 14.4288 20.4603 14.9445 19.9445C15.4603 19.4288 15.75 18.7293 15.75 18V13C15.75 12.2707 15.4603 11.5712 14.9445 11.0555C14.4288 10.5397 13.7293 10.25 13 10.25H12.75V8C12.75 7.13805 13.0924 6.3114 13.7019 5.7019C14.3114 5.09241 15.138 4.75 16 4.75C16.862 4.75 17.6886 5.09241 18.2981 5.7019C18.9076 6.3114 19.25 7.13805 19.25 8C19.25 8.19891 19.329 8.38968 19.4697 8.53033C19.6103 8.67098 19.8011 8.75 20 8.75C20.1989 8.75 20.3897 8.67098 20.5303 8.53033C20.671 8.38968 20.75 8.19891 20.75 8C20.75 6.74022 20.2496 5.53204 19.3588 4.64124C18.468 3.75045 17.2598 3.25 16 3.25ZM14.25 13V18C14.25 18.3315 14.1183 18.6495 13.8839 18.8839C13.6495 19.1183 13.3315 19.25 13 19.25H6C5.66848 19.25 5.35054 19.1183 5.11612 18.8839C4.8817 18.6495 4.75 18.3315 4.75 18V13C4.75 12.6685 4.8817 12.3505 5.11612 12.1161C5.35054 11.8817 5.66848 11.75 6 11.75H13C13.3315 11.75 13.6495 11.8817 13.8839 12.1161C14.1183 12.3505 14.25 12.6685 14.25 13Z"
                  fill="currentColor"
                />
              </svg>
            ) : (
              <svg
                className="w-10 h-5 text-red-500"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M13 14C13 13.4477 12.5523 13 12 13C11.4477 13 11 13.4477 11 14V16C11 16.5523 11.4477 17 12 17C12.5523 17 13 16.5523 13 16V14Z"
                  fill="currentcolor"
                />
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M7 8.12037C5.3161 8.53217 4 9.95979 4 11.7692V17.3077C4 19.973 6.31545 22 9 22H15C17.6846 22 20 19.973 20 17.3077V11.7692C20 9.95979 18.6839 8.53217 17 8.12037V7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7V8.12037ZM15 7V8H9V7C9 6.64936 9.06015 6.31278 9.17071 6C9.58254 4.83481 10.6938 4 12 4C13.3062 4 14.4175 4.83481 14.8293 6C14.9398 6.31278 15 6.64936 15 7ZM6 11.7692C6 10.866 6.81856 10 8 10H16C17.1814 10 18 10.866 18 11.7692V17.3077C18 18.7208 16.7337 20 15 20H9C7.26627 20 6 18.7208 6 17.3077V11.7692Z"
                  fill="currentcolor"
                />
              </svg>
            )}
            <svg
              fill="currentColor"
              style={{ color: !this.state.engine ? "red" : "green" }}
              className=" w-10 h-5"
              version="1.1"
              id="Layer_1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 511.999 511.999"
            >
              <g>
                <g>
                  <path d="M494.32,196.801l-4.858-8.131h-85.516v39.564h-8.557v-57.371h-44.32l-28.138-24.95h-46.53v-22.695h14.966V89.827H172.742    v33.391h14.966v22.695h-48.443l-28.138,24.95H55.791v16.696v66.236h-22.4v-42.616H0v118.625h33.391v-42.617h22.4v66.236v16.696    h83.474l58.709,52.054h197.414v-58.444h8.557v39.565h85.516l4.858-8.132c1.81-3.027,17.68-31.537,17.68-99.181    S496.13,199.829,494.32,196.801z M221.101,123.22h21.909v22.695h-21.909V123.22z M468.927,369.902h-31.59v-39.565h-75.34v58.444    H210.646l-58.709-52.054H89.183V204.255h34.617l28.138-24.95h158.32l28.138,24.95h23.601v57.371h75.34v-39.564h31.59    c3.873,11.386,9.681,34.956,9.681,73.921C478.609,334.947,472.801,358.516,468.927,369.902z" />
                </g>
              </g>
            </svg>
          </div>
          <div className="w-7 h-20 bg-black absolute top-1/4 mx-0.5 right-12 my-2 rounded-lg flex flex-col justify-between items-start">
            {this.state.signal.right && (
              <svg
                className="w-10 h-5 text-green-500  animate-pulse "
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path d="M17.5 10L10 17.5V14H3V6h7V2.5l7.5 7.5z" />
              </svg>
            )}
            {this.state.lights === "short" && (
              <svg
                fill="currentcolor"
                className="w-10 h-5 text-yellow-500"
                version="1.1"
                id="Layer_1"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 512 512"
              >
                <g>
                  <g>
                    <g>
                      <path d="M319.66,17.515C317.804,7.36,308.972,0,298.668,0C133.975,0,0.001,114.837,0.001,256c0,141.141,133.973,256,298.667,256     c10.304,0,19.136-7.381,20.992-17.536l2.197-12.053c26.069-153.365,26.048-305.792-0.043-453.077L319.66,17.515z" />
                      <path d="M373.015,146.285l106.667,64c3.435,2.069,7.232,3.051,10.965,3.051c7.253,0,14.315-3.691,18.304-10.368     c6.059-10.091,2.795-23.211-7.317-29.269l-106.667-64c-10.112-6.08-23.232-2.773-29.269,7.317     C359.639,127.127,362.903,140.226,373.015,146.285z" />
                      <path d="M501.638,301.702l-106.667-64c-10.133-6.08-23.232-2.773-29.269,7.317c-6.059,10.091-2.795,23.211,7.317,29.269     l106.667,64c3.435,2.069,7.232,3.029,10.944,3.029c7.253,0,14.315-3.669,18.325-10.347     C515.013,320.86,511.75,307.761,501.638,301.702z" />
                      <path d="M501.638,429.702l-106.667-64c-10.133-6.08-23.232-2.773-29.269,7.317c-6.059,10.091-2.795,23.211,7.317,29.269     l106.667,64c3.435,2.069,7.232,3.029,10.944,3.029c7.253,0,14.315-3.669,18.325-10.347     C515.013,448.86,511.75,435.761,501.638,429.702z" />
                    </g>
                  </g>
                </g>
              </svg>
            )}
            <svg
              fill={`${!this.state.seatBelt ? "red" : "green"}`}
              className="w-10 h-5"
              version="1.1"
              id="Layer_1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 512 512"
            >
              <g>
                <g>
                  <path d="M494.297,363.555c-0.327-3.24-2.41-6.029-5.411-7.265c-29.687-12.253-60.734-22.122-92.46-29.643    c-4.025-56.223-27.03-106.452-62.799-137.304l72.995-72.995c3.452-3.443,3.452-9.031,0-12.482l-24.964-24.973    c-3.31-3.31-9.172-3.31-12.482,0l-76.438,76.438c-0.909-2.648-1.421-5.42-1.421-8.271v-15.351    c0.115-0.071,0.212-0.159,0.327-0.221c2.445-1.439,4.785-3.019,7.036-4.732c0.185-0.141,0.38-0.274,0.565-0.424    c4.776-3.708,9.039-8.015,12.729-12.809c0.009-0.018,0.026-0.035,0.035-0.053c5.429-7.08,9.543-15.192,11.988-24.02    c0.106-0.38,0.194-0.759,0.291-1.139c0.609-2.348,1.103-4.74,1.465-7.177c0.097-0.627,0.212-1.245,0.291-1.88    c0.344-2.834,0.583-5.703,0.583-8.633C326.626,31.682,294.943,0,256.005,0s-70.621,31.682-70.621,70.621    c0,2.931,0.229,5.8,0.583,8.633c0.079,0.636,0.194,1.253,0.283,1.88c0.371,2.436,0.856,4.829,1.465,7.177    c0.097,0.38,0.185,0.759,0.291,1.139c2.454,8.828,6.559,16.94,11.997,24.02c0.009,0.018,0.018,0.035,0.035,0.053    c3.681,4.793,7.954,9.101,12.729,12.809c0.185,0.15,0.371,0.282,0.565,0.424c2.242,1.713,4.582,3.293,7.027,4.732    c0.115,0.062,0.221,0.15,0.335,0.221v15.351c0,10.072-5.959,19.341-15.536,24.179c-49.364,24.929-83.968,84.798-89.45,153.644    c-32.918,7.83-64.185,18.317-92.919,31.55c-2.887,1.333-4.838,4.122-5.102,7.3c-0.265,3.169,1.209,6.241,3.84,8.024l35.31,23.967    c2.277,1.536,5.129,1.924,7.742,1.068c17.32-5.738,34.083-10.761,50.432-15.086c1.236,49.496,10.726,93.793,27.233,125.537    c1.51,2.922,4.537,4.758,7.83,4.758h44.138c3.063,0,5.906-1.589,7.512-4.202c1.607-2.604,1.748-5.861,0.371-8.598    c-10.417-20.683-16.013-49.593-16.649-86.016c45.444-9.287,96.088-9.278,141.118-0.018c-0.636,36.44-6.232,65.351-16.649,86.034    c-1.386,2.737-1.245,5.994,0.362,8.598c1.607,2.613,4.458,4.202,7.521,4.202h44.138c3.293,0,6.312-1.836,7.83-4.758    c16.508-31.744,25.997-76.058,27.233-125.59c16.349,4.334,33.112,9.375,50.423,15.139c0.909,0.3,1.854,0.45,2.79,0.45    c1.748,0,3.478-0.521,4.952-1.518l35.31-23.967C493.158,369.938,494.632,366.777,494.297,363.555z M321.117,201.86    c31.638,26.712,52.506,70.612,57.3,120.435c-36.537-7.601-74.108-11.723-111.448-12.703c-1.121-0.035-2.242-0.062-3.363-0.088    c-4.334-0.088-8.678-0.336-13.003-0.336c-12.721,0-25.406,0.397-37.985,1.183L321.117,201.86z M213.121,187.004    c15.563-7.874,25.229-23.172,25.229-39.945v-8.139c5.65,1.457,11.546,2.322,17.655,2.322c6.1,0,11.997-0.865,17.655-2.322v8.139    c0,7.556,2.013,14.989,5.764,21.583L134.608,313.459C142.509,256.15,172.169,207.678,213.121,187.004z M356.472,494.345h-25.22    c8.651-23.066,13.03-52.674,13.03-88.276c0-4.114-2.842-7.68-6.85-8.607c-51.491-11.847-110.839-11.838-162.834,0    c-4.017,0.909-6.868,4.484-6.868,8.607c0,35.602,4.37,65.209,13.021,88.276h-25.212c-14.239-29.881-22.343-70.903-23.067-116.798    c3.266-0.847,6.541-1.651,9.816-2.419c9.092-2.013,18.044-3.752,26.924-5.288c1.554-0.274,3.09-0.494,4.635-0.75    c7.327-1.218,14.592-2.269,21.822-3.16c1.986-0.247,3.972-0.477,5.95-0.697c7.08-0.794,14.115-1.43,21.124-1.916    c1.686-0.115,3.372-0.256,5.049-0.353c35.752-2.11,70.974-0.256,107.617,5.623c0.124,0.018,0.256,0.035,0.388,0.062    c9.251,1.492,18.6,3.231,28.072,5.226c5.235,1.165,10.461,2.383,15.669,3.69C378.806,423.468,370.702,464.481,356.472,494.345z" />
                </g>
              </g>
            </svg>
          </div>
          <div className="w-8 rounded-md -mx-1.5 h-9 bg-black absolute top-1/3 left-1/4 flex justify-center items-center">
            <svg
              className="w-5 h-5  "
              viewBox="0 0 30 30"
              id="Layer_1"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
            >
              <defs>
                <linearGradient id="grad" x1="0" x2="0" y1="100%" y2="0">
                  <stop offset={`0%`} stop-color="yellow" stop-opacity="1.0" />
                  <stop
                    offset={this.state.fuel + "%"}
                    stop-color="yellow"
                    stop-opacity="1.0"
                  />
                  <stop offset={`0%`} stop-color="gray" stop-opacity="1.0" />
                  <stop offset={`90%`} stop-color="gray" stop-opacity="1.0" />
                  {/* <stop offset={`${100 - this.state.fuel}%`} stop-color="gray" stop-opacity="1.0" />
                                <stop offset={`${this.state.fuel}%`} stop-color="yellow" stop-opacity="1.0" />
                                <stop offset={`100%`} stop-color="yellow" stop-opacity="1.0" /> */}
                </linearGradient>
              </defs>
              <path
                fill="url(#grad)"
                class="st7"
                d="M27,8h-2c-2.2,0-4,1.8-4,4v7c0,0.6-0.4,1-1,1h-1V5c0-0.6-0.4-1-1-1H6C5.4,4,5,4.4,5,5v20H4c-0.6,0-1,0.4-1,1v1  h18v-1c0-0.6-0.4-1-1-1h-1v-3h1c1.7,0,3-1.3,3-3v-7h1c1.1,0,2-0.9,2-2h1c0.6,0,1-0.4,1-1S27.6,8,27,8z M8,11c0-2.2,1.8-4,4-4  s4,1.8,4,4v1h-2.9c0-0.2-0.1-0.3-0.2-0.4l-1.3-1.9c-0.2-0.2-0.5-0.4-0.8-0.3c-0.4,0.1-0.6,0.5-0.4,0.9L11,12H8V11z"
              />
            </svg>
          </div>
          <div
            className="absolute top-1/4 left-1/3 -mx-1 w-40 h-20 bg-black text-white text-5xl text-center flex justify-center items-center"
            style={{ fontFamily: "digital2" }}
          >
            <div>{this.state.speed}</div>
            <div className="text-sm font-mono">km/h</div>
            <div className="text-sm">
              <div>GEAR</div>
              <div>{this.state.gear}</div>
            </div>
          </div>
          <div className="absolute w-3/5 -mx-4 left-1/4 h-10 bg-black my-0.5 bottom-10 flex justify-between items-end gap-4">
            <div className="text-white font-mono flex flex-col justify-center items-center">
              <svg
                fill="currentcolor"
                className="w-10 text-green-500 h-5"
                viewBox="0 0 1920 1920"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M1377.882 1344 903.53 988.235v-592.94h112.942v536.47l429.176 321.77-67.765 90.465ZM960 0C430.645 0 0 430.645 0 960c0 529.242 430.645 960 960 960 529.242 0 960-430.758 960-960 0-529.355-430.758-960-960-960Z"
                  fill-rule="evenodd"
                />
              </svg>
              {this.state.time}
            </div>
            <div className="w-full h-full flex jusitfy-center items-end py-2 relative font-mono">
              {Array(13)
                .fill()
                .map((v, i) => {
                  return (
                    <div
                      className="w-1 h-5 bg-white text-white absolute"
                      style={{
                        left: i * 15,
                        backgroundColor: `${i >= 10 ? "red" : ""}`,
                      }}
                    >
                      <div className="absolute z-20 -my-5 -mx-0.5">
                        {i <= 10 ? i : ""}
                      </div>
                    </div>
                  );
                })}

              <div
                className="w-1 h-5 bg-green-500 z-20 text-white absolute transition-all"
                style={{ left: this.state.rpm <= 200 ? this.state.rpm : 0 }}
              ></div>
              <div className="w-full z-10 h-1 bg-gradient-to-r from-white to-red-500"></div>
            </div>
          </div>
        </div>
        {/* <div className="w-1/5 h-1/4 bg-black flex text-white relative justify-center items-center">
            </div> */}
      </div>
    );
  }
}
