import React from "react";
// import $ from "jquery";

export default class Head extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
           Head: [
            // //    'imie',
            // //    'nazwisko',
            // //    'akcje'
           ],
        };

        this.set = this.set.bind(this);

    }   

    set(Head) {
        this.setState({Head:Head})
    }

    render() {
        return (
            this.state.Head.map((v, i, a) => {
                return <th key={i} className=" bg-green-400" dangerouslySetInnerHTML={{ __html: v }}></th>

            })

        );
    }
}