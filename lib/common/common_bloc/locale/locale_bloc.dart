import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(locale: Locale('en'))) {
    on<LocaleChanged>(_onLocaleChanged);
    on<LocaleLoaded>(_onLocaleLoaded);
  }

  Future<void> _onLocaleChanged(
    LocaleChanged event,
    Emitter<LocaleState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _onLocaleLoaded(
    LocaleLoaded event,
    Emitter<LocaleState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    emit(state.copyWith(locale: Locale(languageCode)));
  }
}
