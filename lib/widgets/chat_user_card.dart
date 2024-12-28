import 'package:app_chat/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/main.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

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
          child:  ListTile(
              leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
              title: Text(widget.user.name ?? ''),
              subtitle:  Text(widget.user.about ?? ''),
              trailing:
                  const Text('12:00 PM', style: TextStyle(color: Colors.grey))),
        ));
  }
}
