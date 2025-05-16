import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/data/models/entry_model.dart';
import '../../../core/pagination/pagination_bloc.dart';
import '../../../core/pagination/pagination_state.dart';
import 'list_item_widget.dart';

class PaginatedListView extends StatelessWidget {
  const PaginatedListView({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<Entry>, PaginationState<Entry>>(
      builder: (context, state) {
        final List<Entry> items;
        bool hasMore = true;
        if (state is PaginationLoading<Entry>) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PaginationLoaded<Entry>) {
          items = state.items;
          hasMore = state.hasMore;
        } else if (state is PaginationLoadingMore<Entry>) {
          items = state.items;
        } else if (state is PaginationError<Entry>) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("Something went wrong."));
        }

        if (items.isEmpty) {
          return const Center(child: Text("No entries available."));
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: items.length + (hasMore ? 1 : 0), // Add extra item for loader
          itemBuilder: (context, index) {
            if (index < items.length) {
              return EntryListItem(entry: items[index]);
            } else {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      },
    );
  }
}
