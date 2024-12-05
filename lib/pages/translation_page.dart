import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:nihongo/services/ocr.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  TranslationPageState createState() => TranslationPageState();
}

class TranslationPageState extends State<TranslationPage> {
  final TextEditingController _textController = TextEditingController();
  final Ocr ocrProvider = Ocr();
  String? _translationResult;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  void _submitData() async {
    if (_textController.text.isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide input text or an image')),
      );
      return;
    }

    try {
      // Prepare the request
      var request = http.MultipartRequest('POST', Uri.parse('YOUR_SERVER_URL'));
      if (_textController.text.isNotEmpty) {
        request.fields['text'] = _textController.text;
      }
      if (_image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          _image!.path,
        ));
      }

      // Send request and handle response
      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        setState(() {
          _translationResult =
              responseBody; // Adjust based on your API's response
        });
      } else {
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
      body: Padding(
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
                    icon: const Icon(Icons.mic),
                    onPressed: () {
                      // Implement voice input logic here
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
