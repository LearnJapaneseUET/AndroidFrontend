import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:nihongo/services/ocr.dart';
import 'package:nihongo/services/audio_record.dart';
import 'package:nihongo/services/audio_play.dart';
import 'package:nihongo/services/speech_to_text.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  TranslationPageState createState() => TranslationPageState();
}

class TranslationPageState extends State<TranslationPage> {
  final String serverUrl = 'https://nihongobenkyou.online/api/translateVtoJ/';
  final AudioRecord audioRecord = AudioRecord();
  final AudioPlay audioPlay = AudioPlay();
  bool _isRecording = false;
  final SpeechToText speechToText = SpeechToText();
  final TextEditingController _textController = TextEditingController();
  final Ocr ocrProvider = Ocr();
  String? _translationResult;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  List<String> _history = [];
  void _submitData() async {
    if (_textController.text.isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide input text or an image')),
      );
      return;
    }

    try {
      if (_textController.text.isNotEmpty) {
        // Lưu từ mới vào đầu danh sách lịch sử
        setState(() {
          _history.insert(0, _textController.text); // Thêm vào đầu danh sách
        });
      }

      // final response = await http.post(
      //   Uri.parse(serverUrl),
      //   body: {'text': _textController.text},
      // );

      // // Print response body
      // debugPrint('dangtiendung1201: Response body: ${response.body}');

      // if (response.statusCode == 200) {
      //   setState(() {
      //     _translationResult = response.body;
      //   });
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Error: ${response.statusCode}')),
      //   );
      // }

      final response = await http.post(
        Uri.parse(serverUrl),
        body: jsonEncode({'text': _textController.text}),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Print request body
      debugPrint('dangtiendung1201: Request body: ${jsonEncode({
            'text': _textController.text
          })}');

      // Print response status code
      debugPrint(
          'dangtiendung1201: Response status code: ${response.statusCode}');

      // Print response body
      debugPrint('dangtiendung1201: Response body: ${response.body}');

      if (response.statusCode == 200) {
        String responseBody = response.body;
        setState(() {
          _translationResult =
              responseBody; // Thay đổi theo phản hồi của API nếu cần
        });
      } else {
        debugPrint('dangtiendung1201: Response body: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  void _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null && _isValidImageFormat(pickedImage.path)) {
      setState(() {
        _image = pickedImage;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a valid image (PNG or JPEG)')),
      );
    }
  }

  void _takePhoto() async {
    final takenPhoto = await _picker.pickImage(source: ImageSource.camera);
    if (takenPhoto != null && _isValidImageFormat(takenPhoto.path)) {
      setState(() {
        _image = takenPhoto;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please take a valid image (PNG or JPEG)')),
      );
    }
  }

  bool _isValidImageFormat(String path) {
    final validExtensions = ['png', 'jpeg', 'jpg'];
    final extension = path.split('.').last.toLowerCase();
    return validExtensions.contains(extension);
  }

  void _extractTextFromImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    try {
      String extractedText = await ocrProvider.extractTextFromImage(_image!);
      setState(() {
        _textController.text = extractedText;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to extract text: $e')),
      );
    }
  }

  void _pickImageAndTranslate() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null && _isValidImageFormat(pickedImage.path)) {
      setState(() {
        _image = pickedImage;
      });
      debugPrint('dangtiendung1201: Image path: ${_image!.path}');
      _extractTextFromImage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a valid image (PNG or JPEG)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.translate, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Text(
              'Translation Page',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF8980F0),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter, // Align the image to the top
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Enter text to translate",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                ),
                maxLines: 5,
                minLines: 3,
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: _pickImageAndTranslate,
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: _takePhoto,
                    ),
                    IconButton(
                      icon: Icon(Icons.mic,
                          color: _isRecording ? Colors.red : Color(0xFF0E0C0C)),
                      onPressed: () {
                        if (_isRecording) {
                          audioRecord.stopRecording();
                          speechToText.speechToText().then((newText) {
                            setState(() {
                              _textController.text = newText;
                            });
                          });
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
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Implement handwriting input logic here
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8980F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),

                  // padding: const EdgeInsets.symmetric(vertical: 13),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_translationResult != null)
                Text(
                  'Translation: $_translationResult',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Màu nền trắng
                    borderRadius: BorderRadius.circular(12), // Bo góc
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.3), // Hiệu ứng đổ bóng nhẹ
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Đổ bóng xuống dưới
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(
                      12.0), // Khoảng cách nội dung bên trong
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lịch sử',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Khoảng cách giữa tiêu đề và danh sách
                      Expanded(
                        child: ListView.builder(
                          itemCount: _history.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0), // Khoảng cách giữa các mục
                              child: ListTile(
                                leading: const Icon(
                                  Icons.access_time,
                                  color: Color(0xFF7E57C2), // Màu tím đồng bộ
                                  size: 20, // Kích thước icon vừa phải
                                ),
                                title: Text(
                                  _history[index],
                                  style: const TextStyle(
                                    fontSize: 16, // Tăng kích thước chữ
                                    fontWeight: FontWeight.w500, // Chữ đậm vừa
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _textController.text = _history[index];
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
