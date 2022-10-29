import 'package:darchat/core/consts/consts.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final List<String> list = <String>[
    'Technical',
    'Sales',
  ];
  String dropdownValue = '';
  @override
  void initState() {
    dropdownValue = list.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'ٔName',
                hintText: 'ٔName',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Constants.supportChatBackground),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Email',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Constants.supportChatBackground),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              decoration: InputDecoration(
                labelText: 'I need help with...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.supportChatBackground,
                  ),
                ),
              ),
              icon: const Icon(
                Icons.arrow_downward,
                size: 15,
              ),
              elevation: 16,
              //style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                // This is called when the user selects an item.
              },

              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Constants.supportChatBackground,
                    borderRadius: BorderRadius.circular(4)),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Start chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
