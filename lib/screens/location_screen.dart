import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationData});

  final locationData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int _temperature;
  late String _weatherIcon, _city, _weatherMessage;
  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic locationData) {
    setState(() {
      if (locationData == null) {
        _temperature = 0;
        _weatherIcon = 'error';
        _city = '';
        _weatherMessage = 'Unable to get the location';
        return;
      }
      double temperature = locationData['main']['temp'];
      _temperature = temperature.toInt();
      var condition = locationData['weather'][0]['id'];
      _city = locationData['name'];

      _weatherIcon = weatherModel.getWeatherIcon(condition);
      _weatherMessage = weatherModel.getMessage(_temperature);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData =
                          await weatherModel.getWeatherInformation();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      dynamic typedCity = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));
                      if (typedCity != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
                child: Text(
                  '$_weatherMessage in $_city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
