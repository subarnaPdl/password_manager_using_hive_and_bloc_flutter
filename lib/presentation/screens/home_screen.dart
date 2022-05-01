import 'package:flutter/material.dart';
import 'package:password_manager/presentation/widgets/sidemenu.dart';
import 'package:password_manager/presentation/widgets/startingtutorial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    launchTutorial(context, key);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -----------------AppBar-------------------- //
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          // PopupMenu(),
        ],
      ),

      // -------------------Body-------------------- //
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty.png"),
            const SizedBox(height: 25),
            const Text(
              "No entries found",
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),

      // -----------------Sidemenu------------------ //
      drawer: const SideMenu(),

      // ----------Floating Action Button----------- //
      floatingActionButton: FloatingActionButton(
        key: key,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
