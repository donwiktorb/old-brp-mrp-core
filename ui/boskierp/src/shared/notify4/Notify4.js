import React from "react";
import { CSSTransition, TransitionGroup } from "react-transition-group"; // ES6

// const delay = ms => new Promise(resolve => setTimeout(resolve, ms))

export default class Notify extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      Notifies: [
        // // // {
        // // //     title: "Hi",
        // // //     content: "Need something?",
        // // //     border: 0,
        // // //     style: {
        // // //         mainDiv: `bg-pink-900 border-t-4 border-green-500 rounded-b text-green-100 px-4 py-3 shadow-md`,
        // // //         borderDiv: `bg-green-600 h-0.5 rounded-full transition-all duration-1000`,
        // // //         borderDivMain: 'bg-green-600 h-0.5 rounded-full transition-all duration-1000',
        // // //         img: `https://w7.pngwing.com/pngs/668/568/png-transparent-swat-police-fbi-special-weapons-and-tactics-teams-logo-incident-response-team-swat-people-sniper-bird.png`
        // // //     }
        // // // },
        // // {
        // //     title: "Hi",
        // //     content: "Need something?",
        // //     type: "simple",
        // //     style:  " bg-black border-t-4 border-green-500 rounded-b text-green-100 px-4 py-3 shadow-md text-green-500",
        // //         svg: `
        // //             <svg class="w-6 h-6 fill-current mr-4" version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" >
        // //             <g>
        // //                 <circle fill="current" cx="32" cy="14" r="3"/>
        // //                 <path fill="current" d="M4,25h56c1.794,0,3.368-1.194,3.852-2.922c0.484-1.728-0.242-3.566-1.775-4.497l-28-17   C33.438,0.193,32.719,0,32,0s-1.438,0.193-2.076,0.581l-28,17c-1.533,0.931-2.26,2.77-1.775,4.497C0.632,23.806,2.206,25,4,25z    M32,9c2.762,0,5,2.238,5,5s-2.238,5-5,5s-5-2.238-5-5S29.238,9,32,9z"/>
        // //                 <rect x="34" y="27" fill="current" width="8" height="25"/>
        // //                 <rect x="46" y="27" fill="current" width="8" height="25"/>
        // //                 <rect x="22" y="27" fill="current" width="8" height="25"/>
        // //                 <rect x="10" y="27" fill="current" width="8" height="25"/>
        // //                 <path fill="current" d="M4,58h56c0-2.209-1.791-4-4-4H8C5.791,54,4,55.791,4,58z"/>
        // //                 <path fill="current" d="M63.445,60H0.555C0.211,60.591,0,61.268,0,62v2h64v-2C64,61.268,63.789,60.591,63.445,60z"/>
        // //             </g>
        // //             </svg>
        // //         `,
        // // },
        // // {
        // //     title: "Bank",
        // //     // content: [
        // //     //     {
        // //     //         content: `
        // //     //         <div class="flex">
        // //     //         <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        // //     //         <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        // //     //         </svg>
        // //     //         Godzina:
        // //     //         </div>
        // //     //         `
        // //     //     },
        // //     //     {
        // //     //         content: `
        // //     //         <div class="flex">
        // //     //         <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        // //     //         <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        // //     //         </svg>
        // //     //         Lokalizacja:
        // //     //         </div>
        // //     //         `
        // //     //     }
        // //     // ],
        // //     content: "Dodano 2 000$",
        // //     border: 0,
        // //     style: {
        // //         mainDiv: `bg-black border-t-4 border-green-500 rounded-b text-green-500 px-4 py-3 shadow-md`,
        // //         borderDiv: `bg-green-500 h-0.5 rounded-full transition-all duration-1000`,
        // //         borderDivMain: 'bg-green-600 h-0.5 rounded-full transition-all duration-1000',
        // //         // img: `https://gtaim-panel.com/wp-content/uploads/2021/10/Screenshot_417.png` ,
        // //         imgClass: "w-10 h-10",
        // //         title: "font-bold",
        // //         content: "text-sm",
        // //         subDiv: "",
        // //         perContent: "py-0.5",
        // //         svg: `
        // //             <svg class="w-6 h-6 fill-current mr-4" version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" >
        // //             <g>
        // //                 <circle fill="current" cx="32" cy="14" r="3"/>
        // //                 <path fill="current" d="M4,25h56c1.794,0,3.368-1.194,3.852-2.922c0.484-1.728-0.242-3.566-1.775-4.497l-28-17   C33.438,0.193,32.719,0,32,0s-1.438,0.193-2.076,0.581l-28,17c-1.533,0.931-2.26,2.77-1.775,4.497C0.632,23.806,2.206,25,4,25z    M32,9c2.762,0,5,2.238,5,5s-2.238,5-5,5s-5-2.238-5-5S29.238,9,32,9z"/>
        // //                 <rect x="34" y="27" fill="current" width="8" height="25"/>
        // //                 <rect x="46" y="27" fill="current" width="8" height="25"/>
        // //                 <rect x="22" y="27" fill="current" width="8" height="25"/>
        // //                 <rect x="10" y="27" fill="current" width="8" height="25"/>
        // //                 <path fill="current" d="M4,58h56c0-2.209-1.791-4-4-4H8C5.791,54,4,55.791,4,58z"/>
        // //                 <path fill="current" d="M63.445,60H0.555C0.211,60.591,0,61.268,0,62v2h64v-2C64,61.268,63.789,60.591,63.445,60z"/>
        // //             </g>
        // //             </svg>
        // //         `,
        // //         // mainTextClass: "flex flex-col gap-1 items-center",
        // //         // text: "[10-55]",
        // //         // textClass: "px-1.5"
        // //     }
        // // }
        // {
        //     title: "Hi",
        //     content: [
        //         {
        //             content: `
        //             <div class="flex">
        //             <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        //             <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        //             </svg>
        //             Godzina:
        //             </div>
        //             `
        //         },
        //         {
        //             content: `
        //             <div class="flex">
        //             <svg class="w-5 h-5 text-green-500" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        //             <path d="M12 7V12L14.5 10.5M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        //             </svg>
        //             Lokalizacja:
        //             </div>
        //             `
        //         }
        //     ],
        //     // content: "Need something?",
        //     border: 0,
        //     style: {
        //         mainDiv: `bg-black border-t-4 border-green-500 rounded-b text-green-500 px-4 py-3 shadow-md`,
        //         borderDiv: `bg-green-500 h-0.5 rounded-full transition-all duration-1000`,
        //         borderDivMain: 'bg-green-600 h-0.5 rounded-full transition-all duration-1000',
        //         // img: `https://gtaim-panel.com/wp-content/uploads/2021/10/Screenshot_417.png` ,
        //         imgClass: "w-10 h-10",
        //         title: "font-bold",
        //         content: "text-sm",
        //         subDiv: "",
        //         perContent: "py-0.5",
        //         svg: `
        //             <svg class="w-6 h-6 fill-current mr-4" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-351 153 256 256" xml:space="preserve">
        //             <path id="XMLID_1_" d="M-177.7,334.5c6.3-2.3,12.6-5.2,19.8-8.6c31.9-16.4,51.7-41.7,51.7-41.7s-32.5,0.6-64.4,17  c-4,1.7-7.5,4-10.9,5.7c5.7-7.5,12.1-16.4,18.7-25c25-37.1,31.3-77.3,31.3-77.3s-34.8,21-59.2,58.6c-5.2,7.5-9.8,14.9-13.8,22.7  c1.1-10.3,1.1-22.1,1.1-33.6c0-50-19.8-91.1-19.8-91.1s-19.8,40.5-19.8,91.1c0,12.1,0.6,23.3,1.1,33.6c-4-7.5-8.6-14.9-13.8-22.7  c-25-37.1-59.2-58.6-59.2-58.6s6.3,40,31.3,77.3c6.3,9.2,12.1,17.5,18.7,25c-3.4-2.3-7.5-4-10.9-5.7c-31.9-16.4-64.4-17-64.4-17  s19.8,25.6,51.7,41.7c6.9,3.4,13.2,6.3,19.8,8.6c-4,0.6-8,1.1-12.1,2.3c-30.5,6.4-53.2,23.9-53.2,23.9s27.3,7.5,58.6,1.1  c9.8-2.3,19.8-4.6,27.3-7.5c-1.1,1.1,15.8-8.6,21.6-14.4v60.4h8.6v-61.8c6.3,6.3,22.7,16.4,22.1,14.9c8,2.9,17.5,5.2,27.3,7.5  c30.8,6.3,58.6-1.1,58.6-1.1s-22.1-17.5-53.4-23.8C-169.6,335.7-173.7,335.1-177.7,334.5z"/>
        //             </svg>
        //         `,
        //         // mainTextClass: "flex flex-col gap-1 items-center",
        //         // text: "[10-55]",
        //         // textClass: "px-1.5"
        //     }
        // }
      ],
    };

    this.id = 0;
    this.add = this.add.bind(this);
    this.clear = this.clear.bind(this);
    this.queued = [];
  }

  getId() {
    if (this.id >= 100) this.id = 0;
    else this.id += 1;

    return this.id;
  }

  processQueue() {
    if (this.state.Notifies.length <= 2 && this.queued[0]) {
      this.add(this.queued.shift());
    }
  }

  componentDidUpdate() {
    this.processQueue();
  }

  removeUnused() {
    this.setState((state) => {
      const Notifies = state.Notifies;

      Notifies.forEach((v, i) => {
        if (v.remove) {
          Notifies.splice(i, 1);
        }
      });

      return {
        Notifies,
      };
    });
  }

  async borderLoop(itemId) {
    this.removeUnused();
    await this.setState((state) => {
      const Notifies = state.Notifies;
      let time = 250;
      Notifies.forEach((v, i) => {
        if (v.id === itemId) {
          if (v.time) time = v.time;
          let border = v.border;
          if (border >= 100) v.remove = true;
          else v.border += 3.125;
        }
      });

      setTimeout(() => {
        this.borderLoop(itemId);
      }, time);
      return {
        Notifies,
      };
    });
  }

  queue(item) {
    this.queued.push(item);
  }

  add(data) {
    let id = this.getId();
    data.id = id;
    data.border = 0;
    // // console.log(this.state.Notifies.length)
    if (this.state.Notifies.length >= 3) {
      this.queue(data);
    } else {
      this.setState((state) => {
        const Notifies = [data, ...state.Notifies];

        return {
          Notifies,
        };
      });

      this.borderLoop(id);
    }
  }

  clear() {
    this.setState({ Notifies: [] });
  }

  async componentDidMount() {
    // for (let i=0; i<=20; i++) {
    // let notify = {
    //     title: "Hi",
    //     content: "Need something?",
    //     type: "info",
    //     border: 0,
    // }
    // this.add(notify)
    // }
  }
  getNotifyTheme(v, k) {
    if (v.type === "info") {
      return (
        <div
          key={k}
          className={` bg-blue-900 border-t-4 border-blue-500 rounded-b text-blue-100 px-4 py-3 shadow-md`}
          role="alert"
        >
          <div className="flex">
            <div className="py-1">
              <svg
                className="fill-current h-6 w-6 text-blue-500 mr-4"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
              >
                <path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z" />
              </svg>
            </div>
            <div>
              <p
                className="font-bold"
                dangerouslySetInnerHTML={{ __html: v.title }}
              ></p>
              <p
                className="text-sm"
                dangerouslySetInnerHTML={{ __html: v.content }}
              ></p>
            </div>
          </div>
          <div className="w-full mt-2 bg-gray-200 rounded-full h-0.5 dark:bg-gray-700">
            <div
              className="bg-blue-600 h-0.5 rounded-full transition-all duration-1000"
              style={{ width: v.border + "%" }}
            ></div>
          </div>
        </div>
      );
    } else if (v.type === "warn") {
      return (
        <div
          key={k}
          className={` bg-red-900 border-t-4 border-red-500 rounded-b text-red-100 px-4 py-3 shadow-md`}
          role="alert"
        >
          <div className="flex">
            <div className="py-1">
              <svg
                className="fill-current h-6 w-6 text-red-500 mr-4"
                viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path d="M12.866 3l9.526 16.5a1 1 0 0 1-.866 1.5H2.474a1 1 0 0 1-.866-1.5L11.134 3a1 1 0 0 1 1.732 0zm-8.66 16h15.588L12 5.5 4.206 19zM11 16h2v2h-2v-2zm0-7h2v5h-2V9z" />
              </svg>
            </div>
            <div>
              <p
                className="font-bold"
                dangerouslySetInnerHTML={{ __html: v.title }}
              ></p>
              <p
                className="text-sm"
                dangerouslySetInnerHTML={{ __html: v.content }}
              ></p>
            </div>
          </div>
          <div className="w-full mt-2 bg-gray-200 rounded-full h-0.5 dark:bg-gray-700">
            <div
              className="bg-red-600 h-0.5 rounded-full transition-all duration-1000"
              style={{ width: v.border + "%" }}
            ></div>
          </div>
        </div>
      );
    } else if (v.type == "success") {
      return (
        <div
          key={k}
          className={` bg-green-900 border-t-4 border-green-500 rounded-b text-green-100 px-4 py-3 shadow-md`}
          role="alert"
        >
          <div className="flex">
            <div className="py-1">
              <svg
                className="fill-current h-6 w-6 text-green-500 mr-4"
                viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M10.2426 16.3137L6 12.071L7.41421 10.6568L10.2426 13.4853L15.8995 7.8284L17.3137 9.24262L10.2426 16.3137Z"
                  fill="currentColor"
                />
                <path
                  fillRule="evenodd"
                  clipRule="evenodd"
                  d="M1 12C1 5.92487 5.92487 1 12 1C18.0751 1 23 5.92487 23 12C23 18.0751 18.0751 23 12 23C5.92487 23 1 18.0751 1 12ZM12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12C21 16.9706 16.9706 21 12 21Z"
                  fill="currentColor"
                />
              </svg>
            </div>
            <div>
              <p
                className="font-bold"
                dangerouslySetInnerHTML={{ __html: v.title }}
              ></p>
              <p
                className="text-sm"
                dangerouslySetInnerHTML={{ __html: v.content }}
              ></p>
            </div>
          </div>
          <div className="w-full mt-2 bg-gray-200 rounded-full h-0.5 dark:bg-gray-700">
            <div
              className="bg-green-600 h-0.5 rounded-full transition-all duration-1000"
              style={{ width: v.border + "%" }}
            ></div>
          </div>
        </div>
      );
    } else if (v.type == "simple") {
      return (
        <div key={k} class={v.style} role="alert">
          <div className="flex">
            {v.svg && (
              <div
                className="py-1"
                dangerouslySetInnerHTML={{ __html: v.svg }}
              ></div>
            )}
            {!v.svg && (
              <div className="py-1">
                <svg
                  className="fill-current h-6 w-6 text-blue-500 mr-4"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20"
                >
                  <path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z" />
                </svg>
              </div>
            )}
            <div>
              <p
                className="font-bold"
                dangerouslySetInnerHTML={{ __html: v.title }}
              ></p>
              <p
                className="text-sm"
                dangerouslySetInnerHTML={{ __html: v.content }}
              ></p>
            </div>
          </div>
          <div className="w-full mt-2 bg-gray-200 rounded-full h-0.5 dark:bg-gray-700">
            <div
              className="bg-green-600 h-0.5 rounded-full transition-all duration-1000"
              style={{ width: v.border + "%" }}
            ></div>
          </div>
        </div>
      );
    } else {
      return (
        <div key={`${k}-${v.id}`} class={v.style.mainDiv}>
          <div class={"flex py-1"}>
            <div className={v.style.mainTextClass}>
              {v.style.img && (
                <div class={v.style.imgClass}>
                  <img src={v.style.img} alt="hello" />
                </div>
              )}

              {v.style.text && (
                <div
                  class={v.style.textClass}
                  dangerouslySetInnerHTML={{ __html: v.style.text }}
                ></div>
              )}

              {v.style.svg && (
                <div dangerouslySetInnerHTML={{ __html: v.style.svg }}></div>
              )}
            </div>

            <div class={v.style.subDiv}>
              <div
                class={v.style.title}
                dangerouslySetInnerHTML={{ __html: v.title }}
              ></div>

              <div class={v.style.content}>
                {Array.isArray(v.content) ? (
                  v.content.map((v5, i5) => {
                    return (
                      <div
                        key={`text-${k}-${i5}`}
                        class={v.style.perContent}
                        dangerouslySetInnerHTML={{ __html: v5.content }}
                      ></div>
                    );
                  })
                ) : (
                  <div dangerouslySetInnerHTML={{ __html: v.content }}></div>
                )}
              </div>
            </div>
          </div>

          <div class={v.style.borderDiv}>
            <div
              class={v.style.borderDivMain}
              style={{ width: v.border + "%" }}
            ></div>
          </div>
        </div>
      );
    }
  }

  render() {
    return (
      <div className="flex justify-end p-4 opacity-90   overflow-hidden">
        <div className="grid grid-cols-1  gap-2 max-w-2xl break-all ">
          <TransitionGroup component={null} className="todo-list">
            {this.state.Notifies.map((v, i) => (
              <CSSTransition key={i} timeout={500} classNames="item">
                {this.getNotifyTheme(v, i)}
              </CSSTransition>
            ))}
          </TransitionGroup>
        </div>
      </div>
    );
  }
}
