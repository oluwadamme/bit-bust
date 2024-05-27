import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle blackStyle(
  double size,
  Color color, {
  TextDecoration? decoration,
  String? family,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w800,
    letterSpacing: letterSpacing,
    height: 1.3,
    decoration: decoration,
    fontFamily: family ?? GoogleFonts.outfit().fontFamily,
  );
}

TextStyle boldStyle(
  double size,
  Color color, {
  TextDecoration? decoration,
  String? family,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w700,
    letterSpacing: letterSpacing,
    height: 1.3,
    decoration: decoration,
    fontFamily: family ?? GoogleFonts.outfit().fontFamily,
  );
}

TextStyle semiBoldStyle(
  double size,
  Color color, {
  TextDecoration? decoration,
  String? family,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w600,
    letterSpacing: letterSpacing,
    height: 1.3,
    decoration: decoration,
    fontFamily: family ?? GoogleFonts.outfit().fontFamily,
  );
}

TextStyle mediumStyle(
  double size,
  Color color, {
  TextDecoration? decoration,
  String? family,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w500,
    letterSpacing: letterSpacing,
    height: 1.4,
    decoration: decoration,
    fontFamily: family ?? GoogleFonts.outfit().fontFamily,
  );
}

TextStyle normalStyle(
  double size,
  Color color, {
  TextDecoration? decoration,
  String? family,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w400,
    letterSpacing: letterSpacing,
    height: 1.4,
    decoration: decoration,
    fontFamily: family ?? GoogleFonts.outfit().fontFamily,
  );
}

TextStyle lightStyle(
  double size,
  Color color, {
  TextDecoration? decoration,
  String? family,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w400,
    letterSpacing: letterSpacing,
    height: 1.3,
    decoration: decoration,
    fontFamily: family ?? GoogleFonts.outfit().fontFamily,
  );
}

TextStyle italicStyle(
  double size,
  Color color,
  FontWeight fontWeight, {
  TextDecoration? decoration,
  String? family,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontStyle: FontStyle.italic,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    height: 1.3,
    decoration: decoration,
    fontFamily: family ?? GoogleFonts.outfit().fontFamily,
  );
}
