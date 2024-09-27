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
          finishButtonText: 'Go to Dashboard',
          onFinish: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignupOrSignin()),
                (route) => false);
          },
          finishButtonStyle: const FinishButtonStyle(
            elevation: 15,
              focusElevation: 3,


              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                  side: BorderSide(color: Colors.black26, width: 4)),
              backgroundColor: Colors.white10),

          finishButtonTextStyle: const TextStyle(fontWeight:FontWeight.bold,fontFamily: 't3',color: Colors.black,fontSize: 15,letterSpacing: 1,leadingDistribution: TextLeadingDistribution.proportional),
          skipTextButton: const Text(
            "Skip",
            style:  TextStyle(fontFamily: 't3',color: Colors.black,fontSize: 20,letterSpacing: 2,leadingDistribution: TextLeadingDistribution.proportional),
          ),
          skipIcon: const Icon(
            Icons.navigate_next_rounded,
            color: Colors.white,
          ),
          trailing: const Text(
            "Dashboard",
            style: TextStyle(fontFamily: 't3',color: Colors.black,fontSize: 17,letterSpacing: 2,leadingDistribution: TextLeadingDistribution.proportional),
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
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/med1.jpg'),
                      fit: BoxFit.fitWidth)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/ai.png'),
                      fit: BoxFit.fitWidth)),
            ),
            const Stack(
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
                top: MediaQuery.of(context).size.height / 7,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Mindful',
                        style: TextStyle(fontFamily: 't2',color: Colors.black,fontSize: 60,letterSpacing: 5,leadingDistribution: TextLeadingDistribution.proportional),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.15,
                      ),
                      const Text(
                        "Improve your health, live better all aspects, one app!",
                        style: TextStyle(fontFamily: 't3',color: Colors.black,fontSize: 20,letterSpacing: 2,leadingDistribution: TextLeadingDistribution.proportional),
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Most Powerful Integration',
                        style: TextStyle(fontFamily: 't2',color: Colors.black,fontSize: 50,letterSpacing: 0,leadingDistribution: TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(height: MediaQuery.of(context).size.height / 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.7,
                      ),
                      Text(
                        "Suggestions like Never Before and Analysis like a Pro",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Powered by',
                        style: TextStyle(fontFamily: 't1',color: Colors.black,fontSize: 50,letterSpacing: 2,leadingDistribution: TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                      Text(
                        "Fully Secure Transmission of Vital Information",
                        style: TextStyle(fontWeight:FontWeight.bold,fontFamily: 't3',color: Colors.black,fontSize: 18,letterSpacing: 2,leadingDistribution: TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Thanks to the encrypted Technologies used",
                        style: TextStyle(fontWeight:FontWeight.bold,fontFamily: 't3',color: Colors.black,fontSize: 18,letterSpacing: 2,leadingDistribution: TextLeadingDistribution.proportional),
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
