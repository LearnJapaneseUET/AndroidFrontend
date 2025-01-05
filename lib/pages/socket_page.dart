import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late IO.Socket _socket;
  bool _isThinking = false;

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  void _connectToServer() {
    _socket = IO.io(
      'http://localhost:3000', // Replace with your server URL
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setExtraHeaders({'foo': 'bar'})
          .build(),
    );

    _socket.onConnect((_) {
      print('Connected to server');
      _socket.emit(
          'join', 'FlutterUser'); // Replace with a dynamic username if needed
    });

    _socket.on('receive-message', (data) {
      setState(() {
        _messages.add({
          'username': data['username'],
          'message': data['message'],
          'isUser': false,
        });
      });
    });

    _socket.on('user-connected', (username) {
      setState(() {
        _messages.add({
          'username': 'System',
          'message': '$username joined the chat.',
          'isUser': false,
        });
      });
    });

    _socket.on('user-disconnected', (username) {
      setState(() {
        _messages.add({
          'username': 'System',
          'message': '$username left the chat.',
          'isUser': false,
        });
      });
    });
  }

  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildChatBody()),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildChatBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _messages.length + (_isThinking ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const SpinKitThreeBounce(
                color: Colors.grey,
                size: 20.0,
              ),
            ),
          );
        }
        final message = _messages[index];
        final isUserMessage = message['isUser'];
        return Align(
          alignment:
              isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue[100] : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUserMessage)
                  Text(
                    message['username'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                Text(message['message']),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF8980F0)),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final userText = _textController.text;
    if (userText.isEmpty) return;

    setState(() {
      _messages.add({
        'username': 'You',
        'message': userText,
        'isUser': true,
      });
      _textController.clear();
      _isThinking = false;
    });

    _socket.emit('send-message', userText);
  }
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF8980F0),
      title: const Row(
        children: [
          Icon(Icons.group, color: Colors.white, size: 28),
          SizedBox(width: 10),
          Text(
            "Chat Room",
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Noto Sans',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
