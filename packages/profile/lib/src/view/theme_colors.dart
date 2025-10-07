import 'package:flutter/material.dart';

class ThemeColors {
  final bool dark;

  ThemeColors(this.dark);

  Color get primaryColor => !dark ? Colors.grey[900]! : Colors.grey[100]!;
  Color get secondaryColor => !dark ? Colors.grey[800]! : Colors.grey[100]!;
  Color get backgroundColor => !dark ? Colors.grey[100]! : Colors.grey[900]!;
  Color get cardColor => !dark ? Colors.white : Colors.grey[800]!;
}
