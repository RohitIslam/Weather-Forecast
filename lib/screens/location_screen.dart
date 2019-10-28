import 'package:flutter/material.dart';

import '../services/weather_service.dart';

import '../constants.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  const LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Current Location Icon',
                  ),
                  Text(
                    'City Name',
                  ),
                  Text(
                    'Search City Icon',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Weather Icon',
                  ),
                  Text(
                    'Temperature',
                  ),
                  Text(
                    'Current Date',
                  ),
                ],
              ),
              Container(
                child: Text(
                  'Weather Message',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
