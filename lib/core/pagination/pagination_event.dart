import 'package:equatable/equatable.dart';

abstract class PaginationEvent<T> extends Equatable {
  const PaginationEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered to load the first page or refresh
class LoadInitial<T> extends PaginationEvent<T> {}

/// Triggered to load the next page
class LoadMore<T> extends PaginationEvent<T> {}
