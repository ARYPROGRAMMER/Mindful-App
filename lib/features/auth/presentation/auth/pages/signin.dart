import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:mental_health/features/auth/data/models/auth/signin_user_req.dart';
import 'package:mental_health/features/auth/domain/entities/auth/googleapisignin.dart';
import 'package:mental_health/features/auth/domain/usecases/auth/signin.dart';
import 'package:mental_health/features/auth/presentation/auth/pages/signup.dart';
import 'package:mental_health/injections.dart';
import 'package:mental_health/presentation/homePage/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _passworde = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      final user = await GoogleSignInApi.login();
      final myboxx = Hive.box('lastlogin');
      final first = Hive.box('firstime');
      if (user == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Cancelled by User")));
      } else {
        myboxx.put('google', 'true');
        first.put('firsttime', 'true');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (route) => false);
      }
    }

    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(right: 41.0, top: 5),
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
            vertical: 20,
            horizontal: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Get In Your Mood",
                style: TextStyle(
                    fontFamily: 't3',
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              _registerText(),
              const SizedBox(
                height: 100,
              ),
              _emailfield(context),
              const SizedBox(
                height: 60,
              ),
              _password(context),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  var result = await sl<SigninUseCase>().call(
                      params: SigninUserReq(
                          email: _email.text.toString(),
                          password: _passworde.text.toString()));

                  result.fold((l) {
                    var snackbar = SnackBar(
                      content: Text(l),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }, (r) {
                    final my = Hive.box('lastlogin');
                    my.put("google", "false");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()),
                        (route) => false);
                  });
                },
                child: const Text(
                  "  Sign In  ",
                  style: TextStyle(
                    fontFamily: 't3',
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Continue with Google",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: signIn),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(
          letterSpacing: 1,
          fontFamily: 't1',
          color: Colors.green,
          fontSize: 25,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
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

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(
                fontFamily: 't2',
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Signup()));
              },
              child: const Text(
                "Register Now",
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
