import 'package:flutter/material.dart';

class Assignment {
  String id;
  String title;
  String description;
  int keenKoins;
  String imageUrl;
  String videoUrl;
  String createdBy;
  List<String> assignedTo;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.keenKoins,
    required this.imageUrl,
    required this.videoUrl,
    required this.createdBy,
    required this.assignedTo,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      keenKoins: json['keenKoins'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      createdBy: json['createdBy'],
      assignedTo: List<String>.from(json['assignedTo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'keenKoins': keenKoins,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'createdBy': createdBy,
      'assignedTo': assignedTo,
    };
  }
}

class AssignmentProvider with ChangeNotifier {
  List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;

  void addAssignment(Assignment assignment) {
    _assignments.add(assignment);
    notifyListeners();
  }
}