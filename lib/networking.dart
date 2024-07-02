import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '9d97138da1fd4302d98e7c3c019f9fdf';
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class Networking {
  static Future getWeather(String city) async {
    var url = '$openWeatherMapURL?q=$city&appid=$apiKey&units=metric';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
