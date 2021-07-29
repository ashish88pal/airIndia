import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/services/CloudFirestoreServices.dart';

import '../models/travelMsgModel.dart';
import '../models/travelerModel.dart';

class ChatScreenn extends StatefulWidget {
  final TravelerModel you;
  final TravelerModel me;
  ChatScreenn({@required this.you, @required this.me});
  final CloudFirestoreServices _fst = CloudFirestoreServices();
  List<TravelMsgModel> _messages = [];
  List<TravelMsgModel> get messages => _messages;

  @override
  _ChatScreennState createState() => _ChatScreennState();

  Future sendMsg(String msgbody, String recieverId) async {
    final TravelMsgModel msg = TravelMsgModel(
      messageBody: msgbody,
      receiverId: recieverId,
      senderId: me.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _fst.createMsg(msg);
  }
}

class _ChatScreennState extends State<ChatScreenn> {
  final TextEditingController _messageBodyController = TextEditingController();

  void listenToMsg(String youId) {
    widget._fst.listenToMsgRealtime(youId, widget.me.id).listen((msgData) {
      List<TravelMsgModel> updatedMsg = msgData;
      if (updatedMsg != null && updatedMsg.length > 0) {
        widget._messages = updatedMsg;
        setState(() {});
      } else {}
    });
  }

  @override
  initState() {
    listenToMsg(widget.you.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          elevation: 1,
          toolbarHeight: 80,
          shadowColor: Colors.red,
          title: Row(
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
                        widget.you.name,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "  " + widget.you.code,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Text(
                    widget.you.position,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500),
                  ),
                  Text(
                    widget.you.company,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
                  )
                ],
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: widget.messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      bool isSent =
                          widget.messages[index].senderId != widget.you.id;
                      return ChatBubbleAlignment(
                        isSender: isSent,
                        msg: widget.messages[index].messageBody,
                      );
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
                      widget.sendMsg(
                          _messageBodyController.text.trim(), widget.you.id);
                      _messageBodyController.clear();
                      setState(() {});
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
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final Color color;
  final String msg;
  ChatBubble({this.color = Colors.orange, this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Center(
                child: Text(
              msg,
              style: TextStyle(
                fontSize: 20,
                color: color,
              ),
            )),
          ),
          decoration: BoxDecoration(
              // color: Colors.yellow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color, width: 2)),
        ),
      ),
    );
  }
}

class ChatBubbleAlignment extends StatelessWidget {
  bool isSender;
  final String msg;
  ChatBubbleAlignment({this.isSender, this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (!isSender)
            Icon(
              Icons.person_outline,
              color: Colors.grey.shade600,
            ),
          ChatBubble(
            color:
                isSender ? Colors.orangeAccent.shade200 : Colors.grey.shade600,
            msg: msg,
          )
        ],
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
