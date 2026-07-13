import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/add_info.dart';
import 'package:weather_app/forecast_row.dart';
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
  String? desc;
  String? humid;
  String? wind;
  String? pressure;
  List<Map<String, dynamic>> hourlyData = [];
  String? errorMessage;

  bool isLoading = true;

  // Maps condition text to an appropriate Flutter icon
  IconData _conditionIcon(String condition) {
    final c = condition.toLowerCase();
    if (c.contains('sunny') || c.contains('clear')) return Icons.wb_sunny;
    if (c.contains('rain') || c.contains('drizzle')) return Icons.grain;
    if (c.contains('snow') || c.contains('blizzard')) return Icons.ac_unit;
    if (c.contains('thunder') || c.contains('storm')) return Icons.bolt;
    if (c.contains('fog') || c.contains('mist')) return Icons.foggy;
    if (c.contains('wind')) return Icons.wind_power;
    return Icons.cloud; // default
  }

  Future<void> fetchCurrentWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final api = dotenv.get('WEATHER_API');
      final response = await http.get(
        Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$api&q=New Delhi&days=1&aqi=no&alerts=no',
        ),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final current = data['current'] as Map<String, dynamic>;
        final condition = current['condition'] as Map<String, dynamic>;

        final List<dynamic> hours =
            data['forecast']['forecastday'][0]['hour'] as List<dynamic>;

        setState(() {
          isLoading = false;
          temp = (current['temp_c'] as num).toDouble();
          desc = condition['text'] as String;
          humid = current['humidity'].toString();
          pressure = current['pressure_mb'].toString();
          wind = current['wind_kph'].toString();
          const targetTimes = {'09:00', '12:00', '15:00', '18:00', '21:00'};
          hourlyData = hours.map((h) {
            final hMap = h as Map<String, dynamic>;
            return {
              'time': (hMap['time'] as String).split(' ').last, // "HH:mm"
              'desc': hMap['condition']['text'] as String,
              'temp': (hMap['temp_c'] as num).toDouble(),
            };
          }).where((h) => targetTimes.contains(h['time'])).toList();
        });
      } else {
        throw Exception('Failed to fetch weather data (${response.statusCode})');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load weather. Please try again.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // Disabled while a request is in flight to prevent duplicate calls
        onPressed: isLoading ? null : fetchCurrentWeather,
        backgroundColor: const Color.fromRGBO(59, 87, 126, 0.752),
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: const Text('Weather App'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 23.4,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.cloud_off, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: fetchCurrentWeather,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    if (temp != null && desc != null)
                      MainCard(
                        temp: temp!,
                        icon: _conditionIcon(desc!),
                        desc: desc!,
                      ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 6, 8, 8),
                        child: Text(
                          'Forecast',
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
                        children: hourlyData.map((h) {
                          return HourlyForecast(
                            time: h['time'] as String,
                            icon: _conditionIcon(h['desc'] as String),                            temp: h['temp'] as double,
                          );
                        }).toList(),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 8, 8, 0),
                        child: Text(
                          'Additional Info',
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
                        AddInfo(
                          name: 'Humidity',
                          icon: Icons.water,
                          value: humid,
                        ),
                        AddInfo(
                          name: 'Wind Speed',
                          icon: Icons.wind_power,
                          value: wind,
                        ),
                        AddInfo(
                          name: 'Pressure',
                          icon: Icons.compress,
                          value: pressure,
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
