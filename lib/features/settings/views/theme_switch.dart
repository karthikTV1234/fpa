import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/theme/theme_cubit.dart'; // Adjust path if needed

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('System Default'),
          value: ThemeMode.system,
          groupValue: themeMode,
          onChanged: (mode) => context.read<ThemeCubit>().setTheme(mode!),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Light'),
          value: ThemeMode.light,
          groupValue: themeMode,
          onChanged: (mode) => context.read<ThemeCubit>().setTheme(mode!),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Dark'),
          value: ThemeMode.dark,
          groupValue: themeMode,
          onChanged: (mode) => context.read<ThemeCubit>().setTheme(mode!),
        ),
      ],
    );
  }
}
