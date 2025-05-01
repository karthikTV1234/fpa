import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/features/entries/widgets/list_item_widget.dart';
import 'package:fpa/navigation/routes/app_routes.dart';
import '../../../core/constants/app_icons.dart';
import 'package:fpa/data/models/entry_model.dart';
import '../../../core/pagination/pagination_bloc.dart';
import '../../../core/pagination/pagination_event.dart';
import '../../../core/pagination/pagination_state.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("EntriesScreen initState triggered");

    // Load initial entries when the screen is opened
    context.read<PaginationBloc<Entry>>().add(LoadInitial<Entry>());

    // Detect scroll to trigger loading more data
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<PaginationBloc<Entry>>().add(LoadMore<Entry>());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("EntriesScreen build() called | hashCode: $hashCode");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entries'),
      ),
      body: BlocBuilder<PaginationBloc<Entry>, PaginationState<Entry>>(
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
            controller: _scrollController,
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
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, AppRoutes.addEntry);
          if (result == true) {
            // Reset and reload the entries
            context.read<PaginationBloc<Entry>>().add(LoadInitial<Entry>());
          }
        },
        child: const Icon(MyAppIcons.add),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
