import 'package:flutter/material.dart';
import 'package:my_test_project/my_card_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyCardTheme lightCardTheme = MyCardTheme(
      background: Colors.blueGrey[200]!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    );
    MyCardTheme darkCardTheme = MyCardTheme(
      background: Colors.blueGrey[800]!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.green,
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          color: Colors.green,
        ),
        extensions: <ThemeExtension<dynamic>>[
          lightCardTheme,
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          color: Colors.green,
        ),
        extensions: <ThemeExtension<dynamic>>[
          darkCardTheme,
        ],
      ),
      home: const MyHomePage(title: 'Themes Extendeddd…'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final MyCardTheme customCardTheme =
        Theme.of(context).extension<MyCardTheme>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text('Card styled from default theme')),
            ),
            Card(
              shape: customCardTheme.shape,
              color: customCardTheme.background,
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text('Card styled from custom theme')),
            ),
            Card(
              shape: customCardTheme.shape,
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                      'background from default theme, shape from custom theme')),
            ),
            Card(
              color: customCardTheme.background,
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                      'background from custom theme, shape from default theme')),
            ),
          ],
        ),
      ),
    );
  }
}
