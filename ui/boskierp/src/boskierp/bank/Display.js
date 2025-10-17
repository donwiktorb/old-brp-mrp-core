import React from 'react'
import sendMessage from '../../Api'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';
import { Line } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

const options = {
  responsive: true,
  plugins: {
    legend: {
      position: 'top',
    },
    title: {
      display: false,
      text: 'Chart.js Line Chart',
    },
  },
};

export default class Display extends React.Component {
    constructor(props) {
        super(props)
        this.state = props.state || {}
        this.default = props.state.data
        this.makeData = this.makeData.bind(this)
    
    }

    makeData() {
        const data = this.default 
        this.state.transactions.forEach((v) => {
            if (v.type === 'out') {
                let time = new Date(v.time)
                let month = time.getMonth()
                data.datasets[0].data[month] += v.fine/2
            } else {
                let time = new Date(v.time)
                let month = time.getMonth()
                data.datasets[1].data[month] += v.fine/2
            }     
        })        
        this.setState({
            data: data
        })
    }    

    // componentDidMount() {
    //     this.makeData()
    // }

    static getDerivedStateFromProps(nextProps, state) {
        if (nextProps.state !== state && nextProps) {
            return nextProps.state ? nextProps.state : []
        } else return null
    }

    transfer(e) {
        e.preventDefault()
        let {target} = e
        let bankId = target[0]
        let value = target[1]
        if (bankId && value)
            sendMessage('bank_transfer', {
                bankId: bankId,
                value: value
            }) 
        
    }

    submitDraw(e) {
        e.preventDefault()
        let {nativeEvent} = e
        let {submitter} = nativeEvent
        if (submitter) {
            let {type} = submitter.dataset
            let {value} = e.target[0] 
            if (type && type === 'in') {
                sendMessage('bank_deposit', {
                    value: value
                }) 
            } else if (type && type === 'out') {
                sendMessage('bank_withdraw', {
                    value: value
                }) 
            }
        }
    }

    close(e) {
        e.preventDefault()
        sendMessage('bank_close', {})
    }

    render() {
        return (    
            <div className="w-full h-full flex ">
                <div className="w-full h-full flex flex-col">
                    <div className="w-full h-full grid grid-cols-3 text-white gap-2 p-2">
                        <div className="w-full h-full flex items-center justify-center text-2xl">
                            <div className="border-2 border-green-200 rounded-lg p-4 flex flex-col gap-4 text-left">
                                Boskie Bankowości
                                <div className="text-white border-2 border-white rounded-lg text-lg text-center">
                                    Witaj {this.state.name}
                                </div>
                                <button onClick={(e) => this.close(e)} className="
                                appearance-none
                                text-sm
                                font-bold
                                text-green-500
                                border-2 rounded-lg
                                py-0.5
                                border-green-500
                                hover:border-blue-200
                                hover:text-blue-200
                                transition-all
                                " >Wyloguj się</button>
                            </div>
                        </div>
                        <div className="w-full h-full flex items-center justify-center text-2xl text-white
                        
                        ">
                            <div className="border-2 border-blue-500 rounded-lg p-4 flex flex-col gap-4">
                                Stan konta
                                <div className="text-green-500 border-2 border-green-500 rounded-lg text-lg">
                                    ${this.state.balance}
                                </div>
                            </div>
                        </div>
                        <div className="w-full h-full flex items-center justify-center text-2xl text-white
                         
                        ">
                            <div className="border-2 border-blue-500 rounded-lg p-4 flex flex-col gap-4">
                                Numer Konta
                                <div className="text-blue-800 border-2 border-blue-800 rounded-lg text-lg">
                                    {this.state.bankId}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="w-full h-full text-white flex">
                        <div className="w-full h-full">
                            <Line options={options} data={this.state.data} />
                        </div>
                    </div>
                </div>
                <div className="flex w-full h-full flex-col">
                    <div className="w-full h-1/2 flex justify-center gap-4">
                        <div className="w-full h-full flex items-center justify-center text-white 
                        ">
                        <form onSubmit={(e) => this.submitDraw(e)} className="p-8 flex flex-col gap-8 px-4 justify-center items-center  border-blue-500 border-2 rounded-lg">
                                <input type="text" className="text-center
                                bg-transparent
                                border-b-2
                                border-blue-500
                                placeholder-green-400
                                appearance-none
                                outline-none
                                py-2
                                text-green-500
                                hover:border-blue-200
                                " placeholder="Wpisz ilość $"/>
                                <div className="grid grid-cols-2 gap-4">
                                    <input type="submit"
                                    data-type = "in" 
                                     className="
                                    appearance-none
                                    text-green-500
                                    border-b-2
                                    py-2
                                    border-green-500
                                    hover:border-blue-200
                                    hover:text-blue-200
                                    transition-all
                                    " value="Wpłać" />
                                    <input data-type="out" type="submit" className="
                                    appearance-none
                                    text-green-500
                                    border-b-2
                                    py-2
                                    border-green-500
                                    hover:border-blue-200
                                    hover:text-blue-200
                                    transition-all
                                    " value="Wypłać" />
                                </div>
                            </form>
                        </div>

                        <div className="w-full h-full flex items-center justify-center text-white p-2
                        ">
                        <form className="p-8 flex flex-col gap-8 px-4 justify-center items-center  border-blue-500 border-2 rounded-lg">
                                <div className="grid grid-cols-2 gap-4">
                                    <input type="text" className="text-center
                                    bg-transparent
                                    border-b-2
                                    border-blue-500
                                    placeholder-green-400
                                    appearance-none
                                    outline-none
                                    py-2
                                    text-green-500
                                    hover:border-blue-200
                                    " placeholder="Numer konta"/>
                                    <input type="text" className="text-center
                                    bg-transparent
                                    border-b-2
                                    border-blue-500
                                    placeholder-green-400
                                    appearance-none
                                    outline-none
                                    py-2
                                    text-green-500
                                    hover:border-blue-200
                                    " placeholder="Wpisz ilość $"/>
                                </div>
                                <input type="submit" className="
                                appearance-none
                                text-green-500
                                border-b-2
                                py-2
                                border-green-500
                                hover:border-blue-200
                                hover:text-blue-200
                                transition-all
                                " value="Przelej" />
                            </form>
                        </div>

                        
                    </div> 
                    <div className="w-full h-1/2 items-center justify-center pt-4 rounded-lg">
                        <div className="w-full h-full overflow-auto flex flex-col gap-4 px-4">
                            {this.state.transactions.map((v, i) => {
                                if (v.type === 'out') {
                                    return <div className="border-2 rounded-lg border-orange-800">
                                        <div className="flex gap-4 justify-between px-2">
                                            <div className="text-red-500">
                                                {v.fine}
                                            </div>
                                            <div className="text-blue-500">
                                                {v.by}
                                            </div>
                                        </div>
                                        <div className="text-white text-left p-2 break-words">
                                        {v.reason}
                                        </div>
                                    </div>
                                } else {
                                    return <div className="border-2 rounded-lg border-green-800">
                                        <div className="flex gap-4 justify-between px-2">
                                            <div className="text-green-500">
                                                {v.fine}
                                            </div>
                                            <div className="text-blue-500">
                                                {v.by}
                                            </div>
                                        </div>
                                        <div className="text-white text-left p-2 break-words">
                                        {v.reason}
                                        </div>
                                    </div>
                                } 
                            })}
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}
