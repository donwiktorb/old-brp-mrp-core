

import React from 'react'

export default class LeafClear extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            leafes: Array(10).fill()
        }

        this.current = null

    }

    select(e) {
        e.preventDefault()
        if (this.current) {
            let leafs = this.state.leafes
            if (leafs.length <= 1) {
                this.props.submit()
                return
            } 
            leafs.splice(Number(e.target.id), 1)
            this.setState({
                leafes: leafs
            })
        }     
    }

    clicked(e) {
        if (this.current) return
        let {target} = e
        this.current = target
    }

    follow(e) {
        if (!this.current) return
        let x = -20
        let y= -130
        x += e.pageX
        y += e.pageY
        this.current.style.left = x+"px"
        this.current.style.top = y+"px"
    }

    render() {
        return <div className="w-full h-full flex justify-center items-center relative z-20 flex-col">
            <div className="h-1/2 w-full flex justify-center items-center" >
                <img onMouseDown={(e) => this.clicked(e)} id="hello" src="https://boskierp.pl/img/ss/dwb_fEes.com(2).png" className="w-40 animate-rotn -rotate-[135deg] absolute top-0 left-0" alt="LOGO" />
            </div> 
            <div style={{cursor: "url('https://boskierp.pl/img/ss/dwb_fEes.com(2).png'), url('https://boskierp.pl/img/ss/dwb_fEes.com(2).png');"}} className="h-1/2 w-full grid justify-center items-center grid-cols-5 gap-2 place-items-center z-10" onMouseDown={(e) => this.select(e)} onMouseMove={(e)=> this.follow(e)}>
                {this.state.leafes.map((v, i) => {
                    return <img id={i} key={`drug-${i}`} src="https://boskierp.pl/img/ss/dwb_kb9o.png" className="w-32" alt="LOGO" />
                })}
            </div> 
        </div>
    }
}
