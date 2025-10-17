import React from 'react'

export default class FastClick extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            currentKey: "Enter",
            currentTime: 20,
            correct: 20
        }

        this.keys = [
            'Enter',
            'j',
            'e',
            'g'
        ]

        this.timer = null
    }

    randomKey() {
        let newKey = this.keys[Math.floor(Math.random() * this.keys.length)] 
        while (newKey === this.state.currentKey)
            newKey = this.keys[Math.floor(Math.random() * this.keys.length)] 
        this.setState({
            currentKey: newKey,
            correct: this.state.correct-1
        })
    }

    manageTime(val) {
        let current = this.state.currentTime-val
        if (current <= 0) {
            clearTimeout(this.timer)
            this.setState({
                currentTime: 0
            })
            return
        }
        this.setState({
            currentTime: current
        })
    }

    loop() {
        this.timer = setTimeout(() => this.loop(), 1000)
        this.manageTime(1)
    }

    clicked(e) {
        if (e.key === this.state.currentKey) {
            if (this.state.currentTime > 0) {
                this.randomKey()
            }
        } else {
            this.manageTime(4)
        }
    }

    componentDidMount() {
        document.onkeydown = (e) => this.clicked(e)

        this.loop()
    }

    render() {
        return <div className="w-full h-full flex justify-center items-center flex-col gap-4">
            <div className="flex gap-4">
                <div className="text-black border-2 border-black rounded-lg py-1 px-2 text-lg ">
                    <div className="capitalize">
                        {this.state.currentTime}
                    </div>
                </div>
                <div className="text-black border-2 border-black rounded-lg py-1 px-2 text-lg ">
                    <div className="capitalize">
                        {this.state.correct}
                    </div>
                </div>
            </div>
            <div className="text-black border-2 border-black rounded-lg py-1 px-2 text-lg shadow-lg shadow-black">
                <div className="animate-rainbowtxt capitalize">
                    {this.state.currentKey}
                </div>
            </div>
        </div>
    }
}