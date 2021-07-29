import 'package:flutter/cupertino.dart';
import 'package:untitled3/models/travelMsgModel.dart';
import 'package:untitled3/models/travelerModel.dart';
import 'package:untitled3/services/CloudFirestoreServices.dart';

class ChatViewModel with ChangeNotifier {
  CloudFirestoreServices _fireStoreService = CloudFirestoreServices();
  List<TravelMsgModel> _messages = [];
  List<TravelMsgModel> get messages {
    return _messages;
  }

  Future sendMsg(String msgbody, String recieverId,
      TravelerModel currentUser) async {
    final TravelMsgModel msg = TravelMsgModel(
      messageBody: msgbody,
      receiverId: recieverId,
      senderId: currentUser.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _fireStoreService.createMsg(msg);
  }

  listenToMsg(String friendId, String currentUserId) {
    _fireStoreService
        .listenToMsgRealtime(friendId, currentUserId)
        .listen((msgData) {
      List<TravelMsgModel> updatedMsg = msgData;
      if (updatedMsg != null && updatedMsg.length > 0) {
        _messages = updatedMsg;
        notifyListeners();
      }
    });
  }
}
