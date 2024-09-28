import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health/features/auth/data/models/auth/signin_user_req.dart';
import 'package:mental_health/features/auth/domain/usecases/auth/signin.dart';
import 'package:mental_health/features/auth/presentation/auth/pages/signup.dart';
import 'package:mental_health/injections.dart';
import 'package:mental_health/presentation/homePage/home_page.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _passworde = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: AppBar(
        title: Image.asset(
          "screenshots/logo.png",
          height: 300,
          width: 300,
        ),
        centerTitle: true,
      ),
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
              Text("Get In Your Mood",style: TextStyle(fontFamily: 't3',color: Colors.black,fontSize: 32,fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 110,
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
                height: 80,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()),
                        (route) => false);
                  });
                },
                child: const Text("  Sign In  ",style: TextStyle(fontFamily: 't3',color: Colors.white,fontSize: 22,),
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
      'Sign In',
      style: TextStyle(letterSpacing:3,fontFamily: 't1',color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailfield(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: "Enter Email",

      ),
      style: TextStyle(fontFamily: 't3',color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
    );
  }

  Widget _password(BuildContext context) {
    return TextField(
      controller: _passworde,
      decoration: const InputDecoration(
        hintText: "Password",
      ),
      style: TextStyle(fontFamily: 't3',color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),

    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(fontFamily: 't2',color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),

          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Signup()));
              },
              child: const Text("Register Now",style: TextStyle(letterSpacing:0,fontFamily: 't2',color: Colors.purple,fontSize: 25,fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
