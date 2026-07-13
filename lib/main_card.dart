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
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(59, 87, 126, 0.752),
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