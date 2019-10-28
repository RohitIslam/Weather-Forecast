import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/weather_service.dart';

import '../constants.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  const LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherService weatherService = WeatherService();

  int temperature;
  String weatherIcon;
  String weatherMessage;
  String cityName;

  @override
  void initState() {
    updateUI(widget.weatherData);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Error, unable to get weather data';
        cityName = '';
        return;
      }
      dynamic temp = weatherData['main']['temp'];

      temperature = temp.toInt();
      var message = weatherService.getMessage(temperature);

      var conditionNumber = weatherData['weather'][0]['id'];
      weatherIcon = weatherService.getWeatherIcon(conditionNumber);

      cityName = weatherData['name'];
      weatherMessage = "$message in $cityName!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        margin: const EdgeInsets.all(10),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.my_location,
                    size: 26,
                  ),
                  Text(
                    cityName,
                    style: kCityTextStyle,
                  ),
                  Icon(
                    Icons.search,
                    size: 26,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    weatherIcon,
                    style: kConditionTextStyle,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          "C",
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${DateFormat.MMMMEEEEd().format(DateTime.now())}',
                    style: kDateTextStyle,
                  ),
                ],
              ),
              Container(
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
