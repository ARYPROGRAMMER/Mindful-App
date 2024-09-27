import 'package:flutter/material.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/auth/presentation/auth/pages/signup_or_signin.dart';
import 'package:mental_health/presentation/homePage/home_page.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
          totalPage: 3,
          headerBackgroundColor: Colors.white,
          finishButtonText: 'Go to Register / Sign In',
          onFinish: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignupOrSignin()),
                (route) => false);
          },
          finishButtonStyle: FinishButtonStyle(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.red, width: 2)),
              backgroundColor: Colors.black),
          finishButtonTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
          skipTextButton: Text(
            "Skip",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          skipIcon: Icon(
            Icons.navigate_next_rounded,
            color: Colors.white,
          ),
          trailing: Text(
            "Sign Up/In",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          trailingFunction: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignupOrSignin()),
                (route) => false);
          },
          background: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/med1.jpg'),
                      fit: BoxFit.fitWidth)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/ai.png'),
                      fit: BoxFit.fitWidth)),
            ),
            Stack(
              children: [
                Image(
                  image: AssetImage('assets/nodepress.png'),
                  width: 450,
                  height: 450,
                ),
                Image(
                  image: AssetImage('assets/firebase.png'),
                  width: 225,
                  height: 850,
                ),
                Positioned(
                    top: 355,
                    child: Image(
                      image: AssetImage('assets/postgres.png'),
                      width: 620,
                      height: 150,
                    )),
              ],
            ),
          ],
          speed: 1.5,
          pageBodies: [
            Stack(children: [
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height / 6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Mindful',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.95,
                      ),
                      Text(
                        "Improve your health, live better all aspects, one app!",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Stack(children: [
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height / 9,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Most Powerful',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Text('Integration',
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.7,
                      ),
                      Text(
                        "Suggestions like Never Before and Analysis like a Pro",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "Everything is possible with Gemini-3.5-turbo",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Stack(children: [
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height / 17,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Powered by',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                      Text(
                        "Fully Secure Transmission of Vital Information",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "Thanks to the encrypted Technologies used",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ]),

      // body: Stack(
      //   children: [
      //     Positioned.fill(
      //         child: Image.asset(
      //       'assets/onboarding.png',
      //       fit: BoxFit.contain,
      //     )),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: SizedBox(
      //           height: 70,
      //           child: ElevatedButton(
      //               onPressed: () {
      //                 Navigator.of(context).pushAndRemoveUntil(
      //                     MaterialPageRoute(
      //                         builder: (BuildContext context) => HomePage()),
      //                     (context) => false);
      //               },
      //               style: ElevatedButton.styleFrom(
      //                   minimumSize: const Size(double.infinity, 50),
      //                   backgroundColor: Theme.of(context).focusColor,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(12))),
      //               child: Text(
      //                 "Let us help you",
      //                 style: Theme.of(context).textTheme.bodyLarge,
      //               )),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
