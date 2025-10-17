import React from "react";
import Players from './Players'
import Fractions from "./Fractions";
import Stats from "./Stats";
import {Transition } from 'react-transition-group'; // ES6

const duration = 300;

const defaultStyle = {
  transition: `opacity ${duration}ms ease-in-out`,
  opacity: 0,
}

const transitionStyles = {
  entering: { opacity: 1 },
  entered:  { opacity: 1 },
  exiting:  { opacity: 0 },
  exited:  { opacity: 0 },
};
export default class Scoreboard extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
            hidden: true,
            title: "BoskieRP"
        };
        this.open = this.open.bind(this)            
        this.close = this.close.bind(this)            
        this.stats = this.stats.bind(this)            
        this.scroll = this.scroll.bind(this)            
        this.players = this.players.bind(this)            
        this.fractions= this.fractions.bind(this)   
        this.set = this.set.bind(this)
    }   

    hideScoreboard(state) {

        if (state) {
            this.setState({
                hidden: state
            })
        } else {
            this.setState({
                hidden: !this.state.hidden
            })
        }
    }

    set(data) {
        this.setState({
            title: data.title
        })
    }

    open() {
        this.setState({hidden:false})
    }

    close() {
        this.setState({hidden:true})
    }

    stats(data) {
        let func = this.Stats[data.action]
        if (func) func(data)
    }    

    scroll(data) {
        if (data.action === 'up') document.getElementById('Players').scrollTop  -= 12
        else document.getElementById('Players').scrollTop += 12;
    }    

    players(data) {
        let func = this.Players[data.action]
        if (func) func(data)
    }

    fractions(data) {
        let func = this.Fractions[data.action]
        if (func) func(data)
    } 

    
    render() {
        return (    
            <Transition in={!this.state.hidden} timeout={duration}>
                {state => (
                    <div 
                        style={{
                            ...defaultStyle,
                            ...transitionStyles[state]
                        }}
                        className="flex justify-end items-center h-screen" >
                        <div id="Players" style={{
                                // display: this.state.hidden ? 'none' : ''
                            }} className="mr-2 w-1/4 max-h-72 text-center overflow-hidden font-sans rounded-lg bg-black bg-opacity-80 ">
                            <div className="text-green-400 py-1 ">
                                <p className="text-lg">
                                    {this.state.title}
                                </p>
                                <Fractions ref={ref => (this.Fractions = ref)}/>
                            </div>
                            
                            <table className="table-fixed  min-w-full">
                            <thead className="sticky top-0">
                                <tr key="sticky">
                                    <th key="id" className="w-1/6 bg-green-600">ID</th>
                                    <th key="name" className="w-1/2 bg-green-400">Nazwa</th>
                                    <th key="ping" className="w-1/6 bg-green-600">Ping</th>
                                </tr>
                            </thead>
                            <tbody className="break-all text-green-400 " >
                                <Players ref={ref => (this.Players = ref)}/>
                            </tbody>
                            </table>
                            <Stats ref={ref => (this.Stats = ref)}/>
                        </div>
                    </div>
                )}
            </Transition>
        );
    }
}