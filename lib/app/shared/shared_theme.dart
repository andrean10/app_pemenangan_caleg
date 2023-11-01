import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedTheme {
  static const _primaryColor = Color(0xff303677);

  static final _primaryTextStyle = GoogleFonts.josefinSans().fontFamily;
  static final _secondaryTextStyle = GoogleFonts.openSans().fontFamily;

  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const black = FontWeight.w900;

  static final _textThemeStyle = TextTheme(
    bodyLarge: TextStyle(fontFamily: _secondaryTextStyle),
    bodyMedium: TextStyle(fontFamily: _secondaryTextStyle),
    bodySmall: TextStyle(fontFamily: _secondaryTextStyle),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _primaryColor,
    fontFamily: _primaryTextStyle,
    textTheme: _textThemeStyle,
  );

  // static final darkTheme = ThemeData(
  //   useMaterial3: true,
  //   // colorSchemeSeed: const Color(0xff2FA849),
  //   colorScheme: _darkColorScheme,
  //   fontFamily: _primaryTextStyle,
  //   textTheme: _textThemeStyle,
  // );
}
