import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './location_screen.dart';
import '../services/weather_service.dart';
import '../constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherService().getLocationWeather();
    print(weatherData);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(weatherData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(5),
            width: 200,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: kBackgroundColorLight,
            ),
            child: Text(
              'Weather',
              style: TextStyle(
                fontFamily: 'Spartan MB',
                fontSize: 30,
              ),
            ),
          ),
          SpinKitWanderingCubes(
            color: Colors.white,
            size: 100,
          ),
        ],
      ),
    );
  }
}
