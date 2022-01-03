import 'package:flutter/material.dart';
import 'package:frontend/CustomUI/OwnMessageCard.dart';
import 'package:frontend/CustomUI/ReplyCard.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:frontend/Model/MessageModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  late IO.Socket socket;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();

  void connect() {
    socket = IO.io('http://192.168.1.14:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket.connect();
    print(33333);
    // socket.onConnect((data) => print('connected'));
    socket.onConnect((data) {
      print('connected');
      print(data);
      socket.on('message', (msg) {
        print('サーバーからemitした値:: $msg');
        setMessage('destination', msg['message']);
      });
    });
    print(socket.connected);
    print('id::  ${widget.sourceChat.id}');
    socket.emit('signIn', widget.sourceChat.id);
    // socket.on('/test', (data) => );
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage('source', message);
    socket.emit('message',
        {'message': message, 'sourceId': sourceId, 'targetId': targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message);
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    connect();
    print(111);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
      body: Container(
        height: MediaQuery.of(context).size.height - 140,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    if (messages[index].type == 'source') {
                      return OwnMessageCard(message: messages[index].message);
                    } else {
                      return ReplyCard(message: messages[index].message);
                    }
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                      margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: TextFormField(
                        controller: _controller,
                        focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              sendButton = true;
                            });
                          } else {
                            setState(() {
                              sendButton = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message',
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.emoji_emotions)),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) => bottomSheet());
                                    },
                                    icon: Icon(Icons.attach_file)),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.camera_alt)),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      right: 2,
                      left: 2,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFF128C7E),
                      child: IconButton(
                        icon: Icon(
                          sendButton ? Icons.send : Icons.mic,
                          // sendButton ? Icons.mic : Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (sendButton) {
                            sendMessage(_controller.text, widget.sourceChat.id!,
                                widget.chatModel.id!);
                            // 送信したメッセージをクリアしてくれる。
                            _controller.clear();
                            setState(() {
                              sendButton = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(
                      Icons.insert_drive_file, Colors.indigo, 'Document'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.camera_alt, Colors.pink, 'Camera'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.insert_photo, Colors.purple, 'Gallery'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(Icons.headset, Colors.orange, 'Audio'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(
                      Icons.insert_drive_file, Colors.pink, 'Document'),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.insert_drive_file, Colors.blue, 'contact'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
