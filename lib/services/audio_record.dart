import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AudioRecord {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _filePath;

  AudioRecord() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Request microphone permissions
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }

    await _recorder.openRecorder();

    // Optionally, set a default path
    Directory tempDir = await getTemporaryDirectory();
    _filePath = '${tempDir.path}/audio.wav';
  }

  Future<void> startRecording() async {
    if (_filePath == null) return;

    await _recorder.startRecorder(
      toFile: _filePath,
      codec: Codec.pcm16WAV, // You can choose different codecs
    );

    debugPrint("dangtiendung1201: Recording started");
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();

    debugPrint("dangtiendung1201: Recording stopped. File path: $_filePath");
  }

  Future<String> getFilePath() async {
    return _filePath!;
  }
}
