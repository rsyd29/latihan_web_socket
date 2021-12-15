import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latihan_web_socket/model/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  late TextEditingController chatController;
  late IO.Socket socket;

  var chatMessage = <MessageModel>[].obs;
  var connectedUser = 0.obs;

  @override
  void onInit() {
    chatController = TextEditingController();
    socket = IO.io(
        'http://localhost:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    setUpSocketListener();
    super.onInit();
  }

  @override
  void onClose() {
    chatController.dispose();
    socket.close();
    super.dispose();
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      var messageJson = {
        "message": text,
        "sentByMe": socket.id,
        "date": DateTime.now().toIso8601String(),
      };
      socket.emit('message', messageJson);
      chatMessage.add(MessageModel.fromJson(messageJson));
    }
    chatController.clear();
    update();
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      print(data);
      chatMessage.add(MessageModel.fromJson(data));
    });

    socket.on('connected-user', (data) {
      print(data);
      connectedUser.value = data;
    });
  }
}
