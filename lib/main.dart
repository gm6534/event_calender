import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Pages/Home.dart';
import 'Testing.dart';
import 'Widgets/Meetings.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
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
      title: 'My Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      // MyHomePage()
      // CustomTooltip()
      HomePage(),
    );
  }
}

