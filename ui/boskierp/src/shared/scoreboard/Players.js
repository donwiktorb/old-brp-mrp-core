import React from "react";

export default class Players extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
           Players: []
        };

        this.add = this.add.bind(this);
        this.remove = this.remove.bind(this);
        this.updateMulti = this.updateMulti.bind(this);
        this.set = this.set.bind(this);
        this.update = this.update.bind(this);

    }   

    updateMulti(data) {
        this.setState(state => {
            const Players = state.Players
            data.players.forEach((nv) => {
                Players.forEach((v) => {
                    if (v.id === nv.id)
                        v.ping = nv.ping
                })                
            })
            return {
                Players
            }
        })
    }

    update(data) {
        this.setState(state => {
            const Players = state.Players
            
            Players.forEach((v) => {
                if (v.id === data.id) 
                    v.ping = data.ping
            })

            return {
                Players
            }
        })

    }

    add(data) {
        this.setState(state => {
            const Players = [state.Players, {
                id: data.id,
                name:data.name,
                ping: data.ping
            }]

            Players.sort((a,b) => a.id - b.id)

            return {
                Players
            }
        })
    }

    set(data) {
        let players = data.players
        players.sort((a,b) => a.id - b.id)
        this.setState({Players:players});
    }

    remove(data) {
        this.setState(state => {
            const Players = state.Players

            Players.forEach((v, i) => {
                if (v.id === data.id)
                    Players.splice(i, 1)
            })

            return {
                Players
            }
        })
    }

    getColour(ping) {
        let color = 'green';

        if (ping > 150 && ping < 300) color = 'yellow'
        else if (ping > 300) color = 'red'

        return color
    }

    render() {
        return (
            this.state.Players.map((v, i, a) => {
                return <tr key={i} className=" border-t border-green-800">
                        <td>{v.id}</td>
                        <td>{v.name}</td>
                        <td className={`text-${this.getColour(v.ping)}-400`}>{v.ping}</td>
                </tr>
            })

        );
    }
}