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
var front = {};
io.on('connection',(socket) => {
  console.log('connected');
  console.log(socket.id,'has joiend');

  // 仕組み
  // ログインすると連想配列に、ログインid(sourceId)をキーにsocketをvalueにした値をいれる。
  // 投稿するとmessageソケットを受け取り、メッセージからtargetIdを取得。
  // すでにclientsにはログインidをキーにした値があるので、clients[targetId]
  // で43行目のtargetIdと同じなので同じキーになりif文が実行される。
  // jsでは1以上ならtrueとして扱われる。

  socket.on('signIn',(id) => {
    console.log(id);
    clients[id] = socket;
    console.log('サインイン')
    console.log(clients);
  });

  socket.on('message',(msg) => {
    console.log(msg);
    let targetId = msg.targetId;
    console.log('message.onでのclientsの取得')
    console.log(clients)
    console.log('ターゲットId');
    console.log(clients[targetId]);

    if(clients[targetId]) {
        clients[targetId].emit('message',msg);
        console.log('正しい結果');
    } else {
        console.log('間違い')
    }
  });

  socket.on('q-login',(myId) => {
    console.log(myId);
    front[myId] = socket;
    console.log('サインインです')
    console.log(front);
  });

  socket.on('answer',(ans) => {
    console.log(ans);
    // let targetId = ans.targetId;
    let targetId = ans.targetId;
    console.log('message.onでのclientsの取得です')
    console.log(front)
    console.log('ターゲットIdです');
    console.log(front[targetId]);

    if(front[targetId]) {
        // あとで、不正解パターンもやる。
        // なぜかタップしたユーザにはこの処理は発火されない
        front[targetId].emit('answer',ans);
        console.log('正しい結果です');
    } else {
        console.log('間違いです')
    }
  });
});
// 192.168.1.14
server.listen(port,'0.0.0.0',() => {
    console.log('server started');
});