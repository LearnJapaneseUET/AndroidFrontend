import 'package:flutter/material.dart';
import 'package:nihongo/components/chat_field.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: ChatAppBar(),
        body: ChatBody(),
        bottomNavigationBar: ChatBottomNavigationBar());
  }
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Icon(Icons.rocket, color: Colors.blue, size: 30),
          SizedBox(width: 10),
          Text(
            "ChatGPT",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          Spacer(),
          Text(
            "Online",
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
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
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildOptionTile(
            icon: Icons.translate,
            title: "Dịch",
            subtitle: "Tôi có thể giúp bạn dịch",
          ),
          SizedBox(height: 20),
          _buildOptionTile(
            icon: Icons.edit,
            title: "Viết câu hỏi",
            subtitle: "Hãy hỏi tôi điều gì đó",
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.grey[700]),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
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
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mic),
            color: Colors.purple,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo_camera),
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
