import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/auth/domain/entities/auth/googleapisignin.dart';
import 'package:mental_health/features/meditation/presentation/pages/generalSettings/fieldUpdates.dart';
import 'package:mental_health/presentation/onboarding/onboarding.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchInAppWithBrowserOptions(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
      browserConfiguration: const BrowserConfiguration(showTitle: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.white,
        elevation: 10,
        shadowColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              Container(
                width: 55,
                height: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/essentials/set.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/admin.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => upDate()));
                      },
                      child: const Text(
                        'General Settings',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/heart.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Health and Data',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/health.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri toLaunch = Uri(
                          scheme: 'https',
                          host: 'www.postgresql.org',
                          path: '/');
                      setState(() {
                        _launched = _launchInAppWithBrowserOptions(toLaunch);
                      });
                    },
                    child: const SizedBox(
                      width: 200,
                      child: Text(
                        'Data Storage',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/api.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri toLaunch = Uri(
                          scheme: 'https',
                          host: 'docs.llama-api.com',
                          path: '/essentials/chat');
                      setState(() {
                        _launched = _launchInAppWithBrowserOptions(toLaunch);
                      });
                    },
                    child: const SizedBox(
                      width: 200,
                      child: Text(
                        'API Integrations',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/noti.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/support.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      'Support and Feedback',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/adv.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Advanced Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/misc.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Miscellaneous',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/help.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Help',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/invite.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Invite Others',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Onboarding()),
                          (route) => false);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/essentials/logout.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: GestureDetector(
                      onTap: () async {
                        final m = Hive.box('lastlogin');
                        if (m.get('google').toString() == "true") {
                          m.put('google', 'false');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Onboarding()),
                              (route) => false);
                          await GoogleSignInApi.logout();
                        } else {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Onboarding()),
                              (route) => false);
                        }
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/essentials/clear.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Clear Cache',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
