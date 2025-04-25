import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator function

  const LocationField({Key? key, required this.controller, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context)!.addEntryLocation,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: validator, // Apply validator
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
