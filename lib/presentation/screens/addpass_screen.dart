import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPassScreen extends StatefulWidget {
  const AddPassScreen({Key? key}) : super(key: key);

  @override
  State<AddPassScreen> createState() => _AddPassScreenState();
}

class _AddPassScreenState extends State<AddPassScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double ht = MediaQuery.of(context).size.height;
    final double wd = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5 * ht,
                ),
                const Text('  Websites'),
                SizedBox(
                  height: 1.5 * ht,
                ),
                // _buildDropDownMenu(
                //     context,
                //     subcategories[_selectedcategoryindex],
                //     _selectedsubcategory,
                //     false),
                SizedBox(
                  height: 0.05 * ht,
                ),
                const Text('  Passwords'),
                SizedBox(
                  height: 1.5 * ht,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 2, 53, 21),
                          Color.fromARGB(255, 194, 157, 8),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(3)),
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Enter your Password here.",
                      filled: true,
                      fillColor: Theme.of(context).backgroundColor,
                      prefixIcon: const Icon(Icons.password),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      errorMaxLines: 4,
                    ),
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Password too short';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (query) {},
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                SizedBox(
                  height: 0.7 * ht,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(0.7 * wd, 0.7 * ht),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        primary: Colors.green,
                      ),
                      child: const Text('Add Pass'),
                    )),
                  ],
                ),
                SizedBox(
                  height: 0.3 * ht,
                ),
                InkWell(
                    onTap: () {},
                    child: const Center(
                      child: Text('Generate Password'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
