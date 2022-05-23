import 'package:api_send_data/models/weather_forecase_model.dart';
import 'package:flutter/material.dart';
import 'package:api_send_data/services/weather_service.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> cities = [
    'Kathmandu',
    'Lalitpur',
    'Pokhara',
    'Manang',
    'Mustang'
  ];
  String bgImage = 'assets/images/water.gif';
  WeatherForecast? weatherData;

  getWeatherImage(city) async {
    WeatherForecast data = await getWeather(city: city);
    setState(() {
      weatherData = data;
    });
    switch (data.description) {
      case 'Thunderstorm':
        setState(() {
          bgImage = 'assets/images/th.gif';
        });
        break;
      case 'Partly cloudy':
        setState(() {
          bgImage = 'assets/images/tornado.gif';
        });
        break;
      case 'Moderate or heavy snow showers':
        setState(() {
          bgImage = 'assets/images/sky.gif';
        });
        break;
      default:
    }
  }

  @override
  void initState() {
    getWeatherImage(cities[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getDays(days) {
      return DateFormat('EEEE')
          .format(DateTime.now().add(Duration(days: days)));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Kathmandu',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.fill)),
          child: Column(children: <Widget>[
            const SizedBox(height: 50),
            SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cities.length,
                    itemBuilder: (BuildContext context, int index) {
                      String city = cities[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              getWeatherImage(city);
                            },
                            child: Chip(label: Text(city))),
                      );
                    })),
            if (weatherData != null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Text(
                      weatherData!.temperature,
                      style: const TextStyle(fontSize: 70, color: Colors.white),
                    ),
                  ),
                  Text(weatherData!.wind!),
                  Text(weatherData!.description!),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: weatherData!.forecast!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Forecast forecast = weatherData!.forecast![index];
                            return Card(
                                child: ListTile(
                                    leading: const Icon(Icons.cloud),
                                    title:
                                        Text(getDays(int.parse(forecast.day!))),
                                    trailing: Text(forecast.temperature!)));
                          }))
                ],
                
              ),
          ])),
    );
  }
}
