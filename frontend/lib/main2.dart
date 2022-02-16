import 'package:flutter/material.dart';
import 'package:frontend/ViewModel/question_state.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  static const navigateToDetailsButtonKey = Key('navigateToDetails');
  void _navigateToDetailsPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => DetailsPage('Hello!'));
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing navigation'),
      ),
      body: Consumer<QuestionState>(        
        builder: (context, model,_) {
          return RaisedButton(
            key: navigateToDetailsButtonKey,
            onPressed: () => _navigateToDetailsPage(context),
            child: Text('Navigate to details page!'),
          );
        }
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  DetailsPage(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details page'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}