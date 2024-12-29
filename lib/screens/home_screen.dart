import 'package:app_chat/api/apis.dart';
import 'package:app_chat/models/chat_user.dart';
import 'package:app_chat/screens/profile_screen.dart';
import 'package:app_chat/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _list = [];

  // for storing searching items
  final List<ChatUser> _searchList = [];

  // for storing searching status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        title: _isSearching
            ? TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name, Email,...',
                ),
                autofocus: true,
                style: TextStyle(fontSize: 17, letterSpacing: 0.5),
                onChanged: (value) {
                  _searchList.clear();

                  for (var i in _list) {
                    if (i.name!.toLowerCase().contains(value.toLowerCase()) ||
                        i.email!.toLowerCase().contains(value.toLowerCase())) {
                      _searchList.add(i);
                    }

                    setState(() {
                      _searchList;
                    });
                  }
                },
              )
            : Text('App Chat'),
        actions: [
          IconButton(
            icon: Icon(_isSearching
                ? CupertinoIcons.clear_thick_circled
                : CupertinoIcons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfileScreen(user: APIs.me)));
            },
          ),
        ],
      ),

      // Floating action button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () {}, child: Icon(Icons.add_comment_rounded)),
      ),

      body: StreamBuilder(
        //
        stream: APIs.getAllUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            // if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              // convert data to list of ChatUser
              _list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              // check if list is not empty
              if (_list.isNotEmpty) {
                return ListView.builder(
                  itemCount: _isSearching ? _searchList.length : _list.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(
                        user: _isSearching ? _searchList[index] : _list[index]);
                  },
                );
              } else {
                return const Center(
                    child:
                        Text('No user found', style: TextStyle(fontSize: 20)));
              }
          }
        },
      ),
    );
  }
}
