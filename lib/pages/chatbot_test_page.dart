import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For 3-dot animation
import 'package:http/http.dart' as http;
import 'package:nihongo/services/audio_record.dart';
import 'package:nihongo/services/audio_play.dart';
import 'package:nihongo/services/speech_to_text.dart';
import 'package:nihongo/services/text_to_speech.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final AudioRecord audioRecord = AudioRecord();
  final AudioPlay audioPlay = AudioPlay();
  final SpeechToText speechToText = SpeechToText();
  final TextToSpeech textToSpeech = TextToSpeech();
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  String? _filePath;
  bool _isThinking = false;
  bool _isRecording = false;
  bool _isPlaying = false;

  final String serverUrl =
      "YOUR_SERVER_URL_HERE"; // Replace with your server URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          // Show "thinking" animation
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
            child: Text(message['text']),
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
            icon: const Icon(Icons.mic, color: Colors.purple),
            onPressed: () {
              if (_isRecording) {
                audioRecord.stopRecording();
                speechToText.speechToText().then((newText) {
                  setState(() {
                    _textController.text = newText;
                  });
                });
                // speechToText.speechToText().then((value) {
                //   setState(() {
                //     _textController.text = value;
                //   });
                // });
                // audioPlay.startPlaying();
                setState(() {
                  _isRecording = false;
                });
              } else {
                audioRecord.startRecording();
                setState(() {
                  _isRecording = true;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.purple),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _stopRecordAudio() async {
    audioRecord.stopRecording();
    speechToText.speechToText().then((value) {
      setState(() {
        _textController.text = value;
      });
    });
    setState(() {
      _isRecording = false;
    });
  }

  // Future<File> _simulateAudioRecording() async {
  //   // Simulate recording a .wav file
  //   return File('path/to/audio.wav'); // Replace with actual recorded file
  // }

  // Future<String> _sendAudioToServer(File audioFile) async {
  //   final request = http.MultipartRequest("POST", Uri.parse(serverUrl))
  //     ..files.add(await http.MultipartFile.fromPath('file', audioFile.path));

  //   final response = await request.send();
  //   if (response.statusCode == 200) {
  //     final responseData = await response.stream.bytesToString();
  //     return jsonDecode(responseData)['text'];
  //   } else {
  //     return "Error processing audio.";
  //   }
  // }

  Future<void> _sendMessage() async {
    final userText = _textController.text;
    if (userText.isEmpty) return;

    setState(() {
      _messages.add({'text': userText, 'isUser': true});
      _textController.clear();
      _isThinking = true;
    });

    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": userText}),
      );

      if (response.statusCode == 200) {
        final responseText = jsonDecode(response.body)['response'];
        setState(() {
          _isThinking = false;
          _messages.add({'text': responseText, 'isUser': false});
        });
      } else {
        throw Exception("Failed to send message");
      }
    } catch (e) {
      setState(() {
        _isThinking = false;
        _messages.add({
          'text': "Error: Unable to process your message.",
          'isUser': false
        });
      });
    }
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
          Icon(Icons.chat, color: Colors.white, size: 28),
          SizedBox(width: 10),
          Text(
            "ChatGPT",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
