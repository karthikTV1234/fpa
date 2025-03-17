import 'package:equatable/equatable.dart';
import 'package:fpa/data/models/entry_model.dart';

// Abstract class for all AddEntry events
abstract class AddEntryEvent extends Equatable {
  const AddEntryEvent();

  @override
  List<Object?> get props => [];
}

// Event to submit the entry
class SubmitEntry extends AddEntryEvent {
  final Entry entry;

  const SubmitEntry(this.entry);

  @override
  List<Object?> get props => [entry];
}

// Event for selecting a category
class CategorySelected extends AddEntryEvent {
  final String category;

  const CategorySelected(this.category);

  @override
  List<Object?> get props => [category];
}
