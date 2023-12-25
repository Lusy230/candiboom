// controllers/sound_controller.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:candiboom/Model/sound_model.dart';

class SoundController {
  late SoundSettingsModel soundSettings;
  late AudioPlayer _audioPlayer;

  SoundController({required this.soundSettings}) {
    _audioPlayer = AudioPlayer();
  }

  void playTapSound() async {
    if (soundSettings.soundEnabled) {
      await _audioPlayer.play('assets/sound.mp3' as Source);
    }
  }
}