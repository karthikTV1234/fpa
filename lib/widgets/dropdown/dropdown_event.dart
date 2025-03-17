import 'package:equatable/equatable.dart';

abstract class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object?> get props => [];
}

// Initialize dropdown with items
class InitializeDropdown extends DropdownEvent {
  final List<String> items;
  final String? initialItem;

  const InitializeDropdown({required this.items, this.initialItem});

  @override
  List<Object?> get props => [items, initialItem];
}

// Select item from dropdown
class SelectItem extends DropdownEvent {
  final String selectedItem;

  const SelectItem(this.selectedItem);

  @override
  List<Object?> get props => [selectedItem];
}
