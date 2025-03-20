// bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants/app_icons.dart';
import '../features/analysis/views/analysis_screen.dart';
import '../features/settings/views/settings_screen.dart';
import '../features/entries/views/entries_screen.dart';
import '../features/home/views/home_screen.dart';
import 'bottom_nav_bloc.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

// Bottom Navigation Bar UI
class BottomNavigation extends StatelessWidget {
  final List<Widget> screens = [HomeScreen(), EntriesScreen(), AnalysisScreen()];

  //build() → Called only once when the widget is created.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
       //builder() → Called every time the BLoC emits a new state.
        builder: (context, state) {
          final currentIndex = (state as BottomNavInitial).currentIndex;
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => context.read<BottomNavBloc>().add(BottomNavItemSelected(index)),
              items: const [
                BottomNavigationBarItem(icon: Icon(MyAppIcons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(MyAppIcons.listEntries), label: 'Entries'),
                BottomNavigationBarItem(icon: Icon(MyAppIcons.analytics), label: 'Analysis')
              ],
            ),
          );
        },
      ),
    );
  }
}