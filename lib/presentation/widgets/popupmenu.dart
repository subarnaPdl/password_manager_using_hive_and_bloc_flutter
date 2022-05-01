import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  PopupMenu({Key? key}) : super(key: key);

  var myMenuItems = <String>[
    'Settings',
    'Exit',
  ];

  void onSelect(item) {
    switch (item) {
      case 'Settings':
        print('Settings clicked');
        break;
      case 'Exit':
        print('Exit clicked');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        onSelected: onSelect,
        itemBuilder: (BuildContext context) {
          return myMenuItems.map((String choice) {
            return PopupMenuItem<String>(
              child: Text(choice),
              value: choice,
            );
          }).toList();
        });
  }
}
