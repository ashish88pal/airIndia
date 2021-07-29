import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

import '../models/travelMsgModel.dart';

class TravelMsgList extends StatelessWidget {
  final List<TravelMsgModel> messages;
  final String friendId;
  TravelMsgList({this.messages, this.friendId});

  @override
  Widget build(BuildContext context) {
    if (messages.length == 0) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Image.asset('images/airIndiaLogo.png', height: 200),
          ),
        ),
      );
    }

    return Expanded(
        child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              bool isSent = messages[index].senderId != friendId;
              return isSent
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Bubble(
                            nip: BubbleNip.no,
                            alignment: Alignment.bottomRight,
                            // color: isSent ? Color(0xFFE7C4BE) : Colors.blue.shade800,
                            padding: BubbleEdges.all(8),
                            margin: BubbleEdges.all(5),
                            radius: Radius.circular(20),
                            borderColor: Colors.orange,
                            borderWidth: 2,
                            shadowColor: Colors.orange,
                            elevation: 5,
                            child: Text(messages[index].messageBody,
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 20)),
                          ),
                        ),
                        // Icon(
                        //   Icons.person_outline,
                        //   color: Colors.orange,
                        // ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Bubble(
                            nip: BubbleNip.no,
                            alignment: Alignment.topLeft,
                            // color: isSent ? Color(0xFFE7C4BE) : Colors.blue.shade800,
                            padding: BubbleEdges.all(15),
                            margin: BubbleEdges.all(5),
                            radius: Radius.circular(20),
                            borderColor: Colors.grey.shade500,
                            borderWidth: 2,
                            shadowColor: Colors.grey.shade500,
                            elevation: 5,
                            child: Text(messages[index].messageBody,
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 20)),
                          ),
                        )
                      ],
                    );
            }));
  }
}
