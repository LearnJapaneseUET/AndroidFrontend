import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // get the notifications message and display on screen
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8980F0),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thông báo",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            // Icon(Icons.edit_square, color: Colors.white)
          ],
        ),
      ),
      body: Column(
        children: [
          // Text(message.notification!.title.toString()),
          Text(message.notification!.body.toString()),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
