import 'package:flutter/material.dart';

class NavigationHelper {
  static void push(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void replace(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void pop(BuildContext context, [result]) {
    Navigator.pop(context, result);
  }
}
