import 'package:equatable/equatable.dart';

abstract class EntriesEvent extends Equatable {
  const EntriesEvent();

  @override
  List<Object> get props => [];
}

// Load entries when the screen is opened
class LoadEntries extends EntriesEvent {}
