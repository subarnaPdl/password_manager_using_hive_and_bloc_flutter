import 'package:flutter/material.dart';
import 'package:password_manager/presentation/widgets/confirmation_dailog.dart';
import 'package:password_manager/presentation/widgets/sidemenu_tiles.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            // Header
            ListTile(
              leading:
                  Image.asset("assets/images/logo.png", height: 36, width: 36),
              title: const Text("Password Manager",
                  style: TextStyle(fontSize: 20)),
            ),
            const Divider(color: Colors.black54, thickness: 0.8),

            // Body

            //All
            SMListTile(
              icon: Icons.all_inbox,
              text: "All",
              onTap: () => Navigator.of(context).pushReplacementNamed('/home'),
            ),

            // Trash
            SMListTile(
              icon: Icons.delete_outline,
              text: "Trash",
              onTap: () => Navigator.of(context).pushReplacementNamed('/trash'),
            ),
            const Divider(color: Colors.black54, thickness: 0.8),

            // About Us
            SMListTile(
              icon: Icons.person,
              text: "About Us",
              onTap: () => {
                showAboutDialog(
                  context: context,
                  applicationName: 'Password Manager',
                  // TODO: Before Publishing: Change the app version below
                  // Change in pubspec.yaml file too
                  applicationVersion: '1.0.0',
                  applicationIcon: Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                    width: 50,
                  ),
                  applicationLegalese:
                      'This app is designed and created by Subarna Poudel.',
                )
              },
            ),

            // Privacy Policy
            SMListTile(
              icon: Icons.lock,
              text: "Privacy Policy",
              onTap: () async {
                Uri url = Uri.parse(
                    'https://sites.google.com/view/subarnainfotech-passmanger-pp/home');
                if (await launchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),

            // Disclaimer
            SMListTile(
              icon: Icons.privacy_tip_outlined,
              text: "Disclaimer",
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Disclaimer"),
                      content: const Text(
                        "The information provided by Subarna Infotech ('we', 'us', or 'our') on our mobile application is for general informational purposes only. All information on our mobile application is provided in good faith, however we make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability, or completeness of any information on our mobile application. UNDER NO CIRCUMSTANCE SHALL WE HAVE ANY LIABILITY TO YOU FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF OUR MOBILE APPLICATION OR RELIANCE ON ANY INFORMATION PROVIDED ON OUR MOBILE APPLICATION. YOUR USE OF OUR MOBILE APPLICATION AND YOUR RELIANCE ON ANY INFORMATION ON OUR MOBILE APPLICATION IS SOLELY AT YOUR OWN RISK.",
                      ),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }),
            ),
            const Divider(color: Colors.black54, thickness: 0.8),

            // Share
            SMListTile(
              icon: Icons.share_outlined,
              text: "Share",
              onTap: () {
                return Share.share(
                    'https://play.google.com/store/apps/details?id=com.subarnainfotech.password_manager');
              },
            ),

            // Rate Us
            SMListTile(
              icon: Icons.star_outlined,
              text: "Rate Us",
              onTap: () async => await RateMyApp().launchStore(),
            ),

            // Exit
            SMListTile(
              icon: Icons.exit_to_app,
              text: "Exit",
              onTap: () => showConfirmationDailog(
                context: context,
                title: 'Exit App',
                content: 'Do you want to exit the App?',
                yesAction: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
