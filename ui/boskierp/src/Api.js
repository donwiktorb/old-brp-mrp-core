export default async function sendMessage(type, data, nojs) {
    const resp = await fetch("https://" + window.name + "/" + type, {
        method: "POST",
        body: JSON.stringify(data),
    });
    if (nojs) return resp;
    else return resp.json();
}

async function loadImage(img, cb) {
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");
    // canvas.height = img.naturalHeight
    canvas.height = img.height;
    canvas.width = img.width;
    // canvas.width = img.naturalWidth
    ctx.drawImage(img, 0, 0);
    let dataUrl = canvas.toDataURL();
    cb(dataUrl, img);
}

export async function getBase64Image(src, cb) {
    const img = new Image();
    img.crossOrigin = "Anonymous";
    img.addEventListener("load", () => loadImage(img, cb));
    img.src = src;
}

let pc;
let number;
let localStream;

const offerOptions = {
    mediaStreamConstraints: {
        audio: true, // Request audio only
        video: false, // Do not request video
    },
};

export async function initPeer(number2) {
    number = number2;
    pc = new RTCPeerConnection();
    // //     // {
    // // // //   iceServers: [
    // // // //     // { urls: 'stun:stun.l.google.com:19302' }, // Add STUN server URL
    // // // //     // {
    // // // //     //     urls: 'turn:boskierp.pl:3478',
    // // // //     //     username: 'donwiktorb',
    // // // //     //     credential: 'NEW'
    // // // //     // }
    // // // // ]
    // //     // }
    // // )

    pc.onanswer = (event) => {
        pc.setRemoteDescription(event.answer);
    };

    pc.onaddstream = (event) => {
        document.getElementById("remoteAudio").srcObject = event.stream;
    };

    pc.oniceconnectionstatechange = (event) => {
        console.log(event);
    };

    pc.onconnectionstatechange = (event) => {
        console.log(event);
    };

    pc.ontrack = (event) => {
        console.log(event);
        document.getElementById("remoteAudio").srcObject = event.streams[0];
    };

    pc.onicecandidate = (event) => {
        if (event.candidate) {
            sendMessage("phone_new_candidate", {
                candidate: event.candidate,
                number: number,
            });
        }
    };

    return pc;
}

// change this, candidate is being added faster then pc is being created (maybe connection should be created once at the init time?)

async function addCandidate(candidate) {
    if (!pc) {
        setTimeout(() => {
            addCandidate(candidate);
        }, 20);
    } else {
        await pc.addIceCandidate(candidate);
    }
}

export function hangup() {
    document.getElementById("remoteAudio").srcObject = null;
    localStream?.getTracks().forEach((track) => {
        track.stop();
        localStream.removeTrack(track);
        pc.getSenders().forEach((v) => {
            pc.removeTrack(v);
        });
        // // pc.removeTrack(pc.getSenders().find((sender) => sender.track === track));
    });
    // // document.getElementById('localAudio').stop()
    pc?.close();
    pc = null;
}

export async function AddCandidate(candidate) {
    addCandidate(candidate);
}

export async function getMedia() {
    await navigator.mediaDevices
        .getUserMedia({ audio: true })
        .then((stream) => {
            localStream = stream;
            document.getElementById("localAudio").srcObject = stream;
            stream.getTracks().forEach((track) => pc.addTrack(track, stream));
        })
        .catch(console.warn);
}

export async function createOffer() {
    const offer = await pc.createOffer(offerOptions);
    pc.setLocalDescription(offer);
    return offer;
}

export async function setOffer(sdp) {
    const offer = new RTCSessionDescription({
        type: "offer",
        sdp: sdp,
    });
    pc.setRemoteDescription(offer);
    return;
}

export async function createAnswer() {
    const offer = await pc.createAnswer();
    pc.setLocalDescription(offer);
    return offer;
}

export async function setAnswer(sdp) {
    const answer = new RTCSessionDescription({
        type: "answer",
        sdp: sdp,
    });

    pc.setRemoteDescription(answer);
    return;
}

// let dataChannelDataReceived;
// let localPeerConnection;
// let remotePeerConnection;
// let localStream;
// let sendChannel;
// let receiveChannel;
// const dataChannelOptions = {ordered: true};
// let dataChannelCounter = 0;
// let sendDataLoop;
// const offerOptions = {
//   offerToReceiveAudio: 1,
//   offerToReceiveVideo: 0,
//   voiceActivityDetection: false
// };

