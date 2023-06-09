import 'package:flutter/material.dart';

class ScreenSize {
  static double height = 0;
  static double width = 0;
  static MediaQueryData mediaQueryData = const MediaQueryData();

  static void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    height = mediaQueryData.size.height;
    width = mediaQueryData.size.width;
  }
}
