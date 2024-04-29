import 'package:flutter/material.dart';

class AlertDialogUtil {
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPositiveBtnTap,
    required VoidCallback onNegativeBtnTap,
    String positiveBtnText = 'OK',
    String negativeBtnText = 'Cancel',
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onNegativeBtnTap,
              child: Text(negativeBtnText),
            ),
            TextButton(
              onPressed: onPositiveBtnTap,
              child: Text(positiveBtnText),
            ),
          ],
        );
      },
    );
  }
}

class AlertDialogPositoveUtil {
  static Future<void> showPositiveAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPositiveBtnTap,
    String positiveBtnText = 'OK',
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPositiveBtnTap,
              child: Text(positiveBtnText),
            ),
          ],
        );
      },
    );
  }
}

void navigateToScreen(BuildContext context, Widget screen) {
  final result = Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );

  print('Received back: $result');
}
