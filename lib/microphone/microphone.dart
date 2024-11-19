import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MicrophoneButton extends StatefulWidget {
  const MicrophoneButton({super.key});

  @override
  _MicrophoneButtonState createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _initPlayer();
  }

  Future<void> _initRecorder() async {
    // Request microphone permissions
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }

    await _recorder.openRecorder();
    // Optionally, set a default path
    Directory tempDir = await getTemporaryDirectory();
    _filePath = '${tempDir.path}/flutter_sound_example.aac';
  }

  Future<void> _initPlayer() async {
    await _player.openPlayer();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (_filePath == null) return;

    await _recorder.startRecorder(
      toFile: _filePath,
      codec: Codec.aacADTS, // You can choose different codecs
    );
    setState(() {
      _isRecording = true;
    });
    print("Recording started");
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    print("Recording stopped");
  }

  Future<void> _startPlayback() async {
    if (_filePath == null) return;

    await _player.startPlayer(
      fromURI: _filePath,
      codec: Codec.aacADTS,
      whenFinished: () {
        setState(() {
          _isPlaying = false;
        });
        print("Playback finished");
      },
    );
    setState(() {
      _isPlaying = true;
    });
    print("Playback started");
  }

  Future<void> _stopPlayback() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
    print("Playback stopped");
  }

  void _onPressed() async {
    if (_isRecording) {
      // Stop recording and start playback
      await _stopRecording();
      await _startPlayback();
    } else if (_isPlaying) {
      // Stop playback
      await _stopPlayback();
    } else {
      // Start recording
      await _startRecording();
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    if (_isRecording) {
      icon = Icons.stop;
      color = Colors.red;
    } else if (_isPlaying) {
      icon = Icons.stop;
      color = Colors.orange;
    } else {
      icon = Icons.mic;
      color = Colors.purple;
    }

    return IconButton(
      onPressed: _onPressed,
      icon: Icon(icon),
      color: color,
      iconSize: 36.0,
      tooltip: _isRecording
          ? 'Stop Recording'
          : _isPlaying
              ? 'Stop Playback'
              : 'Start Recording',
    );
  }
}
