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
import '../../../common/widgets/date_picker_widget.dart';
import '../../../common/widgets/my_dropdown_widget.dart';
import '../../../core/constants/strings/app_strings.dart';
import '../../../core/constants/strings/validation_messages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({Key? key}) : super(key: key);

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  late TextEditingController locationController;
  late TextEditingController priceController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController();
    priceController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    locationController.dispose();
    priceController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EntryRepository entryRepository = EntryRepository();

    return BlocProvider(
      create: (context) => AddEntryBloc(entryRepository),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Entry')),
        body: BlocListener<AddEntryBloc, AddEntryState>(
          listener: (context, state) {
            if (state is AddEntrySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.entryAdded)),
              );
              Navigator.pop(context, true); // Go back after success
            } else if (state is AddEntryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
               key: _formKey, // Assign form key
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
                    MyDropdownField(
                      items: categories,
                      label: AppLocalizations.of(context)!.addEntrySelectCategory,
                      selectedValue: selectedCategory.isNotEmpty ? selectedCategory : null,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AddEntryBloc>().add(CategorySelected(value));
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Item Dropdown (Updates based on category)
                    MyDropdownField(
                      items: items,
                      label: AppLocalizations.of(context)!.addEntrySelectItem,
                      selectedValue: selectedItem.isNotEmpty ? selectedItem : null,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AddEntryBloc>().add(ItemSelected(value));
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    Text(
                        AppLocalizations.of(context)!.addEntrySelectDate,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 8),
                    DatePickerField(controller: dateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ValidationMessages.invalidDate;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    LocationField(
                      controller: locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ValidationMessages.invalidLocation;
                        }
                        return null;
                      },
                    ),

                    PriceField(
                      controller: priceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ValidationMessages.invalidPrice;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<AddEntryBloc, AddEntryState>(
                      builder: (context, state) {
                        if (state is AddEntryLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return SubmitButton(
                            onPressed: () => _onSubmit(
                                context, selectedCategory, selectedItem,
                                dateController, locationController,
                                priceController
                            )
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
      ),
    );
  }

   void _onSubmit(BuildContext context, String selectedCategory, String selectedItem, TextEditingController dateController, TextEditingController locationController, TextEditingController priceController) {
     if (_formKey.currentState!.validate()) {
       final entry = Entry(
         category: selectedCategory.isNotEmpty ? selectedCategory : 'Unknown',
         item: selectedItem.isNotEmpty ? selectedItem : 'Unknown',
         date: dateController.text,
         location: locationController.text,
         price: double.tryParse(priceController.text) ?? 0.0,
       );
       context.read<AddEntryBloc>().add(SubmitEntry(entry));
     } else {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Please fill all fields correctly')),
       );
     }
   }

}
