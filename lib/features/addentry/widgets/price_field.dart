import 'package:flutter/material.dart';

class PriceField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator function

  const PriceField({Key? key, required this.controller, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price (per kg)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
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
