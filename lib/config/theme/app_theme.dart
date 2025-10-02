import 'package:flutter/material.dart';

class AppTheme {
  //Clase interna anonima
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark
  );
}