import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:multi_i18n/multi_i18n.dart';

class TestI18n extends MultiI18n {
  TestI18n(TranslationLoader super.loader, {MissingTranslationHandler? missing})
    : super(missingTranslationHandler: missing);
}
