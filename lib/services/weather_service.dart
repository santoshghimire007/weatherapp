import 'dart:convert';

import 'package:api_send_data/models/weather_forecase_model.dart';
import 'package:http/http.dart' as http;

Future<WeatherForecast> getWeather({required String city}) async {
  String weatherUrl = 'https://goweather.herokuapp.com/weather/$city';

  http.Response response = await http.get(Uri.parse(weatherUrl));

  // print(response.body);
  if (response.statusCode == 200) {
    return WeatherForecast.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('error');
  }
}
