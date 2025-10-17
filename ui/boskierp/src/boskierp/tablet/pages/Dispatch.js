


import React, { useState, useEffect } from 'react'
import sendMessage from '../../../Api'
export default function Dispatch(props) {
  const loadUsers = [
    // {
    //     name: "John Black",
    //     rank: {
    //         label: "Kadet",
    //         value: "cadet"
    //     },
    //     badge: "delta",
    //     dob: "02/02/2004",
    //     licenses: [
    //         {
    //             label: "Bron Dluga",
    //             value: "long"
    //         }
    //     ]
    // }, 
  ]

  const [users, setUsers] = useState(loadUsers)

  const allUsers = loadUsers

  const [vehicles, setVehicles] = useState([])

  const fnc = async () => {
    const data = await sendMessage('tablet_dispatch')

    setUsers(data.dispatches)
    setVehicles(data.vehicles)
  }

  useEffect(() => {
    fnc()
  }, [])

  const searchName = (e) => {
    let { value } = e.target
    let newUsrs = allUsers
    let usrs = newUsrs.filter((v) => v.name.toString().includes(value))
    setUsers(usrs)
  }

  const join = (e, d) => {
    sendMessage('tablet_dispatch_join', {
      dispatch: d
    })
  }

  const leave = (e, d) => {
    sendMessage('tablet_dispatch_leave', {
      dispatch: d
    })
  }

  const create = (e) => {
    let elem = document.getElementById('dispatch-name').value
    let elem2 = document.getElementById('dispatch-note').value
    sendMessage('tablet_dispatch_create', {
      name: elem,
      note: elem2,
      vehicle: vehicle
    })
  }

  const [vehicle, setVehicle] = useState({})

  const setCurrentVehicle = (e) => {
    const { value } = e.target
    const veh = vehicles[Number(value)]
    setVehicle(veh)
  }

  return (
    <div className=" w-full h-full text-white">
      <div className="h-full w-full">
        <div className="w-full h-full flex gap-2 p-2">

          <div className="w-full h-full bg-black bg-opacity-40 rounded-lg flex flex-col">
            <div className="w-full p-2 flex gap-2 ">
              <input onChange={searchName} type="search" id="default-search" className="bg-gray-700 p-2 rounded-lg w-full" placeholder="Wyszukaj dispatch" />
            </div>
            <div className="flex gap-2 w-full h-full flex-col overflow-auto">
              {users.map((v) => {
                return <div className="flex justify-center p-2 gap-4 w-full">
                  <button className="w-full h-fit p-2 bg-gray-700 rounded-lg">
                    {v.name}
                  </button>

                  <button onClick={(e) => join(v)} className="w-full h-auto p-2 bg-green-700 rounded-lg">
                    Dołącz
                  </button>
                  <button onClick={(e) => leave(v)} className="w-full h-auto p-2 bg-red-700 rounded-lg">
                    Opuść
                  </button>
                </div>
              })}
            </div>
          </div>

          <div className="w-full h-full basis-3/4">
            <div className="flex flex-col w-full h-full gap-2">
              <select className="appearance-none bg-gray-700 p-2 rounded-lg text-center" name="licenses" id="licenses" onChange={setCurrentVehicle}>
                {vehicles.map((v, i) => {
                  return <option key={i} value={i}>{v.label}</option>
                })}
                {/* <option value="volvo">Kadet</option>
                                <option value="saab">Oficer</option> */}
              </select>
              <div className="w-full flex gap-2 flex-col">
                <input type="text" id="dispatch-name" className="w-full h-auto text-center p-2 bg-gray-700 rounded-lg" />
                <textarea type="text" id="dispatch-note" className="w-full h-auto text-center p-2 bg-gray-700 rounded-lg" />
                <button className="w-full h-auto p-2 bg-gray-700 rounded-lg" onClick={create}>
                  Dodaj
                </button>
              </div>
              {/* <div className="w-full h-full flex gap-2">
                                <div className="w-full h-full rounded-lg bg-black flex gap-2 flex-col overflow-auto bg-opacity-40 p-2">
                                    {user.licenses.map((v, i) => {
                                        return <button onClick={(e) => removeLicense(e, i)} className="w-full h-auto p-2 bg-gray-700 rounded-lg">
                                            {v.label}
                                        </button>
                                    })}
                                </div>

                                <div className="w-full h-full rounded-lg bg-black flex gap-2 flex-col overflow-auto bg-opacity-40 p-2">
                                    {licenses.map((v ,i) => {
                                        return <button onClick={(e) => addLicense(e,i, i)} className="w-full h-auto p-2 bg-gray-700 rounded-lg">
                                            {v.label}
                                        </button>
                                    })}
                                </div>
                            </div> */}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}


