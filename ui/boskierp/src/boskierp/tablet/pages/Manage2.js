


import React, { useState, useEffect } from 'react'
import { Link, useNavigate} from 'react-router-dom'
import sendMessage from '../../../Api'

export default function Manage(props) {
    const [jobs, setJobs] = useState([
        // {
        //     grade_label: "x d",
        //     value: "x d"
        // },
        // {
        //     grade_label: "x d",
        //     value: "x d2"
        // },
        // {
        //     grade_label: "x d",
        //     value: "x d4"
        // }, ...Array(32).fill({
        //     grade_label: "x d",
        //     value:"x d"
        // })
    ])
    const [job, setJob] = useState({
            // // label: "x d",
            // // value: "x d2",
            // // clothes: [{
            // //     label: "x d",
            // // }]
    })
    const [updatedJobs, setUpdateJobs] = useState(false)
    const [user, setUser] = useState({
            // // avatar: "https://boskierp.pl/img/ss/dwb_xD0V.png",
            // // firstname: "John",
            // // lastname: "Black",
            // // job: 1
    })
    const [users, setUsers] = useState([
        {
            avatar: "https://boskierp.pl/img/ss/dwb_xD0V.png",
            firstname: "John",
            lastname: "Black",
            job: 1
        }, ...Array(43).fill({
            avatar: "https://boskierp.pl/img/ss/dwb_xD0V.png",
            firstname: "John",
            lastname: "Black",
            job: 1
        })
    ])
    const navigate = useNavigate()

    useEffect(() => {
        const fnc = async() => {
            const data = await sendMessage('tablet_manage', {
                type: "get"
            })
            if (!data) return navigate('/')
            setJobs(data.jobs)
            setUsers(data.users)
        }
        fnc()
    }, [])

    useEffect(() => {
        if (!user.changed) return
        sendMessage('tablet_manage', {
            type: "update_user",
            value: user
        })
    }, [user])

    useEffect(() => {
        if (!updatedJobs) return
        sendMessage('tablet_manage', {
            type: "update_jobs",
            value: jobs
        })
    }, [jobs])

    const clearHours = (e) => {
        e.preventDefault()
        sendMessage('tablet_manage', {
            type: "clear_hours"
        })
    }

    const addJob = (e) => {
        e.preventDefault()
        const label = e.target[0].value
        const name = e.target[1].value
        const boss = e.target[2].checked
        const autoSkin = e.target[3].checked
        const grade = Number(e.target[4].value)
        const newJobs = [...jobs]
        newJobs.splice(grade, 0, {
            grade_name:name,
            grade_label:label,
            clothes: [
                {
                    autoSkin: autoSkin,
                    label: "Domyślne"
                },
            ],
            isBoss: boss
        })
        setClothes(
            {}
        )

            setUpdateJobs(true)
        setJobs(newJobs)
    }

    const removeJob = (e, id) => {
        e.preventDefault()
        const newJobs = [...jobs]
        newJobs.splice(id, 1)
            setUpdateJobs(true)
        
        setJobs(newJobs)
        
    }

    const onJobLabelChange = (e) => {
        setJob({...job, grade_label: e.target.value})
    }

    const onJobNameChange = (e) => {
        setJob({...job, grade_name: e.target.value})
    }

    const onJobGradeChange = (e) => {
        setJob({...job, grade: e.target.value})
    }

    const onBossChange = (e) => {
        setJob({...job, isBoss: e.target.checked})
    }

    const updateJob = (e) => {
        e.preventDefault()
        const newJobs = [...jobs]
        newJobs[job.idx] = {...job}

            setUpdateJobs(true)
        setJobs(newJobs )    
    }

    const setCurrentJob = (e, i, v) => {
        v.idx = i-1
        setJob(v)
        setClothes(v.clothes || {})
    }
    

    const [clothes, setClothes] = useState({})

    const updateClothes = (e) => {e.preventDefault()

            setUpdateJobs(true)
        const native = e.nativeEvent
        const submitter = native.submitter.dataset.submitter
        const clothes = Number(e.target[0].value)
        const txt = e.target[1].value
        if (submitter === 'update-auto') {
            const newJob ={...job}
            newJob.clothes.push({
                label: newJob.clothes[clothes].label,
                clothes: JSON.parse(txt),
                autoSkin: true
            })
            setJob({...job, ...newJob})                         
        } else if (submitter === 'update-text') {
            const newJob ={...job}
            newJob.clothes.push({
                label: newJob.clothes[clothes].label,
                clothes: JSON.parse(txt)
            })
            setJob({...job, ...newJob})                         
        } else if (submitter === 'delete') {
            const newJob ={...job}
            newJob.clothes.splice(clothes, 1)
            setJob({...job, ...newJob})                         
        }
    }

    const setCurrentClothes = (e) => {
        let idx = Number(e.target.value)
        let clothes = job.clothes[idx].clothes
        setClothes(clothes)
    }

    const updateCurrentClothes = (e) => {
        let clothes = JSON.parse(e.target.value)
        setClothes(clothes)
    }

    const addClothes = (e) => {e.preventDefault()
        const label = e.target[0].value
        const autoSkin = e.target[1].checked
        const txt = e.target[2].value
        const newjob = {...job}
        if (!newjob.clothes) newjob.clothes = []
        newjob.clothes.push({
            label: label,
            clothes: JSON.parse(txt),
            autoSkin: autoSkin
        })

            setUpdateJobs(true)
        setJob({...job, ...newjob})
    }

    const fre = (e) => {
        const usr = {...user}
        usr.fre = true
        usr.changed = true
        setUser({...user, ...usr})
    }

    const setRank = (e) => {
        const usr = {...user}
        usr.job = Number(e.target.value)
        usr.changed = true
        setUser({...user, ...usr})
    }

    const addUser = (e) => {
            e.preventDefault()
          sendMessage('tablet_manage', {
            type: "add_user",
            value: e.target[0].value
        })
    }

   function toHoursAndMinutes(totalMinutes) {
        let hours = Math.floor(totalMinutes / 60);
        let minutes = totalMinutes % 60

        // if (minutes.length <= 1) minutes = minutes + '0'

        return `${hours}h ${minutes}m`
    }

    return (
        <div className=" w-full h-full text-white p-2">
            <div className="w-full h-full overflow-auto snap-mandatory snap-y">
                <div className="w-full h-full flex gap-4 snap-end">
                    <div className="w-1/2 h-full bg-black bg-opacity-70 rounded-lg p-4 overflow-auto flex flex-col gap-4">
                        {users.map((v, i) => {
                            return <div className="w-full bg-black bg-opacity-70 rounded-lg p-2 flex justify-between items-center text-xl">
                                 <img src={v.avatar} alt="x d" className="rounded-full w-24 h-24"></img>
                                <div>
                                    {v.firstname} {v.lastname} 
                                </div>
                                <div>
                                    {v.badge || 0}
                                </div>
                                <div>
                                    {toHoursAndMinutes(v.time || 1)}
                                </div>
                                <div>
                                    {jobs[v.job - 1]?.grade_label}
                                </div>
                                <button onClick={() => setUser(v)} className="p-2 rounded-lg border-2">
                                    Zarządzaj
                                </button>
                            </div>

                        })}
                    </div> 

                    {user?.firstname && <div className="w-1/2 h-full bg-black bg-opacity-70 rounded-lg p-2 flex flex-col items-center gap-4 text-2xl">
                        <div className="w-full flex gap-4 justify-between items-center p-2">

                                <img src={user.avatar} alt="x d" className="rounded-full w-24 h-24"></img> 
                                <div>
                                    {user.firstname} {user.lastname}
                                </div>
                                <div>
                                    {jobs[user.job-1]?.grade_label}
                                </div>
                        </div>
                        <div className="w-full flex gap-4">
                            <select onChange={setRank} className="appearance-none w-full p-2 rounded-lg bg-black" name="ranks" defaultValue={user.job}>
                                {jobs.map((v, i) => {
                                    return <option value={i+1}>{v.grade_label}</option>
                                })}
                            </select>
                            <button className="p-2 rounded-lg border-2 w-full">
                                Zapisz
                            </button>
                            <button onClick={fre} className="p-2 rounded-lg border-2 w-full">
                                Wyrzuć
                            </button>
                        </div>
                    </div>}
                </div>

                <div className="w-full h-full flex gap-4 snap-start">
                    <div className="w-1/2 h-full bg-black bg-opacity-70 rounded-lg p-4 overflow-auto flex flex-col gap-4">
                        {jobs.map((v, i) => {
                            i = i+1
                            return <div className="w-full bg-black bg-opacity-70 rounded-lg p-2 flex justify-between items-center text-xl">
                            <div>
                                {v.grade_label}
                            </div>
                            <div>
                                Grade: {i}
                            </div>
                            {v.isBoss && <div>
                                Szef
                            </div>}

                            <div className="flex gap-4">
                                <button className="p-2 rounded-lg border-2 border-pink-500" onClick={(e) => removeJob(e,i-1)}>
                                    Usuń
                                </button>
                                <button onClick={(e) => setCurrentJob(e,i,v)} className="p-2 rounded-lg border-2">
                                    Zarządzaj
                                </button>
                            </div>
                        </div>

                        })}
                    </div> 

                    <div className="w-1/2 h-full bg-black bg-opacity-70 rounded-lg p-2 gap-4 flex flex-col">
                        {job?.grade_label && <div className="w-full h-1/2 bg-black bg-opacity-70 rounded-lg overflow-auto snap-mandatory-y">
                            <form className=" snap-start w-full h-full flex flex-col gap-4 p-2" onSubmit={updateJob}>   
                                <div className="flex justify-between items-center gap-4">
                                    <input onChange={onJobLabelChange}  value={job.grade_label} className="appearance-none w-full border-2 rounded-lg bg-black p-2" type='text' placeholder="Nazwa joba (np Mechanik)"></input>
                                    <input onChange={onJobNameChange} value={job.grade_name} className="w-full p-2 appearance-none rounded-lg bg-black border-2" type='text' placeholder="Name joba (np. mechanic4)"></input>
                                </div>

                                <div className="w-full flex gap-4 justify-start items-center">
                                    <input onChange={onBossChange} className="appearance-none bg-white checked:bg-black p-2 rounded-lg border-2" type='checkbox' name='boss'></input>
                                    <label for='boss'>Dostęp szefa</label>

                                    <input className="appearance-none bg-white checked:bg-black p-2 rounded-lg border-2" type='checkbox' name='skin'></input>
                                    <label for='skin'>Automatycznie pobierz aktualny strój</label>
                                </div>
                                
                                <input type='number' placeholder="Grade joba (od 0 do ile chcesz)" onChange={onJobGradeChange} className="p-2  appearance-none bg-black rounded-lg border-2 w-auto" min={1}></input>
                                <input className="w-full p-2 bg-black rounded-lg border-2" type='submit' value="Zapisz"></input>
                            </form>
                            <form onSubmit={updateClothes} className="w-full h-full p-2 snap-start flex flex-col gap-4">
                                <div className="flex gap-4 w-full flex-col">
                                    <select onChange={setCurrentClothes} className="appearance-none w-full p-2 rounded-lg bg-black" name="skins">
                                        {job?.clothes?.map((v, i) => {
                                            return <option value={i}>{v.label}</option>
                                        })}
                                    </select>
                                    <textarea value={JSON.stringify(clothes)} className="w-full h-full bg-black rounded-lg" placeholder="strój" onChange={updateCurrentClothes}>
                                    </textarea>
                                    <div className="w-full h-full flex gap-4">

                                    <input data-submitter="update-auto" value="Aktualizuj strój (Pobierze twój aktualny)" type="submit" className="w-full rounded-lg border-2 p-2">
                                    </input>
                                    <input data-submitter="update-text" value="Aktualizuj strój z textu" type="submit" className="w-full rounded-lg border-2 p-2">
                                    </input>
                                    <input data-submitter="delete" value="Usuń" type="submit" className="w-full rounded-lg border-2 p-2">
                                    </input>
                                    <button onClick={updateJob} className="p-2 rounded-lg border-2">Zapisz</button>
                                    </div>
                                </div>

                            </form>

                            <form onSubmit={addClothes} className=" snap-start w-full h-full flex flex-col gap-4 p-2">   
                            <input className="appearance-none w-full border-2 rounded-lg bg-black p-2" type='text' placeholder="Nazwa stroju (np Mechanik)"></input>
                            <div className="w-full flex gap-4 justify-start items-center">
                                <input className="appearance-none bg-white checked:bg-black p-2 rounded-lg border-2" type='checkbox' name='skin'></input>
                                <label for='skin'>Automatycznie pobierz aktualny strój</label>
                            </div>
                            <textarea defaultValue="{}" className="w-full h-full bg-black rounded-lg" placeholder="strój">

                            </textarea>
                            <input className="w-full p-2 bg-black rounded-lg border-2" type='submit' value="Dodaj"></input>
                            <button onClick={updateJob} className="p-2 rounded-lg border-2">Zapisz</button>
                            </form>
                        </div>}
                        <div className="w-full h-1/2 bg-black bg-opacity-70 rounded-lg">
                            <form onSubmit={addJob} className="w-full h-full flex flex-col gap-4 p-2">   
                                <div className="flex justify-between items-center gap-4">
                                    <input className="appearance-none w-full border-2 rounded-lg bg-black p-2" type='text' placeholder="Nazwa joba (np Mechanik)"></input>
                                    <input className="w-full p-2 appearance-none rounded-lg bg-black border-2" type='text' placeholder="Name joba (np. mechanic4)"></input>
                                </div>
                                <div className="w-full flex gap-4 justify-start items-center">
                                    <input className="appearance-none bg-white checked:bg-black p-2 rounded-lg border-2" type='checkbox' name='boss'></input>
                                    <label for='boss'>Dostęp szefa</label>
                                </div>
                                <div className="w-full flex gap-4 justify-start items-center">
                                    <input className="appearance-none bg-white checked:bg-black p-2 rounded-lg border-2" type='checkbox' name='skin'></input>
                                    <label for='skin'>Automatycznie pobierz aktualny strój</label>
                                </div>
                                
                                <input type='number' placeholder="Grade joba (od 0 do ile chcesz)" className="p-2  appearance-none bg-black rounded-lg border-2 w-auto" min={1}></input>
                                <input className="w-full p-2 bg-black rounded-lg border-2" type='submit' value="Dodaj"></input>
                            </form>
                        </div>
                        
                    </div> 
                </div>
 <div className="w-full h-full flex gap-4 snap-end flex-col">
                    <form onSubmit={addUser} className="w-full h-full flex flex-col gap-4 p-2">
                        <input type='number' placeholder="Pesel" className="p-2  appearance-none bg-black rounded-lg border-2 w-auto" min={1}></input>
                        <input className="w-full p-2 bg-black rounded-lg border-2" type='submit' value="Zatrudni"></input>
                    </form>
                    <div>
                        <button onClick={clearHours} className="w-full p-2 bg-black rounded-lg border-2" type='xd' value="Wyczysc Godziny">Wyczysc godziny</button>
                    </div>
                </div>
            </div>
        </div>
    )
}


