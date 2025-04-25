import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LocaleCubit extends Cubit<Locale> {
  // Default locale
  LocaleCubit() : super(const Locale('en'));

  void setLocale(Locale locale) {
    // You can also add logic here to check if the locale is supported
    emit(locale);
  }
}