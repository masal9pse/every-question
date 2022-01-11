import 'dart:math';

import 'package:flutter/material.dart';

class QuestionState extends ChangeNotifier {
  static List<Map<String, dynamic>> questions = [
    {
      'title': 'この中でナルトに登場しない人物は？',
      'questions': ['ダンゾウ', 'サスケ', 'ルフィ', 'ネジ'],
      'ans': 3,
      'isAns': false,
    },
    {
      'title': 'six invitational 2019の優勝チームは？',
      'questions': ['Liquid', 'FAZE', 'G2', 'PENTA'],
      'ans': 3,
      'isAns': false,
    },
    {
      'title': 'penguといえば？',
      'questions': [
        'めっちゃリスキルする',
        'めっちゃラペリングする',
        '彼女がいない',
        'six invitational 2020で優勝している'
      ],
      'ans': 1,
      'isAns': false,
    },
  ];

  // int num = 0; 0 ~ 2の乱数
  int randomNumber = Random().nextInt(questions.length);

  void changeQuestion() {
    questions[randomNumber]['isAns'] = true;

    // 最適化など問題がありそうだが、一旦これにする。
    // まずisAnsがtrueのオブジェクトを削除する。IteratorになっているのでListに直そう。
    final createNoAnsList =
        questions.where((element) => !element['isAns']).toList();

    // それ以外のオブジェクトをシャッフルして１番目を取り出す。
    createNoAnsList.shuffle();
    print(createNoAnsList.first);

    // questionsと比較して同じオブジェクトの配列の要素番号を取り出し、randomNumberに代入
    final noAnsRandomNumber = questions.indexOf(createNoAnsList.first);
    randomNumber = noAnsRandomNumber;
    notifyListeners();
  }
}
// ChangeNotifierProvider<QuestionState>(
// create: (context) => QuestionState(),
// ),
