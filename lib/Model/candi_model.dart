// Model/candi_model.dart
import 'dart:math';

class CandiModel {
  final int rowSize = 8;
  List<String> candies = [];

  CandiModel() {
    // Initialize candies with random asset identifiers
    generateRandomCandies();
  }

  void generateRandomCandies() {
    // Initialize candies with random asset identifiers
    final random = Random();
    for (int i = 0; i < rowSize * rowSize; i++) {
      candies.add("Borobudur.png");
      candies.add("Candi Prambanan.png");
      candies.add("cankuang.png"); // Assuming you have 5 different candy assets
    }
  }

  String getCandyAsset(int index) {
    return candies[index];
  }

  void removeCandies(List<int> indices) {
    // Remove candies at given indices
    for (int index in indices) {
      candies[index] = "empty"; // Assuming "empty" is an identifier for an empty cell
    }
  }
 void applyGravity(List<int> affectedIndices) {
    for (int col = 0; col < rowSize; col++) {
      for (int row = rowSize - 1; row > 0; row--) {
        if (affectedIndices.contains(row * rowSize + col) && candies[row * rowSize + col] == "empty") {
          // Find the nearest non-empty candy above and make it fall down
          int nonEmptyRow = row - 1;
          while (nonEmptyRow >= 0 && candies[nonEmptyRow * rowSize + col] == "empty") {
            nonEmptyRow--;
          }

          if (nonEmptyRow >= 0) {
            candies[row * rowSize + col] = candies[nonEmptyRow * rowSize + col];
            candies[nonEmptyRow * rowSize + col] = "empty";
          }
        }
      }
    }
  }


  int get boardSize => candies.length;
}