import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants/locale_cubit.dart';
import '../../../core/constants/style/app_text_styles.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the language selector
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0), // Add some bottom padding
            child: Text(
              AppLocalizations.of(context)!.language, // Localized "Language" key
              style: MyAppTextStyles.headingStyle
            ),
          ),
          // Language selection dropdown
          DropdownButtonFormField<String>(
            value: Localizations.localeOf(context).languageCode,
            onChanged: (String? newLanguage) {
              if (newLanguage != null) {
                _changeLanguage(context, newLanguage);
              }
            },
            items: [
              DropdownMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: 'es',
                child: Text('Español'),
              ),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200], // Light grey background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey), // Border color
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside the dropdown
            ),
          ),
        ],
      ),
    );
  }

  // This method changes the language and updates the app's locale using LocaleCubit
  void _changeLanguage(BuildContext context, String languageCode) {
    Locale newLocale = Locale(languageCode); // Set the new locale
    context.read<LocaleCubit>().setLocale(newLocale); // Use LocaleCubit to change the locale
  }
}
