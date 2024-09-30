import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health/features/auth/presentation/auth/pages/signin.dart';
import 'package:mental_health/features/auth/presentation/auth/pages/signup.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset("assets/top_pattern.svg"),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset("assets/bottom_pattern.svg"),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "screenshots/logo.png",
              width: 400,
              height: 300,
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(AppVectors.logo),
                      const SizedBox(
                        height: 260,
                      ),
                      const Text(
                        "Lets clear your mind",
                        style: TextStyle(
                            fontFamily: 't3',
                            color: Colors.white,
                            fontSize: 28,
                            letterSpacing: 0,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Mindful - One Step Ahead",
                        style: TextStyle(
                            fontFamily: 't3',
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 0,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      const Text(
                        "Mindful does everything you ever wished for from making you relaxed to give you future motivation",
                        style: TextStyle(
                            fontFamily: 't3',
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 3,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Signup()));
                                },
                                child: Text('Register',
                                    style: TextStyle(
                                      fontFamily: 't3',
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  elevation: 10,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignIn()));
                                },
                                child: Text('Sign In',
                                    style: TextStyle(
                                      fontFamily: 't3',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
