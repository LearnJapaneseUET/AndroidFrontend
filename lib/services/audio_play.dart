import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AudioPlay {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  String? _filePath;

  AudioPlay() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _player.openPlayer();

    // Optionally, set a default path
    Directory tempDir = (await getExternalStorageDirectory())!;
    _filePath = '${tempDir.path}/audio.wav';
  }

  Future<void> startPlaying() async {
    if (_filePath == null) return;

    await _player.startPlayer(
      fromURI: _filePath,
      codec: Codec.pcm16WAV,
      whenFinished: () {
        debugPrint("dangtiendung1201: Finished playing");
      },
    );
  }

  Future<void> stopPlaying() async {
    await _player.stopPlayer();

    debugPrint("dangtiendung1201: Player stopped");
  }
}
