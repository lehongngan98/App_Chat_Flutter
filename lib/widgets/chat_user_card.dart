import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {    
    return InkWell(
        onTap: () {},
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: mq.width * .04 , vertical: 5),          
          elevation: 0.5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          child: const ListTile(
              leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
              title: const Text('Le Hong Ngan'),
              subtitle: const Text('Last user message'),
              trailing:
                  const Text('12:00 PM', style: TextStyle(color: Colors.grey))),
        ));
  }
}