// let localAudio = document.querySelector('div#local audio');
// let remoteAudio = document.querySelector('audio#audio2');
// let number

// export async function getMedia() {
//     localAudio = document.querySelector('div#local audio');
//     remoteAudio = document.querySelector('audio#audio2');

//     if (localStream) {
//         localStream.getTracks().forEach(track => track.stop())
//     }

//     try {
//         const userMedia = await navigator.mediaDevices.getUserMedia(
//         {
//         audio: true,
//         }
//         );
//         console.log(userMedia)
//         gotStream(userMedia)
//     } catch(e) {
//         console.log(e)
//     }

// }

// function gotStream(stream) {
//     console.log('Received local stream');
//     console.log(stream)
//     // localAudio.srcObject = stream;
//     localStream = stream;
//     const audioTracks = localStream.getAudioTracks();
//     if (audioTracks.length > 0) {
//         console.log(`Using Audio device: ${audioTracks[0].label}`);
//     }
//     localStream.getTracks().forEach(track => localPeerConnection.addTrack(track, localStream));
// }

// export function createPeerConnection(number) {
//     number = number
//     console.log('Starting call');
//     const audioTracks = localStream.getAudioTracks();

//     if (audioTracks.length > 0) {
//         console.log(`Using audio device: ${audioTracks[0].label}`);
//     }
//     const servers = {
//       iceServers: [
//         {
//             urls: 'turn:boskierp.pl:3478',
//             username: 'donwiktorb',
//             credential: 'NEW'
//         }
//     ]

//     };

//     // const servers = null

//     localPeerConnection = new RTCPeerConnection(servers);
//     console.log('Created local peer connection object localPeerConnection');

//     localPeerConnection.onicecandidate = e => onIceCandidate(localPeerConnection, e);

//     sendChannel = localPeerConnection.createDataChannel('sendDataChannel', dataChannelOptions);
//     sendChannel.onopen = onSendChannelStateChange;
//     sendChannel.onclose = onSendChannelStateChange;
//     sendChannel.onerror = onSendChannelStateChange;

//     remotePeerConnection = new RTCPeerConnection(servers);

//     console.log('Created remote peer connection object remotePeerConnection');

//     remotePeerConnection.onicecandidate = e => onIceCandidate(remotePeerConnection, e);
//     remotePeerConnection.ontrack = gotRemoteStream;
//     remotePeerConnection.ondatachannel = receiveChannelCallback;

//     localStream.getTracks()
//         .forEach(track => localPeerConnection.addTrack(track, localStream));
//     console.log('Adding Local Stream to peer connection');
// }

// function onSetSessionDescriptionSuccess() {
//   console.log('Set session description success.');
// }

// function onSetSessionDescriptionError(error) {
//   console.log(`Failed to set session description: ${error.toString()}`);
// }

// export async function createOffer() {
//   try {
//     const offer = await localPeerConnection.createOffer(offerOptions);
//     return offer
//     // gotDescription1(offer);
//   } catch (e) {
//     onCreateSessionDescriptionError(e);
//   }
// }

// function onCreateSessionDescriptionError(error) {
//   console.log(`Failed to create session description: ${error.toString()}`);
// }

// export async function setOffer(sdp2) {
//   // Restore the SDP from the textarea. Ensure we use CRLF which is what is generated
//   // even though https://tools.ietf.org/html/rfc4566#section-5 requires
//   // parsers to handle both LF and CRLF.
//   const sdp = sdp2
//       .split('\n')
//       .map(l => l.trim())
//       .join('\r\n');
//   const offer = {
//     type: 'offer',
//     sdp: sdp
//   };
//   console.log(`Modified Offer from localPeerConnection\n${sdp}`);

//   try {
//     // eslint-disable-next-line no-unused-vars
//     const ignore = await localPeerConnection.setLocalDescription(offer);
//     onSetSessionDescriptionSuccess();
//   } catch (e) {
//     onSetSessionDescriptionError(e);
//     // return;
//   }

//   try {
//     // eslint-disable-next-line no-unused-vars
//     const ignore = await remotePeerConnection.setRemoteDescription(offer);
//     onSetSessionDescriptionSuccess();
//   } catch (e) {
//     onSetSessionDescriptionError(e);
//     // return;
//   }
//   return
// }

// function gotDescription1(description) {
// }

