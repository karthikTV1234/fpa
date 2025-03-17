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
import 'package:fpa/widgets/dropdown/dropdown_widget.dart';
import '../widgets/date_picker_widget.dart';

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
              Navigator.pop(context);  // Go back after success
            } else if (state is AddEntryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownField(
                  items: categories,
                  label: 'Select Category',
                  onChanged: (value) {
                    print('Selected Category: $value');
                    // Dispatch the CategorySelected event when a category is selected
                    context.read<AddEntryBloc>().add(CategorySelected(value));
                  },
                ),

                // Item Dropdown (Depends on Category)
                DropdownField(
                  items: const ['Apple', 'Orange', 'Potato', 'Tomato'], // Add your item list here
                  label: 'Select Item',
                  onChanged: (value) {
                    print('Selected Item: $value');
                  },
                ),

                const SizedBox(height: 16),
                const Text('Select Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DatePickerField(controller: dateController),
                const SizedBox(height: 16),

                LocationField(controller: locationController),

                PriceField(controller: priceController),


                BlocBuilder<AddEntryBloc, AddEntryState>(
                  builder: (context, state) {
                    if (state is AddEntryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SubmitButton(
                      onPressed: () {
                        final entry = Entry(
                          category: 'Vegetable', // Replace with actual value
                          item: 'Apple', // Replace with actual value
                          date: dateController.text, // Replace with actual value
                          location: locationController.text,
                          price: double.tryParse(priceController.text) ?? 0.0,
                        );
                        context.read<AddEntryBloc>().add(SubmitEntry(entry));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
