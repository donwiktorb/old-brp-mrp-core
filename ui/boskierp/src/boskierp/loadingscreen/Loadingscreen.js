import React from "react";



// we are using this https://github.com/MaelDrapier/react-simple-snake here 
import sendMessage from "../../Api";
import { CSSTransition } from "react-transition-group";

export default class Loadingscreen extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            show: window.nuiHandoverData ? true : false,
            playerLoaded: false,
            player: this.player || {},
            id: localStorage.getItem("loadingscreen-video") || "vbLOeHL82UY",
            volume: localStorage.getItem("loadingscreen-volume") || "25",
            width: 0,
        };

        this.count = 0;
        this.newCount = 0;
        this.playerLoaded = this.playerLoaded.bind(this);
        this.loadingEvents = this.loadingEvents.bind(this);
        this.loadMeIn = this.loadMeIn.bind(this);
    }

    loadingEvents(data) {
        switch (data.eventName) {
            case "startInitFunctionOrder": {
                this.count = data.count;
                break;
            }

            case "initFunctionInvoking": {
                this.setState({
                    width: (data.idx / this.count) * 100,
                });
                break;
            }

            case "startDataFileEntries": {
                this.count = data.count;
                break;
            }

            case "performMapLoadFunction": {
                this.newCount += 1;

                this.setState({
                    width: (this.newCount / this.count) * 100,
                });
                break;
            }

            default:
                break;
        }
    }

    playerLoaded() {
        this.setState({
            playerLoaded: true,
            width: 100,
        });
    }

    componentDidMount() {
        if (!window.YT) {
            const tag = document.createElement("script");

            tag.src = "https://www.youtube.com/iframe_api";

            window.onYoutubeIframeAPIReady = () => this.loadVideo();

            const scriptTag = document.getElementsByTagName("script")[0];
            scriptTag.parentNode.insertBefore(tag, scriptTag);
            setTimeout(() => {
                this.loadVideo();
            }, 2000);
        } else {
            this.loadVideo();
        }
    }

    loadVideo = () => {
        const { id } = this.state;
        this.player = new window.YT.Player(`youtube-player`, {
            videoId: id,
            playerVars: { autoplay: 1, controls: 0, loop: 1 },
            events: {
                onReady: this.onPlayerReady,
                // // onStateChange: this.onStateChange
            },
        });
    };

    onStateChange = (playerStatus) => {
        if (playerStatus === window.YT.PlayerState.ENDED) {
            this.loadVideo();
        }
    };

    onPlayerReady = (event) => {
        this.player = event.target;
        event.target.playVideo();
        event.target.setVolume(this.state.volume);
        // this.setState({player: event.target})
    };

    setVideo(e) {
        e.preventDefault();
        let { value } = e.target;
        let vidTag = value?.split("v=")[1]?.split("&")[0];
        if (!vidTag) return;
        this.setState({
            id: vidTag,
        });
        localStorage.setItem("loadingscreen-video", vidTag);

        if (this.player) this.player.loadVideoById(vidTag);
        e.target.value = "Zmieniono!";
    }

    getVolume() {
        return this.state.volume;
    }

    setVolume(e) {
        e.preventDefault();
        let { value } = e.target;
        this.setState({ volume: value });
        localStorage.setItem("loadingscreen-volume", value);
        if (this.player) this.player.setVolume(value);
    }

    loadMeIn(e) {
        if (e && e.preventDefault) e.preventDefault();
        sendMessage("loadMeIn", {});
        this.setState({ show: false });
    }

    render() {
        return (
            <CSSTransition
                in={this.state.show}
                timeout={500}
                classNames="loading"
                unmountOnExit
            >
                <div className="z-40">
                    <div id={`youtube-player`} className="absolute w-full h-full"></div>
                    <div></div>
                    <div className="bg-black text-white w-full h-full absolute z-30 grid">
                        <div>
                            <nav className=" border-gray-200 px-2 sm:px-4 py-2.5 rounded bg-gray-900">
                                <div className="container grid grid-cols-3 gap-4 content-between justify-items-center mx-auto">
                                    <a href="https://militaryrp.pl/" className="flex items-start">
                                        <img
                                            src="https://cdn.discordapp.com/attachments/635045504111214592/938907638408818738/xd8.png"
                                            className="mr-3 h-6 sm:h-9"
                                            alt="BoskieRP Logo"
                                        />
                                        <span className="self-center text-xl font-semibold whitespace-nowrap dark:text-white">
                                            BoskieRP
                                        </span>
                                    </a>
                                    <div className="flex md:order-2">
                                        <button
                                            type="button"
                                            data-collapse-toggle="navbar-search"
                                            aria-controls="navbar-search"
                                            aria-expanded="false"
                                            className="md:hidden  text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 rounded-lg text-sm p-2.5 mr-1"
                                        >
                                            <svg
                                                className="w-5 h-5"
                                                aria-hidden="true"
                                                fill="currentColor"
                                                viewBox="0 0 20 20"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    fillRule="evenodd"
                                                    d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                                                    clipRule="evenodd"
                                                ></path>
                                            </svg>
                                            <span className="sr-only">Search</span>
                                        </button>
                                        <div className="hidden relative md:block">
                                            <div className="flex absolute inset-y-0 -top-2 left-0 items-center pl-3 pointer-events-none">
                                                <svg
                                                    className="w-5 h-5 text-gray-500"
                                                    aria-hidden="true"
                                                    fill="currentColor"
                                                    viewBox="0 0 20 20"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                >
                                                    <path
                                                        fillRule="evenodd"
                                                        d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                                                        clipRule="evenodd"
                                                    ></path>
                                                </svg>
                                                <span className="sr-only">Search icon</span>
                                            </div>
                                            <input
                                                onChange={(e) => this.setVideo(e)}
                                                type="text"
                                                id="search-navbar"
                                                className="block p-2 pl-10 w-full text-gray-900 rounded-lg border border-gray-300 sm:text-sm focus:ring-blue-500 focus:border-blue-500 bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                placeholder="Link do piosenki..."
                                            />
                                        </div>
                                        <button
                                            data-collapse-toggle="navbar-search"
                                            type="button"
                                            className="inline-flex items-center p-2 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
                                            aria-controls="navbar-search"
                                            aria-expanded="false"
                                        >
                                            <span className="sr-only">Open menu</span>
                                            <svg
                                                className="w-6 h-6"
                                                aria-hidden="true"
                                                fill="currentColor"
                                                viewBox="0 0 20 20"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    fillRule="evenodd"
                                                    d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                                                    clipRule="evenodd"
                                                ></path>
                                            </svg>
                                        </button>
                                    </div>
                                    <div
                                        className="hidden justify-between items-center w-full md:flex md:w-auto md:order-1 "
                                        id="navbar-search"
                                    >
                                        <div className="relative mt-3 md:hidden">
                                            <div className="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                                <svg
                                                    className="w-5 h-5 text-gray-500"
                                                    aria-hidden="true"
                                                    fill="currentColor"
                                                    viewBox="0 0 20 20"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                >
                                                    <path
                                                        fillRule="evenodd"
                                                        d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                                                        clipRule="evenodd"
                                                    ></path>
                                                </svg>
                                            </div>
                                            <input
                                                onChange={(e) => this.setVideo(e)}
                                                type="text"
                                                id="search-navbar"
                                                className="block p-2 pl-10 w-full   rounded-lg border border-gray-300 sm:text-sm focus:ring-blue-500 focus:border-blue-500 bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                placeholder="Link do piosenki..."
                                            />
                                        </div>
                                        <ul className="flex flex-col p-4 mt-4  rounded-lg border md:flex-row md:space-x-8 md:mt-0 md:text-sm md:font-medium md:border-0  bg-gray-800 text-white border-gray-700">
                                            <li>
                                                <a
                                                    target="_blank"
                                                    rel="noreferrer"
                                                    href="https://militaryrp.pl"
                                                    className="block py-2 pr-4 pl-3  rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 md:dark:hover:text-white text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent border-gray-700"
                                                >
                                                    Strona
                                                </a>
                                            </li>
                                            <li>
                                                <a
                                                    target="_blank"
                                                    rel="noreferrer"
                                                    href="https://discord.gg/militaryrp"
                                                    className="block text-white py-2 pr-4 pl-3 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 md:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700"
                                                >
                                                    Discord
                                                </a>
                                            </li>
                                            <li>
                                                <a
                                                    target="_blank"
                                                    rel="noreferrer"
                                                    href="https://tiktok.com/@fivemmilitaryrp"
                                                    className="block py-2 pr-4 pl-3 text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-gray-400 md:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700"
                                                >
                                                    Tiktok
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div className=" border-2 border-gray-800 px-2 sm:px-4 py-2.5 rounded bg-gray-900">
                                    <div className="text-center grid grid-cols-3 gap-4">
                                        <a href="https://boskierp.pl/" className="place-self-start">
                                            <span className="self-center text-xl font-semibold whitespace-nowrap dark:text-white">
                                                {this.player?.videoTitle}
                                            </span>
                                        </a>

                                        <div className="place-self-center">
                                            {this.state.playerLoaded ? (
                                                <div>
                                                    <button
                                                        onClick={(e) => this.loadMeIn(e)}
                                                        className="relative inline-flex items-center justify-center p-0.5 mb-2 mr-2 overflow-hidden text-sm font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-purple-600 to-blue-500 group-hover:from-purple-600 group-hover:to-blue-500 hover:text-white dark:text-white focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800"
                                                    >
                                                        <span className="relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0">
                                                            Naciśnij, aby zamknąć ekran ładowania.
                                                        </span>
                                                    </button>
                                                </div>
                                            ) : (
                                                <h2>
                                                    Trwa ładowanie, po zakończeniu pojawi się tutaj
                                                    przycisk.
                                                </h2>
                                            )}
                                        </div>

                                        <div className="place-self-end">
                                            <div className="">
                                                <label
                                                    for="minmax-range"
                                                    className="block mb-2 text-sm font-medium text-gray-300"
                                                >
                                                    Głośność {this.getVolume()}%
                                                </label>
                                                <input
                                                    onChange={(e) => this.setVolume(e)}
                                                    id="minmax-range"
                                                    type="range"
                                                    min="0"
                                                    max="100"
                                                    value={this.getVolume()}
                                                    className="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer "
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </div>
                        <div>
                            {/* <SnakeGame /> */}
                        </div>
                        <div className="grid content-center">
                            <div className="w-full  rounded-full bg-gray-700 ">
                                <div
                                    className="bg-blue-600 text-xs font-medium text-blue-100 text-center p-0.5 leading-none rounded-full"
                                    style={{ width: `${this.state.width}%` }}
                                >
                                    {" "}
                                    {Math.floor(this.state.width)}%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </CSSTransition>
        );
    }
}
