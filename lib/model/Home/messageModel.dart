class MessageModel {
  String? dateTime;
  String? sender;
  String? reciever;
  String? text;


  MessageModel({
    this.text,
    this.reciever,
    this.dateTime,
    this.sender,
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    reciever = json['reciever'];
    dateTime = json['dateTime'];
    sender = json['sender'];

  }
  Map<String, dynamic> tojson() {
    return {
      'text': text,
      'reciever': reciever,
      'dateTime': dateTime,
      'sender': sender,
    };
  }
}
