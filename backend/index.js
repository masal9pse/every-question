const express = require('express');
var http = require('http');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
// チュートリアルでは2.3
var io = require('socket.io')(server,{
    cors: {
        origin:'*'
    }
});

// middleware
app.use(express.json());
app.use(cors());

io.on('connection',(socket) => {
  console.log('connected');
});
// 192.168.1.14
server.listen(port,0,0,0,0,() => {
    console.log('server started');
});