import React from "react";
import { BrowserRouter } from "react-router-dom";
import sendMessage, { getBase64Image } from "./Api";
import MenuDialog from "./shared/menu-dialog//MenuDialog";
import Menu from "./shared/menu/Menu";
import MenuInput from "./shared/menu-input/Menu";
import MenuExtra from "./shared/menu-extra/MenuExtra";

import MenuCategory from "./shared/menu-category/MenuCategory";
import MenuGrid from "./shared/menu-grid/MenuGrid";
import MenuSide from "./shared/menu-side/MenuSide";
import MenuCursor from "./shared/menu-cursor/MenuCursor";
import Chat from "./shared/chat/Chat";
import Hud from "./shared/hud/Hud";
import Tab from "./shared/tab/Tab";
import Bar from "./shared/progbar/Bar";
import Scoreboard from "./shared/scoreboard/Scoreboard";

import Notify from "./shared/notify4/Notify4";
import Settings from "./shared/settings/Settings";
import Notify2 from "./shared/notify2/Notify2";
import Notify3 from "./shared/notify3/Notify3";

//import Hud from "./shared//hud/Hud";

import Laptop from "./shared/laptop/Laptop";

import InventoryM from "./militaryrp/inventory/Inventory";
import Aim from "./militaryrp/Aim/Aim";
import MineDefuse from "./militaryrp/defuse-mine/DefuseMine";
import MilitaryHud from "./militaryrp/hud/Hud";
import Mortar from "./militaryrp/mortar/Mortar";

import Teams from "./militaryrp/teams/Teams";

import Phone from "./boskierp/phone/Phone";
import Inventory from "./boskierp/inventory/Inventory";

import Tablet from "./boskierp/tablet/Tablet";
import Loadingscreen from "./boskierp/loadingscreen/Loadingscreen";
import Bank from "./boskierp/bank/Bank";
import Bw from "./boskierp/bw/Bw";
import Bg from "./boskierp/bg/Bg";
import Speed from "./boskierp/speed/Speed";
import Radio from "./boskierp/radio/Radio";
import Skills from "./boskierp/skills/Skills";
import CarRadio from "./boskierp/car-radio/CarRadio";
import Compass from "./boskierp/compass/Compass";
import Documents from "./boskierp/documents/Documents";
import Loading from "./boskierp/loading/Loading";
import Keys from "./boskierp/skills/Keys";
import Tut from "./boskierp/tut/Tut";
import Speed2 from "./boskierp/speed2/Speed2";
import Hacking from "./boskierp/skills/Hacking";
import Scratch from "./boskierp/scratch/Scratch";
import PoliceRadar from "./boskierp/police-radar/PoliceRadar";
import DUI from "./boskierp/dui/Dui";
import SlotMachine from "./shared/spins/Spins";

