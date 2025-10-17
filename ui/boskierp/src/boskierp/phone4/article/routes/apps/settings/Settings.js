
import React, {useEffect, useState} from 'react'
import { useParams } from 'react-router-dom';
import sendMessage from '../../../../../Api'

export default function Settings(props) {
    const [settings, setSettings] = useState(props.settings || [])
    useEffect(() => {
        const fn = async () => {
            const settings2 = await sendMessage('phone_get_settings')
            setSettings(settings2 || [])
        }
        fn()
    }, [])

    return (
        <div className="w-full h-full bg-black bg-opacity-50 p-2 relative">
            <div className="grid grid-cols-1 text-white gap-4 w-full h-full content-start select-none">
                {settings.map((v) => {
                    return <div className="w-full border-b-2 h-fit flex flex-col hover:border-blue-500 transition-all">
                        <div className="text-lg">
                            {v.label}
                        </div>
                        <div className="text-blue-400">
                            {v.value}
                        </div>
                    </div>
                })}
            </div>
        </div>
    )
}


