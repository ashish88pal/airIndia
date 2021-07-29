import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/models/travelerModel.dart';
import 'package:untitled3/viewModel/ChatViewModel.dart';
import '../widgets/tarvelMsgList.dart';

class ChatView extends StatefulWidget {
  final TravelerModel friend;
  final TravelerModel currentUser;
  ChatView({@required this.friend, @required this.currentUser});
  final List<String> preWrittenMessages = [
    "How are you?",
    "Hello",
    "Would you like to have a business chat?",
    "Good morning",
    "Thanks for connecting",
    "Thank you"
  ];
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageBodyController = TextEditingController();

  @override
  void initState() {
    context
        .read<ChatViewModel>()
        .listenToMsg(widget.friend.id, widget.currentUser.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool portrait = orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(
              icon: Icon(
                CupertinoIcons.xmark,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        backgroundColor: Colors.white,
        elevation: 2,
        toolbarHeight: portrait ?80 : 50,
        shadowColor: Colors.grey,
        title:

        portrait ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.friend.name,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "  " + widget.friend.code,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  widget.friend.position,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                ),
                Text(
                  widget.friend.company,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
                )
              ],
            )
          ],
        ) :
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Text(
                  widget.friend.name,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "  " + widget.friend.code,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  widget.friend.position,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.friend.company,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
                )
              ],
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TravelMsgList(
              messages: Provider.of<ChatViewModel>(context).messages,
              friendId: widget.friend.id,
            ),
            Container(
                height: 55,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.preWrittenMessages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Bubble(
                            padding: BubbleEdges.all(5),
                            margin: BubbleEdges.all(1),
                            radius: Radius.circular(20),
                            child: InkWell(

                              onTap: () {
                                context.read<ChatViewModel>().sendMsg(
                                    widget.preWrittenMessages[index],
                                    widget.friend.id,
                                    widget.currentUser);
                              },
                              child: Center(
                                  child: Text(widget.preWrittenMessages[index],
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20))),
                            ),
                            borderWidth: 2,
                            borderColor: Colors.blue,
                          ));
                    })),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: TextField(
                            maxLines: null,
                            controller: _messageBodyController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tap to type',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageBodyController.text.isEmpty) {
                        return;
                      }
                      context.read<ChatViewModel>().sendMsg(
                          _messageBodyController.text.trim(),
                          widget.friend.id,
                          widget.currentUser);
                      _messageBodyController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
