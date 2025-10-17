
import React from 'react'

export default class Text extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            show: false,
            containerClass: "w-full h-1/4 flex justify-start items-end flex-col gap-2 p-2 overflow-auto max-h-1/4",
            defaultClass: "bg-black rounded-lg p-0.5 text-white",
            content: [
                // // ...Array(32).fill({
                // //     text: "JOHN BLACK 004",
                // // })
            ],
        }

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
    }

    open(data) {
        this.setState(data)
    }

    close() {
        this.setState({show: false})
    }

    render() {
        if (!this.state.show) return <div></div>

        return <div className="w-full h-full select-none absolute">
            <div class={this.state.containerClass || "w-full h-full flex justify-start items-start flex-col gap-2 p-2"}>
                {this.state.content.map((v, i) => {
                    return <div class={v.class ? v.class : this.state.defaultClass}>
                        {v.text}
                    </div>
                })}
            </div>
        </div>
    }
}