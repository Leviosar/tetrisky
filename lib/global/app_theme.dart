import 'package:flutter/painting.dart';

class AppThemeColors {
  Color blue;
  Color green;
  Color yellow;
  Color orange;
  Color red;

  AppThemeColors() {
    this.blue = Color(0xff264653);
    this.green = Color(0xff2a9d8f);
    this.yellow = Color(0xffe9c46a);
    this.orange = Color(0xfff4a261);
    this.red = Color(0xffe76f51);
  }
}

class AppTheme {
  AppThemeColors colors;

  AppTheme() {
    this.colors = new AppThemeColors();
  }
}