import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownField extends StatelessWidget {
  final List<String> items;
  final String label;
  final Function(String) onChanged;

  const DropdownField({
    Key? key,
    required this.items,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DropdownBloc()..add(InitializeDropdown(items: items)),
      child: BlocBuilder<DropdownBloc, DropdownState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: state.selectedItem,
                items: state.items.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  context.read<DropdownBloc>().add(SelectItem(value!));
                  onChanged(value);
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
