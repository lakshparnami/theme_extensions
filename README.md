## Flutter 3 — ThemeData finally Extendeddd…
The wait is over, now we have ThemeExtensions in Flutter 3.
To begin with, create a custom theme class that extends ThemeExtension<YourClassName>
```
import 'package:flutter/material.dart';

@immutable
class MyCardTheme extends ThemeExtension<MyCardTheme> {
  const MyCardTheme({
    this.background = Colors.white,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  });

  final Color background;
  final ShapeBorder shape;

  @override
  MyCardTheme copyWith({
    Color? background,
    ShapeBorder? shape,
  }) {
    return MyCardTheme(
      background: background ?? this.background,
      shape: shape ?? this.shape,
    );
  }

  @override
  MyCardTheme lerp(ThemeExtension<MyCardTheme>? other, double t) {
    if (other is! MyCardTheme) {
      return this;
    }
    return MyCardTheme(
      background: Color.lerp(background, other.background, t) ?? Colors.white,
      shape: ShapeBorder.lerp(shape, other.shape, t) ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
    );
  }

  @override
  String toString() => 'MyCardTheme('
      'background: $background, radius: $shape'
      ')';
}
```
It is necessary to override the lerp() and copyWith() methods when extending ThemeExtension class.

The lerp() function controls how the properties will change when the theme changes. it will linearly interpolate between two properties for a smoother transition.

Now add extensions to your ThemeData for both, light and dark themes.
```
MaterialApp(
  title: 'Flutter Demo',
  debugShowCheckedModeBanner: false,
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
```
and you’re good to go!
use these properties by using

`final MyCardTheme customCardTheme =
Theme.of(context).extension<MyCardTheme>()!;`

```
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
```
  
Final result:<br/><br/>
<img src="/screenshots/light_mode.jpeg"  width="200"/><br/><br/><br/>
And in dark mode:<br/><br/>
<img src="/screenshots/dark_mode.jpeg"  width="200"/><br/><br/>

For more details visit https://api.flutter.dev/flutter/material/ThemeData/extensions.html
