import 'package:flutter/material.dart';
import 'package:frontend/Model/ChatModel.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(radius: 20),
            ],
          ),
        ),
        title: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.chatModel.name),
              Text(
                'last seen today at 12:05',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
        actions: [
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
      ),
    );
  }
}