// export async function createAnswer() {
//   // Since the 'remote' side has no media stream we need
//   // to pass in the right constraints in order for it to
//   // accept the incoming offer of audio and video.
//   try {
//     const answer = await remotePeerConnection.createAnswer();
//     // gotDescription2(answer);
//     return answer
//   } catch (e) {
//     onCreateSessionDescriptionError(e);
//   }
// }

// export async function setAnswer(sdp2) {
//   // Restore the SDP from the textarea. Ensure we use CRLF which is what is generated
//   // even though https://tools.ietf.org/html/rfc4566#section-5 requires
//   // parsers to handle both LF and CRLF.
//   const sdp = sdp2
//       .split('\n')
//       .map(l => l.trim())
//       .join('\r\n');

//   const answer = {
//     type: 'answer',
//     sdp: sdp
//   };

//   try {
//     // eslint-disable-next-line no-unused-vars
//     const ignore = await remotePeerConnection.setLocalDescription(answer);
//     onSetSessionDescriptionSuccess();
//   } catch (e) {
//     onSetSessionDescriptionError(e);
//     // return;
//   }

//   console.log(`Modified Answer from remotePeerConnection\n${sdp}`);
//   try {
//     // eslint-disable-next-line no-unused-vars
//     const ignore = await localPeerConnection.setRemoteDescription(answer);
//     onSetSessionDescriptionSuccess();
//   } catch (e) {
//     onSetSessionDescriptionError(e);
//     // return;
//   }

//   return
// }

// function gotDescription2(description) {
// }

// function sendData() {
//   if (sendChannel.readyState === 'open') {
//     sendChannel.send(dataChannelCounter);
//     console.log(`DataChannel send counter: ${dataChannelCounter}`);
//     dataChannelCounter++;
//   }
// }

// export function hangup() {
//   remoteAudio.srcObject = null;
//   console.log('Ending call');
//   localStream.getTracks().forEach(track => track.stop());
//   sendChannel.close();
//   if (receiveChannel) {
//     receiveChannel.close();
//   }
//   localPeerConnection.close();
//   remotePeerConnection.close();
//   localPeerConnection = null;
//   remotePeerConnection = null;
// }

// function gotRemoteStream(e) {
//     if (remoteAudio.srcObject !== e.streams[0]) {
//         remoteAudio.srcObject = e.streams[0];
//         console.log('Received remote stream');
//     }
// }

// function getOtherPc(pc) {
//   return (pc === localPeerConnection) ? remotePeerConnection : localPeerConnection;
// }

// function getName(pc) {
//   return (pc === localPeerConnection) ? 'localPeerConnection' : 'remotePeerConnection';
// }

// export function AddCandidate(candidate) {
//     localPeerConnection.addIceCandidate(candidate)
//     remotePeerConnection.addIceCandidate(candidate)
// }

// async function onIceCandidate(pc, event) {
//   try {
//     // eslint-disable-next-line no-unused-vars
//     const ignore = await getOtherPc(pc).addIceCandidate(event.candidate);
//     sendMessage('phone_new_candidate', {
//         candidate: event.candidate,
//         number: number
//     })

//     onAddIceCandidateSuccess(pc);
//   } catch (e) {
//     onAddIceCandidateError(pc, e);
//   }

//   console.log(`${getName(pc)} ICE candidate:\n${event.candidate ? event.candidate.candidate : '(null)'}`);
// }

// function onAddIceCandidateSuccess() {
//   console.log('AddIceCandidate success.');
// }

// function onAddIceCandidateError(error) {
//   console.log(`Failed to add Ice Candidate: ${error.toString()}`);
// }

// function receiveChannelCallback(event) {
//   console.log('Receive Channel Callback');
//   receiveChannel = event.channel;
//   receiveChannel.onmessage = onReceiveMessageCallback;
//   receiveChannel.onopen = onReceiveChannelStateChange;
//   receiveChannel.onclose = onReceiveChannelStateChange;
// }

// function onReceiveMessageCallback(event) {
//   dataChannelDataReceived = event.data;
//   console.log(`DataChannel receive counter: ${dataChannelDataReceived}`);
// }

// function onSendChannelStateChange() {
//   const readyState = sendChannel.readyState;
//   console.log(`Send channel state is: ${readyState}`);
//   if (readyState === 'open') {
//     sendDataLoop = setInterval(sendData, 1000);
//   } else {
//     clearInterval(sendDataLoop);
//   }
// }

// function onReceiveChannelStateChange() {
//   const readyState = receiveChannel.readyState;
//   console.log(`Receive channel state is: ${readyState}`);
// }
