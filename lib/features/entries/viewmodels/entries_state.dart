import 'package:equatable/equatable.dart';
import 'package:fpa/data/models/entry_model.dart';

abstract class EntriesState extends Equatable {
  const EntriesState();

  @override
  List<Object> get props => [];
}

// Initial State
class EntriesInitial extends EntriesState {}

// Loading State
class EntriesLoading extends EntriesState {}

// Loaded State
class EntriesLoaded extends EntriesState {
  final List<Entry> entries;

  const EntriesLoaded(this.entries);

  @override
  List<Object> get props => [entries];
}
