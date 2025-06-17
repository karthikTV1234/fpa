import 'package:equatable/equatable.dart';
import 'package:fpa/features/entries/data/models/entry_model.dart';

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

// Event for selecting an item
class ItemSelected extends AddEntryEvent {
  final String item;

  const ItemSelected(this.item);

  @override
  List<Object?> get props => [item];
}
