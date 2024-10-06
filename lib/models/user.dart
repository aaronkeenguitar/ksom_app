import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      final userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      _user = User.fromJson(userDoc.data()!);
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        _user = User(
          id: firebaseUser.uid,
          name: name,
          role: 'user',
          keenKoins: 0,
          photoUrl: '',
          themeMode: ThemeMode.system,
        );
        await _firestore.collection('users').doc(firebaseUser.uid).set(_user!.toJson());
        notifyListeners();
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await fetchUser();
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  void updateName(String name) {
    if (_user != null) {
      _user!.name = name;
      _firestore.collection('users').doc(_user!.id).update({'name': name});
      notifyListeners();
    }
  }

  void updatePhotoUrl(String photoUrl) {
    if (_user != null) {
      _user!.photoUrl = photoUrl;
      _firestore.collection('users').doc(_user!.id).update({'photoUrl': photoUrl});
      notifyListeners();
    }
  }

  void updateTheme(ThemeMode themeMode) {
    if (_user != null) {
      _user!.themeMode = themeMode;
      _firestore.collection('users').doc(_user!.id).update({'themeMode': themeMode.index});
      notifyListeners();
    }
  }
}

class User {
  String id;
  String name;
  String role;
  int keenKoins;
  String photoUrl;
  ThemeMode themeMode;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.keenKoins,
    required this.photoUrl,
    this.themeMode = ThemeMode.system,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      keenKoins: json['keenKoins'],
      photoUrl: json['photoUrl'],
      themeMode: ThemeMode.values[json['themeMode'] ?? ThemeMode.system.index],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'keenKoins': keenKoins,
      'photoUrl': photoUrl,
      'themeMode': themeMode.index,
    };
  }
}