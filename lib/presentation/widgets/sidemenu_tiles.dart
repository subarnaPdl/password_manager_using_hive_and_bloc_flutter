import 'package:flutter/material.dart';

class SMListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const SMListTile(
      {Key? key, required this.icon, required this.text, required, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      minLeadingWidth: 20,
      leading: Icon(icon, color: Colors.black87),
      title: Text(text),
      onTap: onTap,
    );
  }
}
