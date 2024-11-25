import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

class TextToSpeech {
  late final String apiKey;
  late final String region;

  // Load .env
  TextToSpeech() {
    _initialize();
  }

  Future<void> _initialize() async {
    await dotenv.load(fileName: ".env");

    // Get the endpoint from .env
    apiKey = dotenv.env['TTS_KEY'] ?? '';
    region = dotenv.env['TTS_REGION'] ?? '';

    // Request storage permission
    var status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      debugPrint('debug: Storage permission denied.');
    } else {
      debugPrint('debug: Storage permission granted.');
    }
  }

  // Print the configuration for debugging
  void printConfig() {
    debugPrint('debug: API Key: $apiKey');
    debugPrint('debug: Region: $region');
  }

  // Convert text to speech and save it to a file
  Future<void> convertTextToSpeech(String text) async {
    // Define the API URL
    final url = Uri.parse(
        'https://$region.tts.speech.microsoft.com/cognitiveservices/v1');

    // Set the headers
    final headers = {
      'Content-Type': 'application/ssml+xml',
      'Ocp-Apim-Subscription-Key': apiKey,
      'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
      'User-Agent': 'curl',
    };

    // Define the SSML (Speech Synthesis Markup Language) body
    final ssml = '''
    <speak version='1.0' xml:lang='ja-JP'>
      <voice xml:lang='ja-JP' xml:gender='Female' name='ja-JP-NanamiNeural'>
      $text
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
      debugPrint('debug: Text-to-Speech conversion successful!');

      // Get the audio data from the response
      final audioData = response.bodyBytes;

      // Save the audio to a file
      await _saveAudioToFile(audioData);
    } else {
      // If the request failed, print the error
      debugPrint('debug: Error: ${response.statusCode}, ${response.body}');
    }
  }

  // Save the audio data to a file
  Future<void> _saveAudioToFile(Uint8List audioData) async {
    final directory = (await getExternalStorageDirectory())!;
    final filePath = '${directory.path}/output.mp3';
    final file = File(filePath);
    await file.writeAsBytes(audioData);
    debugPrint('debug: Audio saved as $filePath');
  }

  Future<void> _playAudioFile() async {
    debugPrint('debug: Playing audio file...');
    final player = AudioPlayer();
    final directory = (await getExternalStorageDirectory())!;
    final filePath = '${directory.path}/output.mp3';
    debugPrint('debug: File path: $filePath');

    // Play the audio file
    try {
      // Path to the audio file in the device storage
      await player.play(DeviceFileSource(filePath));
      debugPrint('debug: Audio playback started successfully.');
    } catch (e) {
      debugPrint('debug: Error playing audio: $e');
    }

    // Optionally, handle completion or errors
    player.onPlayerComplete.listen((event) {
      debugPrint('debug: Audio playback completed.');
    });
  }

  // Call convertTextToSpeech when text is submitted, then _saveAudioToFile, then playAudioFile
  void processTTS(String text) async {
    await convertTextToSpeech(text);
    _playAudioFile();
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
