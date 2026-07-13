import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData? icon;
  final String? desc;

  const HourlyForecast({
    super.key,
    required this.time,
    required this.icon,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          margin: EdgeInsets.fromLTRB(12, 10, 0, 10),
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          decoration: BoxDecoration(
            color: Color.fromRGBO(59, 87, 126, 0.752),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                icon,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(desc!, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
