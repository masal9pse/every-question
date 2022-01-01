import 'package:flutter/material.dart';
import 'package:frontend/Model/ChatModel.dart';

class AvtarCard extends StatelessWidget {
  const AvtarCard({ Key? key,required this.contact }) : super(key: key);
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blueGrey,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 11,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 2),
          Text(contact.name,style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}