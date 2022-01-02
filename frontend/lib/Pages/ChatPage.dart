import 'package:flutter/material.dart';
import 'package:frontend/CustomUI/CustomCard.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:frontend/Screens/SelectContact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key,required this.chatModels,required this.sourceChat}) : super(key: key);
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // List<ChatModel> chats = [
  //   ChatModel(
  //       name: 'dev stack',
  //       isGroup: false,
  //       currentMessage: 'Hi Everyone',
  //       time: '4:00'),
  //   ChatModel(
  //       name: 'Kishor',
  //       isGroup: false,
  //       currentMessage: 'Hi Kishor',
  //       time: '10:00'),
  //   ChatModel(
  //       name: 'masato',
  //       isGroup: false,
  //       currentMessage: 'Hi Everyone',
  //       time: '4:00',
  //       icon: 'person.svg'),
  //   ChatModel(
  //       name: 'dev server chat',
  //       isGroup: true,
  //       currentMessage: 'Hi body',
  //       time: '4:00'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(Icons.chat),
      ),
      // Listの値を動的にしたい場合はbuilderを使う
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomCard(
            chatModel: widget.chatModels[index], sourceChat: widget.sourceChat,
          );
        },
      ),
    );
  }
}
