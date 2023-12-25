// controllers/settings_controller.dart
import 'package:candiboom/Model/language_model.dart';
import 'package:candiboom/Model/sound_model.dart';

class SettingsController {
  late SoundSettingsModel soundSettings;
  late LanguageSettingsModel languageSettings;

  SettingsController({
    required this.soundSettings,
    required this.languageSettings,
  });

  void toggleSound() {
    soundSettings.soundEnabled = !soundSettings.soundEnabled;
  }

  void adjustVolume(double volume) {
    soundSettings.soundVolume = volume;
  }

  void changeLanguage(String newLanguage) {
    languageSettings.selectedLanguage = newLanguage;
  }
}