import 'package:candiboom/Model/setting_model.dart';

class SuaraController {
  SuaraModel model;

  SuaraController({required this.model});

  void toggleSuara() {
    model.toggleSuara();
  }

  void setVolume(double value) {
    model.setVolume(value);
  }

  void setSelectedSong(String s) {}
}