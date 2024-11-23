import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SpeechToText {
  late final String apiKey;
  late final String region;

  // Load .env
  SpeechToText() {
    _initialize();
  }

  Future<void> _initialize() async {
    await dotenv.load(fileName: ".env");

    // Get the endpoint from .env
    apiKey = dotenv.env['STT_KEY'] ?? '';
    region = dotenv.env['STT_REGION'] ?? '';
  }

  // Print the configuration for debugging
  void printConfig() {
    debugPrint('debug: API Key: $apiKey');
    debugPrint('debug: Region: $region');
  }

  Future<String> speechToText(String path) async {
    // Define the API URL
    final url = Uri.parse(
        'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=ja-JP&format=detailed');

    // Set the headers
    final headers = {
      'Content-Type': 'audio/wav',
      'Ocp-Apim-Subscription-Key': apiKey,
    };

    // Read the audio file
    final file = File(path);
    final bytes = await file.readAsBytes();

    // Make the request
    final response = await http.post(
      url,
      headers: headers,
      body: bytes,
    );

    // Parse the response
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['DisplayText'];
    } else {
      return 'Error: ${response.reasonPhrase}';
    }
  }
}