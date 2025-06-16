import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/widgets/my_dropdown_widget.dart';
import '../../../core/constants/locale_cubit.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current language code (e.g., 'en' or 'es')
    final currentLangCode = Localizations.localeOf(context).languageCode;

    // Localized label for dropdown title
    final label = AppLocalizations.of(context)!.generalLanguage;

    // Mapping of internal code ↔ display label
    final langMap = {
      'English': 'en',
      'Telugu': 'te',
      'Español': 'es',
    };

    // Find the currently selected label
    final currentLabel = langMap.entries
        .firstWhere((entry) => entry.value == currentLangCode)
        .key;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyDropdownField(
        label: label,
        selectedValue: currentLabel,
        items: langMap.keys.toList(),
        onChanged: (String? newLanguage) {
          if (newLanguage != null) {
            _changeLanguage(context, langMap[newLanguage]!); // Get the corresponding code
          }
        },
      ),
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    final newLocale = Locale(languageCode);
    context.read<LocaleCubit>().setLocale(newLocale);
  }
}
