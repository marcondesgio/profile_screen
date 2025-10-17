import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _bio = '';
  int _age = 0;
  bool _dark = false;
  File? _image;
  Timer? _timer;
  bool _isLoading = false;
  int _seconds = 0;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get bio => _bio;
  int get age => _age;
  bool get dark => _dark;
  File? get image => _image;
  Timer? get timer => _timer;
  bool get isLoading => _isLoading;
  int get seconds => _seconds;

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

  Future<void> selectProfileImage(
    BuildContext context,
    Color backgroundColor,
    Color primaryColor,
  ) async {
    final ImagePicker _picker = ImagePicker();

    await showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library, color: primaryColor),
                title: Text('Galeria', style: TextStyle(color: primaryColor)),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    updateProfileImage(File(pickedFile.path));
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: primaryColor),
                title: Text('Câmera', style: TextStyle(color: primaryColor)),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (pickedFile != null) {
                    updateProfileImage(File(pickedFile.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _isLoading = true;
    _seconds = 60;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds--;
      if (_seconds <= 0) {
        timer.cancel();
        _isLoading = false;
        _seconds = 0;
      }
      notifyListeners();
    });
  }

  String get formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
