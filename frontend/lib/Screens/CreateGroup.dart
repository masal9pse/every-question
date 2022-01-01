import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/CustomUI/AvatarCard.dart';
import 'package:frontend/CustomUI/ButtonCard.dart';
import 'package:frontend/CustomUI/ContactCard.dart';
import 'package:frontend/Model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack developer"),
    ChatModel(name: "Balram", status: "Flutter Developer..........."),
    ChatModel(name: "Saket", status: "Web developer..."),
    ChatModel(name: "Bhanu Dev", status: "App developer...."),
    ChatModel(name: "Collins", status: "Raect developer.."),
    ChatModel(name: "Kishor", status: "Full Stack Web"),
    ChatModel(name: "Testing1", status: "Example work"),
    ChatModel(name: "Testing2", status: "Sharing is caring"),
    ChatModel(name: "Divyanshu", status: "....."),
    ChatModel(name: "Helper", status: "Love you Mom Dad"),
    ChatModel(name: "Tester", status: "I find the bugs"),
  ];
  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Contact',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Add participants', style: TextStyle(fontSize: 13)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 26)),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      if (contacts[index].select == false) {
                        setState(() {
                          contacts[index].select = true;
                          groups.add(contacts[index]);
                        });
                      } else {
                        setState(() {
                          contacts[index].select = false;
                          groups.remove(contacts[index]);
                        });
                      }
                    },
                    child: ContactCard(contact: contacts[index]));
              }),
          groups.length > 0 ? Column(
            children: [
              Container(
                height: 75,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0){
                      return Container(height: groups.length > 0 ? 90:10);
                    }
                    if (contacts[index-1].select == true) {
                      return InkWell(
                          onTap: () {
                            groups.remove(contacts[index-1]);
                            contacts[index-1].select = false;
                          },
                          child: AvtarCard(contact: contacts[index-1]));
                    } else {
                      return Container();
                    }
                  },
                  itemCount: contacts.length,
                ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          ): Container(),
        ],
      ),
    );
  }
}
