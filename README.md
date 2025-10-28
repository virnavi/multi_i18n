<!-- This is includes instructions and setup guide for Mutli_i18n package -->


# 🈯 multi_i18n
A **Flutter internationalization (i18n) helper package** that allows you to easily load and manage **multiple sets of translations** from different packages or modules in the same Flutter app.

Built on top of [flutter_i18n](https://pub.dev/packages/flutter_i18n), `multi_i18n` extends its functionality so that you can have **isolated translation contexts** — one per package or feature — instead of being restricted to a single global localization delegate.



## ✨ Features
✅ Load i18n files from **multiple packages or modules**  
✅ Simple integration with Flutter’s localization system  
✅ Full support for `flutter_i18n` loaders (`FileTranslationLoader`, `NetworkTranslationLoader`, etc.)  
✅ Built-in `translate()` and `plural()` helpers  
✅ Handles missing translations gracefully


## 🚀 Usage

### 1. Create Your Translation Classes

Each translation module should subclass `MultiI18n` and define its own delegate.

    import 'package:multi_i18n/multi_i18n.dart';
    
    class SampleI18n1 extends MultiI18n {
      SampleI18n1()
          : super(
              FileTranslationLoader(
                basePath: "assets/i18n_1",
                fallbackFile: "en",
              ),
              missingTranslationHandler: (key, locale) {
                print("Missing translation for $key in $locale");
              },
            );
    }
    
    class SampleI18n1Delegate extends MultiI18nDelegate<SampleI18n1> {
      static final delegate = SampleI18n1Delegate._();
      SampleI18n1Delegate._() : super(SampleI18n1());
    }
    
    // You can have another translation module:
    class SampleI18n2 extends MultiI18n {
      SampleI18n2()
          : super(
              FileTranslationLoader(
                basePath: "assets/i18n_2",
                fallbackFile: "en",
              ),
              missingTranslationHandler: (key, locale) {
                print("Missing translation for $key in $locale");
              },
            );
    }
    
    class SampleI18n2Delegate extends MultiI18nDelegate<SampleI18n2> {
      static final delegate = SampleI18n2Delegate._();
      SampleI18n2Delegate._() : super(SampleI18n2());
    }


### 2. Register Delegates in Your App

    import 'package:flutter/material.dart';
    import 'package:multi_i18n/multi_i18n.dart';
    
    void main() => runApp(const MyApp());
    
    class MyApp extends StatelessWidget {
      const MyApp({super.key});
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Multi i18n Demo',
          locale: const Locale("en"),
          supportedLocales: const [Locale("en"), Locale("bn")],
          localizationsDelegates: [
            SampleI18n1Delegate.delegate,
            SampleI18n2Delegate.delegate,
          ],
          home: const MyHomePage(),
        );
      }
    }

### 3. Translate Text in Widgets

    import 'package:flutter/material.dart';
    import 'package:multi_i18n/multi_i18n.dart';
    
    class MyHomePage extends StatelessWidget {
      const MyHomePage({super.key});
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text("MultiI18n Example")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  'From i18n_1: ${SampleI18n1Delegate.delegate.translate(context, "sample.title")}',
                ),
                Text(
                  'From i18n_2: ${SampleI18n2Delegate.delegate.translate(context, "sample.title")}',
                ),
              ],
            ),
          ),
        );
      }
    }

## 🧠 How It Works

MultiI18n and MultiI18nDelegate are thin wrappers around flutter_i18n:

Each subclass of MultiI18n defines its own translation loader and maintains its own decoded translation map.

MultiI18nDelegate handles locale changes and loading of the translations for that specific i18n instance.

You can access translations through static delegate instances.

This allows multiple isolated i18n contexts to coexist, which is especially useful for modular Flutter apps and packages with independent translation files.

## 🧰 Dependencies
-   [flutter_i18n](https://pub.dev/packages/flutter_i18n)

## 🧑‍💻 Contributors

* **Mohammed Shakib** ([@shakib1989](https://github.com/shakib1989)) - *Main Library Development*
* **Shuvo Prosad Sarnakar** ([@shuvoprosadsarnakar](https://github.com/shuvoprosadsarnakar)) - *Extensive documentation and getting the project for pub.dev.*

## 🪪 License
This project is licensed under the **MIT License** — see the LICENSE file for details.


