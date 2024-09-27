import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
      // appBar: AppBar(
      //   title: SvgPicture.asset(
      //     AppVectors.logo,
      //     height: 50,
      //     width: 50,
      //   ),
      // ),
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
              _registerText(),
              const SizedBox(
                height: 40,
              ),
              _fullnamefield(context),
              const SizedBox(
                height: 40,
              ),
              _emailfield(context),
              const SizedBox(
                height: 40,
              ),
              _password(context),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()),
                        (route) => false);
                  });
                },
                child: const Text('Create Account'),
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
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullnamefield(BuildContext context) {
    return TextField(
      controller: _fullname,
      decoration: const InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailfield(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: "Enter Email",
      ),
    );
  }

  Widget _password(BuildContext context) {
    return TextField(
      controller: _passworde,
      decoration: const InputDecoration(
        hintText: "Password",
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignIn()));
              },
              child: const Text("Sign In")),
        ],
      ),
    );
  }
}
