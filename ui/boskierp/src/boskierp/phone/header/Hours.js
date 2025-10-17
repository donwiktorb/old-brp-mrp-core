
import React from 'react';

export default class Hour extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
            hour: this.getHour()
        };

    }   

    addZero(i) {
        if (i < 10) {i = "0" + i}
        return i;
    }

    getHour() {
        let d = new Date();
        let hour = this.addZero(d.getHours());
        let min = this.addZero(d.getMinutes());
        return hour+":"+min
    }

    setHour() {
        setTimeout(() => {
            let d = new Date();
            let hour = this.addZero(d.getHours());
            let min = this.addZero(d.getMinutes());
            this.setState({
                hour: hour+":"+min
            })
            this.setHour()
        }, 2222)
    }

    componentDidMount() {
        this.setHour()
    }


    render() {
        return (    
            <p>{this.state.hour}</p>
        );
    }
}

