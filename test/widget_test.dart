import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/add_info.dart';
import 'package:weather_app/forecast_row.dart';
import 'package:weather_app/main_card.dart';

void main() {
  // ─── MainCard ──────────────────────────────────────────────────────────────

  group('MainCard', () {
    testWidgets('displays temperature, description, and icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MainCard(
              temp: 28.5,
              icon: Icons.wb_sunny,
              desc: 'Sunny',
            ),
          ),
        ),
      );

      expect(find.text('28.5°C'), findsOneWidget);
      expect(find.text('Sunny'), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    });

    testWidgets('formats temperature to one decimal place', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MainCard(
              temp: 21.0,
              icon: Icons.cloud,
              desc: 'Cloudy',
            ),
          ),
        ),
      );

      expect(find.text('21.0°C'), findsOneWidget);
    });
  });

  // ─── AddInfo ───────────────────────────────────────────────────────────────

  group('AddInfo', () {
    testWidgets('displays label, value, and icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AddInfo(
              name: 'Humidity',
              icon: Icons.water,
              value: '72',
            ),
          ),
        ),
      );

      expect(find.text('Humidity'), findsOneWidget);
      expect(find.text('72'), findsOneWidget);
      expect(find.byIcon(Icons.water), findsOneWidget);
    });

    testWidgets('shows -- when value is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AddInfo(
              name: 'Pressure',
              icon: Icons.compress,
              value: null,
            ),
          ),
        ),
      );

      expect(find.text('--'), findsOneWidget);
    });
  });

  // ─── HourlyForecast ────────────────────────────────────────────────────────

  group('HourlyForecast', () {
    testWidgets('displays time, description, and icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HourlyForecast(
              time: '15:00',
              icon: Icons.grain,
              temp: 22.5,
            ),
          ),
        ),
      );

      expect(find.text('15:00'), findsOneWidget);
      expect(find.text('Light rain'), findsOneWidget);
      expect(find.byIcon(Icons.grain), findsOneWidget);
    });
  });
}
