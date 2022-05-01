import 'package:flutter/material.dart';
import 'package:password_manager/presentation/widgets/sidemenu_tiles.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            // Header
            ListTile(
              leading: Image.asset("assets/images/logo36.png"),
              title: const Text(
                "My Pass",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {},
            ),
            const Divider(color: Colors.black54, thickness: 0.8),

            // Body
            SMListTile(
              icon: Icons.all_inbox,
              text: "All",
              onTap: () => {},
            ),
            const Divider(color: Colors.black54, thickness: 0.8),

            SMListTile(
              icon: Icons.archive_outlined,
              text: "Archived",
              onTap: () => {},
            ),
            SMListTile(
              icon: Icons.delete_outline,
              text: "Trash",
              onTap: () => {},
            ),
            const Divider(color: Colors.black54, thickness: 0.8),

            SMListTile(
              icon: Icons.edit_outlined,
              text: "Edit Labels",
              onTap: () => {},
            ),
            SMListTile(
              icon: Icons.settings_outlined,
              text: "Settings",
              onTap: () => {},
            ),
            const Divider(color: Colors.black54, thickness: 0.8),

            SMListTile(
              icon: Icons.person,
              text: "About Us",
              onTap: () => {},
            ),
            SMListTile(
              icon: Icons.lock,
              text: "Privacy Policy",
              onTap: () => {},
            ),
            SMListTile(
              icon: Icons.privacy_tip_outlined,
              text: "Disclaimer",
              onTap: () => {},
            ),
            SMListTile(
              icon: Icons.share_outlined,
              text: "Share",
              onTap: () => {},
            ),
            SMListTile(
              icon: Icons.star_outlined,
              text: "Rate Us",
              onTap: () => {},
            ),
            SMListTile(
              icon: Icons.exit_to_app,
              text: "Exit",
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
