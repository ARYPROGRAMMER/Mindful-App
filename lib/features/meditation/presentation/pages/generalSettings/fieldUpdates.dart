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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile Details Update",
          style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 't3'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 350, child: _fullnamefield(context)),
            const SizedBox(
              height: 20,
            ),
            SizedBox(width: 350, child: _photofield(context)),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 7,
                      foregroundColor: Colors.white70,
                      shadowColor: Colors.black),
                  onPressed: () {
                    user!.updateDisplayName(_fullname.value.text.toString());
                    user.reload();
                  },
                  child: const Text(
                    "Update Name",
                    style: TextStyle(
                        fontFamily: 't3',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 7,
                      foregroundColor: Colors.white70,
                      shadowColor: Colors.black),
                  onPressed: () {
                    user!.updatePhotoURL(_photourl.value.text.toString());
                    user.reload();
                  },
                  child: Text(
                    "Update Pic Link",
                    style: const TextStyle(
                        fontFamily: 't3',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
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
