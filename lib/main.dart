// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:event_calender/Pages/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Pages/Home.dart';
import 'Testing.dart';
import 'Testing2.dart';
import 'Widgets/Meetings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await AndroidAlarmManager.initialize();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EveCalendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      // Test()
      // DemoApp()
          SplashPage()
      // MyHomePage()
      // HomePage(),
    );
  }
}
