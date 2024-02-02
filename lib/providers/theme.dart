import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData _themeData = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), );

  ThemeProvider();

  ThemeData get theme => _themeData;

  void toogleTheme() {
    final isDark = _themeData == ThemeData.dark();
    if(isDark){
      _themeData = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), );
    }else{
      _themeData = ThemeData.dark();
    }
    notifyListeners();
  }

}