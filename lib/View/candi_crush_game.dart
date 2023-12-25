import 'package:candiboom/Controller/game_controller.dart';
import 'package:candiboom/Controller/setting_controller.dart';
import 'package:candiboom/Controller/sound_controller.dart';
import 'package:candiboom/Model/language_model.dart';
import 'package:candiboom/Model/sound_model.dart';
import 'package:candiboom/View/candi_tile.dart';
import 'package:flutter/material.dart';

class CandiGame extends StatefulWidget {
  @override
  _CandiGameState createState() => _CandiGameState();
}

class _CandiGameState extends State<CandiGame> {
  late GameController gameController;
  late SettingsController settingsController;
  late SoundController soundController; // Add sound controller

  @override
  void initState() {
    super.initState();

    // Initialize controllers and settings
    settingsController = SettingsController(
      soundSettings: SoundSettingsModel(soundEnabled: true, soundVolume: 0.5),
      languageSettings: LanguageSettingsModel(selectedLanguage: 'English'),
    );

    soundController = SoundController(soundSettings: settingsController.soundSettings);

    gameController = GameController(
      onScoreUpdated: _handleScoreUpdated,
      onCandiesUpdated: _handleCandiesUpdated,
      currentLanguage: settingsController.languageSettings.selectedLanguage,
    );
  }

  void _handleScoreUpdated(int newScore) {
    print('Score Updated: $newScore');
    setState(() {});
  }

  void _handleCandiesUpdated() {
    // Rebuild the UI after the fall effect
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candy Crush'),
        backgroundColor: Color.fromRGBO(139, 90, 71, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _openSettings(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: ${gameController.score}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: gameController.candyModel.boardSize,
                itemBuilder: (context, index) {
                  return CandyTile(
                    assetPaths: [
                      'Borobudur.png',
                      'Candi Prambanan.png',
                      'cankuang.png',
                      // Add more asset paths as needed
                    ],
                    onTap: () {
                      setState(() {
                        gameController.onTileTapped(index);
                        soundController.playTapSound(); // Play tap sound
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Settings'),
              content: Column(
                children: [
                  SwitchListTile(
                    title: Text('Sound'),
                    value: settingsController.soundSettings.soundEnabled,
                    onChanged: (value) {
                      setState(() {
                        settingsController.toggleSound();
                      });
                    },
                  ),
                  Slider(
                    value: settingsController.soundSettings.soundVolume,
                    onChanged: (value) {
                      setState(() {
                        settingsController.adjustVolume(value);
                      });
                    },
                    min: 0.0,
                    max: 100.0,
                    divisions: 10,
                    label: 'Volume',
                  ),
                  DropdownButton<String>(
                    value: settingsController.languageSettings.selectedLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        settingsController.changeLanguage(newValue!);
                      });
                    },
                    items: <String>['English', 'Spanish', 'French', 'German']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}