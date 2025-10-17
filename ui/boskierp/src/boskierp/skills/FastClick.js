
import React from 'react'

export default class FastClick extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            currentKey: 'Enter',
            time: 0
        }

        this.keys = [
            'Enter',
            'j',
            'e',
            'g'
        ]
    }

    open() {
        this.setState({
            show: true
        })
    }

    close() {
        this.setState({
            show: false
        })
    }

    randomKey() {
        let newKey = this.keys[Math.floor(Math.random() * this.keys.length)] 
        while (newKey === this.state.currentKey)
            newKey = this.keys[Math.floor(Math.random() * this.keys.length)] 
        clearTimeout(this.timer)
        this.setState({currentKey: newKey}, () => {
            this.timer = setTimeout(() => {
                this.randomKey()
                this.props.submit({
                    value: 'none',
                    type: "not-hit"
                })
            }, 550)
        })
    }


    clicked(e) {
        if (e.key === this.state.currentKey) {
            this.randomKey()
            this.props.submit({
                value: e.key,
                type: "hit"
            })
        }  else {
            this.props.submit({
                value: e.key,
                type: "not-hit"
            })
        }
    }
        
    componentDidMount() {
        document.onkeydown = (e) => this.clicked(e)
    }

    render() {
        return <div className="w-full h-full flex justify-center items-center flex-col gap-4">
            <div className="text-white border-2 border-black rounded-lg py-1 px-2 text-lg shadow-lg shadow-black">
                500 MSEC
            </div>
            <div className="text-white border-2 border-black rounded-lg py-1 px-2 text-lg shadow-lg shadow-black">
                <div className=" capitalize bg-black bg-opacity-40">
                    {this.state.currentKey}
                </div>
            </div>
        </div>
    }
}