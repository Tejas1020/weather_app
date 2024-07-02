import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'networking.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final Map weatherData;
  final String city;

  WeatherDetailsScreen({required this.weatherData, required this.city});

  @override
  _WeatherDetailsScreenState createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  late Map weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = widget.weatherData;
  }

  void _refreshWeatherData() async {
    var updatedWeatherData = await Networking.getWeather(widget.city);
    setState(() {
      weatherData = updatedWeatherData;
    });
  }

  // weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
        return 'assets/mist.json';
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/showers.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    String weatherCondition = weatherData['weather'][0]['main'];
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.city,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Lottie.asset(getWeatherAnimation(weatherCondition)),
            Text(
              'Temperature: ${weatherData['main']['temp']} °C',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'Condition: ${weatherData['weather'][0]['description']}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'Humidity: ${weatherData['main']['humidity']} %',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'Wind Speed: ${weatherData['wind']['speed']} m/s',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _refreshWeatherData,
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70,
                ),
                child: Text('Refresh'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
