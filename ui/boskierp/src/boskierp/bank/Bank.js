import React from 'react'
import Display from './Display'
import Login from './Login'
import Register from './Register'
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

import { Routes, Route } from "react-router-dom";
import sendMessage from '../../Api';

const labels = ["Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"];

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
export default class Bank extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      page: 'withdraw',
      name: "john Black",
      balance: 20000000,
      avgSpending: 0,
      avatar: "https://boskierp.pl/img/ss/dwb_yowb.png",
      bankId: 48,
      transactions: [
        // // ...Array(32).fill({

        // //     type: "in",
        // //     time: 1683888268658,
        // //     fine: 2000,
        // //     by: "LSPD",
        // //     reason: "dsadsad"
        // // }),
        // // {
        // //     type: "in",
        // //     time: 1683888268658,
        // //     fine: 2000,
        // //     by: "LSPD",
        // //     reason: "dsadsad"
        // // },
        // // {
        // //     type: "out",
        // //     time: 1673017265650,
        // //     fine: 2000,
        // //     by: "LSPD",
        // //     reason: "dsadsad"
        // // }
      ],
      data: {
        labels,
        datasets: [
          {
            label: 'Rozchód $',
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            borderColor: 'rgb(255, 99, 132)',
            backgroundColor: 'rgba(255, 99, 132, 0.5)',
          },
          {
            label: 'Przychód $',
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            borderColor: 'rgb(53, 162, 235)',
            backgroundColor: 'rgba(53, 162, 235, 0.5)',
          },
        ],
      }
    }

    this.data = {
      labels,
      datasets: [
        {
          label: 'Rozchód $',
          data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          borderColor: 'rgb(255, 99, 132)',
          backgroundColor: 'rgba(255, 99, 132, 0.5)',
        },
        {
          label: 'Przychód $',
          data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          borderColor: 'rgb(53, 162, 235)',
          backgroundColor: 'rgba(53, 162, 235, 0.5)',
        },
      ],
    }

    this.classTypes = {
      in: 'w-full bg-green-500 bg-opacity-70 rounded-lg p-2',
      out: 'w-full bg-red-500 bg-opacity-70 rounded-lg p-2',
    }

    this.open = this.open.bind(this)
    this.close = this.close.bind(this)

  }

  makeData() {
    const data = this.data
    this.state.transactions.forEach((v) => {
      if (v.type === 'out') {
        let time = new Date(v.time)
        let month = time.getMonth()
        data.datasets[0].data[month] += v.price / 2
      } else {
        let time = new Date(v.time)
        let month = time.getMonth()
        data.datasets[1].data[month] += v.price / 2
      }
    })
    this.setState({
      data: data
    })
  }

  componentDidMount() {
    this.makeData()
  }

  setPage = (e, i) => {
    this.setState({ page: i })
  }

  withdraw = (e) => {
    e.preventDefault('x d')
  }

  handleSubmit(e) {
    let action = this.state.page
    e.preventDefault()
    if (action === 'deposit') {
      const target = e.target.elements
      let quantity = target.quantity.value
      sendMessage('bank_deposit', {
        value: quantity
      })
    } else if (action === 'withdraw') {
      const target = e.target.elements
      let quantity = target.quantity.value
      sendMessage('bank_withdraw', {
        value: quantity
      })
    } else {
      const target = e.target.elements
      let bankId = target.number.value
      let quantity = target.quantity.value

      sendMessage('bank_transfer', {
        bankId: bankId,
        value: quantity
      })
    }
    e.target.reset()
  }

  deposit = (e) => {
    e.preventDefault()
  }

  transfer = (e) => {
    e.preventDefault()
  }

  open(data) {
    data.show = true
    this.setState(data, () => {
      this.makeData()
    })
    // this.setState({show: true,
    //     name: data.fullName,
    //     balance: data.balance,
    //     bankId: data.bankId,
    //     transactions: data.transactions
    // })
  }

  close() {
    this.setState({ show: false })
  }

  cancel() {
    sendMessage('menu_cancel', {
      name: "bank"
    })
  }

  render() {
    if (!this.state.show) return <div></div>
    return <div className="w-full h-full absolute z-20">
      <div className="w-full h-full flex justify-center items-center">
        <div className="w-3/4 h-3/4 bg-black bg-opacity-70 rounded-lg">
          <div className="w-full h-full flex select-none">
            <div className="w-1/4 h-full bg-black bg-opacity-70 flex flex-col text-white text-lg p-2 gap-4 rounded-l-lg">
              <div className="flex justify-center items-center w-full gap-4 border-b-2 p-2 text-xl font-bold font-serif">
                <img src="https://cdn.discordapp.com/attachments/1020433320934379612/1024767726104870933/xd8_digital_art_x4.png" className="opacity-70 w-24" alt="dwb"></img>
                <div>
                  BoskiBank
                </div>
              </div>
              <div className="flex justify-center items-center w-full gap-4 border-b-2 p-2">
                <img src={this.state.avatar} className="opacity-70 rounded-full w-14" alt="dwb"></img>
                <div>
                  {this.state.fullName}
                </div>
              </div>
              <div className="flex h-full items-center w-full gap-4 flex-col">
                <button onClick={(e) => this.setPage(e, 'withdraw')} className="w-full flex justify-center items-center text-white hover:text-blue-500 transition-all">
                  <svg className="w-9 h-9" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M0 26.016q0 2.496 1.76 4.224t4.256 1.76h20q2.464 0 4.224-1.76t1.76-4.224v-6.016l-8-8h-1.984v4h0.32l5.664 6.016h-5.984v1.984q0 0.832-0.608 1.44t-1.408 0.576h-8q-0.832 0-1.408-0.576t-0.576-1.44v-1.984h-6.016l5.664-6.016h0.352v-4h-2.016l-8 8v6.016zM10.048 5.664q-0.096 0.608 0.096 1.12t0.736 0.864 1.12 0.352h2.016v6.016q0 0.736 0.384 1.248t1.024 0.608 1.152 0 1.024-0.608 0.416-1.248v-6.016h1.984q0.672 0 1.152-0.352t0.704-0.896 0.096-1.12-0.544-1.056l-4-4q-0.608-0.608-1.408-0.576t-1.408 0.576l-4 4q-0.48 0.48-0.544 1.088z" fill='currentColor' />
                  </svg>
                  <div className="p-2 rounded-lg transition-all">Wypłata</div>
                </button>
                <button onClick={(e) => this.setPage(e, 'deposit')} className="w-full flex justify-center items-center text-white hover:text-blue-500 transition-all">
                  <svg fill="#000000" className="w-9 h-9" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
                    <title>received-inbox</title>
                    <path fill="currentColor" d="M0 26.016q0 2.496 1.76 4.224t4.256 1.76h20q2.464 0 4.224-1.76t1.76-4.224v-6.016l-6.88-6.88q-0.384 0.64-0.864 1.12l-1.856 1.824 5.6 5.952h-5.984v1.984q0 0.832-0.608 1.44t-1.408 0.576h-8q-0.832 0-1.408-0.576t-0.576-1.44v-1.984h-6.016l5.6-5.92-1.824-1.856q-0.48-0.448-0.896-1.12l-6.88 6.88v6.016zM10.048 10.368q0.096 0.608 0.544 1.056l4 4q0.64 0.608 1.44 0.576t1.376-0.576l4-4q0.48-0.48 0.576-1.088t-0.128-1.12-0.736-0.864-1.12-0.352h-1.984v-5.984q0-0.736-0.416-1.248t-1.024-0.608-1.152 0-1.024 0.608-0.384 1.248v5.984h-2.016q-0.64 0-1.152 0.384t-0.704 0.864-0.096 1.12z" />
                  </svg>
                  <div className="p-2 rounded-lg transition-all">Wpłata</div>
                </button>
                <button onClick={(e) => this.setPage(e, 'transfer')} className="w-full flex justify-center items-center text-white hover:text-blue-500 transition-all">
                  <svg className="w-9 h-9" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                      <g id="Transfer">
                        <rect id="Rectangle" fill-rule="nonzero" x="0" y="0" width="24" height="24">

                        </rect>
                        <path d="M19,7 L5,7 M20,17 L5,17" id="Shape" stroke="currentColor" stroke-width="2" stroke-linecap="round">

                        </path>
                        <path d="M16,3 L19.2929,6.29289 C19.6834,6.68342 19.6834,7.31658 19.2929,7.70711 L16,11" id="Path" stroke="currentColor" stroke-width="2" stroke-linecap="round">

                        </path>
                        <path d="M8,13 L4.70711,16.2929 C4.31658,16.6834 4.31658,17.3166 4.70711,17.7071 L8,21" id="Path" stroke="currentColor" stroke-width="2" stroke-linecap="round">

                        </path>
                      </g>
                    </g>
                  </svg>
                  <div className="p-2 rounded-lg transition-all">Przelew</div>
                </button>
              </div>
              <div className="flex justify-center items-end p-2 w-full gap-4 border-t-2">
                <button onClick={(e) => this.cancel()} className="w-full flex justify-center items-center text-white hover:text-blue-500 transition-all">
                  <svg className="w-9 h-9" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M21 12L13 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                    <path d="M18 15L20.913 12.087V12.087C20.961 12.039 20.961 11.961 20.913 11.913V11.913L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                    <path d="M16 5V4.5V4.5C16 3.67157 15.3284 3 14.5 3H5C3.89543 3 3 3.89543 3 5V19C3 20.1046 3.89543 21 5 21H14.5C15.3284 21 16 20.3284 16 19.5V19.5V19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                  </svg>
                  <div className="p-2 rounded-lg transition-all">Wyloguj</div>
                </button>
              </div>
            </div>
            <div className="w-full h-full bg-black bg-opacity-80 flex rounded-r-lg text-white">
              <div className="w-1/2 h-full">
                <div className="w-full flex-col h-full flex justify-center items-center">
                  <div className="flex w-full h-full justify-center items-center gap-4">
                    <div className="text-2xl font-semibold flex justify-center items-center flex-col">
                      <div className="text-center">
                        Balance
                      </div>
                      <div>
                        {
                          new Intl.NumberFormat("de-DE", { style: "currency", currency: "USD" }).format(
                            this.state.balance,
                          )
                        }

                      </div>
                    </div>


                  </div>
                  <div className="flex justify-between w-full p-2">
                    <div className="text-lg font-semibold flex flex-col justify-center items-center">
                      <div className="text-center">
                        AVG Spending
                      </div>
                      <div>
                        {
                          new Intl.NumberFormat("de-DE", { style: "currency", currency: "USD" }).format(
                            this.state.avgSpending,
                          )
                        }

                      </div>
                    </div>
                    <div className="text-lg font-semibold flex flex-col justify-center items-center">
                      <div className="text-center">
                        Konto
                      </div>
                      <div>
                        {this.state.bankId}
                        {/* {
                                                        new Intl.NumberFormat("en-IN", { style: "currency", currency: "USD" }).format(
                                                            this.state.balance,
                                                        )
                                                } */}

                      </div>
                    </div>
                  </div>
                  <div className="w-full h-full overflow-y-scroll p-2 flex gap-4 flex-col ">

                    {this.state.transactions.map((v) => {
                      return <div className={this.classTypes[v.type]}>
                        <div className="flex justify-between">
                          <div>
                            {v.by}
                          </div>
                          <div>
                            {new Date(v.time).toDateString()}
                          </div>
                          <div>
                            {v.price}$
                          </div>
                        </div>
                        <div>
                          {v.reason}
                        </div>
                      </div>
                    })}
                  </div>


                </div>



              </div>
              <div className="w-1/2 h-full flex flex-col gap-4 justify-center items-center transition-all ">
                <form onSubmit={(e) => this.handleSubmit(e, this.state.page)} className="w-full h-full flex flex-col text-lg gap-4 justify-center items-center animate-fadeInFast">
                  {this.state.page === 'withdraw' && (<>
                    <div className="w-full text-xl font-bold flex justify-center">
                      Wypłata
                    </div>
                    <div className="w-full flex justify-center">
                      <input name="quantity" type="number" className="appearance-none text-center outline-none hover:outline-none border-b-2 bg-transparent hover:border-blue-500 transition-all" placeholder="Ilość" ></input>

                    </div>
                    <div className="w-full flex justify-center gap-4">
                      <input type="submit" name="submit" value="Wypłać" className=" appearance-none p-0.5 border-b-2 hover:border-blue-500 transition-all" />
                    </div></>)
                  }
                  {this.state.page === 'deposit' && (<>
                    <div className="w-full text-xl font-bold flex justify-center">
                      Wpłata
                    </div>
                    <div className="w-full flex justify-center">
                      <input name="quantity" type="number" className="appearance-none text-center outline-none hover:outline-none border-b-2 bg-transparent hover:border-blue-500 transition-all" placeholder="Ilość" ></input>

                    </div>
                    <div className="w-full flex justify-center gap-4">
                      <input type="submit" name="submit" value="Wpłać" className=" appearance-none p-0.5 border-b-2 hover:border-blue-500 transition-all" />
                    </div>
                  </>)
                  }

                  {this.state.page === 'transfer' && (<>
                    <div className="w-full text-xl font-bold flex justify-center">
                      Przelew
                    </div>
                    <div className="w-full flex justify-center gap-4">
                      <input name="number" type="number" className="appearance-none text-center outline-none hover:outline-none border-b-2 bg-transparent hover:border-blue-500 transition-all" placeholder="Numer konta" ></input>
                      <input type="number" name="quantity" className="appearance-none text-center outline-none hover:outline-none border-b-2 bg-transparent hover:border-blue-500 transition-all" placeholder="Ilość" ></input>

                    </div>
                    <div className="w-full flex justify-center gap-4">
                      <input name="submit" type="submit" value="Wyślij" className=" appearance-none p-0.5 border-b-2 hover:border-blue-500 transition-all" />
                    </div>
                  </>)
                  }
                </form>
                <div className="w-full h-full p-2">
                  <div className="w-full h-full flex justify-center items-end">
                    <Line options={options} data={this.state.data} />
                  </div>
                </div>

              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
    return (
      <div className={`flex absolute h-screen justify-center items-center z-20 w-screen `} >
        <div
          className="h-3/5 w-3/5 text-center rounded-md ">
          <div className="
                        h-full w-full flex flex-col rounded-md 
                        bg-gradient-to-t 
                       from-green-500 to-blue-500 
                        shadow-2xl shadow-black
                        border-black
                        border-double
                        border-4
                    ">
            <div className="w-full h-full
                    
                        bg-black  bg-opacity-80
                     ">
              <Display ref={ref => (this.Display = ref)} state={this.state} />
              {/* <Routes> 
                            <Route path={``} element={<Display ref={ref => (this.Display = ref)} state={this.state} />} />
                            <Route path={`/`} element={<Display ref={ref => (this.Display = ref)} state={this.state} />} />
                            <Route path={`/bank`} element={<Display />} />
                            <Route path={`/bank/register`} element={<Register />} />
                        </Routes> */}
            </div>
          </div>
        </div>
      </div>
    );
  }
}
