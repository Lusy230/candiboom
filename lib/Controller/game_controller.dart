// controllers/game_controller.dart
import 'package:candiboom/Model/candi_model.dart';
import 'package:flutter/material.dart';

class GameController {
  CandiModel candyModel;
  final Function(int) onScoreUpdated;
  final VoidCallback onCandiesUpdated; // Updated this line
  int score;

  GameController({
    required this.onScoreUpdated, 
    required this.onCandiesUpdated, 
    required String currentLanguage})
      : candyModel = CandiModel(),
        score = 0;
  
   void onTileTapped(int tappedIndex) {
    final List<int> matchingIndices = getMatchingIndices(tappedIndex);

    if (matchingIndices.length >= 3) {
      candyModel.removeCandies(matchingIndices);
      updateScore(matchingIndices.length);
      onScoreUpdated(score); // Notify the UI about the updated score

      // Trigger the fall effect immediately for the matched candies
      triggerFallEffect(matchingIndices);
    }
  }

  void updateScore(int points) {
    score += points;
  }

 void triggerFallEffect(List<int> affectedIndices) {
    // Apply gravity only for the affected indices
    candyModel.applyGravity(affectedIndices);
    onCandiesUpdated(); // Notify the UI after the fall effect
  }

  List<int> getAdjacentIndices(int index) {
    final List<int> adjacentIndices = [];
    if (index % candyModel.rowSize > 0) {
      adjacentIndices.add(index - 1); // Left
    }
    if (index % candyModel.rowSize < candyModel.rowSize - 1) {
      adjacentIndices.add(index + 1); // Right
    }
    if (index >= candyModel.rowSize) {
      adjacentIndices.add(index - candyModel.rowSize); // Up
    }
    if (index < candyModel.boardSize - candyModel.rowSize) {
      adjacentIndices.add(index + candyModel.rowSize); // Down
    }
    return adjacentIndices;
  }

  List<int> getMatchingIndices(int tappedIndex) {
    final List<int> matchingIndices = [tappedIndex];
    final String targetAsset = candyModel.getCandyAsset(tappedIndex);

    void checkNeighbor(int index) {
      final List<int> adjacentIndices = getAdjacentIndices(index);
      for (int adjacentIndex in adjacentIndices) {
        if (!matchingIndices.contains(adjacentIndex) &&
            candyModel.getCandyAsset(adjacentIndex) == targetAsset) {
          matchingIndices.add(adjacentIndex);
          checkNeighbor(adjacentIndex);
        }
      }
    }

    checkNeighbor(tappedIndex);
    return matchingIndices;
  }
}