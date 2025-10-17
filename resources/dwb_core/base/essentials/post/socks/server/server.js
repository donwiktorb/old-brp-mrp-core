const WebSocket = require("ws");

let cb = () => {};
let tries = 0;

function initHandlers() {
  let ws = new WebSocket("ws://localhost:34343/");
  ws.on("close", function clear() {
    tries++;
    if (tries <= 10)
      setTimeout(() => {
        ws = new WebSocket("ws://localhost:3434/");
        initHandlers();
      }, 4444);
  });
  ws.on("error", console.error);

  ws.on("open", function open() {
    //ws.send("something");
  });

  ws.on("message", function message(data) {
    console.log(data);
    const receivedBuffer = Buffer.from(data || []);

    // Convert buffer to string using UTF-8 encoding
    const stringData = receivedBuffer.toString("utf8");
    console.log(data, stringData);
    if (cb) setImmediate(() => cb(stringData));
  });
}

global.exports("ws_send", (data, cb) => {
  cb = cb;
  ws.send(data);
});

if (false) initHandlers();
