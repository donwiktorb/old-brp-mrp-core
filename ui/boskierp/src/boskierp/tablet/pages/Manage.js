

import React, { useState, useEffect } from 'react'
import sendMessage from '../../../Api'
export default function Manage(props) {

    const [licenses, setLicenses] = useState([
        {
            label: "Bron Dluga",
            value: "longweapon"
        }
    ])

    const [ranks, setRanks] = useState([
        {
            label: "Kadet",
            value: "recrut"
        },
        {
            label: "Kadet2",
            value: "recrut"
        }
    ])

    const loadUsers = [
        {
            name: "John Black",
            rank: {
                label: "Kadet",
                value: "cadet"
            },
            badge: "delta",
            dob: "02/02/2004",
            licenses: [
                "x d"
            ]
        }, 
    ]

    const [users, setUsers] = useState(loadUsers)

    const allUsers = loadUsers

    const [user, setUser] = useState({
        name: "John Black",
        rank: {
            label: "Kadet",
            value: "recruit"
        },
        img: "https://boskierp.pl/img/ss/dwb_PBTZ.png",
        dob: "02/02/2004",
        badge: "delta",
        licenses: [
            "x d" 
        ]
    })

    useEffect(() => {
        const fnc = async() => {
            const data = await sendMessage('tablet_manage')
            setLicenses(data.licenses)
            setRanks(data.ranks)
            setUsers(data.users)
        }
        fnc()
    }, [])

    useEffect(() => {
        sendMessage('tablet_manage_user', {
            user: user
        })
    }, [user])

    const searchName = (e) => {
        let { value } = e.target
        let newUsrs = allUsers
        let usrs = newUsrs.filter((v) => v.name.toString().includes(value))
        setUsers(usrs)
    }

    const searchBadge = (e) => {
        let { value } = e.target
        let newUsrs = allUsers
        let usrs = newUsrs.filter((v) => v.badge.toString().includes(value))
        setUsers(usrs)
    }

    const setUserRank = (e) => {
        let {value} = e.target
        const rank = ranks[Number(value)]
        setUser({
            ...user,
            rank: {
                label: rank.label,
                value: rank.value
            }
        })
    }

    const setUserBadge = (e) => {
        let {value} = document.getElementById('userBadge')
        setUser({
            ...user,
            badge: value
        })
    }

    const fire = (e) => {
        setUser({
            ...user,
            fired: true
        })
    }

    const removeLicense = (e, i) => {
        setUser({
            ...user,
            licenses: user.licenses.filter((v, id) => id !== i)
        })
    }

    const addLicense = (e, i) => {
        let license = licenses[i]
        if (!user.licenses.find((v) => v.value === license.value))
            setUser({
                ...user,
                licenses: [
                    ...user.licenses,
                    license
                ]
            })
    }

    return (
        <div className=" w-full h-full text-white">
            <div className="h-full w-full">
                <div className="w-full h-full flex gap-2 p-2">

                    <div className="w-full h-full bg-black bg-opacity-40 rounded-lg flex flex-col">
                        <div className="w-full p-2 flex gap-2 ">
                            <input onChange={searchName} type="search" id="default-search" className="bg-gray-700 p-2 rounded-lg w-full" placeholder="Wyszukaj imie i nazwisko" />
                            <input type="search" onChange={searchBadge} id="default-search" className="bg-gray-700 p-2 rounded-lg w-full" placeholder="Wyszukaj odznake" />
                        </div>
                        <div className="flex gap-2 w-full h-full flex-col overflow-auto">
                            {users.map((v) => {
                                return <div className="flex justify-center p-2 gap-4 w-full">
                                    <button className="w-full h-fit p-2 bg-gray-700 rounded-lg">
                                        {v.name} ({v.rank.label}) ({v.badge})
                                    </button>
                                    <button onClick={(e) => setUser(v)} className="w-full h-auto p-2 bg-gray-700 rounded-lg">
                                        Zarządzaj
                                    </button>
                                </div>
                            })}
                        </div>
                    </div>

                    <div className="w-full h-full basis-3/4">
                        <div className="flex flex-col w-full h-full gap-2">
                            <div className="w-22 h-22 flex justify-center">
                                <img src={user.img} className="select-none pointer-events-none w-22 h-22 rounded-full border-2 border-white backdrop-brightness-200 backdrop-contrast-100 " alt="RADIO" />
                            </div>
                            <div className="flex flex-col">
                                <div className="text-2xl">
                                    {user.name}
                                </div>
                                <div className="text-xl">
                                    {user.dob}
                                </div>
                            </div>
                            <select className="appearance-none bg-gray-700 p-2 rounded-lg text-center" name="licenses" id="licenses" onChange={setUserRank}>
                                <option value={user.rank.value}>{user.rank.label}</option>
                                {ranks.map((v, i) => {
                                    return <option key={i} value={i}>{v.label}</option>
                                })}
                                {/* <option value="volvo">Kadet</option>
                                <option value="saab">Oficer</option> */}
                            </select>
                            <div className="w-full flex gap-2">
                                <input type="text" id="userBadge" className="w-full h-auto text-center p-2 bg-gray-700 rounded-lg" defaultValue={user.badge} />
                                <button onClick={setUserBadge} className="w-full h-auto p-2 bg-gray-700 rounded-lg">
                                    Zapisz
                                </button>
                                <button onClick={fire} className="w-full h-auto p-2 bg-gray-700 rounded-lg">
                                    Zwolnij
                                </button>
                            </div>
                            <div className="w-full h-full flex gap-2">
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}


