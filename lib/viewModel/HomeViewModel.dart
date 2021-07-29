import 'package:flutter/cupertino.dart';
import 'package:untitled3/models/travelerModel.dart';
import 'package:untitled3/services/CloudFirestoreServices.dart';

class HomeViewModel with ChangeNotifier {
  CloudFirestoreServices _fst = CloudFirestoreServices();
  TravelerModel _current;
  TravelerModel get current {
    return _current;
  }

  // TravelerModel temp = TravelerModel(
  //     id: "45",
  //     name: "Adarsh",
  //     code: "1234567890",
  //     position: "CEO",
  //     company: "Google",
  //     connected: [],
  //     pendingRequest: [],
  //     sentRequest: []
  // );

  Future travalersListFuture(String currentUserID) async {
    // print("------------------------------------->>>>>>>>>>>>\n" + temp.toJson().toString());
    // _fst.createTraveler(temp);
    _current = await _fst.getTraveler(currentUserID);
    // print("------------------------------------->>>>>>>>>>>>\n" + _me.toJson().toString());
    print(_current.toJson());
    var newListOfTravelers = await _fst.getAllUsersOnce(_current.id);

    // print(newListOfTravelers.toJson());
    print(
        "----------------------------------------------- futureToRunTravelers()");
    print(newListOfTravelers.runtimeType);

    var map1 = Map.fromIterable(newListOfTravelers,
        key: (e) => e, value: (e) => setStatus(e));

    print(map1.runtimeType);

    print(
        "end ----------------------------------------------- futureToRunTravelers()");

    return map1;
    // if (newListOfTravelers != null ) {
    //   _listOfTravelers = newListOfTravelers;
    //   notifyListeners();
    // }
    //
    // print(_listOfTravelers);
  }

  int setStatus(TravelerModel friend) {
    int status = 3; // Tap to connect
    // 4 Respond to request
    // 1 Undo reqest

    // print("@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@##@#@#@#@#@#@#");
    if (_current.sentRequest != null ||
        _current.connected != null ||
        _current.pendingRequest != null) {
      print(_current.toJson());
// print(_current.sentRequest);
// print(_current.pendingRequest);
// print(_current.connected);

      if (_current.connected.isNotEmpty) {
        print(_current.connected.contains(friend.id));
        if (_current.connected.contains(friend.id)) {
          status = 2;
          print("connected status set");
        }

        // Connected
      }
      if (_current.sentRequest.isNotEmpty) {
        // print(_current.sentRequest);
        // print(friend.id);
        print(_current.sentRequest.contains(friend.id));
        if (_current.sentRequest.contains(friend.id)) {
          status = 1; // Undo reqest
          print("Undo reqest status set");
        }
      }

      if (_current.pendingRequest.isNotEmpty) {
        // print(_current.sentRequest);
        // print(friend.id);
        if (_current.pendingRequest.contains(friend.id)) {
          status = 4; // Respond to request
          print("Respond to request status set");
        }
      }
    }

    return status;
  }

  undoFriendRequestMV(TravelerModel friend) {
    _fst.undoFriendRequest(_current, friend);
    print(" undo friend request");
    notifyListeners();
  }

  sendFriendRequestMV(TravelerModel friend) {
    _fst.sendFriendRequest(_current, friend);
    print(" send friend request");
    notifyListeners();
  }

  cancelFriendRequestMV(TravelerModel friend) {
    _fst.cancelFriendRequest(_current, friend);
    print(" cancel friend request");
    notifyListeners();
  }

  acceptFriendRequestMV(TravelerModel friend) {
    CloudFirestoreServices a = CloudFirestoreServices();
    _fst.acceptFriendRequest(_current, friend);
    print(" accept friend request");
    notifyListeners();
  }
}
