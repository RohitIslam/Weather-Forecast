import 'package:flutter/material.dart';

import './screens/loading_screen.dart';
// import './screens/city_screen.dart';
// import './screens/location_screen.dart';

import './constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: kBackgroundColor,
      ),
      home: LoadingScreen(),
    );
  }
}
