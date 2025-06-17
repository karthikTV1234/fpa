import 'package:flutter/material.dart';
import 'package:fpa/features/entries/presentation/screens/add_entry_screen.dart';

import '../../app_routing/app_routes.dart';

class AppNavigator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.addEntry:
        return MaterialPageRoute(builder: (_) => AddEntryScreen());

    // Add more routes as needed
      default:
        return _errorRoute();
    }
  }

  // A generic error route when an invalid route is used
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Page not found")),
      ),
    );
  }
}
