import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app_routing/app_routes.dart';
import '../../../../common/pagination/pagination_bloc.dart';
import '../../../../common/pagination/pagination_event.dart';
import '../../../../core/constants/assets/system_icons.dart';
import 'package:fpa/features/entries/data/models/entry_model.dart';
import '../../data/repository/entry_repository.dart'; // Your API call logic
import '../widgets/paginated_listview.dart';

/// This is the screen-level wrapper that provides its own PaginationBloc
class EntriesScreen extends StatelessWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Creates a fresh PaginationBloc<Entry> only for this screen
      create: (_) => PaginationBloc<Entry>(
        fetchPage: (offset, limit) =>
            EntryRepository().getEntriesPaged(offset: offset, limit: limit),
      )..add(LoadInitial<Entry>()),

      // Child widget that uses this bloc instance
      child: const EntriesScreenBody(),
    );


    //fetchPage: (offset, limit) => EntryRepository().getEntriesPaged(offset: offset, limit: limit),
    //same as
    //fetchPage: (offset, limit) {
    //   return EntryRepository().getEntriesPaged(offset: offset, limit: limit);
    // },
    //offset, limit values are giving by fetchPage to getEntriesPaged method.

    //..add(LoadInitial<Entry>() Meaning
    //after creating the PaginationBloc, immediately call add(LoadInitial<Entry>()) on it.
    //This sends the LoadInitial event to the bloc, telling it to start loading the first page right away.

  }
}

/// The inner body of the screen that uses the Bloc
class EntriesScreenBody extends StatefulWidget {
  const EntriesScreenBody({Key? key}) : super(key: key);

  @override
  _EntriesScreenBodyState createState() => _EntriesScreenBodyState();
}

class _EntriesScreenBodyState extends State<EntriesScreenBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Add scroll listener to detect when user reaches end of list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Trigger loading more data
        context.read<PaginationBloc<Entry>>().add(LoadMore<Entry>());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entries')),

      // Paginated list view that listens to PaginationBloc state
      body: PaginatedListView(scrollController: _scrollController),

      // FAB to navigate to add entry screen
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, AppRoutes.addEntry);

          if (result == true) {
            // After adding entry, reload the paginated list from scratch
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
