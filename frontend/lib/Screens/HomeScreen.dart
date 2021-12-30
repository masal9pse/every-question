import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

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
          IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
        ],
        bottom: TabBar(
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
        Text('chats'),
        Text('status'),
        Text('calls'),
      ],
      controller: _controller),
    );
  }
}