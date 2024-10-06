import 'package:flutter/material.dart';

class Submission {
  String id;
  String assignmentId;
  String studentId;
  String videoUrl;
  String status; // 'pending', 'approved', 'rejected'
  String notes;

  Submission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.videoUrl,
    required this.status,
    required this.notes,
  });

  // Add methods to convert to/from JSON for Firebase
  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id'],
      assignmentId: json['assignmentId'],
      studentId: json['studentId'],
      videoUrl: json['videoUrl'],
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignmentId': assignmentId,
      'studentId': studentId,
      'videoUrl': videoUrl,
      'status': status,
      'notes': notes,
    };
  }
}

class SubmissionProvider with ChangeNotifier {
  List<Submission> _submissions = [];

  List<Submission> get submissions => _submissions;

  void addSubmission(Submission submission) {
    _submissions.add(submission);
    notifyListeners();
  }
}