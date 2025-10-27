import 'package:flutter/material.dart';
import 'package:multi_i18n/multi_i18n.dart';

class MockTranslationLoader implements TranslationLoader {
  @override
  Locale? locale;

  final Map<String, dynamic> translations;

  MockTranslationLoader(this.translations, {this.locale});

  @override
  Future<Map<String, dynamic>> load() async => translations;

  @override
  Future<Locale> findDeviceLocale() async => const Locale('en');

  @override
  set forcedLocale(Locale? forcedLocale) {}
}
