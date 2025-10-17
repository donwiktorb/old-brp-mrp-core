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
        this.scrollSide = this.scrollSide.bind(this)
        this.scroll = this.scroll.bind(this)
        this.clear = this.clear.bind(this)
        this.getSelected = this.getSelected.bind(this)
        this.getCurrent = this.getCurrent.bind(this)
        // this.changeElements = props.changeElements.bind(this)
        this.changeElements = props.changeElements
        this.menuChanged = props.menuChanged
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

    componentDidMount() {
        this.updateSelected()
    }

    componentDidUpdate() {
        this.updateSelected()
        let element = document.getElementById('item-selected')
        if (element) element.scrollIntoView({behavior: "instant", block:"center", inline:"center"})
    }

    set(elements) {
        let found = elements.find((({selected}) => selected === true))
        if (!found) elements[0].selected = true
        this.setState({Elements:elements})
    }

    clear() {
        this.setState({Elements:[]})
    }

    scrollSide(right, cb) {
        if (right) {
            this.setState(state => {
                const Elements = state.Elements
                const elem = Elements.find((({selected}) => selected === true))
                if (elem) {
                    if (elem.type === 'slider') {
                        if (!elem.options) {
                            elem.value += 1
                            if (elem.value > elem.max) {
                                elem.value = elem.min
                            } else if (elem.value <= elem.min) {
                                elem.value = elem.max
                            }
                        } else {
                            elem.value += 1
                            if (elem.value >= elem.options.length) {
                                elem.value = elem.min
                            } else if (elem.value <= 0) {
                                elem.value = elem.options.length-1
                            }
                        }
                    
                    }
                }


                return {
                    Elements
                }
            }, () => this.menuChanged(this.getSelected()))
            
        } else {
            this.setState(state => {
                const Elements = state.Elements
                const elem = Elements.find((({selected}) => selected === true))
                if (elem) {
                    if (elem.type === 'slider') {
                        if (!elem.options) {
                            elem.value -= 1
                            if (elem.value >= elem.max) {
                                elem.value = elem.min
                            } else if (elem.value < elem.min) {
                                elem.value = elem.max
                            }
                        } else {
                            elem.value -= 1
                            if (elem.value >= elem.options.length) {
                                elem.value = elem.min
                            } else if (elem.value <= 0) {
                                elem.value = elem.options.length-1
                            }
                        }
                    
                    }
                }


                return {
                    Elements
                }
            }, () => this.menuChanged(this.getSelected()))
        }
    }

    scroll(up, cb) {
        if (up) {
            this.setState(state => {
                const Elements = state.Elements

                for (let key in Elements) {
                    let element = Elements[key]
                    if (element.selected) {
                        let newKey = Number(key)-1
                        if (newKey < Elements.length) {
                            if (newKey >= 0) {

                                delete Elements[key].selected
                                Elements[newKey].selected = true
                                break
                            } else {
                                delete Elements[key].selected
                                Elements[Elements.length-1].selected = true
                                break
                            }
                        } else {
                            delete Elements[key].selected
                            Elements[0].selected = true
                            break
                        }
                    } 
                }

                return {
                    Elements
                }

            }, () => this.menuChanged(this.getSelected()))
        } else {
            this.setState(state => {
                const Elements = state.Elements

                for (let key in Elements) {
                    let element = Elements[key]
                    if (element.selected) {
                        let newKey = Number(key)+1
                        if (newKey < Elements.length) {
                            if (newKey >= 0) {

                                delete Elements[key].selected
                                Elements[newKey].selected = true
                                break
                            } else {
                                delete Elements[key].selected
                                Elements[Elements.length-1].selected = true
                                break
                            }
                        } else {
                            delete Elements[key].selected
                            Elements[0].selected = true
                            break
                        }
                    } 
                }

                return {
                    Elements
                }
            }, () => this.menuChanged(this.getSelected()))
        }
        this.changeElements(this.state.Elements)
    }

    getLabel(element) {
        let {label, options, value, max} = element
        if (element.type === 'slider') {
            if (element.options) {
                let slider =' ❮ ' + options[value] +' ❯ ';
                return label + slider;
            } else {
                let slider =' ❮ ' + value + '/' + max +' ❯ ';
                return label + slider;
            }
        } else {
            return label
        }
    }

    render() {
        return (
            this.state.Elements.map((v, i, a) => {
                return <tr id={!v.selected ? 'item-'+i : 'item-selected'} className={v.selected && 'bg-green-900'} dangerouslySetInnerHTML = {{__html: this.getLabel(v)}} key={i}/>
            })
        )
    }
}