import 'package:flutter_bloc/flutter_bloc.dart';
import 'entries_event.dart';
import 'entries_state.dart';
import 'package:fpa/data/repositories/entry_repository.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  final EntryRepository _entryRepository;

  EntriesBloc(this._entryRepository) : super(EntriesInitial()) {
    on<LoadEntries>((event, emit) async {
      emit(EntriesLoading());

      try {
        final entries = await _entryRepository.getAllEntries();
        emit(EntriesLoaded(entries));
      } catch (e) {
        print('Error loading entries: $e');
        emit(EntriesLoaded([]));  // Show empty list if there's an error
      }
    });
  }
}
