import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';


// Bottom Navigation BLoC
class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial(0)) {
    on<BottomNavItemSelected>((event, emit) {
      emit(BottomNavInitial(event.index));
    });
  }
}