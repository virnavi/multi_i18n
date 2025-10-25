import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/utils/message_printer.dart';
import 'package:flutter_i18n/utils/plural_translator.dart';
import 'package:flutter_i18n/utils/simple_translator.dart';
import 'package:multi_i18n/src/multi_i18n.dart';

class MultiI18nDelegate<T extends MultiI18n> extends LocalizationsDelegate<T> {
  T? _currentTranslationObject;
  @override
  Locale? currentLocale;

  MultiI18nDelegate(T translationObject) {
    _currentTranslationObject = translationObject;
    /*_currentTranslationObject = FlutterI18n(
      translationLoader,
      keySeparator,
      missingTranslationHandler: missingTranslationHandler,
    );*/
  }

  @override
  bool isSupported(final Locale locale) {
    return true;
  }

  @override
  Future<T> load(final Locale locale) async {
    MessagePrinter.info("New locale: $locale");
    final TranslationLoader translationLoader =
        _currentTranslationObject!.translationLoader!;
    if (translationLoader.locale != locale ||
        _currentTranslationObject!.decodedMap == null ||
        _currentTranslationObject!.decodedMap!.isEmpty) {
      translationLoader.locale = currentLocale = locale;
      await _currentTranslationObject!.load();
    }
    return _currentTranslationObject!;
  }

  @override
  bool shouldReload(final MultiI18nDelegate<T> old) {
    return this.currentLocale == null ||
        this.currentLocale == old.currentLocale;
  }

  String translate(
    final BuildContext context,
    final String key, {
    final String? fallbackKey,
    final Map<String, String>? translationParams,
  }) {
    final T currentInstance = _currentTranslationObject!;
    final SimpleTranslator simpleTranslator = SimpleTranslator(
      currentInstance.decodedMap,
      key,
      currentInstance.keySeparator,
      fallbackKey: fallbackKey,
      translationParams: translationParams,
      missingKeyTranslationHandler: (key) {
        currentInstance.missingTranslationHandler(key, currentInstance.locale);
      },
    );
    return simpleTranslator.translate();
  }

  /// Facade method to the plural translation logic
  String plural(
    final BuildContext context,
    final String translationKey,
    final int pluralValue,
  ) {
    final T currentInstance = _currentTranslationObject!;
    final PluralTranslator pluralTranslator = PluralTranslator(
      currentInstance.decodedMap,
      translationKey,
      currentInstance.keySeparator,
      pluralValue,
      missingKeyTranslationHandler: (key) {
        currentInstance.missingTranslationHandler(key, currentInstance.locale);
      },
    );
    return pluralTranslator.plural();
  }
}
