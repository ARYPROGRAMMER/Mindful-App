import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:mental_health/features/auth/data/models/auth/create_user_request.dart';
import 'package:mental_health/features/auth/domain/usecases/auth/signup.dart';
import 'package:mental_health/features/auth/presentation/auth/pages/signin.dart';
import 'package:mental_health/injections.dart';
import 'package:mental_health/presentation/homePage/home_page.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passworde = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(right: 45.0, top: 5),
          child: Image.asset(
            "screenshots/logo.png",
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tune into your Mind",
                style: TextStyle(
                    fontFamily: 't3',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 80,
              ),
              _registerText(),
              const SizedBox(
                height: 80,
              ),
              _fullnamefield(context),
              const SizedBox(
                height: 30,
              ),
              _emailfield(context),
              const SizedBox(
                height: 30,
              ),
              _password(context),
              const SizedBox(
                height: 80,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  var result = await sl<SignupUseCase>().call(
                      params: CreateUserRequest(
                          fullName: _fullname.text.toString(),
                          email: _email.text.toString(),
                          password: _passworde.text.toString()));

                  result.fold((l) {
                    var snackbar = SnackBar(
                      content: Text(l),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }, (r) {
                    final mm = Hive.box('lastlogin');
                    final first = Hive.box('firstime');
                    mm.put("google", "false");
                    first.put('firsttime', 'true');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()),
                        (route) => false);
                  });
                },
                child: const Text(
                  '  Create Account  ',
                  style: TextStyle(
                    fontFamily: 't3',
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
          letterSpacing: 1,
          fontFamily: 't1',
          color: Colors.green,
          fontSize: 25,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
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

  Widget _emailfield(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: "Enter Email",
      ),
      style: const TextStyle(
          fontFamily: 't3',
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _password(BuildContext context) {
    return TextField(
      controller: _passworde,
      obscureText: true,
      obscuringCharacter: "*",
      decoration: const InputDecoration(
        hintText: "Password",
      ),
      style: const TextStyle(
          fontFamily: 't3',
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account?',
            style: TextStyle(
                fontFamily: 't2',
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignIn()));
              },
              child: const Text(
                "Sign In",
                style: TextStyle(
                    letterSpacing: 0,
                    fontFamily: 't2',
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
