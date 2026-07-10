import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/add_info.dart';
import 'package:weather_app/forcast_row.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/main_card.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  double? temp;
  String? icon;
  String? desc;
  bool isLoading = true;

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
    });
    try {
      await dotenv.load();
      final api = dotenv.get('WEATHER_API');
      final response = await http.get(
        Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=$api&q=New Delhi&aqi=no',
        ),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final current = data['current'] as Map<String, dynamic>;
        final condition = current['condition'] as Map<String, dynamic>;

        setState(() {
          temp = (current['temp_c'] as num).toDouble();
          icon = condition['icon'] as String;
          desc = condition['text'] as String;
          isLoading = false;
        });
      } else {
        throw Exception('api data not here');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // You can also add some error handling state here
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchWeather();
        },
        backgroundColor: Color.fromRGBO(59, 87, 126, 0.752),
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Text("Weather App"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 23.4,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (temp != null && icon != null && desc != null)
                  MainCard(temp: temp!, icon: icon!, desc: desc!),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 8, 8),
                    child: Text(
                      "Forecast",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecast(time: "9:00", icon: Icons.cloud, desc: "cloudy"),
                      HourlyForecast(
                        time: "12:00",
                        icon: Icons.cloud,
                        desc: "cloudy",
                      ),
                      HourlyForecast(time: "3:00", icon: Icons.cloud, desc: "cloudy"),
                      HourlyForecast(time: "6:00", icon: Icons.cloud, desc: "cloudy"),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 8, 0),
                    child: Text(
                      "Additional Info",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AddInfo(name: "Humidity", icon: Icons.water, value: "89"),
                    AddInfo(name: "Wind Speed", icon: Icons.wind_power, value: "28"),
                    AddInfo(name: "pressure", icon: Icons.umbrella, value: "1003"),
                  ],
                ),
              ],
            ),
    );
  }
}
