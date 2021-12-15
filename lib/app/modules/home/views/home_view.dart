import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_web_socket/app/routes/app_pages.dart';
import 'package:latihan_web_socket/constant.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: blue),
              child: Text('Chat Room'),
              onPressed: () => Get.toNamed(Routes.CHAT),
            ),
          ],
        ),
      ),
    );
  }
}
