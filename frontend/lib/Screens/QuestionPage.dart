import 'package:flutter/material.dart';
import 'package:frontend/Config/quetion_data.dart';
import 'package:frontend/Screens/CorrectPage.dart';
import 'package:frontend/ViewModel/question_state.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:math';

class QuestionModel {
  QuestionModel({
    required this.myId,
    required this.targetId,
    // required this.quetionId,
    // required this.ansId,
  });

  int myId;
  int targetId;

  // int quetionId;
  // int ansId;
}

class QuestionPage extends StatelessWidget {
  // QuestionPage({Key? key, required this.questionModel,required this.randomQuestionNumber}) : super(key: key);
  QuestionPage({Key? key, required this.questionModel}) : super(key: key);

  // QuestionPage({Key? key}) : super(key: key);
  final QuestionModel questionModel;
  late IO.Socket socket;

  void connect(BuildContext context) {
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
      // なぜかタップしたユーザにはこの処理は発火されない
      socket.on('answer', (msg) {
        print('サーバーからemitした値:: $msg');
        // setMessage('destination', msg['message']);
        ansCorrect(context);
      });
    });
    print(socket.connected);
    // print('id::  ${widget.sourceChat.id}');
    socket.emit('q-login', questionModel.myId);
    // socket.on('/test', (data) => );
  }

  void ansCorrect(BuildContext context) {
    print('正解です。　これはタップを押さなかったユーザーの処理です。');
    // エラーがでる。
    //   Navigator.push(context, MaterialPageRoute(builder: (builder) => CorrectPage()));
    // https://nobushiueshi.com/flutterinitstate%e3%81%a7%e7%94%bb%e9%9d%a2%e9%81%b7%e7%a7%bb%e3%81%99%e3%82%8b%e6%96%b9%e6%b3%95/
    Future(
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CorrectPage();
            },
          ),
        );
      },
    );
  }

  void ansCorrect2(BuildContext context) {
    print('正解です これはタップしたユーザーの処理です。');
    Future(
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => CorrectPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = QuestionState.questions;
    // final int randomQuestionNumber = context;
    // あとでランダムに戻す。
    // ランダムにしつつ同じ問題を出題しないようにする。
    // connect(context);
    final randomQuestionNumber = context.select((QuestionState store) => store.randomNumber);
    return Scaffold(
      body: Container(
        child: Consumer<QuestionState>(builder: (context, model,child) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('ナルトに出ない登場人物は？'),
                  Text('まさとだよ'),
                  Text(questions[randomQuestionNumber]['title']),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(onSurface: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('戻る'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(onSurface: Colors.red),
                    onPressed: () {},
                    // child: Text('ナルト'),
                    child: Text(questions[randomQuestionNumber]['questions'][0]),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(onSurface: Colors.blue),
                    onPressed: () {
                      // socket.emit('answer', {'myId': 1, 'ansId': 2});
                      socket.emit('answer', {
                        'myId': questionModel.myId,
                        'targetId': questionModel.targetId
                      });
                      ansCorrect2(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (builder) => CorrectPage()));
                    },
                    // child: Text('ルフィ'),
                    child: Text(questions[randomQuestionNumber]['questions'][1]),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(onSurface: Colors.red),
                    onPressed: () {
                      model.changeQuestion();
                    },
                    // child: Text('ネジ'),
                    child: Text(questions[randomQuestionNumber]['questions'][2]),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(onSurface: Colors.blue),
                    onPressed: null,
                    // child: Text('サスケ'),
                    child: Text(questions[randomQuestionNumber]['questions'][3]),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
