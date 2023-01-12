import 'package:bloc/bloc.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('pl'));

  void changeStartLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('lang');
    Logger().info(langCode.toString());
    if (langCode != null) {
      emit(Locale(langCode, 'pl'));
    }
  }

  void changeLang(context, String data) async {
    emit(Locale(data, ''));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', data);
  }

  // String defaultLang() {
  //   SharedPreferences prefs = SharedPreferences.getInstance();
  //   String? langCode = prefs.getString('lang');
  //   return langCode ?? 'pl';
  // }
}
