class TravelerModel {
  String id;
  String name;
  String code;
  String position;
  String company;
  List connected;
  List pendingRequest;
  List sentRequest;

  TravelerModel(
      {this.id,
      this.name,
      this.code,
      this.position,
      this.company,
      this.connected,
      this.pendingRequest,
      this.sentRequest});

  static TravelerModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return TravelerModel(
      id: map["id"],
      name: map["name"],
      code: map["code"],
      position: map["position"],
      company: map["company"],
      connected: map["connected"],
      pendingRequest: map["pendingRequest"],
      sentRequest: map["sentRequest"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "code": code,
      "position": position,
      "company": company,
      "connected": connected,
      "pendingRequest": pendingRequest,
      "sentRequest": sentRequest,
    };
  }
}
