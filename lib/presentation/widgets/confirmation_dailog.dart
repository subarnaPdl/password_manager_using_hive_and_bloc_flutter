import 'package:flutter/material.dart';

Future<bool> showConfirmationDailog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() yesAction,
}) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: yesAction,
              child: const Text('Yes'),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}
