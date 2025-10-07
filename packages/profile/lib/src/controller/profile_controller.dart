import 'dart:io';
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _bio = '';
  int _age = 0;
  bool _dark = false;
  File? _image;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get bio => _bio;
  int get age => _age;
  bool get dark => _dark;
  File? get image => _image;

  void updateProfileImage(File? newImage) {
    _image = newImage;
    notifyListeners();
  }

  void updateColor(bool newName) {
    _dark = newName;
    notifyListeners();
  }

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }
  
  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }
  
  void updatePhone(String newPhone) {
    _phone = newPhone;
    notifyListeners();
  }
  
  void updateBio(String newBio) {
    _bio = newBio;
    notifyListeners();
  }
  
  void updateAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }
  
  void incrementAge() {
    _age++;
    notifyListeners();
  }
  
  void decrementAge() {
    if (_age > 0) {
      _age--;
      notifyListeners();
    }
  }
  
  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? bio,
    int? age,
  }) {
    _name = name ?? _name;
    _email = email ?? _email;
    _phone = phone ?? _phone;
    _bio = bio ?? _bio;
    _age = age ?? _age;
    notifyListeners();
  }
  
  void clear() {
    _name = '';
    _email = '';
    _phone = '';
    _bio = '';
    _age = 0;
    _dark = false;
    _image = null;

    notifyListeners();
  }
  
  Map<String, dynamic> get userData => {
    'name': _name,
    'email': _email,
    'phone': _phone,
    'bio': _bio,
    'age': _age,
  };

}