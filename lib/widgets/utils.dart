import 'package:flutter/material.dart';

import '../models/screen_size.dart';

class Utils {
  static Widget logo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        "assets/logo.png",
        height: ScreenSize.height * 0.15,
      ),
    );
  }

  static Widget flexibleLogo({double borderRadius = 60}) {
    return FittedBox(
      fit: BoxFit.cover,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          "assets/logo.png",
        ),
      ),
    );
  }
}
