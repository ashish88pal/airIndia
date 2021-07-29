import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/models/travelMsgModel.dart';
import 'package:untitled3/models/travelerModel.dart';

class CloudFirestoreServices {
  final CollectionReference travelerCollectionRef =
      FirebaseFirestore.instance.collection("tarveler");
  final CollectionReference msgCollectionRef =
      FirebaseFirestore.instance.collection("tarvelermsgs");
  final StreamController<List<TravelMsgModel>> _chatController =
      StreamController<List<TravelMsgModel>>.broadcast();

  Future allTravelers() async {
    var userDocSnap = await travelerCollectionRef.get();
    if (userDocSnap.docs.isNotEmpty) {
      return userDocSnap.docs
          .map((traveler) => TravelerModel.fromMap(traveler.data()))
          .toList();
    }
  }

  Future createTraveler(TravelerModel traveler) async {
    try {
      travelerCollectionRef
          .doc(traveler.id)
          .set(traveler.toJson())
          .whenComplete(() => print("Traveler is created"))
          .catchError((e) => print(e));
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getTraveler(String uid) async {
    try {
      var trvelerData = await travelerCollectionRef.doc(uid).get();
      trvelerData.data();
      return TravelerModel.fromMap(trvelerData.data());
    } catch (e) {}
  }

  Future getAllUsersOnce(currentUser) async {
    var userDocSnap = await travelerCollectionRef.get();
    if (userDocSnap.docs.isNotEmpty) {
      return userDocSnap.docs
          .map((traveler) => TravelerModel.fromMap(traveler.data()))
          .where((traveler) => traveler.id != currentUser)
          .toList();
    }
  }

  Future createMsg(TravelMsgModel msg) async {
    try {
      await msgCollectionRef
          .doc()
          .set(msg.toJson())
          .whenComplete(() => print("msg is created"))
          .catchError((e) => print(e));
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Stream listenToMsgRealtime(String coPassengerId, String currentUserId) {
    _requestMessage(coPassengerId, currentUserId);
    return _chatController.stream;
  }

  void _requestMessage(String coPassengerId, String currentUserId) {
    var msgQuerySnapshot =
        msgCollectionRef.orderBy("createdAt", descending: true);
    msgQuerySnapshot.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        var msg = event.docs
            .map((item) => TravelMsgModel.fromMap(item.data()))
            .where((element) =>
                (element.receiverId == coPassengerId &&
                    element.senderId == currentUserId) ||
                (element.receiverId == currentUserId &&
                    element.senderId == coPassengerId))
            .toList();
        _chatController.add(msg);
      }
    });
  }

// send request       me  send+        you  pending+
  Future sendFriendRequest(
      TravelerModel currentUser, TravelerModel coPassenger) async {
    try {
      travelerCollectionRef.doc(currentUser.id).update({
        // "sendRequest" : currentUserId
        "sentRequest": FieldValue.arrayUnion([coPassenger.id])
      }).then((_) {
        travelerCollectionRef.doc(coPassenger.id).update({
          "pendingRequest": FieldValue.arrayUnion([currentUser.id])
        }).then((_) {
          print("${coPassenger.name} got request from ${currentUser.name}");
        }).catchError((error) => print('Add failed: $error'));
        print("${currentUser.name} send request to ${coPassenger.name}");
      }).catchError((error) => print('Add failed: $error'));
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

// undo request       me  send-        you  pending-
  Future undoFriendRequest(
      TravelerModel currentUser, TravelerModel coPassenger) async {
    try {
      travelerCollectionRef.doc(currentUser.id).update({
        // "sentRequest" : currentUserId
        "sentRequest": FieldValue.arrayRemove([coPassenger.id])
      }).then((_) {
        travelerCollectionRef.doc(coPassenger.id).update({
          "pendingRequest": FieldValue.arrayRemove([currentUser.id])
        }).then((_) {
          print(
              "${coPassenger.name} request is deleted by ${currentUser.name}");
        }).catchError((error) => print('Add failed: $error'));
        print("${currentUser.name} deleted request to ${coPassenger.name}");
      }).catchError((error) => print('Add failed: $error'));
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

// cancel request     me  pending-        you  send-
  Future cancelFriendRequest(
      TravelerModel currentUser, TravelerModel coPassenger) async {
    try {
      travelerCollectionRef.doc(currentUser.id).update({
        // "sendRequest" : currentUserId
        "pendingRequest": FieldValue.arrayRemove([coPassenger.id])
      }).then((_) {
        travelerCollectionRef.doc(coPassenger.id).update({
          "sentRequest": FieldValue.arrayRemove([currentUser.id])
        }).then((_) {
          print(
              "${coPassenger.name} request is canceled by ${currentUser.name}");
        }).catchError((error) => print('Add failed: $error'));
        print("${currentUser.name} canceled request of ${coPassenger.name}");
      }).catchError((error) => print('Add failed: $error'));
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

// accept request     me connected+ pending-     you connected+ sent-
  Future acceptFriendRequest(
      TravelerModel currentUser, TravelerModel coPassenger) async {
    try {
      travelerCollectionRef.doc(currentUser.id).update({
        "connected": FieldValue.arrayUnion(
          [coPassenger.id],
        ),
        "pendingRequest": FieldValue.arrayRemove(
          [coPassenger.id],
        ),
      }).then((_) {
        travelerCollectionRef.doc(coPassenger.id).update({
          "connected": FieldValue.arrayUnion([currentUser.id]),
          "sentRequest": FieldValue.arrayRemove([currentUser.id]),
        }).then((_) {
          print("${coPassenger.name} is added by ${currentUser.name}");
        }).catchError((error) => print('Add failed: $error'));
        print("${currentUser.name} accepted request of ${coPassenger.name}");
      }).catchError((error) => print('Add failed: $error'));
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }
}
