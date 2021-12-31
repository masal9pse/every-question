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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                      margin: EdgeInsets.only(left: 2,right: 2,bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type a message',
                          prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions)),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(onPressed: null, icon: Icon(Icons.attach_file)),
                              IconButton(onPressed: null, icon: Icon(Icons.camera_alt)),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8,right: 2),
                    child: CircleAvatar(
                      radius: 25,
                      child: IconButton(onPressed: null, icon: Icon(Icons.mic)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
