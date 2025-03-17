import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/data/repositories/entry_repository.dart';
import 'package:fpa/features/entries/viewmodels/entries_bloc.dart';
import 'package:fpa/features/entries/viewmodels/entries_event.dart';
import 'package:fpa/features/entries/viewmodels/entries_state.dart';
import 'package:fpa/features/entries/widgets/list_item_widget.dart';
import 'package:fpa/navigation/routes/app_routes.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Inject EntryRepository into EntriesBloc
      create: (context) => EntriesBloc(EntryRepository())..add(LoadEntries()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entries'),
        ),
        body: BlocBuilder<EntriesBloc, EntriesState>(
          builder: (context, state) {
            if (state is EntriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EntriesLoaded) {
              if (state.entries.isEmpty) {
                return const Center(child: Text("No entries available."));
              }
              return ListView.builder(
                itemCount: state.entries.length,
                itemBuilder: (context, index) {
                  return EntryListItem(entry: state.entries[index]);
                },
              );
            } else {
              return const Center(child: Text("Something went wrong."));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigate to AddEntry and refresh on return
            final result = await Navigator.pushNamed(context, AppRoutes.addEntry);
            if (result == true) {
              context.read<EntriesBloc>().add(LoadEntries());
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
