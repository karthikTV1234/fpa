import 'package:flutter/material.dart';
import 'theme_switch.dart';
import 'language_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: const [
          ThemeSwitch(),
          Divider(
            height: 1.0, // Reduce height of the divider
            thickness: 0.5, // Make the divider thinner
            color: Colors.grey, // Optional: Set the color for the divider
          ),
          LanguageSelector(),
        ],
      ),
    );
  }
}
