import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/data/repositories/entry_repository.dart';
import 'add_entry_event.dart';
import 'add_entry_state.dart';

class AddEntryBloc extends Bloc<AddEntryEvent, AddEntryState> {
  final EntryRepository entryRepository;

  AddEntryBloc(this.entryRepository) : super(AddEntryInitial()) {
    on<SubmitEntry>(_onSubmitEntry);
    on<CategorySelected>(_onCategorySelected); // Handle category selection
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

  // Handle category selection
  void _onCategorySelected(CategorySelected event, Emitter<AddEntryState> emit) {
    emit(CategorySelectedState(event.category));  // Emit the category selected state
  }
}
