import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_web_socket/constant.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text('Chat Room'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.chatMessage.length,
                  itemBuilder: (context, index) {
                    var currentItem = controller.chatMessage[index];
                    return MessageItem(
                      sentByMe: currentItem.sentByMe == controller.socket.id,
                      message: currentItem.message,
                    );
                  },
                );
              }),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: blue,
                  controller: controller.chatController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.sendMessage(
                              controller.chatController.text.trim());
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.sentByMe, required this.message,
  }) : super(key: key);

  final bool sentByMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: sentByMe ? blue : white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 18, color: sentByMe ? white : blue),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "1:10 PM",
              style: TextStyle(
                fontSize: 10,
                color: (sentByMe ? white : blue).withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
