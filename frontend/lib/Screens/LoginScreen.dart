import 'package:flutter/material.dart';
import 'package:frontend/CustomUI/ButtonCard.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:frontend/Screens/HomeScreen.dart';
import 'package:frontend/Screens/QuestionPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatModel = [
    ChatModel(
        name: 'dev stack',
        isGroup: false,
        currentMessage: 'Hi Everyone',
        time: '4:00',
        id: 1),
    ChatModel(
        name: 'Kishor',
        isGroup: false,
        currentMessage: 'Hi Kishor',
        time: '10:00',
        id: 2),
    ChatModel(
        name: 'masato',
        isGroup: false,
        currentMessage: 'Hi Everyone',
        time: '4:00',
        icon: 'person.svg',
        id: 3),
    ChatModel(
        name: 'dev server chat',
        isGroup: true,
        currentMessage: 'Hi body',
        time: '4:00',
        id: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // height: 200,
        child: Column(
          children: [
            Container(
              // ListView.builderなどの高さが動的に変化するwidgetのしたに追加するときは、ListViewの高さを指定する
              height: 300,
              child: ListView.builder(
                itemCount: chatModel.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    sourceChat = chatModel.removeAt(index);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => Homescreen(
                                chatModels: chatModel,
                                sourceChat: sourceChat)));
                  },
                  child: ButtonCard(
                      name: chatModel[index].name, icon: Icons.person),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(onSurface: Colors.red),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => QuestionPage(),
                  ),
                );
              },
              child: Text('ユーザー１でログインする'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(onSurface: Colors.blue),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => QuestionPage(),
                  ),
                );
              },
              child: Text('ユーザー２でログインする。'),
            )
          ],
        ),
      ),
    );
  }
}
