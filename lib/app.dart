import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/data/repositories/entry_repository.dart';
import 'package:fpa/features/entries/viewmodels/entries_bloc.dart';
import 'package:fpa/features/entries/viewmodels/entries_event.dart';
import 'package:fpa/navigation/routes/app_navigator.dart';
import 'package:fpa/navigation/bottom_navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EntriesBloc(EntryRepository())..add(LoadEntries()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'fpa',
        initialRoute: '/', // Set initial route if needed
        home: BottomNavigation(), // Bottom Navigation Bar as the home screen
        onGenerateRoute: AppNavigator.generateRoute,
      ),
    );
  }
}
