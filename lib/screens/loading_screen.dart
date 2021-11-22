import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var apiKey = dotenv.env['API_KEY'];

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=c25ba34f6dfe3ff883dfc2c6d617b38a');

  @override
  void initState() {
    super.initState();
    getData();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();

    await location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);
      String cityName = decodedData['name'];
      int condition = decodedData['weather'][0]['id'];
      double temp = decodedData['main']['temp'];

      print(cityName);
      print(condition);
      print(temp);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
