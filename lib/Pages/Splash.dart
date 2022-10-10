import 'dart:async';

import 'package:event_calender/Testing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widgets/CustomPaint.dart';
import 'LoginPage.dart';
import 'MainPage.dart';


Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  User? user= FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    Timer(Duration(seconds: 8), () {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
      (user == null)?
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()))
      :
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage()));
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomPaint(
              painter: Chevron(),
              child: Container(
                height: 250,
              ),
            ),
            CircleAvatar(
              radius: 90,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/51432318d4acaf6e4a3b62d0f3d5ea70.gif"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text("EveCalendar", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade700, fontSize: 35,letterSpacing: 1),),
            ),
            CustomPaint(
              painter: BottomChevron(),
              child: Container(
                height: 250,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("By Team Deviate", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 15),),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
