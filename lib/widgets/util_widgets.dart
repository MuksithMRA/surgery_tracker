import 'package:flutter/material.dart';

import '../utils/screen_size.dart';

class UtilWidgets {
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

  static showSnackBar(BuildContext context, String message, bool isError) {
    final SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
