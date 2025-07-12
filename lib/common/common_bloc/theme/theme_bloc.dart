import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ThemeChanged>(_onThemeChanged);
    on<ThemeLoaded>(_onThemeLoaded);
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', event.themeMode.index);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onThemeLoaded(
    ThemeLoaded event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme') ?? ThemeMode.system.index;
    emit(state.copyWith(themeMode: ThemeMode.values[themeIndex]));
  }
}
