import sendMessage from "./Api"

class WebRTC {
    constructor() {
        this.offerOptions = {
            mediaStreamConstraints: {
                audio: true,  // Request audio only
                video: false  // Do not request video
            }
        }
        this.pc = null
        this.localStream = null
        this.targetNumber = null
        // const configuration = {'iceServers': [{'urls': 'stun:stun.l.google.com:19302'}]}
        // const configuration = {
        // iceServers: [
        //     {
        //     urls: ['turn:boskierp.pl:3478', 'stun:boskierp.pl:3478'],
        //     username: 'donwiktorb',
        //     credential: 'NEW'
        //     }
        // ]
        // };
        this.config = null
        this.candidateBuffer = []
    }

    async signalServer(name, data) {
        data.number = this.targetNumber
        const res = await sendMessage(name, data)
    }

    async setAnswer(answer) {
        const remoteDesc = new RTCSessionDescription(answer);
        // console.log('SET ANSWER (4)', answer, remoteDesc)
        await this.pc.setRemoteDescription(remoteDesc);
        this.candidateBuffer.forEach(async (candidate) => {
            // console.log("ADDING CANDIDATE ", candidate)
            await this.addCandidate(candidate);
        });
        this.candidateBuffer = []
    }

    async createOffer() {
        const offer = await this.pc.createOffer();
        await this.pc.setLocalDescription(offer);
        // console.log('CREATE OFFER (1)', offer)
        this.signalServer('phone_send_offer', {
            offer: offer
        })
    }

    async setOffer(offer) {
        // console.log('SET OFFER (2)', offer)
        this.pc.setRemoteDescription(new RTCSessionDescription(offer));
        const answer = await this.pc.createAnswer();
        await this.pc.setLocalDescription(answer);
        // console.log('SET OFFER (3)', answer)
        this.candidateBuffer.forEach(async (candidate) => {
            // console.log("ADDING CANDIDATE ", candidate)
            await this.addCandidate(candidate);
        });
        this.candidateBuffer = []
        this.signalServer('phone_send_answer', {
            answer: answer
        })
    }

    async addCandidate(iceCandidate) {
        if (this.pc.remoteDescription) {
            if (iceCandidate) {
                try {
                    // console.log('ADD CANDIDATE (5)', iceCandidate)
                    const iceCandidate2 = new RTCIceCandidate(iceCandidate);
                    await this.pc.addIceCandidate(iceCandidate2);
                } catch (e) {
                    console.log('Error adding received ice candidate', e);
                }
            }
        } else {
            const iceCandidate2 = new RTCIceCandidate(iceCandidate);
            this.candidateBuffer.push(iceCandidate2);
        }
    }


    async getMedia() {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
            stream.getTracks().forEach(track => this.pc.addTrack(track, stream));
            document.getElementById('localAudio').srcObject = stream;
            this.localStream = stream;
        } catch (error) {
            console.error('Error getting media:', error);
        }
    }


    hangup() {
        try {

            this.localStream?.getTracks().forEach(track => {
                track.stop()
                this.localStream.removeTrack(track)
                this.pc.getSenders().forEach((v) => {
                    this.pc.removeTrack(v)
                })
            });

            this.pc?.close()
            this.pc = null
            let doc = document.getElementById('remoteAudio')
            doc.srcObject = null
        } catch (e) {
            console.log(e)
        }
    }


    async start(number, cb) {
        this.targetNumber = number
        this.pc = new RTCPeerConnection(this.config)

        this.pc.addEventListener("connectionstatechange", (event) => {
            console.log(this.pc.connectionState)
        }, false,);

        this.pc.addEventListener("icecandidate", (event) => {
            // console.log("CANDIDATE ", event, event.candidate)
            if (event.candidate !== null) {
                this.signalServer('phone_new_candidate', {
                    candidate: event.candidate,
                })
            }
        });

        this.pc.addEventListener("icecandidateerror", (event) => {
            // if (event.errorCode === 701) {
            console.log('icecandidateerror', event, event.errorCode)
            // }
        });

        this.pc.addEventListener("iceconnectionstatechange", (ev) => {
            console.log(this.pc.iceConnectionState)
        }, false,);

        this.pc.addEventListener("icegatheringstatechange", (ev) => {
            let connection = ev.target;
            console.log(connection.iceGatheringState)
        }, false,);

        this.pc.addEventListener("negotiationneeded", (ev) => {
            console.log("NEG NEEDED", ev)
            // this.pc.createOffer()
            // .then((offer) => this.pc.setLocalDescription(offer))
            // .then(() =>
            //     this.signalServer('phone_send_offer', {
            //         offer: this.pc.localDescription
            //     })
            // )
            // .catch((err) => {
            //     console.log(err)
            // });
        }, false,);

        this.pc.addEventListener("signalingstatechange", (ev) => {
            console.log(this.pc.signalingState)
        }, false,);

        this.pc.addEventListener('track', async (event) => {
            const [remoteStream] = event.streams;
            document.getElementById('remoteAudio').srcObject = remoteStream
        });

        await this.getMedia()

        if (cb) cb()
    }
}

export default new WebRTC()
