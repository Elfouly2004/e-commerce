import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('ar'));

  void changeLanguage(BuildContext context, String languageCode) async {
    final newLocale = Locale(languageCode);

    await context.setLocale(newLocale);
    emit(newLocale);
  }
}
