import 'package:flutter/material.dart';
import 'package:flutter_app_exam/firstscreen/FirstScreen.dart';
import 'package:flutter_app_exam/main.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  FirstScreen _firstScreen = FirstScreen();
  MyApp _myApp = MyApp();
  int _currentScreenIndex = 0;

  _getCurrentScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return _firstScreen;
      case 1:
        return _myApp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
    );
  }
}
