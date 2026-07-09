import 'package:flutter/material.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 23.4,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Container(
        // height: 300,
        margin: EdgeInsets.symmetric(vertical: 13, horizontal: 18),
        padding: EdgeInsets.all(100),
        decoration: BoxDecoration(
          color: Color.fromRGBO(66, 139, 93, 1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('3000!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
            const Icon(Icons.cloud),
            const Text('Cloudy', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
