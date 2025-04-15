import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  late FlutterTts _flutterTts;

  TtsService() {
    _flutterTts = FlutterTts();
  }

  Future<void> initialize() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
