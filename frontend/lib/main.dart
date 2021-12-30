import 'package:flutter/material.dart';
import 'package:frontend/Screens/HomeScreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen()
    );
  }
  late IO.Socket socket;
  void connect (){
    socket = IO.io('http://192.168.1.14:5000',<String,dynamic> {
      'transports':['websocket'],
      'autoConnect': false
    });
    socket.connect();
    // socket.onConnect((data) => print('connected'));
    socket.onConnect((data) {
      print('connected');
      print(data);
    });
    print(socket.connected);
    socket.emit('/test','hello world');
    // socket.on('/test', (data) => );
  }
}