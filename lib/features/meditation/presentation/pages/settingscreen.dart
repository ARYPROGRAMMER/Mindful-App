import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 430,
        height: 932,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 142,
              top: 35,
              child: Container(
                width: 53,
                height: 48,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/set.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 27,
              top: 45,
              child: Container(
                width: 29,
                height: 29,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/back.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 54,
              top: 230,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/admin.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 54,
              top: 265,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/heart.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 55,
              top: 321,
              child: Container(
                width: 22,
                height: 21,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/health.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 55,
              top: 356,
              child: Container(
                width: 23,
                height: 22,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/api.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 53,
              top: 394,
              child: Container(
                width: 23,
                height: 21,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/noti.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 55,
              top: 431,
              child: Container(
                width: 22,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/support.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 54,
              top: 501,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/adv.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 58,
              top: 703,
              child: Container(
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/misc.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 59,
              top: 735,
              child: Container(
                width: 19,
                height: 17,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/help.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 57,
              top: 651,
              child: Container(
                width: 20,
                height: 18,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/invite.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 56,
              top: 605,
              child: Container(
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/logout.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 58,
              top: 565,
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/clear.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 190,
              top: 45,
              child: SizedBox(
                width: 82,
                height: 27,
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 234,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'General Settings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 267,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Health and Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 321,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Health and Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 358,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'API Integrations',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 394,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 431,
              child: SizedBox(
                width: 177,
                height: 21,
                child: Text(
                  'Support and Feedback',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 501,
              child: SizedBox(
                width: 146,
                height: 21,
                child: Text(
                  'Advanced Settings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 563,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Miscellaneous',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 605,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Help',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 649,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Invite Others',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 703,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 733,
              child: SizedBox(
                width: 134,
                height: 21,
                child: Text(
                  'Clear Logs',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
