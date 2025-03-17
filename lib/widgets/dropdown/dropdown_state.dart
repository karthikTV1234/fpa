import 'package:equatable/equatable.dart';

class DropdownState extends Equatable {
  final List<String> items;
  final String? selectedItem;

  const DropdownState({this.items = const [], this.selectedItem});

  @override
  List<Object?> get props => [items, selectedItem];
}
