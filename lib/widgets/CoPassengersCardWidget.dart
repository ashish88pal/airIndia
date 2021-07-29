import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/models/travelerModel.dart';
import 'package:untitled3/viewModel/HomeViewModel.dart';

import '../views/ChatView.dart';

class CoPassengersCard extends StatefulWidget {
  final TravelerModel friend;
  final TravelerModel currentUser;
  final int status;
  CoPassengersCard({
    @required this.currentUser,
    @required this.friend,
    @required this.status,
  });

  @override
  _CoPassengersCardState createState() => _CoPassengersCardState();
}

class _CoPassengersCardState extends State<CoPassengersCard> {
  getWidget(status, data, portrait) {
    switch (status) {
      case 1:
        return portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        // context.read<HomeViewModel>().undoFriendRequestMV(widget.friend);
                        data.undoFriendRequestMV(widget.friend);
                      },
                      icon: Icon(
                        CupertinoIcons.refresh_bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text(
                    "Undo reqest",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Undo reqest",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          // context.read<HomeViewModel>().undoFriendRequestMV(widget.friend);
                          data.undoFriendRequestMV(widget.friend);
                        },
                        icon: Icon(
                          CupertinoIcons.refresh_bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      case 2:
        return portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        print(" connected");
                        setState(() {});
                      },
                      icon: Icon(
                        CupertinoIcons.checkmark_alt,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Text(
                    "Connected",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Connected",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          print(" connected");
                          setState(() {});
                        },
                        icon: Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      case 3:
        return portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        // context
                        //     .read<HomeViewModel>()
                        //     .sendFriendRequestMV(widget.friend);
                        //
                        // setState(() {});
                        data.sendFriendRequestMV(widget.friend);
                      },
                      icon: Icon(
                        CupertinoIcons.plus,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "Tap to connect",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Tap to connect",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          data.sendFriendRequestMV(widget.friend);
                        },
                        icon: Icon(
                          CupertinoIcons.plus,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );

      case 4:
        return portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconButton(
                          onPressed: () {
                            // context
                            //     .read<HomeViewModel>()
                            //     .cancelFriendRequestMV(widget.friend);
                            data.cancelFriendRequestMV(widget.friend);
                          },
                          icon: Icon(
                            CupertinoIcons.person_badge_minus,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconButton(
                          onPressed: () {
                            // context
                            //     .read<HomeViewModel>()
                            //     .acceptFriendRequestMV(widget.friend);
                            data.acceptFriendRequestMV(widget.friend);
                          },
                          icon: Icon(
                            CupertinoIcons.person_add,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Respond to request",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Respond to request",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // context
                        //     .read<HomeViewModel>()
                        //     .cancelFriendRequestMV(widget.friend);
                        data.cancelFriendRequestMV(widget.friend);
                      },
                      icon: Icon(
                        CupertinoIcons.person_badge_minus,
                        color: Colors.red,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // context
                        //     .read<HomeViewModel>()
                        //     .acceptFriendRequestMV(widget.friend);
                        data.acceptFriendRequestMV(widget.friend);
                      },
                      icon: Icon(
                        CupertinoIcons.person_add,
                        color: Colors.orange,
                      ),
                    ),

                  ],
                ),
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool portrait = orientation == Orientation.portrait;

    return Consumer<HomeViewModel>(
      builder: (BuildContext context, data, Widget child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: InkWell(
            onTap: () {
              if (widget.currentUser.connected.contains(widget.friend.id)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatView(
                      friend: widget.friend,
                      currentUser: widget.currentUser,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('${widget.friend.name} is not connected to you!'),
                  ),
                );
              }
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                 portrait ?
                 BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 5))  :
                 BoxShadow(
                     color: Colors.grey.shade300,
                     blurRadius: 10,
                     spreadRadius: 0,
                     offset: Offset(2, 5)),
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(2, 5))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: portrait
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.person_outline,
                              size: 35,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.friend.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " " + widget.friend.code,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
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
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              )
                            ],
                          ),
                          Spacer(),
                          getWidget(widget.status, data, portrait)
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.friend.name,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " " + widget.friend.code,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.friend.position,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade500),
                              ),
                              Text(
                                widget.friend.company,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                          getWidget(widget.status, data, portrait)
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
