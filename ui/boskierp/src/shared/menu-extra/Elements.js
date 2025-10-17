/*
    Elements: [
        {
            label: 'Slider Options',
            type: 'slider',
            min: 0,
            max: 2,
            options: ['hi', 'hi2'],
            value: 0
        },
        {
            label: 'Slider value',
            type: 'slider',
            min: 0,
            max: 2,
            value: 0
        },
        {
            label: 'Test',
            key: 'value'
        }
    ]
*/

import React from 'react'

export default class Elements extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            Elements: props.elements || [
                // {
                //     selected: true,
                //     label: 'Slider Options',
                //     type: 'slider',
                //     min: 0,
                //     max: 2,
                //     options: ['hi', 'hi2'],
                //     value: 0
                // },
                // {
                //     label: 'Slider value',
                //     type: 'slider',
                //     min: 0,
                //     max: 2,
                //     value: 0
                // },
                // {
                //     label: 'Test',
                //     key: 'value'
                // }
            ]
        }
        this.set = this.set.bind(this)
        this.clear = this.clear.bind(this)
        this.getSelected = this.getSelected.bind(this)
        this.getCurrent = this.getCurrent.bind(this)
        // this.changeElements = props.changeElements.bind(this)
        this.changeElements = props.changeElements
        this.submit = props.submit
        this.menuChanged = props.menuChanged
        this.onSubmit = props.onSubmit
    }

    static getDerivedStateFromProps(nextProps, state) {
        if (nextProps.elements !== state.Elements && nextProps.elements) {
            return {
                Elements: nextProps.elements ? nextProps.elements : []
            }
        } else return null
    }

    // componentWillReceiveProps(nextProps) {
    //     if (nextProps.elements !== this.state.Elements && nextProps.elements) {
    //         this.setState({ Elements: nextProps.elements});
    //     }
    // }

    getCurrent() {
        return this.state.Elements
    }

    getSelected() {
        return this.state.Elements.find(( ({selected}) => selected === true))
    }

    updateSelected() {
        let found = this.state.Elements.find((({selected}) => selected === true))
        if (!found && this.state.Elements[0])
            this.setState(state => {
                const Elements = state.Elements

                Elements[0].selected = true

                return {
                    Elements
                }
            }) 
    }

    // componentDidMount() {
    //     this.updateSelected()
    // }

    // componentDidUpdate() {
    //     this.updateSelected()
    //     let element = document.getElementById('item-selected')
    //     if (element) element.scrollIntoView({behavior: "smooth", block:"center", inline:"nearest"})
    // }

    set(elements) {
        let found = elements.find((({selected}) => selected === true))
        if (!found) elements[0].selected = true
        this.setState({Elements:elements})
    }

    clear() {
        this.setState({Elements:[]})
    }

    onChange(e, i) {
        this.setState((state) => {
            const Elements = state.Elements
            let {value} = e.target
            if (value >= Elements[i].min && value <= Elements[i].max) {
                Elements[i].value = Number(value)
            } else if (value < Elements[i].min) {
                Elements[i].value = Elements[i].min
            } else if (value > Elements[i].max) {
                Elements[i].value = Elements[i].max
            }

            this.menuChanged(Elements[i])

            return {
                Elements
            }
        })    
    }

    getLabel(element, i) {
        let {label, description, options, value, max, min, step} = element
        step = step || 1
        if (element.type === 'slider') {
            if (element.options) {
                let slider =' ❮ ' + options[value] +' ❯ ';
                return label + slider;
            } else {
                // let slider =' ❮ ' + value + '/' + max +' ❯ ';
                // return label + slider;
                return <div onClick={(e) => {this.onSubmit(this.state.Elements[i])}}>
                    <div dangerouslySetInnerHTML={{__html: label}}>
                    </div>
                    <div className="text-orange-500 text-sm text-left break-words" dangerouslySetInnerHTML={{__html: description}}>
                    </div>
                    <div className="flex justify-between gap-4 appearance-none items-center">
                        <input value={value} type="range" min={min} max={max} step={step} onChange={(e) => this.onChange(e, i)} className=" h-2 w-3/4 bg-green-400 outline-none slider-thumb rounded-lg appearance-none cursor-pointer"></input>  
                        <input
                            inputMode="numeric"
                            step={step}
                            min={min} value={value} onChange={(e) => this.onChange(e, i)}  type="number" id="default-input" className="  w-1/4 text-white text-sm rounded-lg block p-2.5 bg-green-400 text-center"></input>
                    </div>
                </div>             
            }
        } else {
            return <div onClick={(e) => {this.menuChanged(this.state.Elements[i])}}>
                <div dangerouslySetInnerHTML={{__html: label}}>
                </div>
                <div className="text-orange-500 text-sm text-left break-words" dangerouslySetInnerHTML={{__html: description}}>
                </div>
            </div>
        }
    }

    render() {
        return (
            this.state.Elements.map((v, i, a) => {
                // return <tr id={!v.selected ? 'item-'+i : 'item-selected'} className={v.selected && 'bg-green-900'} dangerouslySetInnerHTML = {{__html: this.getLabel(v)}} key={i}/>
                return <div className="p-2 rounded-lg select-none hover:bg-green-800 bg-opacity-80 transition-all">
                    {this.getLabel(v,i)}
                </div>
            })
        )
    }
}