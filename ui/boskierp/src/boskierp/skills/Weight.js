
import React from 'react'

export default class Weight extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            weight: "0.00"
        }

    }

    set(val) {
        let newVal = Number(this.state.weight) + val
        if (newVal >= 0 && newVal <= 0.5) {
            this.setState({
                weight: String(Number(this.state.weight) + val)
            })
        }
    }

    render() {
        return <div className="w-full h-full flex justify-center items-center relative z-20">
            <div className="bg-black w-1/2 h-1/2 rounded-lg flex justify-center items-center px-4" style={{ fontFamily: "digital2" }}>
                <div className="w-1/2 h-1/2 bg-orange-500 bg-opacity-50 flex justify-center items-center text-5xl rounded-lg text-white">
                    <div>{this.state.weight}</div>
                    <div>kg</div>
                </div>

                <div className="w-1/2 h-1/2 text-white flex flex-col justify-between items-center text-lg gap-4">
                    <button className="text-white w-1/2 h-1/2" onClick={(e) => this.set(0.25)}>
                        <svg className="text-white w-full h-full" viewBox="0 0 24 24" fillRule="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path opacity="0.1" d="M3 12C3 4.5885 4.5885 3 12 3C19.4115 3 21 4.5885 21 12C21 19.4115 19.4115 21 12 21C4.5885 21 3 19.4115 3 12Z" fill="#323232" />
                            <path d="M3 12C3 4.5885 4.5885 3 12 3C19.4115 3 21 4.5885 21 12C21 19.4115 19.4115 21 12 21C4.5885 21 3 19.4115 3 12Z" stroke="currentColor" stroke-width="2" />
                            <path d="M12 8L12 16" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M15 11L12.087 8.08704V8.08704C12.039 8.03897 11.961 8.03897 11.913 8.08704V8.08704L9 11" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>
                    <button className="text-white w-1/2 h-1/2" onClick={(e) => this.set(-0.25)}>
                        <svg className="text-white w-full h-full" viewBox="0 0 24 24" fillRule="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path opacity="0.1" d="M3 12C3 4.5885 4.5885 3 12 3C19.4115 3 21 4.5885 21 12C21 19.4115 19.4115 21 12 21C4.5885 21 3 19.4115 3 12Z" fill="currentColor" />
                            <path d="M3 12C3 4.5885 4.5885 3 12 3C19.4115 3 21 4.5885 21 12C21 19.4115 19.4115 21 12 21C4.5885 21 3 19.4115 3 12Z" stroke="currentColor" stroke-width="2" />
                            <path d="M12 16L12 8" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M9 13L11.913 15.913V15.913C11.961 15.961 12.039 15.961 12.087 15.913V15.913L15 13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    }
}