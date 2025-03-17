import 'package:flutter/material.dart';
import 'navigation/routes/app_navigator.dart';
import 'navigation/bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriPriceTrack',
      initialRoute: '/', // Set initial route if needed
      home: BottomNavigation(), // Bottom Navigation Bar as the home screen
      onGenerateRoute: AppNavigator.generateRoute, // Hook up the route generator
    );
  }
}
