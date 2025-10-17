

import React, { useEffect, useRef } from 'react'
import {useState} from 'react'

import { useLocation, useParams } from "react-router-dom";
import sendMessage from '../../../Api';

export default function File(props) {
    const {id} = useParams()
    const {state} = useLocation()
    const [tags, setTags] = useState([
        "x d"
    ])
    const [allTags, setAllTags] = useState([
    ])
    
    const [cop, setCop] = useState({})
    
    const [history, setHistory] = useState([])
    const [updated, setUpdated] = useState(false)
    const [notes, setNotes] = useState([])
    const [licenses, setLicenses] = useState([
    ])
    // const loaded = useRef(0)
    const [init, setInit] = useState(false)

    const [user, setUser] = useState({
        firstname: "",
        lastname:"",
        licenses: [
        ],
        avatar: "",
        id: 2
    })

    useEffect(() => {
        if (init && user.changed) {
            sendMessage('tablet_file', {
                type: "user",
                value: user,
            })
        }
    }, [user])

    useEffect(() => {
        const fn = async ( ) => {
            let data = await sendMessage('tablet_file_data', {
                id: id
            })    
            setHistory(data.history)
            setNotes(data.notes)
            setUser(data.user)
            setLicenses(data.licenses)
            setAllTags(data.allTags)
            setTags(data.tags)
            setCop(data.cop)
            setInit(true)
        }        
        fn()
    }, [])

    // useEffect(() => {
    //     sendMessage('tablet_file', {
    //         type: "licenses",
    //         value: data,
    //     })
    // }, [data])
    
    useEffect(() => {
        if (updated) {
            sendMessage('tablet_file', {
                type: "tags",
                value: tags,
                userId: id
            })
        }
    }, [tags])
    

    // useEffect(() => {
    //     if (init) {
    //         sendMessage('tablet_file', {
    //             type: "notes",
    //             value: notes,
    //             old: initData.notes
    //         })
    //     }
    // }, [notes])

    const [tab, setTab] = useState(0)


    const [msg, setMsg] = useState('')

    const addNote = (e) => {
        const nextArrs = [
            {
                cop: cop.firstname + " "+cop.lastname,
                content: msg,
                time: new Date().getTime(),
                id: Math.random().toString(),
                suspect: id
            },
            ...notes
        ]
        sendMessage('tablet_file', {
            type: "add",
            value: {
                cop: cop.firstname + " "+cop.lastname,
                content: msg,
                time: new Date().getTime(),
                id: 0,
                suspect: id
            },
        })

        setNotes(nextArrs)
    }

    const removeNote = (e, index, id) => {
        sendMessage('tablet_file', {
            type: "remove",
            value: id || index
        })

        setNotes(notes.filter((nv,id) => id ? nv.id !== id : id !== index))
    }

    const editNote = (e, id) => {
        // let elem = document.getElementById(`text-${id}`)
        // setNotes(notes.map((v,i ) => {
        //     if (i === id) {
        //         v.content = elem.value
        //         sendMessage('tablet_file', {
        //             type: "notes",
        //             action: "update",
        //             id: id,
        //             value: v.content
        //         })

        //         return v
        //     }

        //     return v
        // }))
    }

    const addTag = (e, i) => {
        setUpdated(true)
        let obj = allTags[i]
        let found = tags.find((v) => v=== obj)
        // // let found = false
        if (!found) {
            setTags([
                ...tags,
                allTags[i]
            ])
        }
    }

    const removeTag = (e, id) => {
        setUpdated(true)
        const tags2 = tags
        tags2.splice(id, 1)
        setTags([...tags2])
    }

    const removeLicense = (i, ni) => {
        const usr = {...user}
        usr.changed = true
        const userLicenses =[...usr.licenses]
        userLicenses.splice(i,1)
        usr.licenses = userLicenses
        setUser(usr)
    }

    const addLicense = (i) => {
        const usr = {...user}
        usr.changed = true
        const userLicenses = [...usr.licenses]
        let found = userLicenses.find((v) => v=== licenses[i])
        if (!found) {
            userLicenses.push(licenses[i])
            usr.licenses = userLicenses
            setUser(usr)
        }
    }

    return (
        <div className="w-full h-full">
            <div className="w-full h-full text-white">
                <div className="w-full h-full flex gap-4 p-4">
                    <div className="w-full h-full basis-1/5">
                        <div className="flex flex-col gap-4 text-center w-full h-full overflow-auto">
                            <div className="w-full flex justify-center">
                                <img src={user.avatar} className="select-none pointer-events-none w-22 h-22 rounded-full border-2 border-white backdrop-brightness-200 backdrop-contrast-100 " alt="WCZYTYWANIE..."  />
                            </div>
                            <div className="text-2xl">
                                {user.firstname}
                            </div>
                            <div className="text-2xl">
                                {user.lastname}
                            </div>
                            <div className="text-xl">
                                {user.dob}
                            </div>
                            <div className="text-xl">
                                {id}
                            </div>
                            Zabierz licencję
                            <div className=" w-full h-full flex flex-col gap-4 overflow-auto max-h-44">
                                {user?.licenses?.map((v, i) => {
                                    return <div className="border-2  text-xl rounded-lg">
                                        <button onClick={() => removeLicense(i)}>
                                            {v}
                                        </button>
                                    </div>
                                })}
                            </div>
                            Nadaj Licencję 
                            <div className=" w-full h-full flex flex-col gap-4 overflow-auto max-h-44">
                                {licenses.map((v, i) => {
                                    return <div className="border-2  text-xl rounded-lg">
                                        <button onClick={() => addLicense(i)}>
                                            {v}
                                        </button>
                                    </div>
                                })}
                            </div>
                        </div>
                    </div>

                    <div className="w-full h-full flex flex-col gap-4">
                        <div className="flex justify-center w-full h-1/3 flex-col gap-4">
                            <textarea onChange={(e) => setMsg(e.target.value)} value={msg} className="w-full max-h-44 bg-gray-700 p-2 text-center rounded-lg h-44" placeholder="Wpisz notatke" id="target-value">
                            </textarea>
                            <button onClick={(e) => addNote(e)} className=" w-full bg-slate-700 rounded-lg p-2">
                                Wyślij
                            </button>
                        </div>
                        <div className="w-full flex gap-4 justify-center p-1 h-fit">
                            <button onClick={(e) => setTab(0)} className="w-full h-full bg-gray-700 p-1">
                                Notatki
                            </button>
                            <button onClick={(e) => setTab(1)} className="w-full h-full bg-gray-700 p-1">
                                Wyroki
                            </button>
                            <button onClick={(e) => setTab(2)} className="w-full h-full bg-gray-700 p-1">
                                Samochody
                            </button>
                        </div>
                        <div className="w-full h-2/3 flex flex-col gap-2 bg-black bg-opacity-20 rounded-lg overflow-auto">
                            <div className="w-full h-full bg-black bg-opacity-20 rounded-b-lg ">
                                <div className="w-full h-full p-2 flex flex-col gap-4 ">
                                    {tab === 0 ? notes.map((v, i) => {
                                        return  <div key={v.id} className="w-full h-fit bg-slate-700 p-2 rounded-lg flex flex-col gap-2 text-left">
                                            <div className="text-lg font-bold">
                                                {v.cop}
                                            </div>
                                            <textarea id={`text-${i}`} className="bg-slate-700 appearance-none peer">
                                                {v.content}
                                            </textarea>
                                            <div className="flex gap-4">
                                                <button onClick={(e) => editNote(e, i)} className="w-full bg-blue-500">
                                                    Zapisz
                                                </button>
                                                <button onClick={(e) => removeNote(e,i, v.id)} className="w-full bg-red-500">
                                                    Usun
                                                </button>
                                            </div>
                                            {/* <div className="hidden peer-focus:flex w-full justify-center gap-2">
                                                <button onClick={(e) => editNote(e, i)} className="w-full bg-green-500">
                                                    Akceptuj
                                                </button>
                                                <button className="w-full bg-red-500">
                                                    Anuluj
                                                </button>
                                            </div> */}
                                            <div className="text-center">
                                                {new Date(v.time).toLocaleString()}
                                            </div>
                                        </div>
                                    }) : tab === 1 ? history.map((v, i) => {
                                        return  <div key={i} className="w-full h-fit bg-slate-700 p-2 rounded-lg flex flex-col gap-2 text-left">
                                            <div className="text-lg font-bold">
                                                {v.cop}
                                            </div>
                                            <div className="flex justify-between gap-4">
                                            <div className="text-lg font-bold">
                                                {v.jailTime} mieś
                                            </div>
                                            <div className="text-lg font-bold">
                                                {v.ticket} $
                                            </div>
                                            </div>
                                            <div id={`text-${i}`} className="bg-slate-700 appearance-none peer">
                                                {v.content}
                                            </div>
                                            <div className="text-center">
                                                {new Date(v.time).toLocaleString()}
                                            </div>
                                        </div>
                                    }) : tab === 2 && user?.vehicles?.map((v, i) => {
                                        return  <div key={i} className="w-full h-fit bg-slate-700 p-2 rounded-lg flex flex-col gap-2 text-left">
                                            <div className="text-lg font-bold">
                                                {v.plate}
                                            </div>
                                            <div className="flex justify-between gap-4">
                                            <div className="text-lg font-bold">
                                                {v.name}
                                            </div>
                                            <div className="text-lg font-bold">
                                                {v.state === 1 ? 'W garau' : "Na odholowniku"}
                                            </div>
                                            </div>
                                            {/* <div id={`text-${i}`} className="bg-slate-700 appearance-none peer">
                                                {v.content}
                                            </div> */}
                                            <div className="text-center">
                                                {new Date(v.time).toLocaleString()}
                                            </div>
                                        </div>
                                    })}
                                </div>
                            </div>
                        </div>
                    </div>

                    <div className="w-full h-full basis-1/5">
                        <div className="w-full h-full gap-4  flex flex-col ">
                            Tagi
                           <div className="w-full h-1/2 flex flex-col gap-2 overflow-auto pb-2">
                                {tags.map((v, i) => {
                                    return <button onClick={(e) => removeTag(e, i)} className="bg-gray-700 rounded-lg p-2">
                                        {v}
                                    </button>
                                })}
                           </div> 
                           Dodaj tagi
                           <div className="w-full h-1/2 flex flex-col gap-2 overflow-auto py-2">
                                {allTags.map((v, i) => {
                                    return <button className="bg-gray-500 rounded-lg p-2" onClick={(e) => addTag(e,i)}>
                                        {v}
                                    </button>
                                })}
                           </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
