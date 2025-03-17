import 'package:equatable/equatable.dart';

// Abstract class for all AddEntry states
abstract class AddEntryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state when nothing happens yet
class AddEntryInitial extends AddEntryState {}

// Loading state when the entry is being submitted
class AddEntryLoading extends AddEntryState {}

// Success state when the entry is added successfully
class AddEntrySuccess extends AddEntryState {}

// Failure state when there's an error
class AddEntryFailure extends AddEntryState {
  final String error;

  AddEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// State when a category is selected
class CategorySelectedState extends AddEntryState {
  final String selectedCategory;

  CategorySelectedState(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}