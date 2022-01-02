const express = require('express');
var http = require('http');
const cors = require('cors');
const { Collection } = require('mongoose');
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require('socket.io')(server);
// チュートリアルでは2.3
// var io = require('socket.io')(server,{
//     cors: {
//         origin:'*'
//     }
// });

// middleware
app.use(express.json());
// app.use(cors());
var clients = {};
io.on('connection',(socket) => {
  console.log('connected');
  console.log(socket.id,'has joiend');

  socket.on('signIn',(id) => {
    console.log(id);
    clients[id] = socket;
    console.log(clients);
  });

  socket.on('message',(msg) => {
    console.log(msg);
    let targetId = msg.targetId;
    if(clients[targetId]) clients[targetId].emit('message',msg);
  });
});
// 192.168.1.14
server.listen(port,'0.0.0.0',() => {
    console.log('server started');
});