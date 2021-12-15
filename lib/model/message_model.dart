class MessageModel {
  String message;
  String sentByMe;

  MessageModel({required this.message, required this.sentByMe});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(message: json['message'], sentByMe: json['sentByMe']);
  }
}
