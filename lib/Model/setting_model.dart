class SuaraModel {
  bool isSuaraOn;
  double volume;
  String? selectedSongPath;  // Tambahkan properti ini

  SuaraModel({required this.isSuaraOn, required this.volume, this.selectedSongPath});

  void toggleSuara() {
    isSuaraOn = !isSuaraOn;
  }

  void setVolume(double value) {
    volume = value;
  }

  void setSelectedSong(String path) {  // Tambahkan method ini
    selectedSongPath = path;
  }
}
