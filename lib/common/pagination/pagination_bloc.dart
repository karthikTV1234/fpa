import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/common/pagination/pagination_event.dart';
import 'package:fpa/common/pagination/pagination_state.dart';
import '../../core/constants/api_constants.dart';

//FetchPage<T> is the type of any function that takes (int offset, int limit)
// and returns Future<List<T>>
typedef FetchPage<T> = Future<List<T>> Function(int offset, int limit);

class PaginationBloc<T> extends Bloc<PaginationEvent<T>, PaginationState<T>> {
  final FetchPage<T> fetchPage;
  final int pageSize;

  int _currentPage = 0;
  bool _isFetching = false;
  bool _hasMore = true;
  List<T> _allItems = [];

  PaginationBloc({required this.fetchPage, this.pageSize = ApiConstants.pageSize}) : super(PaginationInitial<T>()) {
    on<LoadInitial<T>>(_onLoadInitial);
    on<LoadMore<T>>(_onLoadMore);
  }

  Future<void> _onLoadInitial(LoadInitial<T> event, Emitter<PaginationState<T>> emit) async {
    if (_isFetching) return;
    _isFetching = true;
    emit(PaginationLoading<T>());

    try {
      _currentPage = 0;
      _allItems.clear();
      final newItems = await fetchPage(0, pageSize);
      _allItems.addAll(newItems);
      _hasMore = newItems.length == pageSize;
      emit(PaginationLoaded<T>(items: _allItems, hasMore: _hasMore));
    } catch (e) {
      emit(PaginationError<T>('Failed to load data: $e'));
    }

    _isFetching = false;
  }

  Future<void> _onLoadMore(LoadMore<T> event, Emitter<PaginationState<T>> emit) async {
    if (_isFetching || !_hasMore) return;
    _isFetching = true;
    emit(PaginationLoadingMore<T>(_allItems));

    try {
      _currentPage++;
      final offset = _currentPage * pageSize;

      //Pause for 1 minute before fetching
      await Future.delayed(const Duration(minutes: 1));

      final newItems = await fetchPage(offset, pageSize);
      _allItems.addAll(newItems);
      _hasMore = newItems.length == pageSize;
      emit(PaginationLoaded<T>(items: _allItems, hasMore: _hasMore));
    } catch (e) {
      emit(PaginationError<T>('Failed to load more data: $e'));
    }

    _isFetching = false;
  }
}
