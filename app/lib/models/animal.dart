import 'dart:convert';
import 'package:oisely_client/oisely_client.dart';
import 'package:uuid/uuid.dart';

/// Represents a stored behavior analysis with timestamp
class StoredBehaviorAnalysis {
  final String id;
  final BehaviorAnalysisInsight insight;
  final DateTime timestamp;

  StoredBehaviorAnalysis({
    String? id,
    required this.insight,
    required this.timestamp,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'insight': insight.toJson(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory StoredBehaviorAnalysis.fromJson(Map<String, dynamic> json) {
    return StoredBehaviorAnalysis(
      id: json['id'] as String?,
      insight: BehaviorAnalysisInsight.fromJson(
        json['insight'] as Map<String, dynamic>,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

/// Represents an animal that has been identified
class Animal {
  final String id;
  final String species;
  final String? breed;
  final String imageUrl;
  final DateTime identifiedAt;
  final bool isAdopted;
  final AdoptionInfo? adoptionInfo;
  final String? localImagePath;
  final List<StoredBehaviorAnalysis> behaviorAnalyses;

  Animal({
    required this.id,
    required this.species,
    this.breed,
    required this.imageUrl,
    required this.identifiedAt,
    this.isAdopted = false,
    this.adoptionInfo,
    this.localImagePath,
    List<StoredBehaviorAnalysis>? behaviorAnalyses,
  }) : behaviorAnalyses = behaviorAnalyses ?? [];

  /// Get the most recent behavior analysis
  StoredBehaviorAnalysis? get latestBehaviorAnalysis {
    if (behaviorAnalyses.isEmpty) return null;
    return behaviorAnalyses.reduce(
      (a, b) => a.timestamp.isAfter(b.timestamp) ? a : b,
    );
  }

  /// Get analysis count
  int get behaviorAnalysisCount => behaviorAnalyses.length;

  Animal copyWith({
    String? id,
    String? species,
    String? breed,
    String? imageUrl,
    DateTime? identifiedAt,
    bool? isAdopted,
    AdoptionInfo? adoptionInfo,
    String? localImagePath,
    List<StoredBehaviorAnalysis>? behaviorAnalyses,
  }) {
    return Animal(
      id: id ?? this.id,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      imageUrl: imageUrl ?? this.imageUrl,
      identifiedAt: identifiedAt ?? this.identifiedAt,
      isAdopted: isAdopted ?? this.isAdopted,
      adoptionInfo: adoptionInfo ?? this.adoptionInfo,
      localImagePath: localImagePath ?? this.localImagePath,
      behaviorAnalyses: behaviorAnalyses ?? this.behaviorAnalyses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'species': species,
      'breed': breed,
      'imageUrl': imageUrl,
      'identifiedAt': identifiedAt.toIso8601String(),
      'isAdopted': isAdopted,
      'adoptionInfo': adoptionInfo?.toJson(),
      'localImagePath': localImagePath,
      'behaviorAnalyses': behaviorAnalyses.map((a) => a.toJson()).toList(),
    };
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    // Handle migration from old single analysis field
    final List<StoredBehaviorAnalysis> analyses = [];

    // Check for new list format first
    if (json['behaviorAnalyses'] != null) {
      analyses.addAll(
        (json['behaviorAnalyses'] as List)
            .map(
              (a) => StoredBehaviorAnalysis.fromJson(a as Map<String, dynamic>),
            )
            .toList(),
      );
    }

    // Migrate from old single analysis field if exists
    if (json['behaviorAnalysis'] != null) {
      analyses.add(
        StoredBehaviorAnalysis.fromJson(
          json['behaviorAnalysis'] as Map<String, dynamic>,
        ),
      );
    }

    return Animal(
      id: json['id'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String?,
      imageUrl: json['imageUrl'] as String,
      identifiedAt: DateTime.parse(json['identifiedAt'] as String),
      isAdopted: json['isAdopted'] as bool,
      adoptionInfo: json['adoptionInfo'] != null
          ? AdoptionInfo.fromJson(json['adoptionInfo'] as Map<String, dynamic>)
          : null,
      localImagePath: json['localImagePath'] as String?,
      behaviorAnalyses: analyses,
    );
  }

  String get displayName =>
      breed != null && breed!.isNotEmpty ? '$species ($breed)' : species;
}
