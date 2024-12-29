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
      showSnackbar('Đã gửi thành công');
      _mailMessageController.clear();
    } catch (e) {
      // Xử lý lỗi khi gửi email
      showSnackbar('Lỗi khi gửi email: $e');
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
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        elevation: 0,
        backgroundColor: const Color(0xFF8980F0),
        title: const Row(
          children: [
            Icon(Icons.chat, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Text(
              "Đánh giá",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // Form nhập nội dung email

              TextFormField(
                maxLines: 10,
                controller: _mailMessageController,
                decoration: InputDecoration(
                  hintText: "Hãy để lại đánh giá cho ứng dụng...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 20),
                ),
              ),
              const SizedBox(height: 20),
              // Nút gửi email
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8980F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  onPressed: () {
                    // Gửi email khi nhấn nút
                    sendMail(
                      mailMessage: _mailMessageController.text.toString(),
                    );
                  },
                  child: const Text('Gửi mail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
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
