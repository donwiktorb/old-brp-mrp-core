import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import reportWebVitals from './reportWebVitals';
import App from './App'

import ReactGA from "react-ga4";
const TRACKING_ID = "G-N5CPX1VKN1"; // OUR_TRACKING_ID
ReactGA.initialize(TRACKING_ID);

const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
    <React.StrictMode>
        <App />
    </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
// reportWebVitals();
function sendToAnalytics({ id, name, value }) {
    ReactGA.event({
    category: "webv",
    action: name,
    label: id, // optional
    value: Math.round(name === 'CLS' ? value * 1000 : value), // values must be integers
    nonInteraction: true, // optional, true/false
    transport: "xhr", // optional, beacon/xhr/image
    });
}

reportWebVitals(sendToAnalytics);
