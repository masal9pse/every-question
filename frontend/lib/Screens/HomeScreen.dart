import 'package:flutter/material.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:frontend/Pages/ChatPage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key,required this.chatModels,required this.sourceChat}) : super(key: key);
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = TabController(length: 4, vsync: this,initialIndex: 0);
    _controller = TabController(length: 4, initialIndex: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('whatsapp clone'),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          // IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('new group'), value: 'new group'),
                PopupMenuItem(
                    child: Text('new broadcast'), value: 'new broadcast'),
                PopupMenuItem(
                    child: Text('whatsapp web'), value: 'whatsapp web'),
                PopupMenuItem(
                    child: Text('stared messages'), value: 'stared messages'),
                PopupMenuItem(child: Text('settings'), value: 'settings'),
              ];
            },
            onSelected: (value) {
              print(value);
            },
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: [
            Tab(
              icon: Icon(Icons.camera),
            ),
            Tab(
              text: 'chats',
            ),
            Tab(
              text: 'status',
            ),
            Tab(
              text: 'calls',
            ),
          ],
        ),
      ),
      body: TabBarView(children: [
        Text('camera'),
        ChatPage(chatModels:widget.chatModels, sourceChat: widget.sourceChat),
        Text('status'),
        Text('calls'),
      ], controller: _controller),
    );
  }
}
