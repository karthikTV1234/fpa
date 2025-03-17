import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/data/repositories/entry_repository.dart';
import 'package:fpa/data/category_item_data.dart';
import 'add_entry_event.dart';
import 'add_entry_state.dart';

class AddEntryBloc extends Bloc<AddEntryEvent, AddEntryState> {
  final EntryRepository entryRepository;

  String selectedCategory = '';
  String selectedItem = '';
  List<String> items = [];

  AddEntryBloc(this.entryRepository) : super(AddEntryInitial()) {
    on<SubmitEntry>(_onSubmitEntry);
    on<CategorySelected>(_onCategorySelected); // Handle category selection
    on<ItemSelected>(_onItemSelected);

  }

  // Handle entry submission
  Future<void> _onSubmitEntry(SubmitEntry event, Emitter<AddEntryState> emit) async {
    emit(AddEntryLoading());
    try {
      // Log the entry data before saving
      print('Saving entry to DB: ${event.entry.toMap()}');
      final result = await entryRepository.insertEntry(event.entry);
      if (result != -1) {
        emit(AddEntrySuccess());
      } else {
        emit(AddEntryFailure('Failed to add entry.'));
      }
    } catch (e) {
      emit(AddEntryFailure(e.toString()));
    }
  }

  void _onCategorySelected(CategorySelected event, Emitter<AddEntryState> emit) {
    selectedCategory = event.category;
    selectedItem = ''; // Reset item when category changes
    items = categoryItems[event.category] ?? [];
    emit(AddEntryFormState(
      selectedCategory: selectedCategory,
      selectedItem: selectedItem,
      items: items,
    ));
  }

  void _onItemSelected(ItemSelected event, Emitter<AddEntryState> emit) {
    selectedItem = event.item;
    emit(AddEntryFormState(
      selectedCategory: selectedCategory,
      selectedItem: selectedItem,
      items: items,
    ));
  }
}
