import 'package:flutter/material.dart';
import 'package:frontend/Model/ChatModel.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key,required this.name,required this.icon}) : super(key: key);
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.greenAccent,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
