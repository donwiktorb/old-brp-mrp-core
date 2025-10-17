import React from "react";

export default class Stats extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
           Stats: [
            //   {
            //       name: "svuptime",
            //       label: "Stan serwera",
            //       value: "00h 00m"
            //   },
            //   {
            //       name:"playtime",
            //       label: "Czas gry",
            //       value: "00h 00m"
            //   },
            //   {
            //       name:"players",
            //       label:"Graczy",
            //       value: 0
            //   }
           ]
        };
        this.add = this.add.bind(this);
        this.set = this.set.bind(this)

        this.update = this.update.bind(this);

    }   

    set(data) {
        this.setState({Stats:data.stats})
    }    

    add(data) {
        this.setState(state => {
            const Stats = [...state.Stats, {name:data.name, value:data.value, label:data.label}]

            return {
                Stats
            }
        })
    }
    
    update(data) {
        this.setState(state => {
            const Stats = state.Stats

            Stats.forEach((v, i) => {
                if (v.name === data.name)
                    Stats[i].value = data.value
            })

            return {
                Stats
            }
        })
    }

    render() {
        return (
            <div 
                style={{gridTemplateColumns:`repeat(${this.state.Stats.length}, minmax(0,1fr))`}} 
                className={`grid gap-4 bottom-0 sticky bg-green-900 text-green-200 rounded-b`}>
                {this.state.Stats.map((v, i, a) => {
                    return <p key={i}>
                        <p>{v.label}</p>
                        <p>{v.value}</p>
                    </p>
                })}
            </div>
        );
    }
}