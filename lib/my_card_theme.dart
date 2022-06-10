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
