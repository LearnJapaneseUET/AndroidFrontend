import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatgpt {
// POST: https://nihongobenkyou.online/api/chat/
// {
//     "message": "Chào bạn Nhàn"
// }
  Future<String> getResponse(String message) async {
    final response = await http.post(
      Uri.parse('https://nihongobenkyou.online/api/chat/'),
      headers: {"Content-Type": "application/json"},
      body: '{"message": "$message"}',
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error processing message.";
    }
  }
}
