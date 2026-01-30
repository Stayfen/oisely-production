import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oisely_client/oisely_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/animal.dart';

/// Provider for managing animal adoption state and lists
class AdoptionProvider extends ChangeNotifier {
  static const String _animalsKey = 'oisely_animals';

  List<Animal> _animals = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Animal> get animals => List.unmodifiable(_animals);
  List<Animal> get interestingAnimals =>
      _animals.where((a) => !a.isAdopted).toList();
  List<Animal> get adoptedAnimals =>
      _animals.where((a) => a.isAdopted).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;

  AdoptionProvider() {
    _loadAnimals();
  }

  /// Load animals from local storage
  Future<void> _loadAnimals() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final animalsJson = prefs.getString(_animalsKey);

      if (animalsJson != null) {
        final List<dynamic> decoded = jsonDecode(animalsJson);
        _animals = decoded.map((json) => Animal.fromJson(json)).toList();
      }

      _error = null;
    } catch (e) {
      _error = 'Failed to load animals: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Save animals to local storage
  Future<void> _saveAnimals() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final animalsJson = jsonEncode(_animals.map((a) => a.toJson()).toList());
      await prefs.setString(_animalsKey, animalsJson);
    } catch (e) {
      _error = 'Failed to save animals: $e';
    }
  }

  /// Add a new identified animal
  Future<void> addAnimal(Animal animal) async {
    _animals.insert(0, animal); // Add to beginning of list
    await _saveAnimals();
    notifyListeners();
  }

  /// Adopt an animal (move from interesting to adopted)
  Future<void> adoptAnimal(String animalId) async {
    final index = _animals.indexWhere((a) => a.id == animalId);
    if (index != -1) {
      _animals[index] = _animals[index].copyWith(isAdopted: true);
      await _saveAnimals();
      notifyListeners();
    }
  }

  /// Un-adopt an animal (move from adopted to interesting)
  Future<void> unadoptAnimal(String animalId) async {
    final index = _animals.indexWhere((a) => a.id == animalId);
    if (index != -1) {
      _animals[index] = _animals[index].copyWith(isAdopted: false);
      await _saveAnimals();
      notifyListeners();
    }
  }

  /// Remove an animal
  Future<void> removeAnimal(String animalId) async {
    _animals.removeWhere((a) => a.id == animalId);
    await _saveAnimals();
    notifyListeners();
  }

  /// Check if an animal is adopted
  bool isAdopted(String animalId) {
    final animal = _animals.firstWhere(
      (a) => a.id == animalId,
      orElse: () => Animal(
        id: '',
        species: '',
        imageUrl: '',
        identifiedAt: DateTime.now(),
      ),
    );
    return animal.isAdopted;
  }

  /// Get animal by ID
  Animal? getAnimalById(String id) {
    try {
      return _animals.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all behavior analyses for an animal (sorted by timestamp, newest first)
  List<StoredBehaviorAnalysis> getBehaviorAnalyses(String animalId) {
    final animal = getAnimalById(animalId);
    if (animal == null) return [];

    final analyses = List<StoredBehaviorAnalysis>.from(animal.behaviorAnalyses);
    analyses.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return analyses;
  }

  /// Get latest behavior analysis for an animal
  StoredBehaviorAnalysis? getLatestBehaviorAnalysis(String animalId) {
    final animal = getAnimalById(animalId);
    return animal?.latestBehaviorAnalysis;
  }

  /// Get a specific behavior analysis by ID
  StoredBehaviorAnalysis? getBehaviorAnalysisById(
    String animalId,
    String analysisId,
  ) {
    final animal = getAnimalById(animalId);
    if (animal == null) return null;

    try {
      return animal.behaviorAnalyses.firstWhere((a) => a.id == analysisId);
    } catch (e) {
      return null;
    }
  }

  /// Save behavior analysis for an animal (adds to history)
  Future<void> saveBehaviorAnalysis(
    String animalId,
    BehaviorAnalysisInsight insight,
  ) async {
    final index = _animals.indexWhere((a) => a.id == animalId);
    if (index != -1) {
      final storedAnalysis = StoredBehaviorAnalysis(
        insight: insight,
        timestamp: DateTime.now(),
      );

      // Add to existing list
      final updatedAnalyses = List<StoredBehaviorAnalysis>.from(
        _animals[index].behaviorAnalyses,
      )..add(storedAnalysis);

      _animals[index] = _animals[index].copyWith(
        behaviorAnalyses: updatedAnalyses,
      );
      await _saveAnimals();
      notifyListeners();
    }
  }

  /// Delete a specific behavior analysis
  Future<void> deleteBehaviorAnalysis(
    String animalId,
    String analysisId,
  ) async {
    final index = _animals.indexWhere((a) => a.id == animalId);
    if (index != -1) {
      final updatedAnalyses = _animals[index].behaviorAnalyses
          .where((a) => a.id != analysisId)
          .toList();

      _animals[index] = _animals[index].copyWith(
        behaviorAnalyses: updatedAnalyses,
      );
      await _saveAnimals();
      notifyListeners();
    }
  }

  /// Clear all animals (for testing/logout)
  Future<void> clearAll() async {
    _animals = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_animalsKey);
    notifyListeners();
  }
}
