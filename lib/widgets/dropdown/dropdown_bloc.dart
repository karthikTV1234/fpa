import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(const DropdownState()) {
    on<InitializeDropdown>((event, emit) {
      emit(DropdownState(items: event.items, selectedItem: event.initialItem ?? (event.items.isNotEmpty ? event.items[0] : null)));
    });

    on<SelectItem>((event, emit) {
      emit(DropdownState(items: state.items, selectedItem: event.selectedItem));
    });
  }
}
