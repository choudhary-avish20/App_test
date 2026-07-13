import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final double temp;
  final IconData icon;
  final String desc;

  const MainCard({
    super.key,
    required this.temp,
    required this.icon,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            '${temp.toStringAsFixed(1)}°C',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 13),
          Icon(icon, size: 80),
          const SizedBox(height: 13),
          Text(desc, style: const TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}