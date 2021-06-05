import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thinq24_demo/activities/splash.dart';
import 'package:thinq24_demo/activities/intro.dart';
import 'package:thinq24_demo/activities/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: splash(),
        routes: <String, WidgetBuilder>{
          '/intro': (BuildContext context) => new intro(),
          '/map': (BuildContext context) => new map(),
        });
  }
}
