import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../services/weather_service.dart';

import '../widgets/top_icon_button.dart';

import '../constants.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  const LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherService _weatherService = WeatherService();

  int _temperature;
  String _weatherIcon;
  String _weatherMessage;
  String _cityName;
  String _typedCityName;
  bool _doSearch = false;
  bool _showSpinnier = false;

  @override
  void initState() {
    updateUI(widget.weatherData);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        _temperature = 0;
        _weatherIcon = 'Error';
        _weatherMessage = 'Error, unable to get weather data';
        _cityName = 'Invalid';
        return;
      }
      dynamic temp = weatherData['main']['temp'];

      _temperature = temp.toInt();
      var message = _weatherService.getMessage(_temperature);

      var conditionNumber = weatherData['weather'][0]['id'];
      _weatherIcon = _weatherService.getWeatherIcon(conditionNumber);

      _cityName = weatherData['name'];
      _weatherMessage = "$message in $_cityName!";
      _doSearch = false;
    });
  }

  void _getCurrentLocationWeather() async {
    setState(() {
      _showSpinnier = true;
    });
    var weatherData = await WeatherService().getLocationWeather();
    setState(() {
      _showSpinnier = false;
    });
    updateUI(weatherData);
  }

  void _onSubmitCityName() async {
    if (_typedCityName != null) {
      setState(() {
        _showSpinnier = true;
      });
      var weatherData = await _weatherService.getCityWeather(_typedCityName);
      setState(() {
        _showSpinnier = false;
      });
      updateUI(weatherData);
      _typedCityName = null;
    } else {
      _getCurrentLocationWeather();
    }
  }

  @override
  void dispose() {
    _showSpinnier = false;
    _doSearch = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinnier,
        child: Container(
          margin: const EdgeInsets.all(10),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopIconButton(
                      icon: Icons.my_location,
                      onPress: _getCurrentLocationWeather,
                    ),
                    Text(
                      _cityName,
                      style: kCityTextStyle,
                    ),
                    TopIconButton(
                      icon: Icons.search,
                      onPress: () {
                        setState(() {
                          _doSearch = !_doSearch;
                        });
                      },
                    ),
                  ],
                ),
                _doSearch
                    ? Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                icon: Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                ),
                                hintText: "Enter City Name",
                                hintStyle: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                _typedCityName = value;
                              },
                              onSubmitted: (_) => _onSubmitCityName(),
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              'Get Weather',
                              style: kButtonTextStyle,
                            ),
                            onPressed: _onSubmitCityName,
                          )
                        ],
                      )
                    : Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _weatherIcon,
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
                            '$_temperature°',
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
                    _weatherMessage,
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
