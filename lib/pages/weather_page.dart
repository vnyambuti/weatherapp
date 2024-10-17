import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apikey: '5dfccb677b55e38883360afe860641e9');
  Weather? _weather;

  _fetchWeather() async {
    //get city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city

    try {
      final weather = await _weatherService.getweather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city ..."),
            Text('${_weather?.temperature.round()} C'),
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
