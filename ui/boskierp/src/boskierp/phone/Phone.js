import React from "react";
import "./phone.css";
import sendMessage from "../../Api";
import Header from "./header/Header";
import Footer from "./footer/Footer";

import { Link } from "react-router-dom";

import Swipe from "./lib/Swipe";
import Article from "./article/Article";

export default class Phone extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      show: false,
      battery: 90,
      chats: {
        twitter: [],
        darkweb: [],
      },
      messages: [],
      lastMessages: [],
      calls: [],
      photos: [],
      contacts: [],
      storeApps: [],
      crime: {
        inGroup: false,
        isGroupOwner: false,
        members: [],
        btc: 0.0,
        actions: [],
      },
      notifications: [],

      callStateManager: {
        isCalling: false,
        inCall: false,
        callOwner: false,
        caller: "",
        stopCall: false,
        offer: false,
        answer: false,
        candidate: false,
      },
    };
    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
    this.setCrimeData = this.setCrimeData.bind(this);
    this.article = this.article.bind(this);
    this.setCallState = this.setCallState.bind(this);
    this.clearNotifiesByType = this.clearNotifiesByType.bind(this);
    this.addNotify = this.addNotify.bind(this);
    this.setAnswer = this.setAnswer.bind(this);
    this.setOffer = this.setOffer.bind(this);
    this.setMessages = this.setMessages.bind(this);
    this.setLastMessages = this.setLastMessages.bind(this);
    this.addCandidate = this.addCandidate.bind(this);
    this.setChatMessages = this.setChatMessages.bind(this);
    // this.setNotifies = this.setNotifies.bind(this)
    this.setBattery = this.setBattery.bind(this);
    this.stopCall = this.stopCall.bind(this);
    this.onKey = this.onKey.bind(this);
  }

  open() {
    this.setState({ show: true });
  }

  setCrimeData(data) {
    this.setState({ crime: { ...this.state.crime, ...data } });
  }

  close() {
    this.setState({ show: false });
  }

  setCallState(data) {
    this.setState(({ callStateManager }) => ({
      callStateManager: { ...callStateManager, ...data },
    }));
    console.log(data, this.state);
    // this.setState({callStateManager: {...this.state.callStateManager, ...data}},  () => {console.log(this.state)})
  }

  clearNotifiesByType(data) {
    this.setState((s) => {
      const notifications = s.notifications;
      notifications.filter((v) => v.type !== data.type);
      return { notifications };
    });
  }

  clearNotifies() {
    this.setState({ notifications: [] });
  }

  addNotify(data) {
    this.setState({ notifications: [...this.state.notifications, data] });
  }

  removeNotify(e, i) {
    e.preventDefault();
    this.setState((state) => {
      const notifications = state.notifications;
      notifications.slice(i, 1);
      return { notifications };
    });
  }

  stopCall() {
    // this.setState({ callStateManager: {...this.state.callStateManager, stopCall: true} }, () => {
    //     setTimeout(() => {
    //         this.setState({ callStateManager: {...this.state.callStateManager, stopCall: false} })
    //     }, 5000)
    // })
    this.setState(({ callStateManager }) => ({
      callStateManager: {
        ...callStateManager,
        stopCall: true,
        caller: "",
        isCalling: false,
      },
    }));
  }
  cancel = () => {
    sendMessage("menu_cancel", {
      name: "phone",
    });
  };
  article(data) {
    if (this[data.action]) return this[data.action](data);
  }
  setBattery(battery) {
    this.setState({ battery: battery });
  }
  setChatMessages(data) {
    this.setState((state) => {
      const chats = state.chats;
      chats[data.type] = data.messages;
      return {
        chats,
      };
    });
  }

  addCandidate(data) {
    // this.rtc.addCandidate(data.candidate)
    // this.setState({

    this.setState(({ callStateManager }) => ({
      callStateManager: {
        ...callStateManager,
        candidate: data.candidate,
        caller: data.number,
      },
    }));

    //     callStateManager: {...this.state.callStateManager, candidate: data.candidate}
    // }, () => {
    //     // setTimeout(() => {
    //     //     this.setState({
    //     //         callStateManager: {...this.state.callStateManager, candidate: false}
    //     //     })
    //     // }, 10000)
    // })
  }

  setOffer(data) {
    this.setState(({ callStateManager }) => ({
      callStateManager: {
        ...callStateManager,
        offer: data.offer,
        caller: data.number,
        isCalling: true,
      },
    }));
    // this.rtc.init(data.number, () => {
    //     this.rtc.setOffer(data.offer)
    // })
    // console.log(data.number)
    // this.setState({
    //     callStateManager: {...this.state.callStateManager, offer: data.offer, caller:data.number, isCalling:true}
    // }, () => {
    //     // setTimeout(() => {
    //     //     this.setState({
    //        console.log(this.state)
    //     //         callStateManager: {...this.state.callStateManager, offer: false, caller:false, isCalling:false}
    //     //     })
    //     // }, 10000)
    // })
  }

  setAnswer(data) {
    // this.rtc.setAnswer(data.answer)
    this.setState(({ callStateManager }) => ({
      callStateManager: {
        ...callStateManager,
        answer: data.answer,
        caller: data.number,
      },
    }));
    // this.setState({
    //     // answer: data.answer
    //     callStateManager: {...this.state.callStateManager, answer: data.answer}
    // }, () => {
    //     // setTimeout(() => {
    //     //     this.setState({
    //     //         // answer: false
    //     //         callStateManager: {...this.state.callStateManager, answer: false}
    //     //     })
    //     // }, 10000)
    // })
  }

  setMessages(data) {
    this.setState({
      messages: data.messages,
    });
  }
  setLastMessages(data) {
    this.setState({
      lastMessages: data.messages,
    });
  }

  // // componentDidUpdate() {

  // //     if (this.state.show) {
  // //         const classes = Swipe.directions();
  // //         const elem = document.querySelector('#swipe-open');
  // //         const elem2 = document.querySelector('#swipe-close')

  // //         const afterSwipe = (direction) => {
  // //             elem.style.height = null
  // //             if (direction === 'down') {
  // //                 elem.classList.remove('h-0')
  // //                 elem.classList.add('h-full')
  // //             } else {
  // //                 elem.classList.remove('h-full')
  // //                 elem.classList.add('h-0')
  // //             }
  // //         };

  // //         const liveSwipe = (direction, dist) => {
  // //             if (dist <= 100)
  // //                 elem.style.height = `${dist}%`
  // //         };

  // //         const swipe = new Swipe(elem, {
  // //             corners: false,
  // //             minDistance: 35

  // //         });

  // //         this.swipe = swipe

  // //         let afterEvent = swipe.addEventListener("after", direction => {
  // //             afterSwipe(direction);
  // //         });

  // //         let liveEvent = swipe.addEventListener("live", (direction, dist) => {
  // //             liveSwipe(direction, dist);
  // //         });
  // //     } else {
  // //         this.swipe.removeListeners()
  // //         this.swipe = null
  // //     }
  // // }

  onKey(e) {
    if (e.key === "Escape") {
      this.cancel();
    }
  }
  render() {
    if (!this.state.show) return <div></div>;
    return (
      <div
        className={`flex h-full absolute flex justify-end items-end z-20 w-full`}
      >
        {/* <div className="w-1/6 h-4/6 max-h-3/5 text-center relative rounded-md m-4 origin-bottom-right" style={{ scale: "100%" }}> */}
        <div
          className="w-[20rem] h-[40rem] text-center relative rounded-md m-4 origin-bottom-right"
          style={{ scale: "100%" }}
        >
          {/* <div id="phonebg" className="w-full h-full absolute object-scale-down object-center "></div> */}
          {/* <div className="w-full h-full absolute object-scale-down object-center bg-black rounded-lg"></div> */}

          <div id="phonebg4" className="w-full h-full ">
            {/* <div className="w-full h-full px-[8px] py-3"> */}
            <div className="w-full h-full">
              <div
                id="phone-bg-main"
                className="w-full h-full flex flex-col gap-4 rounded-3xl bg-gradient-to-t from-purple-700 to-purple-500 text-white"
              >
                <div className="w-full h-full rounded-t-3xl flex flex-col ">
                  <div
                    className="w-full h-[5%] rounded-t-xl flex justify-around items-center"
                    onMouseDown={this.onMouseDown}
                  >
                    <Header battery={this.state.battery} />
                  </div>

                  <div className="w-full h-full overflow-auto">
                    <div className="w-full h-full relative">
                      <div className="w-full h-full overflow-auto pt-5">
                        <Article
                          ref={(ref) => (this.Article = ref)}
                          state={this.state}
                          callFn={(data) => this.article(data)}
                        />
                      </div>
                      <div
                        id="swipe-open"
                        className="w-full h-5 bg-opacity-50 bg-gray-900 flex flex-col py-2 items-center absolute top-0 right-0 transition-all overflow-hidden hover:h-full transition-[height] delay-50 duration-300 easy-in-out"
                      >
                        <div className="w-full h-full overflow-hidden">
                          <div className="w-full h-auto">
                            <div className="w-full h-auto flex gap-4 px-4 justify-between">
                              <button
                                title="powiadomienia"
                                id="clear"
                                to={"/twitter/"}
                                onClick={this.clearNotifies}
                                className="w-10 h-10 rounded-lg text-black hover:scale-110 transition-all flex flex-col justify-center items-center self-end text-red-500 "
                              >
                                <svg
                                  className="w-full h-full text-red-500"
                                  viewBox="0 0 24 24"
                                  fill="none"
                                  xmlns="http://www.w3.org/2000/svg"
                                >
                                  <path
                                    d="M9 9L15 15"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                  <path
                                    d="M15 9L9 15"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                  <circle
                                    cx="12"
                                    cy="12"
                                    r="9"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                </svg>
                              </button>
                              <Link
                                title="settings"
                                id="settings"
                                to={"/settings/"}
                                className="w-10 h-10 rounded-lg text-black hover:scale-110 transition-all flex flex-col justify-center items-center self-end"
                              >
                                <svg
                                  className="w-full h-full"
                                  viewBox="0 0 30.8 27.8"
                                  xmlns="http://www.w3.org/2000/svg"
                                >
                                  <g
                                    id="Group_716"
                                    data-name="Group 716"
                                    transform="translate(-100.2 -100.1)"
                                  >
                                    <path
                                      id="Path_1494"
                                      data-name="Path 1494"
                                      d="M124.5,117h-1.8l1.3,1.3a1.45,1.45,0,0,1,0,2.1l-3.5,3.5a1.45,1.45,0,0,1-2.1,0l-1.3-1.3v1.8a1.538,1.538,0,0,1-1.5,1.5h-5a1.538,1.538,0,0,1-1.5-1.5v-1.8l-1.3,1.3a1.45,1.45,0,0,1-2.1,0l-3.5-3.5a1.45,1.45,0,0,1,0-2.1l1.3-1.3h-1.8a1.538,1.538,0,0,1-1.5-1.5v-5a1.538,1.538,0,0,1,1.5-1.5h1.8l-1.3-1.3a1.45,1.45,0,0,1,0-2.1l3.5-3.5a1.45,1.45,0,0,1,2.1,0l1.3,1.3v-1.8a1.538,1.538,0,0,1,1.5-1.5h5a1.538,1.538,0,0,1,1.5,1.5v1.8l1.3-1.3a1.45,1.45,0,0,1,2.1,0l3.5,3.5a1.45,1.45,0,0,1,0,2.1l-1.3,1.3h1.8a1.538,1.538,0,0,1,1.5,1.5v5A1.538,1.538,0,0,1,124.5,117Zm-.5-5.5a.472.472,0,0,0-.5-.5h-1.7a7.674,7.674,0,0,0-1.2-2.8l1.2-1.2a.483.483,0,0,0,0-.7l-2.1-2.1a.483.483,0,0,0-.7,0l-1.2,1.2a11.82,11.82,0,0,0-2.8-1.2v-1.7a.472.472,0,0,0-.5-.5h-3a.472.472,0,0,0-.5.5v1.7a7.674,7.674,0,0,0-2.8,1.2l-1.2-1.2a.483.483,0,0,0-.7,0l-2.1,2.1a.483.483,0,0,0,0,.7l1.2,1.2a11.82,11.82,0,0,0-1.2,2.8h-1.7a.472.472,0,0,0-.5.5v3a.472.472,0,0,0,.5.5h1.7a7.674,7.674,0,0,0,1.2,2.8l-1.2,1.2a.483.483,0,0,0,0,.7l2.1,2.1a.483.483,0,0,0,.7,0l1.2-1.2a11.82,11.82,0,0,0,2.8,1.2v1.7a.472.472,0,0,0,.5.5h3a.472.472,0,0,0,.5-.5v-1.7a7.674,7.674,0,0,0,2.8-1.2l1.2,1.2a.483.483,0,0,0,.7,0l2.1-2.1a.483.483,0,0,0,0-.7l-1.2-1.2a11.82,11.82,0,0,0,1.2-2.8h1.7a.472.472,0,0,0,.5-.5ZM113,119a6,6,0,1,1,6-6A6.018,6.018,0,0,1,113,119Zm0-10a4,4,0,1,0,4,4A4.012,4.012,0,0,0,113,109Z"
                                      fill="currentColor"
                                    />
                                  </g>
                                </svg>
                              </Link>
                            </div>
                          </div>
                          <div className="w-full h-full overflow-y-scroll p-4">
                            {this.state.notifications.map((v, i) => {
                              <div className="flex justify-around w-full h-auto bg-gray-700 rounded-lg p-0.5">
                                <button
                                  onClick={(e) => this.removeNotify(e, i)}
                                  title="powiadomienia"
                                  id="clear"
                                  to={"/twitter/"}
                                  className="w-10 h-10 rounded-lg text-black hover:scale-110 transition-all flex flex-col justify-center items-center self-end text-red-500 "
                                >
                                  <svg
                                    className="w-full h-full text-red-500"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    xmlns="http://www.w3.org/2000/svg"
                                  >
                                    <path
                                      d="M9 9L15 15"
                                      stroke="currentColor"
                                      stroke-width="2"
                                      stroke-linecap="round"
                                      stroke-linejoin="round"
                                    />
                                    <path
                                      d="M15 9L9 15"
                                      stroke="currentColor"
                                      stroke-width="2"
                                      stroke-linecap="round"
                                      stroke-linejoin="round"
                                    />
                                    <circle
                                      cx="12"
                                      cy="12"
                                      r="9"
                                      stroke="currentColor"
                                      stroke-width="2"
                                      stroke-linecap="round"
                                      stroke-linejoin="round"
                                    />
                                  </svg>
                                </button>
                                <div className="w-full h-auto flex flex-col">
                                  <div>{v.title}</div>
                                  <div className="text-sm">{v.content}</div>
                                </div>
                                <Link
                                  title="powiadomienia"
                                  id="clear"
                                  to={v.redirect}
                                  className="w-10 h-10 rounded-lg text-black hover:scale-110 transition-all flex flex-col justify-center items-center self-end text-red-500 "
                                >
                                  <svg
                                    className="w-full h-full text-green-500"
                                    viewBox="0 0 30 30"
                                    fill="none"
                                    xmlns="http://www.w3.org/2000/svg"
                                  >
                                    <path
                                      d="M6.65263 14.0304C6.29251 13.6703 6.29251 13.0864 6.65263 12.7263C7.01276 12.3662 7.59663 12.3662 7.95676 12.7263L11.6602 16.4297L19.438 8.65183C19.7981 8.29171 20.382 8.29171 20.7421 8.65183C21.1023 9.01195 21.1023 9.59583 20.7421 9.95596L12.3667 18.3314C11.9762 18.7219 11.343 18.7219 10.9525 18.3314L6.65263 14.0304Z"
                                      fill="currentColor"
                                    />
                                    <path
                                      clip-rule="evenodd"
                                      d="M14 1C6.8203 1 1 6.8203 1 14C1 21.1797 6.8203 27 14 27C21.1797 27 27 21.1797 27 14C27 6.8203 21.1797 1 14 1ZM3 14C3 7.92487 7.92487 3 14 3C20.0751 3 25 7.92487 25 14C25 20.0751 20.0751 25 14 25C7.92487 25 3 20.0751 3 14Z"
                                      fill="currentColor"
                                      fill-rule="evenodd"
                                    />
                                  </svg>
                                </Link>
                              </div>;
                            })}
                          </div>
                        </div>
                        <div
                          id="swipe-close"
                          className="w-1/3 h-2 bg-white rounded-lg"
                        ></div>
                      </div>
                    </div>
                  </div>

                  <div className="w-full h-[15%] rounded-b-xl ">
                    {/* <div className="w-full h-3 absolute bottomflex justify-center items-center items-center">
                                                <div className="w-1/3 h-full flex justify-between items-center pb-4">
                                                    <div className={`w-3 h-3 rounded-full bg-white`}>

                                                    </div>
                                                    <div className={`w-3 h-3 rounded-full border-2`}>

                                                    </div>
                                                    <div className={`w-3 h-3 rounded-full border-2`}>

                                                    </div>
                                                </div>

                                            </div> */}
                    <div className="w-full h-full relative">
                      <Footer />
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
