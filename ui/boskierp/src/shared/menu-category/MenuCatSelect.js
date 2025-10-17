import React from "react";

export default class MenuCatSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      elements: this.props.elements,
      noButtons: this.props.noButtons,
    };

    this.static = JSON.parse(JSON.stringify(this.state.elements));

    this.defaultImg =
      "https://cosystatic.bmwgroup.com/bmwweb/cosySec?COSY-EU-100-2545xM4RIyFnbm9Mb3AgyyIJrjG0suyJRBODlsrjGpua8rQbhSIqppglBgERGal384MlficYiGHqoQxYLW7%25f3tiJ0PCJirQbLDWcQW7%251uSFoqoQh47wMvcYi9M%25CoMb3islBglUbuZcRSrQdr9SbbW8zcRacH8g7MbnW85WubxKqogMbUMdoPEyJGqo9qaFbel3iyJHy5BRbrQ%25l3ulUj80cRSrQdr9YEUW8zcRacH715MbnW85WunUUqogMbUMdgmYyJGqo9qaG4zl3iyJHy5i3RrQ%25l3ulU%25awcRSrQdr9SmnW8zcRacHzRuMbnW85Wun87qogMbUMdgPoyJGqo9qaDJKl3iyJHy5m3ArQ%25l3ulUCGpcRSrQdr98KGW8zcRacHbziMbnW85Wuo9bqogMbUMdJbtyJGqo9qa3s7l3iyJHy5Q4urQbBUq2rjGLqryJR5GlJirjGNY3QcNQBUJ1";
  }

  // // componentDidMount() {
  // //     this.setState({
  // //         elements: [...this.state.elements, ...this.state.elements, ...this.state.elements]
  // //     })
  // // }
  onImageError = (e) => {
    e.target.src = this.defaultImage;
  };

  selectMe(obj) {
    this.props.setAll(obj, 2);
  }

  sortIt(e) {
    let { target } = e;
    let value = target.value.toLowerCase();
    let elems = JSON.parse(JSON.stringify(this.static));
    elems.forEach((nv) => {
      nv.elements = nv.elements.filter((nv2) =>
        nv2.label.toLowerCase().includes(value),
      );
    });
    elems = elems.filter((nv) => nv.elements.length > 0);
    this.setState({
      elements: elems,
    });
  }

  sortSelect(e) {
    let { target } = e;
    let value = target.value.toLowerCase();
    if (value === "all") {
      let elems = JSON.parse(JSON.stringify(this.static));
      this.setState({
        elements: elems,
      });
    } else {
      let elems = JSON.parse(JSON.stringify(this.static));
      elems = elems.filter((nv2) => nv2.label.toLowerCase().includes(value));
      this.setState({
        elements: elems,
      });
    }
  }

  sortNew(e) {
    let { target } = e;
    let { checked } = target;

    let elems = JSON.parse(JSON.stringify(this.static));
    elems.forEach((nv) => {
      nv.elements = nv.elements.filter((nv2) =>
        checked ? nv2.new === checked : nv2,
      );
    });
    elems = elems.filter((nv) => nv.elements.length > 0);
    this.setState({
      elements: elems,
    });
  }

  sortDiscount(e) {
    let { target } = e;
    let { checked } = target;

    let elems = JSON.parse(JSON.stringify(this.static));
    elems.forEach((nv) => {
      nv.elements = nv.elements.filter((nv2) => (checked ? nv2.discount : nv2));
    });
    elems = elems.filter((nv) => nv.elements.length > 0);
    this.setState({
      elements: elems,
    });
  }

  render() {
    return (
      <div className="w-full h-full flex justify-center items-center relative z-20">
        <div className="w-2/3 h-2/3 bg-gradient-to-t bg-[#181a1b] bg-opacity-90 rounded-lg  flex flex-col items-center justify-start text-gray-400 relative">
          <button className="absolute top-1 right-1" onClick={this.props.close}>
            <svg
              className="text-red-500 w-10 h-10"
              viewBox="0 0 1024 1024"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
            >
              <path
                fill="currentColor"
                d="M195.2 195.2a64 64 0 0 1 90.496 0L512 421.504 738.304 195.2a64 64 0 0 1 90.496 90.496L602.496 512 828.8 738.304a64 64 0 0 1-90.496 90.496L512 602.496 285.696 828.8a64 64 0 0 1-90.496-90.496L421.504 512 195.2 285.696a64 64 0 0 1 0-90.496z"
              />
            </svg>
          </button>
          <div className="w-full h-1/6 rounded-t-lg flex">
            <div className="w-1/2 h-full p-2 flex flex-col justify-center items-center gap-1">
              <div className="text-xl font-bold">Szukaj</div>
              <div className="relative inline-block">
                <input
                  onChange={(e) => this.sortIt(e)}
                  defaultValue=""
                  className="bg-gray-500 focus:outline-none text-black rounded-lg px-2 py-0.5 "
                />
                <svg
                  className="absolute top-0 right-0.5 p-1 object-center w-7 text-black"
                  fill="currentColor"
                  version="1.1"
                  id="Layer_1"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 502.173 502.173"
                >
                  <g>
                    <g>
                      <g>
                        <path d="M494.336,443.646L316.402,265.713c20.399-31.421,30.023-68.955,27.189-106.632     C340.507,118.096,322.783,79.5,293.684,50.4C261.167,17.884,217.984,0,172.023,0c-0.222,0-0.445,0.001-0.668,0.001     C125.149,0.176,81.837,18.409,49.398,51.342c-66.308,67.316-65.691,176.257,1.375,242.85     c29.112,28.907,67.655,46.482,108.528,49.489c37.579,2.762,75.008-6.867,106.343-27.21l177.933,177.932     c5.18,5.18,11.984,7.77,18.788,7.77s13.608-2.59,18.789-7.769l13.182-13.182C504.695,470.862,504.695,454.006,494.336,443.646z      M480.193,467.079l-13.182,13.182c-2.563,2.563-6.73,2.561-9.292,0L273.914,296.456c-1.936-1.937-4.497-2.929-7.074-2.929     c-2.044,0-4.098,0.624-5.858,1.898c-60.538,43.788-143.018,37.3-196.118-15.425C5.592,221.146,5.046,124.867,63.646,65.377     c28.67-29.107,66.949-45.222,107.784-45.376c0.199,0,0.392-0.001,0.591-0.001c40.617,0,78.785,15.807,107.52,44.542     c53.108,53.108,59.759,135.751,15.814,196.509c-2.878,3.979-2.441,9.459,1.032,12.932l183.806,183.805     C482.755,460.35,482.755,464.517,480.193,467.079z" />
                        <path d="M259.633,84.449c-48.317-48.316-126.935-48.316-175.253,0c-23.406,23.406-36.296,54.526-36.296,87.627     c0,33.102,12.89,64.221,36.296,87.627S138.906,296,172.007,296c33.102,0,64.222-12.891,87.627-36.297     C307.951,211.386,307.951,132.767,259.633,84.449z M245.492,245.561C225.863,265.189,199.766,276,172.007,276     c-27.758,0-53.856-10.811-73.484-30.44c-19.628-19.628-30.438-45.726-30.438-73.484s10.809-53.855,30.438-73.484     c20.262-20.263,46.868-30.39,73.484-30.39c26.61,0,53.227,10.133,73.484,30.39C286.011,139.112,286.011,205.042,245.492,245.561z     " />
                        <path d="M111.017,153.935c1.569-5.296-1.452-10.861-6.747-12.43c-5.294-1.569-10.86,1.451-12.429,6.746     c-8.73,29.459-0.668,61.244,21.04,82.952c1.952,1.952,4.512,2.929,7.071,2.929s5.118-0.977,7.071-2.928     c3.905-3.906,3.905-10.238,0-14.143C110.506,200.544,104.372,176.355,111.017,153.935z" />
                        <path d="M141.469,94.214c-10.748,4.211-20.367,10.514-28.588,18.735c-3.905,3.906-3.905,10.238,0,14.143     c1.952,1.952,4.512,2.929,7.071,2.929s5.118-0.977,7.07-2.929c6.26-6.26,13.575-11.057,21.741-14.255     c5.143-2.015,7.678-7.816,5.664-12.959C152.413,94.735,146.611,92.202,141.469,94.214z" />
                      </g>
                    </g>
                  </g>
                </svg>
              </div>
            </div>
            {!this.state.noButtons && (
              <div className="w-1/2 h-full p-2 ">
                <div>
                  <div className="text-xl text-center font-bold">Filtry</div>
                  <div className="flex gap-4">
                    <div className="flex gap-1 items-center">
                      <div>Kategoria</div>
                      <select
                        onChange={(e) => this.sortSelect(e)}
                        className="rounded-lg p-1 bg-gray-500 text-white"
                      >
                        <option value="all">Wszystkie</option>
                        {this.static.map((v, i) => {
                          return <option value={v.label}>{v.label}</option>;
                        })}
                      </select>
                    </div>

                    <div className="flex items-center gap-4">
                      <div>Tylko Nowe</div>
                      <div className="w-5 h-5">
                        <input
                          defaultChecked={false}
                          onChange={(e) => this.sortNew(e)}
                          type="checkbox"
                          class="appearance-none border-2 bg-white checked:bg-black w-full h-full rounded"
                        />
                      </div>
                    </div>

                    <div className="flex items-center gap-4">
                      <div>Tylko Przecena</div>
                      <div className="w-5 h-5">
                        <input
                          defaultChecked={false}
                          onChange={(e) => this.sortDiscount(e)}
                          type="checkbox"
                          class="appearance-none border-2 bg-white checked:bg-black w-full h-full rounded"
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>

          <div className="w-full h-full flex flex-col px-5 overflow-auto gap-5 ">
            {this.state.elements.map((v, i) => {
              return (
                <div key={`hello-${i}`} className="w-full h-fit">
                  <div className="text-2xl py-2">{v.label}</div>
                  <div className="grid grid-cols-4 gap-5 justify-items-center">
                    {v.elements.map((nv, ni) => {
                      return (
                        <button
                          key={`hi-${ni}`}
                          onClick={(e) => this.selectMe(nv)}
                          className="w-3/5 h-fit rounded-lg p-1 relative select-none group flex flex-col"
                        >
                          <img
                            onError={this.onImageError}
                            src={
                              nv.img ||
                              `https://docs.fivem.net/vehicles/${nv.value}.webp`
                            }
                            alt="NO"
                            className="transition ease-in-out delay-100 group-hover:scale-110 w-full h-full"
                          />
                          <div className="text-xl font-bold">{nv.label}</div>
                          {nv.new && (
                            <div className="text-xs p-0.5 rounded-lg bg-gray-500 text-white font-bold absolute top-0 right-0">
                              NOWOŚĆ
                            </div>
                          )}

                          {nv.discount && (
                            <div className="text-xs p-0.5 rounded-lg bg-red-500 text-white font-bold absolute top-0 left-0">
                              PRZECENA {nv.discount}%
                            </div>
                          )}

                          {/* <div className="grid grid-cols-2 gap-2 truncate">
                                            {nv.elements.map((nv2, ni2) => {
                                                return <div className="flex gap-2">
                                                    <div>{nv2.label}</div>
                                                    <div className="font-bold">{nv2.value}</div>
                                                </div>
                                            })}
                                        </div> */}
                          <div className="text-lg flex gap-1">
                            <div>od</div>
                            <div className="text-green-500">
                              {new Intl.NumberFormat().format(nv.price)}$
                            </div>
                          </div>
                        </button>
                      );
                    })}
                  </div>
                </div>
              );
            })}
          </div>

          {/* <div className="w-full h-1/6  rounded-b-lg">

                </div> */}
        </div>
      </div>
    );
  }
}
