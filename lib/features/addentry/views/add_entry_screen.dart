import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/data/category_item_data.dart';
import 'package:fpa/data/models/entry_model.dart';
import 'package:fpa/data/repositories/entry_repository.dart';
import 'package:fpa/features/addentry/viewmodel/add_entry_bloc.dart';
import 'package:fpa/features/addentry/viewmodel/add_entry_event.dart';
import 'package:fpa/features/addentry/viewmodel/add_entry_state.dart';
import 'package:fpa/features/addentry/widgets/location_field.dart';
import 'package:fpa/features/addentry/widgets/price_field.dart';
import 'package:fpa/features/addentry/widgets/submit_button.dart';
import 'package:fpa/widgets/dropdown_widget.dart';
import '../../../widgets/date_picker_widget.dart';

class AddEntryScreen extends StatelessWidget {
  const AddEntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final EntryRepository entryRepository = EntryRepository();

    return BlocProvider(
      create: (context) => AddEntryBloc(entryRepository),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Entry')),
        body: BlocListener<AddEntryBloc, AddEntryState>(
          listener: (context, state) {
            if (state is AddEntrySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Entry added successfully!')),
              );
              Navigator.pop(context); // Go back after success
            } else if (state is AddEntryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AddEntryBloc, AddEntryState>(
              builder: (context, state) {
                String selectedCategory = '';
                String selectedItem = '';
                List<String> items = [];

                // Handle combined form state
                if (state is AddEntryFormState) {
                  selectedCategory = state.selectedCategory;
                  selectedItem = state.selectedItem;
                  items = state.items;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Dropdown
                    DropdownField(
                      items: categories,
                      label: 'Select Category',
                      selectedValue: selectedCategory.isNotEmpty ? selectedCategory : null,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AddEntryBloc>().add(CategorySelected(value));
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Item Dropdown (Updates based on category)
                    DropdownField(
                      items: items,
                      label: 'Select Item',
                      selectedValue: selectedItem.isNotEmpty ? selectedItem : null,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AddEntryBloc>().add(ItemSelected(value));
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    const Text('Select Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DatePickerField(controller: dateController),
                    const SizedBox(height: 16),

                    LocationField(controller: locationController),
                    PriceField(controller: priceController),
                    const SizedBox(height: 16),

                    BlocBuilder<AddEntryBloc, AddEntryState>(
                      builder: (context, state) {
                        if (state is AddEntryLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return SubmitButton(
                          onPressed: () {
                            final entry = Entry(
                              category: selectedCategory.isNotEmpty ? selectedCategory : 'Unknown',
                              item: selectedItem.isNotEmpty ? selectedItem : 'Unknown',
                              date: dateController.text,
                              location: locationController.text,
                              price: double.tryParse(priceController.text) ?? 0.0,
                            );
                            context.read<AddEntryBloc>().add(SubmitEntry(entry));
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
