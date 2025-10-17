

import React from 'react'

export default class MenuCatSelect extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            element: props.element,
            tunes: props.tunes
        }
    }

    static getDerivedStateFromProps(nextProps, state) {
        if (nextProps.element !== state.element && nextProps.element) {
            return {
                element: nextProps.element
            }
        } else return null
    }

    hexToRgb(hex) {
        let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? {
            r: parseInt(result[1], 16),
            g: parseInt(result[2], 16),
            b: parseInt(result[3], 16)
        } : null;       
    }

    setColor = (e, v) => {
        let color = this.hexToRgb(e.target.value) 
        this.props.changeColor({
            name: v.value,
            value: color
        })     
    }

    setXenon = (e, type, id) => {
        this.props.changeColor({
            type: type,
            value: e.target.checked,
            id: id
        })     
    }

    setCheckbox = (e, v) => {
        this.props.changeColor({
            name: v.value,
            value: e.target.checked
        })     
    }

    onImageError = (e) => {
        e.target.src = "https://boskierp.pl/img/ss/dwb_vnpX.com(5).png"
    }
    render() {
        return <div className="w-full h-full flex justify-end relative z-20 p-4">
            <div className="w-1/5 h-full bg-gradient-to-t bg-[#181a1b] rounded-lg  flex flex-col items-center justify-start text-gray-200 bg-opacity-50">
                <div className="w-full h-1/6 rounded-t-lg flex justify-center">
                    <img onError={this.onImageError} src={this.state.element.img || `https://docs.fivem.net/vehicles/${this.state.element.value}.webp`} alt="NO" className="transition ease-in-out delay-100 hover:scale-110" /> 
                </div>

                <div className="w-full h-full flex flex-col p-4 overflow-auto text-lg select-none gap-4 ">
                    <div >
                        <div className="text-2xl text-center">
                            Informacje
                        </div>
                        <div className="text-center text-xl p-2 text-blue-500">
                            {this.state.element.label}
                        </div>
                        <div className="grid grid-cols-2 gap-2 place-items-center">
                        {this.state.element.elements && this.state.element.elements.map((v) => {
                            return <div className="flex gap-1">
                                <div>
                                    {v.label}
                                </div>
                                <div>
                                    {v.value}
                                </div>
                            </div>
                        })}
                        </div>
                    </div>

                    {this.state.tunes.length > 0 && <div className="flex flex-col gap-4 justify-center items-center">
                        <div className="text-2xl text-center">
                            Konfiguracja
                        </div>
                        <div className="grid grid-cols-2 place-items-start">
                            {this.state.tunes.map((v) => {
                                if (v.type === 'checkbox') {
                                    return <div className="p-2 peer">
                                        <div>
                                            {v.label}
                                        </div>
                                        <div className="w-5 h-5">
                                            <input defaultChecked={false} onChange={(e) => this.setCheckbox(e, v)} type="checkbox" class="appearance-none border-2 bg-white checked:bg-black w-full h-full rounded peer/draft" />
                                        </div>
                                    </div>
                                } else if (v.type === 'color') {
                                    return <div className="p-2 peer">
                                        <div>
                                            {v.label}
                                        </div>
                                        <div className="w-5 h-5">
                                            <input name="color" id="color" type="color" defaultValue onChange={(e) => this.setColor(e, v) } />
                                        </div>
                                    </div>
                                }
                            })} 

                            
                        </div>
                    </div>}
                    {/* {this.state.elements.map((v, i) => {
                        return <div className="w-full h-full">
                            <div className="text-2xl py-2">{v.label}</div>
                            <div className="grid grid-cols-4 gap-4">
                                {v.elements.map((nv, ni) => {
                                    return <div className="w-fit h-fit rounded-lg p-1 relative select-none">
                                        <img src="https://cosystatic.bmwgroup.com/bmwweb/cosySec?COSY-EU-100-2545xM4RIyFnbm9Mb3AgyyIJrjG0suyJRBODlsrjGpua8rQbhSIqppglBgERGal384MlficYiGHqoQxYLW7%25f3tiJ0PCJirQbLDWcQW7%251uSFoqoQh47wMvcYi9M%25CoMb3islBglUbuZcRSrQdr9SbbW8zcRacH8g7MbnW85WubxKqogMbUMdoPEyJGqo9qaFbel3iyJHy5BRbrQ%25l3ulUj80cRSrQdr9YEUW8zcRacH715MbnW85WunUUqogMbUMdgmYyJGqo9qaG4zl3iyJHy5i3RrQ%25l3ulU%25awcRSrQdr9SmnW8zcRacHzRuMbnW85Wun87qogMbUMdgPoyJGqo9qaDJKl3iyJHy5m3ArQ%25l3ulUCGpcRSrQdr98KGW8zcRacHbziMbnW85Wuo9bqogMbUMdJbtyJGqo9qa3s7l3iyJHy5Q4urQbBUq2rjGLqryJR5GlJirjGNY3QcNQBUJ1" alt="NO" className="transition ease-in-out delay-100 hover:scale-150" /> 
                                        <div className="text-xl font-bold">
                                            {nv.label}
                                        </div>
                                        <div className="text-xs p-0.5 rounded-lg bg-gray-500 text-white font-bold absolute top-0 right-0">
                                            NOWOŚĆ
                                        </div>
 
                                        <div className="text-lg flex gap-1">
                                            <div>od</div>
                                            <div className="text-green-500">2000$</div>
                                        </div>
                                    </div>
                                })}
                            </div>
                    
                        </div>
                    })} */}
                    
                </div>
                <div className="w-full h-1/6 rounded-t-lg flex justify-center items-center p-4 flex-col gap-2">
                    <div className="flex gap-1 text-xl">
                        <div>
                            Aktualna Cena
                        </div>
                        <div className="text-green-500">
                        {new Intl.NumberFormat().format(this.state.element.price)}$</div>
                    </div>
                    <button className="text-2xl rounded-lg bg-black p-1 w-full text-white" onClick={() => this.props.setPage(1)}>Wróć</button>
                    <button className="text-2xl rounded-lg bg-black p-2 w-full text-white" onClick={() => this.props.submit(this.state.element, 'buy')}>Zakup</button>
                </div>
            </div>
        </div>
    }
}