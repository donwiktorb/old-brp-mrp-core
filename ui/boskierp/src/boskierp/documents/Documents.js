
import React from "react"
import sendMessage, {getBase64Image} from '../../Api'
import Id from './Id'
import Badge from './Badge'
import Drive from './Drive'

export default class Documents extends React.Component {
    constructor(props) {
        super(props)
        this.state = {


            show: false,
            docType: "badge",
            badge: "444",
            id: 0,
            exp: "02/02/2004",
            ln: "Sample",
            fn: "Seiji",
            country: "Russia",
            dob: "02/02/2004",
            sex: "M",
            avatar: "",
            hgt: 180,
            wgt: 100,
            licenses: [
                'A',
                'B',
                'C'
            ]
        }

        this.open = this.open.bind(this)
        this.close = this.close.bind(this)
        this.cancel = this.cancel.bind(this)
    }

    // componentDidMount() {
    //     let rpm = 1000
    //     let xd = rpm / 1000
    //     let one = 15
    //     let xd2 = xd * one
    //     this.setState({
    //         rpm: xd2
    //     })

    // }

    open(data) {
        if (data.txd) {
            let tempUrl = 'https://nui-img/' + data.txd + '/' + data.txd + '?t=' + String(Math.round(new Date().getTime() / 1000));
            this.setState(data, () => {
                let imgs = document.getElementsByClassName('profileimg')
                for (let v of imgs) {
                    v.src = data.avatar
                }
                // getBase64Image(tempUrl, (src) => {
                //     let imgs = document.getElementsByClassName('profileimg')
                //     for (let v of imgs) {
                //         v.src = tempUrl
                //     }
                // })
            })        
        } else {
            this.setState(data, () => {
                let imgs = document.getElementsByClassName('profileimg')
                for (let v of imgs) {
                    v.src = data.avatar
                }
            })
        }
    }

    cancel() {
        sendMessage("menu_cancel", {
            name: "docs",
        })
    }

    close() {
        this.setState({show:false})
    }

    render() {
        if (!this.state.show) return <></>
        else if (this.state.docType === "id")
            return <Id state={this.state} />
        else if (this.state.docType === "drive")
            return <Drive state={this.state} />
        else if (this.state.docType === 'badge')
            return <Badge state={this.state} />
    }
}
