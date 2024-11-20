// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;

// class TextToSpeech {
//   // Load .env
//   TextToSpeech() {
//     dotenv.load(fileName: ".env");

//     // Get the endpoint from .env
//     final String? endpoint = dotenv.env['TTS_ENDPOINT'];
//     final String? apiKey = dotenv.env['TTS_KEY'];
//     final String? region = dotenv.env['TTS_REGION'];
//   }

//   void printConfig() {
//     final String? endpoint = dotenv.env['TTS_ENDPOINT'];
//     final String? apiKey = dotenv.env['TTS_KEY'];
//     final String? region = dotenv.env['TTS_REGION'];

//     print('Endpoint: $endpoint');
//     print('API Key: $apiKey');
//     print('Region: $region');
//   }
// }

// Future main() async {
//   final TextToSpeech tts = TextToSpeech();
//   tts.printConfig();
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class TextToSpeech {
  late final String endpoint;
  late final String apiKey;
  late final String region;

  // Load .env
  TextToSpeech() {
    dotenv.load(fileName: ".env");

    // Get the endpoint from .env
    endpoint = dotenv.env['TTS_ENDPOINT'] ?? '';
    apiKey = dotenv.env['TTS_KEY'] ?? '';
    region = dotenv.env['TTS_REGION'] ?? '';
  }

  // Print the configuration for debugging
  void printConfig() {
    print('Endpoint: $endpoint');
    print('API Key: $apiKey');
    print('Region: $region');
  }

  // Convert text to speech and save it to a file
  Future<void> convertTextToSpeech(String text) async {
    // Define the API URL
    final url = Uri.parse('$endpoint/cognitiveservices/v1');

    // Set the headers
    final headers = {
      'Content-Type': 'application/ssml+xml',
      'Authorization': 'Bearer $apiKey',
      'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
      'User-Agent': 'AzureTextToSpeechClient/1.0',
    };

    // Define the SSML (Speech Synthesis Markup Language) body
    final ssml = '''
    <?xml version="1.0" encoding="UTF-8"?>
    <speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <voice name="en-US-JessaNeural">
            <prosody rate="0%" volume="100%">
                $text
            </prosody>
        </voice>
    </speak>
    ''';

    // Send the POST request to the Azure TTS API
    final response = await http.post(
      url,
      headers: headers,
      body: ssml,
    );

    if (response.statusCode == 200) {
      // Success: the response contains the audio file
      print('Text-to-Speech conversion successful!');

      // Get the audio data from the response
      final audioData = response.bodyBytes;

      // Save the audio to a file
      await _saveAudioToFile(audioData);
    } else {
      // If the request failed, print the error
      print('Error: ${response.statusCode}, ${response.body}');
    }
  }

  // Save the audio data to a file
  Future<void> _saveAudioToFile(Uint8List audioData) async {
    final file = File('output.mp3');
    await file.writeAsBytes(audioData);
    print('Audio saved as output.mp3');
  }
}

Future main() async {
  // Initialize TextToSpeech instance
  final tts = TextToSpeech();

  // Print the configuration
  tts.printConfig();

  // Convert some text to speech
  await tts.convertTextToSpeech(
      'Hello, this is a test of the Azure Text to Speech service.');
}
