import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health/features/auth/presentation/auth/pages/signup_or_signin.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnBoardingSlider(
          totalPage: 3,
          headerBackgroundColor: Colors.white,
          pageBackgroundColor: Colors.white,
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  side: BorderSide(color: Colors.black26, width: 4)),
              backgroundColor: Colors.white10),
          finishButtonTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 't3',
              color: Colors.black,
              fontSize: 15,
              letterSpacing: 1,
              leadingDistribution: TextLeadingDistribution.proportional),
          skipTextButton: const Text(
            "Skip",
            style: TextStyle(
                fontFamily: 't3',
                color: Colors.black,
                fontSize: 17,
                letterSpacing: 0,
                leadingDistribution: TextLeadingDistribution.proportional),
          ),
          skipIcon: const Icon(
            Icons.navigate_next_rounded,
            color: Colors.white,
          ),
          trailing: const Text(
            "Dashboard",
            style: TextStyle(
                fontFamily: 't3',
                color: Colors.black,
                fontSize: 17,
                letterSpacing: 0,
                leadingDistribution: TextLeadingDistribution.proportional),
          ),
          trailingFunction: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignupOrSignin()),
                (route) => false);
          },
          background: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              child: LottieBuilder.network(
                  "https://lottie.host/041fa715-ab55-4bde-802e-1e230e2f1dce/C4XLl7Dw0s.json"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 9.5),
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/llama.png'),
                          fit: BoxFit.contain)),
                ),
              ]),
            ),
            const Stack(
              children: [
                Image(
                  image: AssetImage('assets/nodepress.png'),
                  width: 400,
                  height: 400,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Image(
                    image: AssetImage('assets/firebase.png'),
                    width: 160,
                    height: 720,
                  ),
                ),
                Positioned(
                    top: 300,
                    child: Image(
                      image: AssetImage('assets/postgres.png'),
                      width: 570,
                      height: 130,
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
                top: MediaQuery.of(context).size.height / 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Mindful',
                        style: TextStyle(
                            fontFamily: 't2',
                            color: Colors.black,
                            fontSize: 60,
                            letterSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.15,
                      ),
                      const Text(
                        "Improve your health, live better all aspects, one app!",
                        style: TextStyle(
                            fontFamily: 't3',
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
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
                top: MediaQuery.of(context).size.height / 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Most Powerful Integration',
                        style: TextStyle(
                            fontFamily: 't2',
                            color: Colors.black,
                            fontSize: 40,
                            letterSpacing: 0,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(height: MediaQuery.of(context).size.height / 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
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
                        "Everything is possible with LLAMA-8B-8192",
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
                top: MediaQuery.of(context).size.height / 35,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Powered by',
                        style: TextStyle(
                            fontFamily: 't1',
                            color: Colors.black,
                            fontSize: 40,
                            letterSpacing: 0,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                      const Text(
                        "Fully Secure Transmission of Vital Information",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 't3',
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Thanks to the encrypted Technologies used",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 't3',
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ]),
    );
  }
}
