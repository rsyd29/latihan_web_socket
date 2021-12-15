import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {
  late TextEditingController chatController;

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.org'),
  );

  void sendMessage() {
    if (chatController.text.trim().isNotEmpty) {
      channel.sink.add(chatController.text.trim());
    }
    chatController.clear();
    update();
  }

  @override
  void onInit() {
    chatController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    chatController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
