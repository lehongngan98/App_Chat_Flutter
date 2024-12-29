import 'package:app_chat/models/chat_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 5),
          elevation: 0.5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
              // user profile image
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .3),
                child: CachedNetworkImage(
                  imageUrl: widget.user.image ?? '',
                  height: mq.height * .055,
                  width: mq.height * .055,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),

              // user name
              title: Text(widget.user.name ?? ''),

              // user about
              subtitle: Text(widget.user.about ?? ''),

              // user last active time
              trailing: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.user.isOnline ?? false
                        ? Colors.green
                        : Colors.grey),
                ),
              ),
              // trailing:
              //     const Text('12:00 PM', style: TextStyle(color: Colors.grey))),
        ));
  }
}