export default class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
        this.config = {
            focus: [
                "Phone",
                "Inventory",
                "MenuCircle",
                "MenuDialog",
                "MenuList",
                "MenuSide",
                "MenuPicker",
                "Chat",
                "MenuCategory",
                "MenuExtra",
                "MenuGrid",
                "Tablet",
            ],
            keyDown: ["Phone", "Skills", "Scratch", "Keys", "Inventory", "Menu"],
        };
        this.audioPlayer = null;
        this.ap = null;
        this.loopAudio = false;
        this.players = [];
        this.player = null;
        this.audioContext = new AudioContext();
    }
    setFocus(type, focus) {
        this.config.focus.forEach((v) => {
            if (v === type) {
                if (focus) {
                    document.getElementById(v).style.zIndex = "99";
                } else {
                    document.getElementById(v).style.zIndex = "0";
                }
            }
        });
    }
    isPlaying(fileName) {
        for (let v of this.players) {
            if (v.attributes.src.nodeValue === fileName) {
                return true;
            }
        }
    }
    async playSound(file, volume, loop, doNotPlayAgain) {
        const fileName = `${process.env.PUBLIC_URL}/sounds/${file}.ogg`;
        if (doNotPlayAgain && (await this.isPlaying(fileName))) return;
        if (this.audioPlayer && this.ap) {
            this.ap
                .then((_) => {
                    this.ap.pause();
                })
                .catch((error) => { });
        }
        // const fileSrc =`./sounds/${file}.ogg`
        const fileSrc = `${process.env.PUBLIC_URL}/sounds/${file}.ogg`;
        this.audioPlayer = new Audio(fileSrc);
        this.audioPlayer.crossOrigin = "anonymous";
        this.audioPlayer.volume = volume;
        this.audioPlayer.loop = loop;
        this.audioPlayer.addEventListener("canplaythrough", () => {
            this.ap = this.audioPlayer.play().catch(() => {
                this.audioPlayer.load();
                this.ap = this.audioPlayer.play();
            });
        });
        if (loop) this.players.push(this.audioPlayer);
    }

    async playSoundCoords(file, volume, coords) {
        let audioContext = new (window.AudioContext || window.webkitAudioContext)();
        let listener = audioContext.listener;
        const fileName = `${process.env.PUBLIC_URL}/sounds/${file}.ogg`;

        if (this.audioPlayer && this.ap) {
            this.ap
                .then((_) => {
                    this.ap.pause();
                })
                .catch((error) => { });
        }
        // const fileSrc =`./sounds/${file}.ogg`
        const fileSrc = `${process.env.PUBLIC_URL}/sounds/${file}.ogg`;
        this.audioPlayer = new Audio(fileSrc);
        this.audioPlayer.crossOrigin = "anonymous";
        this.audioPlayer.volume = volume;
        let source = audioContext.createMediaElementSource(this.audioPlayer);
        let panner = new PannerNode(audioContext, { panningModel: "HRTF" });
        source.connect(panner).connect(audioContext.destination);
        panner.positionX.value = coords.x;
        panner.positionY.value = coords.y;
        panner.positionZ.value = coords.z;

        listener.positionX.value = 0;
        listener.positionY.value = 0;
        listener.positionZ.value = 0;

        this.audioPlayer.addEventListener("canplaythrough", () => {
            this.ap = this.audioPlayer.play().catch(() => {
                this.audioPlayer.load();
                this.ap = this.audioPlayer.play();
            });
        });
    }

    stopSound(file) {
        if (this.audioPlayer && this.ap) {
            let fileName = file ? `./sounds/${file}.ogg` : null;
            let removeThese = [];
            if (file)
                this.players.forEach((v, i) => {
                    if (v.attributes.src.nodeValue === fileName) {
                        v.pause();
                        v.currentTime = 0;
                        v.src =
                            "data:audio/wav;base64,UklGRiQAAABXQVZFZm10IBAAAAABAAEAVFYAAFRWAAABAAgAZGF0YQAAAAA=";
                        removeThese.push(i);
                    }
                });
            else
                this.players.forEach((v, i) => {
                    v.pause();
                    v.currentTime = 0;
                    v.src =
                        "data:audio/wav;base64,UklGRiQAAABXQVZFZm10IBAAAAABAAEAVFYAAFRWAAABAAgAZGF0YQAAAAA=";
                    removeThese.push(i);
                });
            removeThese.forEach((v) => {
                this.players.splice(v, 1);
            });
            this.audioPlayer.loop = false;
            this.audioPlayer.pause();
            this.ap
                .then((_) => {
                    this.ap.pause();
                })
                .catch((error) => { });
        }
    }

    onStateChange(e) {
        if (e.data === window.YT.PlayerState.PLAYING) {
            // let el = this.player.getIframe().contentDocument.getElementsByTagName('video')[0]
            // console.log(el)
            if (this.playerSeek) {
                this.player.seekTo(this.playerSeek);
                this.playerSeek = null;
            }

            if (this.playerVolume) {
                this.player.setVolume(this.playerVolume);
                this.playerVolume = null;
            }
            this.playerUpdate = setInterval(() => {
                sendMessage("dwb_ui_youtube_time", {
                    time: this.getCurrentDuration(),
                });
            }, 1000);
        } else if (e.data === window.YT.PlayerState.ENDED) {
            this.playerSeek = false;
            this.playerVolume = false;

            clearInterval(this.playerUpdate);

            sendMessage("dwb_ui_youtube_end", {});
        }
    }

    startVideo(id, boxCoords, playerCoords, orientation, up) {
        this.stopVideo();
        this.player = new window.YT.Player(`yt-player`, {
            videoId: id,
            playerVars: { autoplay: 0, controls: 0, loop: 0 },
            events: {
                onReady: (e) =>
                    this.onPlayerReady(e, boxCoords, playerCoords, orientation, up),
            },
        });
    }

    setTime(time) {
        if (this.player) this.player.seekTo(time);
    }

    setVolume(v) {
        if (this.player) {
            this.player.setVolume(v);
        }
    }
    setVideo(id) {
        if (this.player) {
            this.player.loadVideoById(id);
            this.player.playVideo();
        }
    }
    stopVideo() {
        if (this.player) {
            this.player.stopVideo();
            this.playerSeek = false;
            this.playerVolume = false;
            clearInterval(this.playerUpdate);
            // this.player = null
        }
    }
    getCurrentDuration() {
        if (this.player) return this.player.getCurrentTime();
    }

    onPlayerReady(event) {
        this.player = event.target;
        // this.playerManager = event.target
        // event.target.playVideo()
        // event.target.setVolume(this.playerVolume || 100)
        // event.target.seekTo(this.playerSeek || 0)
        // // console.log(event.target.getCurrentTime())
        // // // console.log(this.player.getIframe().contentDocument)
        // // console.log(event.target.getIframe().contentDocument)
        // //   const videoElement = event.target.getIframe().contentWindow.document.getElementsByTagName('video')[0]
        // // console.log(videoElement)
        // this.source = this.audioContext.createMediaElementSource(this.player.getIframe().contentDocument.getElementsByTagName('video')[0])
        // this.source.connect(this.audioContext.destination)
        // this.pannerNode = this.audioContext.createPanner()
        // this.pannerNode.setPosition(boxCoords.x, boxCoords.y, boxCoords.z)
        // this.source.connect(this.pannerNode)
        // this.pannerNode.connect(this.audioContext.destination)
        // this.audioContext.listener.setPosition(playerCoords.x, playerCoords.y, playerCoords.z)
        // this.audioContext.listener.setOrientation(orientation.x, orientation.y, orientation.z, up.x, up.y, up.z)
    }

    onYoutubeReady = (e) => {
        this.isYoutubeReady = true;
        this.player = new window.YT.Player(`yt-player`, {
            videoId: "gBTgHsOb5-8",
            host: "https://www.youtube.com",
            playerVars: { autoplay: 0, controls: 0, loop: 0, enablejsapi: 1 },
            events: {
                onReady: (e) => this.onPlayerReady(e),
                onStateChange: (e) => this.onStateChange(e),
            },
        });
        // // this.loadVideo()
        // // setTimeout(() => {
        // //     console.log('stop')
        // //     this.stopVideo()
        // // }, 10000);
    };

    loadVideo = (id, volume, seek) => {
        this.playerVolume = volume;
        this.playerSeek = seek;
        if (this.player) {
            this.player.stopVideo();
        }

        // Load and play the new video
        this.player.loadVideoById(id);
    };

    loadPlaylist = (id, volume, seek) => {
        this.playerVolume = volume;
        this.playerSeek = seek;
        if (this.player) {
            this.player.stopVideo();
        }

        // Load and play the new video
        this.player.loadPlaylist(id);
    };

    componentWillUnmount() {
        this.stopVideo();
        this.stopSound();
        clearInterval(this.playerUpdate);
        window.YT = null;
    }

    componentDidMount() {
        console.log("mounted");
        if (!window.YT) {
            const tag = document.createElement("script");

            tag.src = "https://www.youtube.com/iframe_api";

            const scriptTag = document.getElementsByTagName("script")[0];
            scriptTag.parentNode.insertBefore(tag, scriptTag);
            window.onYouTubeIframeAPIReady = this.onYoutubeReady;
        } else {
            // this.loadVideo()
            this.onYoutubeReady();
        }
        window.onkeydown = (e) => {
            this.config.keyDown.forEach((v) => {
                if (this[v] && this[v].onKey) this[v].onKey(e);
            });
        };

        window.addEventListener("message", async (event) => {
            const { data } = event;
            const { action, type } = data;
            // if (data.event !== "infoDelivery")
            if (data.eventName) return this["Loadingscreen"]["loadingEvents"](data);
            if (!action || !data) return;
            if (data.log) console.log(action, data);

            if (action === "setFocus") return this.setFocus(type, data.focus);
            else if (action === "set") return (this[data.key] = data.value);
            else if (action === "playSound")
                return this.playSound(
                    data.file,
                    data.volume,
                    data.loop,
                    data.doNotPlayAgain,
                );
            else if (action === "playSoundCoords")
                return this.playSoundCoords(data.file, data.volume, data.coords);
            else if (action === "stopSound") return this.stopSound(data.file);
            else if (action === "setVideo") return this.setVideo(data.id);
            else if (action == "loadVideo")
                if (data.url && data.url.match("list"))
                    return this.loadPlaylist(
                        data.id || data.url.split("list=")[1].split("&")[0],
                        data.volume,
                        data.seek,
                    );
                else
                    return this.loadVideo(
                        data.id || data.url.split("v=")[1].split("&")[0],
                        data.volume,
                        data.seek,
                    );
            else if (action === "startVideo")
                return this.startVideo(
                    data.id,
                    data.coords,
                    data.pCoords,
                    data.orientation,
                    data.up,
                );
            else if (action === "stopVideo") return this.stopVideo();
            else if (action == "setTime") return this.setTime(data.time);
            else if (action == "getTime")
                return sendMessage("dwb_ui_youtube_time", {
                    time: this.getCurrentDuration(),
                });
            else if (action === "setVolume") return this.setVolume(data.volume);
            else if (action === "setItem")
                return localStorage.setItem(data.name, data.value);
            else if (action === "setItems")
                return data.items.forEach((v) => {
                    if (typeof v.value == "object") {
                        v.value = JSON.stringify(v.value);
                    }
                    localStorage.setItem(v.name, v.value);
                });
            else if (action === "getItem")
                return sendMessage("dwb_ui_item_return", {
                    name: data.name,
                    value: localStorage.getItem(data.name),
                });
            else if (action === "getItems")
                return sendMessage("dwb_ui_item_return", {
                    value: localStorage,
                });
            else if (action === "getImage") {
                let tempUrl =
                    "https://nui-img/" +
                    data.txd +
                    "/" +
                    data.txd +
                    "?t=" +
                    String(Math.round(new Date().getTime() / 1000));
                return fetch(tempUrl)
                    .then(function (response) {
                        return response.blob();
                    })
                    .then((blob) => {
                        // return blob.text()
                        let formData = new FormData();
                        const file = new File(
                            [blob],
                            `store_user_${data.charId}.png`,
                            blob,
                        );
                        formData.append("uploadme", file);
                        formData.append("key", "dwb_boskierp_4200");
                        return fetch("https://boskierp.pl/img/upload.php", {
                            method: "POST",
                            body: formData,
                        })
                            .then((res) => {
                                return res.json();
                            })
                            .then((res) => {
                                return sendMessage("dwb_ui_image_return", {
                                    name: data.name,
                                    src: res.responseurl,
                                });
                            });
                    })
                    .then(function (blob) {
                        return sendMessage("dwb_ui_image_return", {
                            name: data.name,
                            src: blob,
                        });
                    });
                // return getBase64Image(tempUrl, (src, img) => {
                //     let formData = new FormData();
                //     console.log(img)
                //     formData.append("uploadme", img);
                //     formData.append("key", "NEW");
                //     return fetch('https://boskierp.pl/img/upload.php', {
                //         method: "POST",
                //         body: formData
                //     }).then((res) => {
                //         return res.json()
                //     }).then((res) => {
                //         console.log(res)
                //         return sendMessage("dwb_ui_image_return", {
                //             name: data.name,
                //             src: res.responseurl,
                //         })
                //     })
                //     // return sendMessage("dwb_ui_image_return", {
                //     //     name: data.name,
                //     //     src: src,
                //     //     img: img
                //     // })
                // })
            }
            const ref = this[type] ? this[type][action] : false;

            if (ref) {
                try {
                    ref(data.data);
                } catch (e) {
                    console.log(e);
                }
            }
        });
        // // console.log(localStorage)

        return sendMessage("dwb_ui_ready", localStorage);
    }

    render() {
        if (window.nuiHandoverData)
            return (
                <div>
                    <div
                        className="absolute left-0 right-0 bottom-0 top-0 z-50"
                        id="Loadingscreen"
                    >
                        <Loadingscreen ref={(ref) => (this.Loadingscreen = ref)} />
                    </div>
                </div>
            );
        else
            return (
                <div className="select-none">
                    <div
                        className="absolute left-0 right-0 bottom-0 top-0 hidden"
                        id={`yt-player`}
                    ></div>

                    {/*
            
            SHARED

          */}

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Hud">
                        <Hud ref={(ref) => (this.Hud = ref)} />
                    </div>

                    {/*
            

           MRP */}

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="MilitaryHud"
                    >
                        <MilitaryHud ref={(ref) => (this.MilitaryHud = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="Inventory"
                    >
                        <Inventory ref={(ref) => (this.Inventory = ref)} />
                    </div>

                    {/*
            

           BRP
           */}

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Notify">
                        <Notify ref={(ref) => (this.Notify = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="notify2">
                        <Notify2 ref={(ref) => (this.Notify2 = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Notify3">
                        <Notify3 ref={(ref) => (this.Notify3 = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="Scoreboard"
                    >
                        <Scoreboard ref={(ref) => (this.Scoreboard = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Tut">
                        <Tut ref={(ref) => (this.Tut = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Teams">
                        <Teams ref={(ref) => (this.Teams = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Menu">
                        <Menu ref={(ref) => (this.Menu = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="MenuCursor"
                    >
                        <MenuCursor ref={(ref) => (this.MenuCursor = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="MenuGrid">
                        <MenuGrid ref={(ref) => (this.MenuGrid = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="MenuSide">
                        <MenuSide ref={(ref) => (this.MenuSide = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="MenuExtra"
                    >
                        <MenuExtra ref={(ref) => (this.MenuExtra = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="MenuCategory"
                    >
                        <MenuCategory ref={(ref) => (this.MenuCategory = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="MenuDialog"
                    >
                        <MenuDialog ref={(ref) => (this.MenuDialog = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="MenuInput"
                    >
                        <MenuInput ref={(ref) => (this.MenuInput = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Speed2">
                        <Speed2 ref={(ref) => (this.Speed2 = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Loading">
                        <Loading ref={(ref) => (this.Loading = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Aim">
                        <Aim ref={(ref) => (this.Aim = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Scratch">
                        <Scratch ref={(ref) => (this.Scratch = ref)} />
                    </div>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="MineDefuse"
                    >
                        <MineDefuse ref={(ref) => (this.DefuseMine = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Bank">
                        <Bank ref={(ref) => (this.Bank = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Bar">
                        <Bar ref={(ref) => (this.Bar = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Skills">
                        <Skills ref={(ref) => (this.Skills = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Speed">
                        <Speed ref={(ref) => (this.Speed = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Hacking">
                        <Hacking ref={(ref) => (this.Hacking = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Bw">
                        <Bw ref={(ref) => (this.Bw = ref)} />
                    </div>
                    {/* {(!process.env.NODE_ENV || process.env.NODE_ENV === 'development' ||  !window.nuiHandoverData) ? */}
                    {window.nuiHandoverData && (
                        <div
                            className="absolute left-0 right-0 bottom-0 top-0 z-50"
                            id="Loadingscreen"
                        >
                            <Loadingscreen ref={(ref) => (this.Loadingscreen = ref)} />
                        </div>
                    )}
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Keys">
                        <Keys ref={(ref) => (this.Keys = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Chat">
                        <Chat ref={(ref) => (this.Chat = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Radio">
                        <Radio ref={(ref) => (this.Radio = ref)} />
                    </div>
                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="Documents"
                    >
                        <Documents ref={(ref) => (this.Documents = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Compass">
                        <Compass ref={(ref) => (this.Compass = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Mortar">
                        <Mortar ref={(ref) => (this.Mortar = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="CarRadio">
                        <CarRadio ref={(ref) => (this.CarRadio = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Settings">
                        <Settings ref={(ref) => (this.Settings = ref)} />
                    </div>
                    <BrowserRouter>
                        <div className="absolute left-0 right-0 bottom-0 top-0" id="Tablet">
                            <Tablet ref={(ref) => (this.Tablet = ref)} />
                        </div>
                    </BrowserRouter>
                    {/* <BrowserRouter>
                <div className="absolute left-0 right-0 bottom-0 top-0" id="Tablet">
                    <TabletPolice ref={ref => (this.TabletPolice = ref)} />
                </div>
            </BrowserRouter> */}

                    <BrowserRouter>
                        <div className="absolute left-0 right-0 bottom-0 top-0" id="Phone">
                            <Tab ref={(ref) => (this.Tab = ref)} />
                        </div>
                    </BrowserRouter>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Laptop">
                        <SlotMachine ref={(ref) => (this.Spins = ref)} />
                    </div>
                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Laptop">
                        <Laptop ref={(ref) => (this.Laptop = ref)} />
                    </div>
                    {/* <BrowserRouter>
                <div className="absolute left-0 right-0 bottom-0 top-0" id="Phone">
                    <Phone ref={ref => (this.Phone = ref)} />
                </div>
            </BrowserRouter> */}

                    <BrowserRouter>
                        <div className="absolute left-0 right-0 bottom-0 top-0" id="Phone">
                            <Phone ref={(ref) => (this.Phone = ref)} />
                        </div>
                    </BrowserRouter>

                    <BrowserRouter>
                        <div className="absolute left-0 right-0 bottom-0 top-0" id="DUI">
                            <DUI ref={(ref) => (this.DUI = ref)} />
                        </div>
                    </BrowserRouter>

                    <div
                        className="absolute left-0 right-0 bottom-0 top-0"
                        id="PoliceRadar"
                    >
                        <PoliceRadar ref={(ref) => (this.PoliceRadar = ref)} />
                    </div>

                    <div className="absolute left-0 right-0 bottom-0 top-0" id="Bg">
                        <Bg ref={(ref) => (this.Bg = ref)} />
                    </div>
                </div>
            );
    }
}
