import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/local_storage/storage_keys.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LocalStorage _storage;

  LanguageCubit(this._storage) : super(LanguageLoading());

  late String storedLang;
  Locale currentLanguage = const Locale("ar");
  String showLang = "AR";

  // Getter for current language locale
  Locale get currentLang => currentLanguage;

  Future<void> init() async {
    emit(LanguageLoading());
    storedLang = _storage.getString(key: StorageKeys.lang.name) ?? '';
    if (storedLang.isEmpty) {
      storedLang = _storage.cachedLanguage;
    }
    storedLang = storedLang.isEmpty ? "ar" : storedLang;
    currentLanguage = Locale(storedLang);
    emit(LanguageSuccess());
  }

  Future<void> changeLanguage(String lang) async {
    emit(LanguageLoading());
    currentLanguage = Locale(lang);
    await _storage.cacheString(key: StorageKeys.lang.name, value: lang);
    await _storage.cacheLanguage(code: lang);

    if (isClosed) return;
    emit(LanguageSuccess());
  }

  Future<void> toggleLang() async {
    emit(LanguageLoading());
    final nextLang = currentLanguage.languageCode == "en" ? "ar" : "en";
    currentLanguage = Locale(nextLang);
    showLang = nextLang == "ar" ? "EN" : "AR";
    await _storage.cacheString(key: StorageKeys.lang.name, value: nextLang);
    await _storage.cacheLanguage(code: nextLang);

    if (isClosed) return;
    emit(LanguageSuccess());
  }
}
