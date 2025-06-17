import 'package:flutter/material.dart';
import 'package:fpa/features/entries/presentation/screens/add_entry_screen.dart';
import '../../app_routing/app_routes.dart';

//Define routes (how route names map to screens) in AppNavigator.
//Used in main.dart file, in Material()
class AppNavigator {
  /// Prevents instantiation of this helper class.
  /// All methods are static and should be called directly on the class.
  AppNavigator._();

  /// Generates a [Route] based on the provided [RouteSettings].
  ///
  /// This method is typically used as the `onGenerateRoute` callback
  /// for `MaterialApp` or `CupertinoApp`.
  ///
  /// [settings]: Contains the name of the route to build and any arguments
  ///             passed to it.
  ///
  /// Returns a [MaterialPageRoute] for the specified route, or an error
  /// route if the route name is not recognized.
  ///
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.addEntry:
        return MaterialPageRoute(
            builder: (_) => AddEntryScreen(),
            settings: settings
        );

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
