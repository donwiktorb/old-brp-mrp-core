import React from "react"

export default class Keys extends React.Component {
    constructor(props) {
        super(props)

        this.state = {
            show: false,
            currentKey: "e"
        }
        this.id = null
        this.onKey = this.onKey.bind(this)
        this.pos = null
    }

    move(e) {
        var elems = document.querySelectorAll('#key')
        elems.forEach((elem) => {
            var pos = 0;
            clearInterval(this.id);
            this.id = setInterval(frame, 10);
            function frame() {
                if (pos == 500) {
                    clearInterval(this.id);
                } else {
                    pos++; 
                    elem.style.left = pos + 'px'; 
                }
            }
        })
    }

    // // componentDidMount() {
    // //     this.move({})
    // // }

    onKey =(e)=> {
        // // if (e.key === this.state.currentKey) {
        // //     let targetEleme = document.getElementById('currentButton')
        // //     let offsetLeft = targetEleme.offsetLeft
        // //     if (this.pos == offsetLeft-5) {
        // //         clearInterval(this.id);
        // //         return
        // //     }
        // // }
    }

    render() {
        if (!this.state.show) return <div></div>
        return <div className='w-full h-full absolute'>
            <div className="w-full h-full flex justify-center items-end p-0.5">
                <div className="w-1/3 h-20 flex relative">
                    <div id="currentButton" className= "absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 border-4 border-black w-10 h-10 rounded-full">

                    </div> 
                    <div className="w-full h-full flex items-center font-bold text-xl">
                        <div id="key" className="w-9 h-9 rounded-full text-black absolute">
                            {this.state.currentKey}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }
}