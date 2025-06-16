import 'package:equatable/equatable.dart';

abstract class PaginationState<T> extends Equatable {
  const PaginationState();

  @override
  List<Object?> get props => [];
}

/// Initial loading state
class PaginationInitial<T> extends PaginationState<T> {}

/// Loading first page
class PaginationLoading<T> extends PaginationState<T> {}

/// Data loaded
class PaginationLoaded<T> extends PaginationState<T> {
  final List<T> items;
  final bool hasMore;

  const PaginationLoaded({
    required this.items,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [items, hasMore];
}

/// Error during initial load
class PaginationError<T> extends PaginationState<T> {
  final String message;

  const PaginationError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Loading more items (appends to existing data)
class PaginationLoadingMore<T> extends PaginationState<T> {
  final List<T> items;

  const PaginationLoadingMore(this.items);

  @override
  List<Object?> get props => [items];
}
