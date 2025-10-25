import 'package:flutter/material.dart';
import 'package:multi_i18n/multi_i18n.dart';

void main() {
  runApp(const MyApp());
}

class SampleI18n1 extends MultiI18n {
  SampleI18n1()
    : super(
        FileTranslationLoader(basePath: "assets/i18n_1", fallbackFile: "en"),
        missingTranslationHandler: (a, b) {},
      );
}

class SampleI18n1Delegate extends MultiI18nDelegate<SampleI18n1> {
  static final delegate = SampleI18n1Delegate._();
  SampleI18n1Delegate._() : super(SampleI18n1());
}

class SampleI18n2 extends MultiI18n {
  SampleI18n2()
      : super(
    FileTranslationLoader(basePath: "assets/i18n_2", fallbackFile: "en"),
    missingTranslationHandler: (a, b) {},
  );
}

class SampleI18n2Delegate extends MultiI18nDelegate<SampleI18n2> {
  static final delegate = SampleI18n2Delegate._();
  SampleI18n2Delegate._() : super(SampleI18n2());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi i18n Demo',
      locale: Locale("en"),
      localizationsDelegates: [
        SampleI18n1Delegate.delegate,
        SampleI18n2Delegate.delegate,
      ],
      supportedLocales: [Locale("en")],
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("MultiI18n"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: <Widget>[
             Text('MultiI18n Sample 1: ${SampleI18n1Delegate.delegate.translate(context, "sample.title")}'),
             Text('MultiI18n Sample 2: ${SampleI18n2Delegate.delegate.translate(context, "sample.title")}'),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
