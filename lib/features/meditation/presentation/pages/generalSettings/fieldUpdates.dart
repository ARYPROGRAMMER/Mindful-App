import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class upDate extends StatelessWidget {
  upDate({super.key});
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _photourl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _fullnamefield(context),
          _photofield(context),
          ElevatedButton(
              onPressed: () {
                user!.updateDisplayName(_fullname.value.text.toString());
                user.reload();
                print(user);
              },
              child: Text("update name")),
          ElevatedButton(
              onPressed: () {
                user!.updatePhotoURL(_photourl.value.text.toString());
                user.reload();
              },
              child: Text("update pic link"))
        ],
      ),
    );
  }

  Widget _fullnamefield(BuildContext context) {
    return TextField(
      controller: _fullname,
      decoration: const InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: const TextStyle(
          fontFamily: 't3',
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _photofield(BuildContext context) {
    return TextField(
      controller: _photourl,
      decoration: const InputDecoration(
        hintText: "Link to your Pic",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: const TextStyle(
          fontFamily: 't3',
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    );
  }
}
