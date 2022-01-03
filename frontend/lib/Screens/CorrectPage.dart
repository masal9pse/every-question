import 'package:flutter/material.dart';

class CorrectPage extends StatelessWidget {
  const CorrectPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('正解です'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(onSurface: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}