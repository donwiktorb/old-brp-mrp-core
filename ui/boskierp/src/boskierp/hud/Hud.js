import React from 'react'
export default class Hud extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            heading: 90.0,
            compass : true,
            time:  true,
            clock: "02:02",
            hp: 50,
            armor: 50,
            water : 50,
            food: 50,
            stamina: 50,
            voice: 30,
            color: "green",
            opacity: 90,
            bgColor: "black",
            class: 0
        }
        this.classes = [
            'w-full h-full flex justify-center gap-5 items-end p-0.5', // srodek dol
            'w-full h-full flex justify-center gap-5 items-start p-0.5', // srodek gora
            'w-full h-full flex justify-start gap-5 items-start p-0.5', // lewa gora
            'w-full h-full flex justify-end gap-5 items-start p-0.5', // prawa gora
            'w-full h-full flex justify-end gap-5 items-end p-0.5', // prawa dol
            'w-full h-full flex justify-start gap-5 items-end p-0.5', // lewa dol
        ]

        this.open = this.open.bind(this)
        this.update = this.open.bind(this)
        this.close = this.close.bind(this)
    }
    
    open(data) {
        data.show = true
        this.setState(data)
    }

    update(data) {
        this.setState(data)
    }

    close() {
        this.setState({show: false})
    }

    getCompassDirection(heading) {
        const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
        const index = Math.round(heading / 45) % 8;
        return directions[index];
    }

    getCardinalDirection(heading) {
        const directions = ['N', 'E', 'S', 'W'];
        const index = Math.round(heading / 90) % 4;
        return directions[index];
    }

    render() {
        if (!this.state.show) return <div></div>
        return <div className="w-full h-full absolute overflow-hidden" style={{ opacity: this.state.opacity+"%" }}>
            <div className={this.classes[this.state.class || 0]}>
                {this.state.compass && <div className="flex gap-4 p-0.5 rounded-lg text-white font-bold" style={{backgroundColor: this.state.bgColor}}>
                    <div className="flex gap-4 h-9 w-auto">
                        <div className="w-full h-full rounded-full flex items-center p-0.5 relative justify-center gap-3">
                            <svg version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" className="w-full h-full" viewBox="0 0 64 64" enable-background="new 0 0 64 64" >
                                <g>
                                    <circle fill="white" cx="32" cy="32" r="4" />
                                    <path fill={this.state.color} d="M32,0C14.328,0,0,14.328,0,32s14.328,32,32,32s32-14.328,32-32S49.672,0,32,0z M40,40l-22,6l6-22l22-6   L40,40z" />
                                </g>
                            </svg>
                            <div className="text-xl w-full h-full">
                                {this.getCardinalDirection(this.state.heading)}
                            </div>
                        </div>
                    </div>
                </div>}
                <div className="flex gap-4 p-0.5 rounded-lg" style={{backgroundColor: this.state.bgColor}}>
                    <div className="flex gap-4">
                        <div
                            className="w-9 h-9 rounded-full flex justify-center items-center p-0.5 relative">
                            <svg width="800px" height="800px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <defs>
                                        <linearGradient id="grad55" x1="0" x2="0" y1="100%" y2="0">
                                            <stop offset={`0%`} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={this.state.hp+"%"} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={`0%`} stop-color="gray" stop-opacity="1.0" />
                                            <stop offset={`90%`} stop-color="gray" stop-opacity="1.0" />
                                        </linearGradient>
                                    </defs>
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M8.96173 18.4687C6.01943 16.2137 2 12.4886 2 8.96653C2 3.08262 7.50016 0.885859 12 5.43111C16.4998 0.885859 22 3.08262 22 8.9665C22 12.4887 17.9806 16.2137 15.0383 18.4687C13.7063 19.4896 13.0403 20 12 20C10.9597 20 10.2937 19.4896 8.96173 18.4687ZM16.5 6.25C16.9142 6.25 17.25 6.58579 17.25 7V8.25002H18.5C18.9142 8.25002 19.25 8.5858 19.25 9.00002C19.25 9.41423 18.9142 9.75002 18.5 9.75002H17.25V11C17.25 11.4142 16.9142 11.75 16.5 11.75C16.0858 11.75 15.75 11.4142 15.75 11V9.75002L14.5 9.75002C14.0858 9.75002 13.75 9.41423 13.75 9.00002C13.75 8.5858 14.0858 8.25002 14.5 8.25002H15.75V7C15.75 6.58579 16.0858 6.25 16.5 6.25Z" fill="url(#grad55)" />
                            </svg>
                        </div>
                    </div>
                    <div className="flex gap-4">
                        <div
                            className="w-9 h-9 rounded-full flex justify-center items-center p-0.5 relative">
                            <svg className="w-full h-full" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <defs>
                                        <linearGradient id="grad555" x1="0" x2="0" y1="100%" y2="0">
                                            <stop offset={`0%`} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={this.state.armor+"%"} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={`0%`} stop-color="gray" stop-opacity="1.0" />
                                            <stop offset={`90%`} stop-color="gray" stop-opacity="1.0" />
                                        </linearGradient>
                                    </defs>
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M12.3636 3L5 6.27273V11.1818C5 15.7227 8.14182 19.9691 12.3636 21C16.5855 19.9691 19.7273 15.7227 19.7273 11.1818V6.27273L12.3636 3ZM15.06 9L16 9.94667L10.6667 15.28L8 12.62L8.94667 11.68L10.6667 13.3933L15.06 9Z" fill="url(#grad555)" />
                            </svg>
                        </div>
                    </div>
                    <div className="flex gap-4">
                        <div
                            className="w-9 h-9 rounded-full flex justify-center items-center p-0.5 relative">
                            <svg fill="#000000" className="w-full h-full" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
                                    <defs>
                                        <linearGradient id="grad5555" x1="0" x2="0" y1="100%" y2="0">
                                            <stop offset={`0%`} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={this.state.water+"%"} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={`0%`} stop-color="gray" stop-opacity="1.0" />
                                            <stop offset={`90%`} stop-color="gray" stop-opacity="1.0" />
                                        </linearGradient>
                                    </defs>
                                <path fill="url(#grad5555)" d="M25.378 19.75c1.507 6.027-3.162 11.25-9.375 11.25s-10.9-5.149-9.375-11.25c0.937-3.75 5.625-9.375 9.375-18.75 3.75 9.374 8.438 15 9.375 18.75z" />
                            </svg>
                        </div>
                    </div>
                    <div className="flex gap-4">
                        <div
                            className="w-9 h-9 rounded-full flex justify-center items-center p-0.5 relative">
                            <svg width="800px" height="800px" viewBox="0 -3.84 122.88 122.88" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg">
                                <g>
                                    <defs>
                                        <linearGradient id="grad5" x1="0" x2="0" y1="100%" y2="0">
                                            <stop offset={`0%`} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={this.state.food+"%"} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={`0%`} stop-color="gray" stop-opacity="1.0" />
                                            <stop offset={`90%`} stop-color="gray" stop-opacity="1.0" />
                                        </linearGradient>
                                    </defs>
                                    <path d="M29.03,100.46l20.79-25.21l9.51,12.13L41,110.69C33.98,119.61,20.99,110.21,29.03,100.46L29.03,100.46z M53.31,43.05 c1.98-6.46,1.07-11.98-6.37-20.18L28.76,1c-2.58-3.03-8.66,1.42-6.12,5.09L37.18,24c2.75,3.34-2.36,7.76-5.2,4.32L16.94,9.8 c-2.8-3.21-8.59,1.03-5.66,4.7c4.24,5.1,10.8,13.43,15.04,18.53c2.94,2.99-1.53,7.42-4.43,3.69L6.96,18.32 c-2.19-2.38-5.77-0.9-6.72,1.88c-1.02,2.97,1.49,5.14,3.2,7.34L20.1,49.06c5.17,5.99,10.95,9.54,17.67,7.53 c1.03-0.31,2.29-0.94,3.64-1.77l44.76,57.78c2.41,3.11,7.06,3.44,10.08,0.93l0.69-0.57c3.4-2.83,3.95-8,1.04-11.34L50.58,47.16 C51.96,45.62,52.97,44.16,53.31,43.05L53.31,43.05z M65.98,55.65l7.37-8.94C63.87,23.21,99-8.11,116.03,6.29 C136.72,23.8,105.97,66,84.36,55.57l-8.73,11.09L65.98,55.65L65.98,55.65z" fill={"url(#grad5)"} />

                                </g>

                            </svg>
                        </div>
                    </div>
                    <div className="flex gap-4">
                        <div
                            className="w-9 h-9 rounded-full flex justify-center items-center p-0.5 relative">
                            <svg width="800px" height="800px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <defs>
                                        <linearGradient id="grad45" x1="0" x2="0" y1="100%" y2="0">
                                            <stop offset={`0%`} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={this.state.stamina+"%"} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={`0%`} stop-color="gray" stop-opacity="1.0" />
                                            <stop offset={`90%`} stop-color="gray" stop-opacity="1.0" />
                                        </linearGradient>
                                    </defs>
                                <path d="M20.98 11.802a.995.995 0 0 0-.738-.771l-6.86-1.716 2.537-5.921a.998.998 0 0 0-.317-1.192.996.996 0 0 0-1.234.024l-11 9a1 1 0 0 0 .39 1.744l6.719 1.681-3.345 5.854A1.001 1.001 0 0 0 8 22a.995.995 0 0 0 .6-.2l12-9a1 1 0 0 0 .38-.998z" fill="url(#grad45)" /></svg>
                        </div>
                    </div>

                    <div className="flex gap-4">
                        <div
                            className="w-9 h-9 rounded-full flex justify-center items-center p-0.5 relative">
                            <svg width="800px" height="800px" viewBox="-5 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">

                                <title>microphone</title>
                                <desc>Created with Sketch Beta.</desc>
                                <defs>

                                </defs>
                                <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <g id="Icon-Set-Filled" transform="translate(-107.000000, -309.000000)" fill="#000000">
                                    <defs>
                                        <linearGradient id="grad455" x1="0" x2="0" y1="100%" y2="0">
                                            <stop offset={`0%`} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={this.state.voice+"%"} stop-color={this.state.color} stop-opacity="1.0" />
                                            <stop offset={`0%`} stop-color="gray" stop-opacity="1.0" />
                                            <stop offset={`90%`} stop-color="gray" stop-opacity="1.0" />
                                        </linearGradient>
                                    </defs>
                                        <path d="M118,333 C121.866,333 125,329.866 125,326 L125,316 C125,312.134 121.866,309 118,309 C114.134,309 111,312.134 111,316 L111,326 C111,329.866 114.134,333 118,333 L118,333 Z M129,328 L127,328 C126.089,332.007 122.282,335 118,335 C113.718,335 109.911,332.007 109,328 L107,328 C107.883,332.799 112.063,336.51 117,336.955 L117,339 L116,339 C115.448,339 115,339.448 115,340 C115,340.553 115.448,341 116,341 L120,341 C120.552,341 121,340.553 121,340 C121,339.448 120.552,339 120,339 L119,339 L119,336.955 C123.937,336.51 128.117,332.799 129,328 L129,328 Z" id="microphone" fill={"url(#grad455)"}>

                                        </path>
                                    </g>
                                </g>
                            </svg>
                        </div>
                    </div>
                </div>
                {this.state.time && <div className="flex gap-4 p-0.5 rounded-lg text-white font-bold" style={{backgroundColor: this.state.bgColor}}>
                    <div className="flex gap-4 h-9 w-auto">
                        <div className="w-full h-full rounded-full flex items-center p-0.5 relative justify-center gap-2">
                            <div className="text-xl w-full h-full">
                                {this.state.clock}
                            </div>
                            <svg fill={this.state.color} className="w-full h-full p-0.5" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
                                <title>time</title>
                                <path d="M0 16q0-3.232 1.28-6.208t3.392-5.12 5.12-3.392 6.208-1.28q3.264 0 6.24 1.28t5.088 3.392 3.392 5.12 1.28 6.208q0 3.264-1.28 6.208t-3.392 5.12-5.12 3.424-6.208 1.248-6.208-1.248-5.12-3.424-3.392-5.12-1.28-6.208zM4 16q0 3.264 1.6 6.048t4.384 4.352 6.016 1.6 6.016-1.6 4.384-4.352 1.6-6.048-1.6-6.016-4.384-4.352-6.016-1.632-6.016 1.632-4.384 4.352-1.6 6.016zM14.016 16v-5.984q0-0.832 0.576-1.408t1.408-0.608 1.408 0.608 0.608 1.408v4h4q0.8 0 1.408 0.576t0.576 1.408-0.576 1.44-1.408 0.576h-6.016q-0.832 0-1.408-0.576t-0.576-1.44z" />
                            </svg>
                        </div>
                    </div>
                </div>}
            </div>
        </div>
    }
}