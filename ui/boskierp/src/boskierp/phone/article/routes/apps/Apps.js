

import React from 'react'
import sendMessage from '../../../../../Api'
import { Link } from 'react-router-dom'
export default class Apps extends React.Component {
    constructor(props) {
        super(props)
        this.state = { apps: [ ] }
    }

    onSubmit(e, value) {
        e.preventDefault()
        sendMessage('phone_app_action', {
            action: value
        })
    }

    render() {
        return (
            <div className="w-full h-full">
                <div className="w-full h-auto grid grid-cols-4 gap-3 justify-items-center overflow-auto p-2">



                    <Link title="boskie-store" id="boskie-store" to={'/store/'} className="w-fit h-fit rounded-lg text-orange-500 hover:scale-110 transition-all flex flex-col justify-center items-center">
                        <svg className="w-10 fill-none stroke-blue-500 hover:stroke-cyan-500 h-10 transition-all" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M3.5 11V14C3.5 17.7712 3.5 19.6569 4.67157 20.8284C5.84315 22 7.72876 22 11.5 22H12.5C16.2712 22 18.1569 22 19.3284 20.8284C20.5 19.6569 20.5 17.7712 20.5 14V11" stroke="inherit" stroke-width="1.5" />
                            <path d="M9.4998 2H14.4998L15.1515 8.51737C15.338 10.382 13.8737 12 11.9998 12C10.1259 12 8.6616 10.382 8.84806 8.51737L9.4998 2Z" stroke="inherit" stroke-width="1.5" />
                            <path d="M3.32975 5.35133C3.50783 4.46093 3.59687 4.01573 3.77791 3.65484C4.15938 2.89439 4.84579 2.33168 5.66628 2.10675C6.05567 2 6.50969 2 7.41771 2H9.50002L8.77549 9.24527C8.61911 10.8091 7.30318 12 5.73155 12C3.8011 12 2.35324 10.2339 2.73183 8.34093L3.32975 5.35133Z" stroke="inherit" stroke-width="1.5" />
                            <path d="M20.6703 5.35133C20.4922 4.46093 20.4031 4.01573 20.2221 3.65484C19.8406 2.89439 19.1542 2.33168 18.3337 2.10675C17.9443 2 17.4903 2 16.5823 2H14.5L15.2245 9.24527C15.3809 10.8091 16.6968 12 18.2685 12C20.1989 12 21.6468 10.2339 21.2682 8.34093L20.6703 5.35133Z" stroke="inherit" stroke-width="1.5" />
                            <path d="M9.5 21.5V18.5C9.5 17.5654 9.5 17.0981 9.70096 16.75C9.83261 16.522 10.022 16.3326 10.25 16.201C10.5981 16 11.0654 16 12 16C12.9346 16 13.4019 16 13.75 16.201C13.978 16.3326 14.1674 16.522 14.299 16.75C14.5 17.0981 14.5 17.5654 14.5 18.5V21.5" stroke="inherit" stroke-width="1.5" stroke-linecap="round" />
                        </svg>

                    </Link>
                    <Link title="boskie-store" id="boskie-store" to={'/crime/'} className="w-fit h-fit rounded-lg text-black hover:scale-110 transition-all flex flex-col justify-center items-center">
                        <svg className="w-10 h-10" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9 2C6.79086 2 5 3.79086 5 6C5 8.20914 6.79086 10 9 10C11.2091 10 13 8.20914 13 6C13 3.79086 11.2091 2 9 2Z" fill="currentColor" />
                            <path d="M4.00873 11C2.90315 11 2 11.8869 2 13C2 14.6912 2.83281 15.9663 4.13499 16.7966C5.41697 17.614 7.14526 18 9 18C9.41085 18 9.8155 17.9811 10.2105 17.9427C9.45316 17.0003 9 15.8031 9 14.5C9 13.1704 9.47182 11.9509 10.2572 11L4.00873 11Z" fill="currentColor" />
                            <path d="M10 14.5C10 16.9853 12.0147 19 14.5 19C16.9853 19 19 16.9853 19 14.5C19 12.0147 16.9853 10 14.5 10C12.0147 10 10 12.0147 10 14.5ZM12.4039 17.3032L17.3032 12.4039C17.7408 12.9882 18 13.7138 18 14.5C18 16.433 16.433 18 14.5 18C13.7138 18 12.9882 17.7408 12.4039 17.3032ZM11.6968 16.596C11.2592 16.0118 11 15.2861 11 14.5C11 12.567 12.567 11 14.5 11C15.2861 11 16.0118 11.2592 16.596 11.6968L11.6968 16.596Z" fill="currentColor" />
                        </svg>
                    </Link>
                    <Link title="twitter" id="twitter" to={'/twitter/'} className="w-fit h-fit rounded-lg text-blue-500 hover:scale-110 transition-all flex flex-col justify-center items-center">
                        <svg className="w-10 h-10" viewBox="0 -4 48 48" version="1.1" xmlns="http://www.w3.org/2000/svg">

                            <title>Twitter-color</title>
                            <desc>Created with Sketch.</desc>
                            <defs>

                            </defs>
                            <g id="Icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g id="Color-" transform="translate(-300.000000, -164.000000)" fill="currentColor">
                                    <path d="M348,168.735283 C346.236309,169.538462 344.337383,170.081618 342.345483,170.324305 C344.379644,169.076201 345.940482,167.097147 346.675823,164.739617 C344.771263,165.895269 342.666667,166.736006 340.418384,167.18671 C338.626519,165.224991 336.065504,164 333.231203,164 C327.796443,164 323.387216,168.521488 323.387216,174.097508 C323.387216,174.88913 323.471738,175.657638 323.640782,176.397255 C315.456242,175.975442 308.201444,171.959552 303.341433,165.843265 C302.493397,167.339834 302.008804,169.076201 302.008804,170.925244 C302.008804,174.426869 303.747139,177.518238 306.389857,179.329722 C304.778306,179.280607 303.256911,178.821235 301.9271,178.070061 L301.9271,178.194294 C301.9271,183.08848 305.322064,187.17082 309.8299,188.095341 C309.004402,188.33225 308.133826,188.450704 307.235077,188.450704 C306.601162,188.450704 305.981335,188.390033 305.381229,188.271578 C306.634971,192.28169 310.269414,195.2026 314.580032,195.280607 C311.210424,197.99061 306.961789,199.605634 302.349709,199.605634 C301.555203,199.605634 300.769149,199.559408 300,199.466956 C304.358514,202.327194 309.53689,204 315.095615,204 C333.211481,204 343.114633,188.615385 343.114633,175.270495 C343.114633,174.831347 343.106181,174.392199 343.089276,173.961719 C345.013559,172.537378 346.684275,170.760563 348,168.735283" id="Twitter">

                                    </path>
                                </g>
                            </g>
                        </svg>
                    </Link>
                    <button onClick={(e) => this.onSubmit(e, {value: 'camera'})} title="twitter" id="twitter" to={'/twitter/'} className="w-fit h-fit rounded-lg text-slate-500 hover:scale-110 transition-all flex flex-col justify-center items-center">
                        <svg className="w-10 h-10" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 16C13.6569 16 15 14.6569 15 13C15 11.3431 13.6569 10 12 10C10.3431 10 9 11.3431 9 13C9 14.6569 10.3431 16 12 16Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M3 16.8V9.2C3 8.0799 3 7.51984 3.21799 7.09202C3.40973 6.71569 3.71569 6.40973 4.09202 6.21799C4.51984 6 5.0799 6 6.2 6H7.25464C7.37758 6 7.43905 6 7.49576 5.9935C7.79166 5.95961 8.05705 5.79559 8.21969 5.54609C8.25086 5.49827 8.27836 5.44328 8.33333 5.33333C8.44329 5.11342 8.49827 5.00346 8.56062 4.90782C8.8859 4.40882 9.41668 4.08078 10.0085 4.01299C10.1219 4 10.2448 4 10.4907 4H13.5093C13.7552 4 13.8781 4 13.9915 4.01299C14.5833 4.08078 15.1141 4.40882 15.4394 4.90782C15.5017 5.00345 15.5567 5.11345 15.6667 5.33333C15.7216 5.44329 15.7491 5.49827 15.7803 5.54609C15.943 5.79559 16.2083 5.95961 16.5042 5.9935C16.561 6 16.6224 6 16.7454 6H17.8C18.9201 6 19.4802 6 19.908 6.21799C20.2843 6.40973 20.5903 6.71569 20.782 7.09202C21 7.51984 21 8.0799 21 9.2V16.8C21 17.9201 21 18.4802 20.782 18.908C20.5903 19.2843 20.2843 19.5903 19.908 19.782C19.4802 20 18.9201 20 17.8 20H6.2C5.0799 20 4.51984 20 4.09202 19.782C3.71569 19.5903 3.40973 19.2843 3.21799 18.908C3 18.4802 3 17.9201 3 16.8Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>
                    <Link title="galeria" id="gallery" to={'/photos/'} className="w-fit h-fit rounded-lg text-pink-500 hover:scale-110 transition-all flex flex-col justify-center items-center">
                        <svg className="w-10" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="16" cy="8" r="2" stroke="currentColor" stroke-width="1.5" />
                            <path d="M2 12.5001L3.75159 10.9675C4.66286 10.1702 6.03628 10.2159 6.89249 11.0721L11.1822 15.3618C11.8694 16.0491 12.9512 16.1428 13.7464 15.5839L14.0446 15.3744C15.1888 14.5702 16.7369 14.6634 17.7765 15.599L21 18.5001" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M22 12C22 16.714 22 19.0711 20.5355 20.5355C19.0711 22 16.714 22 12 22C7.28595 22 4.92893 22 3.46447 20.5355C2 19.0711 2 16.714 2 12C2 7.28595 2 4.92893 3.46447 3.46447C4.92893 2 7.28595 2 12 2C16.714 2 19.0711 2 20.5355 3.46447C21.5093 4.43821 21.8356 5.80655 21.9449 8" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                        </svg>
                    </Link>
                </div>
            </div>
        )
    }
}
