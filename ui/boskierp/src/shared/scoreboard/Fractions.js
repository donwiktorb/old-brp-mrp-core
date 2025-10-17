import React from "react";

export default class Fractions extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
           Fractions: [
            // //   {
            // //       name: "ems",
            // //        count: 0,
            // //        icon: "👨‍⚕️",
            // //        color: "red"
            // //    },
            // //    {
            // //         count: 0,
            // //         icon: "👮🏻",
            // //         color: "cyan",
            // //         "name": "police"
            // //     },
            // //     {
            // //         count: 0,
            // //         icon: "🔧",
            // //         color: "grey",
            // //         "name": "mechanic"
            // //     }
           ]
        };
        this.add = this.add.bind(this);
        this.set = this.set.bind(this)

        this.getCount = this.getCount.bind(this);
        this.update = this.update.bind(this);
        this.updateMulti = this.updateMulti.bind(this);

    }   

    set(data) {
        this.setState({Fractions: data.Fractions})
    }

    getCount() {
        return this.state.Fractions.length
    }

    add(data) {
        this.setState(state => {
            const Fractions = [...state.Fractions, {count:data.count, icon:data.icon, name:data.name, color:data.color}]
            return {
                Fractions
            }
        })        
    }

    updateMulti(data) {
        this.setState(state => {
            const Fractions = state.Fractions            
            data.fractions.forEach((nv,ni,na) => {
                Fractions.forEach((v, i,a) => {
                    if (v.name === nv.name) {
                        Fractions[i].count = nv.count
                    }
                })
            })
            
            return {
                Fractions
            }
        })
    }
    
    update(data) {
        this.setState(state => {
            const Fractions = state.Fractions            
            Fractions.forEach((v, i,a) => {
                if (v.name === data.name) {
                    Fractions[i].count = data.count
                }
            })
            
            return {
                Fractions
            }
        })
    }

    render() {
        return (
            <div
                style={{gridTemplateColumns:`repeat(${this.state.Fractions.length}, minmax(0,1fr))`}} 
                className={`grid gap-4`}>
                {this.state.Fractions.map((v, i, a) => {
                    return <p key={i} style={{color:v.color}}>
                        {v.icon} {v.count}
                    </p>
                })}
            </div>
        );
    }
}