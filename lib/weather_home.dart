import 'package:flutter/material.dart';
import 'package:weather_app/add_info.dart';
import 'package:weather_app/forcast_row.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.fromLTRB(120, 30, 120, 20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(59, 87, 126, 0.752),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '3000!',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 13),
                const Icon(
                  Icons.cloud,
                  size: 80,
                ),
                const SizedBox(height: 13),
                const Text('Cloudy', style: TextStyle(fontSize: 22)),
              ],
            ),
          ),
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
                HourlyForecast(time: "9:30", icon: Icons.cloud, desc: "cloudy"),
                HourlyForecast(time: "9:30", icon: Icons.cloud, desc: "cloudy"),
                HourlyForecast(time: "9:30", icon: Icons.cloud, desc: "cloudy"),
                HourlyForecast(time: "9:30", icon: Icons.cloud, desc: "cloudy"),
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
