


import React, { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom';
import sendMessage from '../../../../../Api'

export default function Gallery(props) {
    const [photos, setPhotos] = useState([
        // {
        //     img : "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png",
        //     name: "BRP"
        // },
        // ...Array(32).fill({
        //     img : "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png",
        //     name: "BRP sadasdasdsadsadsadsadasdasdasdasd "
        // })
    ])

    // // const copy = (e,v) =>{
    // //     navigator.permissions.query({ name: "write-on-clipboard" }).then((result) => {
    // //         if (result.state === "granted" || result.state === "prompt") {
    // //             navigator.clipboard.writeText(v.img)
    // //         }
    // //     });
    // // }

    function copy(e) {
        navigator.clipboard.writeText(e.target.src)
    }

    const showImage = (e)=>{
        if (e.target.classList.contains('fixed'))
            e.target.classList.remove('fixed', 'top-0', 'z-40', 'w-auto', 'h-auto', 'left-0')
        else
            e.target.classList.add('fixed', 'z-40', 'top-0', 'w-auto', 'h-auto', 'left-0')
    }

    useEffect(() => {
        const fn = async() => {
        const images = await sendMessage('phone_get_images', {
            type: 'gallery'
        })
        setPhotos(images)
        }
        fn()
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [])

    return (
        <div className="w-full h-full text-white bg-black bg-opacity-70 relative px-2 
        ">
            <div className="w-full h-full p-2">
                <div className="w-full h-full grid grid-cols-2 gap-4 content-start justify-items-center overflow-y-scroll">
                    {photos.map((v, i) => {
                        return <div className="w-full h-full flex flex-col gap-2 text-lg font-bold break-all">
                            <div>
                                <img onClick={(e) => showImage(e)} className="" src={v.img} alt={"zd"} ></img>
                            </div>
                            <input onFocus={(e) => e.target.select()} className="appearance-none bg-transparent rounded-lg text-white text-sm" type='text' value={v.img}>
                            </input>
                            <div className="w-full flex gap-4 justify-center items-center text-base">
                                <button onClick={copy} src={v.img} className="text-green-500 hover:text-white transition-all">
<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="w-9 h-9">
<g id="Edit / Copy">
<path id="Vector" d="M9 9V6.2002C9 5.08009 9 4.51962 9.21799 4.0918C9.40973 3.71547 9.71547 3.40973 10.0918 3.21799C10.5196 3 11.0801 3 12.2002 3H17.8002C18.9203 3 19.4801 3 19.9079 3.21799C20.2842 3.40973 20.5905 3.71547 20.7822 4.0918C21.0002 4.51962 21.0002 5.07967 21.0002 6.19978V11.7998C21.0002 12.9199 21.0002 13.48 20.7822 13.9078C20.5905 14.2841 20.2839 14.5905 19.9076 14.7822C19.4802 15 18.921 15 17.8031 15H15M9 9H6.2002C5.08009 9 4.51962 9 4.0918 9.21799C3.71547 9.40973 3.40973 9.71547 3.21799 10.0918C3 10.5196 3 11.0801 3 12.2002V17.8002C3 18.9203 3 19.4801 3.21799 19.9079C3.40973 20.2842 3.71547 20.5905 4.0918 20.7822C4.5192 21 5.07899 21 6.19691 21H11.8036C12.9215 21 13.4805 21 13.9079 20.7822C14.2842 20.5905 14.5905 20.2839 14.7822 19.9076C15 19.4802 15 18.921 15 17.8031V15M9 9H11.8002C12.9203 9 13.4801 9 13.9079 9.21799C14.2842 9.40973 14.5905 9.71547 14.7822 10.0918C15 10.5192 15 11.079 15 12.1969L15 15" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</g>
</svg>
                                </button>

                                <button className="text-red-500 hover:text-white transition-all">
<svg viewBox="0 -0.5 21 21" version="1.1" xmlns="http://www.w3.org/2000/svg" className="w-9 h-9">
    
    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="Dribbble-Light-Preview" transform="translate(-179.000000, -360.000000)" fill="currentColor">
            <g id="icons" transform="translate(56.000000, 160.000000)">
                <path d="M130.35,216 L132.45,216 L132.45,208 L130.35,208 L130.35,216 Z M134.55,216 L136.65,216 L136.65,208 L134.55,208 L134.55,216 Z M128.25,218 L138.75,218 L138.75,206 L128.25,206 L128.25,218 Z M130.35,204 L136.65,204 L136.65,202 L130.35,202 L130.35,204 Z M138.75,204 L138.75,200 L128.25,200 L128.25,204 L123,204 L123,206 L126.15,206 L126.15,220 L140.85,220 L140.85,206 L144,206 L144,204 L138.75,204 Z" id="delete-[#1487]">

</path>
            </g>
        </g>
    </g>
</svg>
                                </button>
                            </div>
                        </div>
                    })}
                </div>
            </div>
        </div>
    )
}

