// dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_i18n/multi_i18n.dart';

import 'helpers/helpers.dart';

void main() {
  testWidgets('delegate loads and translates a key', (tester) async {
    final loader = MockTranslationLoader({
      'sample': {'title': 'Hello'},
      'greeting': 'Welcome',
    });
    final i18n = TestI18n(loader);
    final delegate = MultiI18nDelegate<TestI18n>(i18n);

    await delegate.load(const Locale('en'));

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            final helloText = delegate.translate(context, 'sample.title');
            expect(helloText, 'Hello');
            final greetingText = delegate.translate(context, 'greeting');
            expect(greetingText, 'Welcome');
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });

  testWidgets('missing translation triggers missingTranslationHandler', (
    tester,
  ) async {
    bool called = false;
    final loader = MockTranslationLoader({
      'sample': {'title': 'Hello'},
    });
    final i18n = TestI18n(
      loader,
      missing: (key, locale) {
        called = true;
      },
    );
    final delegate = MultiI18nDelegate<TestI18n>(i18n);

    await delegate.load(const Locale('en'));

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            // request a non-existing key
            final result = delegate.translate(context, 'no.such.key');
            expect(result, isNotNull);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(called, isTrue);
  });
}
