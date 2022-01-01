import 'package:flutter/material.dart';
import 'package:frontend/Model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key,required this.contact}) : super(key: key);
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.blueGrey,
        ),
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(contact.status!,
            style: TextStyle(
              fontSize: 13,
            )),
      ),
    );
  }
}
