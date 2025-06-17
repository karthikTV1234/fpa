import 'package:flutter/material.dart';

/// A helper class for handling app navigation using named routes.
class NavigationHelper {
  // Private constructor to prevent instantiation.
  NavigationHelper._();

  /// [T] is the expected return type.
  /// [context]: The BuildContext from which to navigate.
  /// [routeName]: The name of the route to push.
  /// [arguments]: Optional arguments to pass to the new route.

  /// Pushes a new route onto the navigator stack.
  static Future<T?> push<T extends Object?>(
      BuildContext context,
      String routeName, {
        Object? arguments,
      }) {
    //assert is great for debug-time checks. assert has no effect in production.
    assert(routeName.isNotEmpty, 'Route name cannot be empty');
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Replaces the current route with a new one by removing the previous one.
  static Future<T?> replace<T extends Object?, TO extends Object?>(
      BuildContext context,
      String routeName, {
        Object? arguments,
        TO? result,
      }) {
    //assert is great for debug-time checks. assert has no effect in production.
    assert(routeName.isNotEmpty, 'Route name cannot be empty');
    return Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Pops the top-most route off the navigator stack.
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// Replaces the entire stack with a new route.
  static Future<T?> replaceAll<T extends Object?>(
      BuildContext context,
      String routeName, {
        Object? arguments,
      }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
          (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }
}

