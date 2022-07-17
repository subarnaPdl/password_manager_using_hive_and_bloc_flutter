import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard({required BuildContext context, required String text}) {
  Clipboard.setData(ClipboardData(text: text)).then((result) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to Clipboard'),
    ));
  });
}
