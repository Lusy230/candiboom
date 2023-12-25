import 'package:candiboom/Controller/suara_controller.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SuaraView extends StatefulWidget {
  final SuaraController? controller;

  SuaraView({this.controller});

  @override
  _SuaraViewState createState() => _SuaraViewState();
}

class _SuaraViewState extends State<SuaraView> {
  bool _isSuaraOn = true;
  double _volume = 0.5;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAudioLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAudio();
    if (widget.controller != null) {
      _isSuaraOn = widget.controller!.model.isSuaraOn;
      _volume = widget.controller!.model.volume;
    }
  }

  void _loadAudio() async {
    await _audioPlayer.setSourceAsset("assets/lagu.mp4");
    _isAudioLoaded = true;
  }

  void _playSound() async {
    if (_isAudioLoaded) {
      await _audioPlayer.play(AssetSource("assets/lagu.mp4"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Suara', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 246, 244, 244),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Suara/Lagu', style: TextStyle(color: Colors.black)),
                  Switch(
                    value: _isSuaraOn,
                    onChanged: (bool value) {
                      setState(() {
                        _isSuaraOn = value;
                        if (widget.controller != null) {
                          widget.controller!.toggleSuara();
                        }
                      });
                    },
                    activeTrackColor: Colors.white,
                    activeColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Atur Volume', style: TextStyle(color: Colors.black)),
              Slider(
                value: _volume,
                onChanged: (double value) {
                  setState(() {
                    _volume = value;
                    if (widget.controller != null) {
                      widget.controller!.setVolume(value);
                    }
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${_volume.toStringAsFixed(1)}',
                activeColor: Colors.black,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _playSound,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text('Putar Lagu', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}