import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
   bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }
  // bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
} 
 
class MyThemes { 
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    primarySwatch: Colors.red,
    primaryColor: Color(0xFFFD1919),
    accentColor: Color(0xFFE7AA07),
    fontFamily: 'Circular',
      );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFEDF6FC),
    primarySwatch: Colors.red,
    primaryColor: Color(0xFFFD1919),
    accentColor: Color(0xFFE7AA07),
    fontFamily: 'Circular',
  );
}
