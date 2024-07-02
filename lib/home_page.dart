import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/networking.dart';
import 'package:weather_app/weather_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  void _searchWeather() async {
    setState(() {
      _isLoading = true;
    });

    String city = _controller.text;

    var weatherData = await Networking.getWeather(city);
    setState(() {
      _isLoading = false;
    });

    if (weatherData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WeatherDetailsScreen(weatherData: weatherData, city: city),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('City not Found'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      // backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
            child: Text(
          'Weather App',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: _searchWeather,
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70,
                ),
                child: Text('Get Weather'),
              ),
            ),
            if (_isLoading)
              SpinKitRing(
                color: Colors.blue,
                size: 50,
              ),
          ],
        ),
      ),
    );
  }
}
