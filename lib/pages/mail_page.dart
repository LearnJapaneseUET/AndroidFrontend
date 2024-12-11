import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SendMail extends StatefulWidget {
  const SendMail({super.key});

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  final TextEditingController _mailMessageController = TextEditingController();

  // Send Mail function
  void sendMail({required String mailMessage}) async {
    // Lấy thông tin email từ .env file
    String username = dotenv.env['GMAIL_EMAIL']!;
    String password = dotenv.env['GMAIL_PASSWORD']!;

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Mail Service')
      ..recipients.add(username)
      ..subject = 'Feedback from Flutter App'
      ..text = 'Message: $mailMessage';

    try {
      // Gửi email
      await send(message, smtpServer);
      showSnackbar('Email sent successfully');
    } catch (e) {
      // Xử lý lỗi khi gửi email
      showSnackbar('Failed to send email: $e');
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra .env
    print(dotenv.env['GMAIL_EMAIL']);
    print(dotenv.env['GMAIL_PASSWORD']);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Feedback'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            // Form nhập nội dung email
            TextFormField(
              maxLines: 5,
              controller: _mailMessageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Nút gửi email
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Gửi email khi nhấn nút
                  sendMail(
                    mailMessage: _mailMessageController.text.toString(),
                  );
                },
                child: const Text('Send Mail'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FittedBox(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}