import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get lightPink => const Color(0xFFF3DCF2);
  Color get darkPink => const Color(0xFF824670);
  Color get brightPink => const Color(0xFFAC6BB7);
  Color get lightBlue => const Color(0xFFDCE6F3);
  Color get darkBlue => const Color(0xFF166E9F);
  Color get brightBlue => const Color(0xFF28ACC9);
  Color get light => const Color(0xFFF9F9F9);
  Color get dark => const Color(0xFF333333);
}

Map CustomeColorScheme = {
  'lightPink': const Color(0xFFF3DCF2),
  'darkPink': const Color(0xFF824670),
  'brightPink': const Color(0xFFAC6BB7),
  'lightBlue': const Color(0xFFDCE6F3),
  'darkBlue': const Color(0xFF166E9F),
  'brightBlue': const Color(0xFF28ACC9),
  'light': const Color(0xFFF9F9F9),
  'dark': const Color(0xFF333333),
};
