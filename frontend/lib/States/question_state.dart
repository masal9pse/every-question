import 'package:flutter/material.dart';

class QuestionState extends ChangeNotifier {
  static List<Map<String, dynamic>> questions = [
    {
      'title': 'この中でナルトに登場しない人物は？',
      'questions': ['ダンゾウ', 'サスケ', 'ルフィ', 'ネジ'],
      'ans': 3,
    },
    {
      'title': 'six invitational 2019の優勝チームは？',
      'questions': ['Liquid', 'FAZE', 'G2', 'PENTA'],
      'ans': 3,
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
    },
  ];
  int num = 0;
  void changeQuestion(){
    if (questions.length - 1 > num){
      num ++;
    }
   notifyListeners();
  }
}
// ChangeNotifierProvider<QuestionState>(
// create: (context) => QuestionState(),
// ),