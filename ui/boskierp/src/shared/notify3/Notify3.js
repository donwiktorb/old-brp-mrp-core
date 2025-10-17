import React from "react";
import { CSSTransition, TransitionGroup } from "react-transition-group"; // ES6

// const delay = ms => new Promise(resolve => setTimeout(resolve, ms))

export default class Notify extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            Notifies: [
                // // {
                // //     title: "nnnnn",
                // //     content: "nnnnn2",
                // //     type: "inv",
                // //     count: 222,
                // //     item: "weapon_pistol"
                // // },
                // // {
                // //     title: "nnnnn",
                // //     content: "nnnnn2",
                // //     type: "inv",
                // //     count: 222,
                // //     item: "weapon_pistol"
                // // },
                // {
                //     title: "nnnnn",
                //     content: "nnnnn2",
                //     type: "inv",
                //     count: 222,
                //     item: "weapon_pistol"
                // },
                // // {
                // //     title: "nnnnn",
                // //     content: "nnnnn2",
                // //     type: "inv",
                // //     count: 222,
                // //     remove:true,
                // //     item: "drone"
                // // }
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
                if (v.removed) {
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
                    if (border >= 100) v.removed = true;
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
        if (this.state.Notifies.length >= 2) {
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

    // // componentDidMount() {
    // //     this.add({
    // //         title: "nnnnn",
    // //         content: "nnnnn2",
    // //         type: "inv",
    // //         count: 222,
    // //         item: "drone"
    // //     })
    // // }

    // async componentDidMount() {
    //     // for (let i=0; i<=20; i++) {

    //     //     let notify = {
    //     //         title: "Hi",
    //     //         content: "Need something?"+i,
    //     //         type: "info",
    //     //         border: 0,
    //     //     }
    //     //     await delay(2000)
    //     //     this.add(notify)
    //     // }
    //     clearInterval(this.timer)
    //     // this.timer = setInterval(() => {
    //     //     this.setState((state) => {
    //     //         const Notifies = state.Notifies

    //     //         Notifies.forEach((v) => {
    //     //             let border = v.border
    //     //             if (border >= 100) {
    //     //                 clearInterval(v.timer)
    //     //             }
    //     //             else v.border += 3.125
    //     //         })

    //     //         return {Notifies}
    //     //     })
    //     // }, 500)
    //     this.updateBorders()
    // }

    // updateNotifies = () => {
    // this.setState(prevState => {
    //     const updatedNotifies = prevState.Notifies.map(v => {
    //     let border = v.border;
    //     if (border >= 100) {
    //     } else {
    //         v.border += 3.125;
    //     }
    //     return v;
    //     });

    //     return { Notifies: updatedNotifies };
    // });
    // };

    // updateBorders = () => {
    //     this.timer = !this.timer && setInterval(() => {
    //         // console.log('ticking')
    //         // setCount(prevCount => prevCount + 1) // new
    //         this.updateNotifies()
    //     }, 1000)
    // }

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
        } else if (v.type === "inv") {
            return (
                <div
                    key={k}
                    className={` bg-gray-900 border-t-4 border-gray-500 rounded-b text-red-100 px-2 py-1 shadow-md`}
                    role="alert"
                >
                    <div className="flex">
                        <div className="relative">
                            {/* <svg className="fill-current h-6 w-6 text-red-500 mr-4" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12.866 3l9.526 16.5a1 1 0 0 1-.866 1.5H2.474a1 1 0 0 1-.866-1.5L11.134 3a1 1 0 0 1 1.732 0zm-8.66 16h15.588L12 5.5 4.206 19zM11 16h2v2h-2v-2zm0-7h2v5h-2V9z"/></svg> */}
                            <img
                                draggable="false"
                                className="w-20 object-scale-down object-center"
                                src={`${process.env.PUBLIC_URL}/img/inv/${v.item}.png`}
                                alt={v.item}
                            />

                            {v.remove ? (
                                <div className="absolute bottom-0 left-0 font-bold text-red-500">
                                    -{v.count}
                                </div>
                            ) : (
                                <div className="absolute bottom-0 left-0 font-bold text-green-500">
                                    +{v.count}
                                </div>
                            )}
                        </div>
                    </div>
                    {/* <div className="w-full mt-2 bg-gray-200 rounded-full h-0.5 dark:bg-gray-700">
                        <div className="bg-yellow-500 h-0.5 rounded-full transition-all duration-1000" style={{width: v.border+"%"}}></div>
                    </div> */}
                </div>
            );
        } else {
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
        }
    }

    render() {
        return (
            <div className="flex justify-start items-center p-4 py-14 opacity-90   overflow-hidden h-full">
                <div className="flex flex-col gap-4 break-all ">
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
