

import React from 'react'

export default class LeafZip extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            leafes: Array(10).fill()
        }

        this.current = null

        this.images = {
            weed: "https://boskierp.pl/img/ss/dwb_agbT.png",
            coke: "https://boskierp.pl/img/ss/dwb_jHJo.png"
        }

    }

    select(e) {
        e.preventDefault()
        if (!e.target.id) return
        if (!this.current) {
            this.current = e.target
            this.current.style.opacity = "0.5"
        } else {
            this.current.style.opacity = "1"
            this.current = null
            this.select(e)
        }
    }

    drop(e) {
        e.preventDefault()
        if (!e.target.id) return
        if (this.current) {
            let leafes = this.state.leafes
            if (leafes.length <= 1) {
                return this.props.submit()
            }
            leafes.splice(Number(this.current.id),1)
            this.current.style.opacity = "1"
            this.setState({
                leafes:leafes 
            })
            this.current = null
        }
    }

    render() {
        return <div className="w-full h-full flex justify-center items-center relative z-20 flex-col">
            <div className="h-1/3 w-full grid justify-center items-center grid-cols-5 gap-2 place-items-center" onMouseDown={(e) => this.select(e)}>
                {this.state.leafes.map((v, i) => {
                    return <img id={i} key={`drug-${i}`} src={this.images[this.props.type]} className="w-32" alt="LOGO" />
                })}
            </div> 
            <div className="h-1/2 w-full flex justify-center items-center" onMouseUp={(e) => this.drop(e)}>
                <img id="hello" src="https://boskierp.pl/img/ss/dwb_aWiX.com(3).png" className="w-1/5" alt="LOGO" />
            </div> 
        </div>
    }
}