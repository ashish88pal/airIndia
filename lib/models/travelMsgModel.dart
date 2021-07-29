class TravelMsgModel {
  String receiverId;
  String senderId;
  String messageBody;
  int createdAt;

  TravelMsgModel(
      {this.senderId, this.receiverId, this.messageBody, this.createdAt});

  static TravelMsgModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return TravelMsgModel(
        senderId: map["senderId"],
        receiverId: map["receiverId"],
        messageBody: map["messageBody"],
        createdAt: map["createdAt"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "messageBody": messageBody,
      "createdAt": createdAt,
    };
  }
}
