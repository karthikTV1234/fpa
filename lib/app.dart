import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fpa/data/repositories/entry_repository.dart';
import 'package:fpa/features/entries/viewmodels/entries_bloc.dart';
import 'package:fpa/features/entries/viewmodels/entries_event.dart';
import 'package:fpa/navigation/routes/app_navigator.dart';
import 'package:fpa/navigation/bottom_navigation.dart';
import 'core/constants/theme/app_themes.dart';
import 'core/constants/theme/theme_cubit.dart';
import 'core/constants/locale_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => EntriesBloc(EntryRepository())..add(LoadEntries()),
        ),
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(), // Default locale is 'en'
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'fpa',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,

                locale: locale, // Dynamically set locale from LocaleCubit
                supportedLocales: [
                  Locale('en'), // English
                  Locale('te'), //Telugu
                  Locale('es'), // Spanish
                ],

                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  // Your custom localization delegate will be added here
                ],

                initialRoute: '/',
                home: BottomNavigation(),
                onGenerateRoute: AppNavigator.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
