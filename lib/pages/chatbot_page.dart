import 'package:flutter/material.dart';
import 'package:nihongo/microphone/microphone.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const ChatAppBar(),
        body: const ChatBody(),
        bottomNavigationBar: const ChatBottomNavigationBar());
  }
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF8980F0),
      title: const Row(
        children: [
          Icon(Icons.rocket, color: Colors.white, size: 28),
          SizedBox(width: 10),
          Text(
            "ChatGPT",
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Noto Sans',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Text(
            "Online",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionTile(
              icon: Icons.translate,
              title: "Dịch",
              subtitle: "Tôi có thể giúp bạn dịch",
            ),
            const SizedBox(height: 20),
            _buildOptionTile(
              icon: Icons.edit,
              title: "Viết câu hỏi",
              subtitle: "Hãy hỏi tôi điều gì đó",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBottomNavigationBar extends StatelessWidget {
  const ChatBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Nhập tin nhắn...",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const MicrophoneButton(), // Replaced mic button with MicrophoneButton
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.photo_camera),
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
