import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/modal_class/weather_modal.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherModal> futureWeather;

  Future<WeatherModal> fetchWeather() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=31.118793&lon=74.463272&appid=7c63333c6d90403be80c96eea0883518');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WeatherModal.fromjson(data);
    } else {
      throw Exception('Could not fetch data');
    }
  }

  @override
  void initState() {
    futureWeather = fetchWeather();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<WeatherModal>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              WeatherModal weatherData = snapshot.data!;
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        "Temperature: ${weatherData.main.temp}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Description : ${weatherData.weather.description}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Humidity : ${weatherData.main.humidity}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Wind Speed : ${weatherData.wind.speed}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text(snapshot.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
