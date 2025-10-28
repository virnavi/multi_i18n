import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/models/loading_status.dart';
import 'package:rxdart/subjects.dart';

export 'package:flutter_i18n/flutter_i18n_delegate.dart';
export 'package:flutter_i18n/loaders/e2e_file_translation_loader.dart';
export 'package:flutter_i18n/loaders/file_translation_loader.dart';
export 'package:flutter_i18n/loaders/namespace_file_translation_loader.dart';
export 'package:flutter_i18n/loaders/network_file_translation_loader.dart';
export 'package:flutter_i18n/loaders/translation_loader.dart';
export 'package:flutter_i18n/widgets/I18nPlural.dart';
export 'package:flutter_i18n/widgets/I18nText.dart';

abstract class MultiI18n {
  TranslationLoader? translationLoader;
  late MissingTranslationHandler missingTranslationHandler;
  String? keySeparator;

  Map<dynamic, dynamic>? decodedMap;

  final _localeStream = BehaviorSubject<Locale?>();

  // ignore: close_sinks
  final _loadingStream = BehaviorSubject<LoadingStatus>();

  Stream<LoadingStatus> get loadingStream => _loadingStream.stream;

  Stream<bool> get isLoadedStream => loadingStream.map(
    (loadingStatus) => loadingStatus == LoadingStatus.loaded,
  );

  MultiI18n(
    TranslationLoader? translationLoader, {
    String keySeparator = ".",
    MissingTranslationHandler? missingTranslationHandler,
  }) {
    this.translationLoader = translationLoader ?? FileTranslationLoader();
    _loadingStream.add(LoadingStatus.notLoaded);
    this.missingTranslationHandler =
        missingTranslationHandler ?? (key, locale) {};
    this.keySeparator = keySeparator;
  }

  /// Used to load the locale translation file
  Future<bool> load() async {
    _loadingStream.add(LoadingStatus.loading);
    decodedMap = await translationLoader!.load();
    _localeStream.add(locale);
    _loadingStream.add(LoadingStatus.loaded);
    return true;
  }

  /// The locale used for the translation logic
  get locale => translationLoader!.locale;
}
