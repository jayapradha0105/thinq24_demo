import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thinq24_demo/style/theme.dart' as Theme;
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

class splash extends StatefulWidget {
  @override
  splashState createState() => splashState();
}

class splashState extends State<splash> {
  double loadval = 0.0;

  @override
  void initState() {
    super.initState();
     Timer.periodic(Duration(milliseconds: 500), (timer) {
        print(loadval + 0.1);
        print(loadval < 1.0);
        if (loadval < 1.0) {
          setState(() {
            loadval = double.parse((loadval + 0.1).toStringAsFixed(1));
          });
          print(loadval);
        } else{
          print("cancelled");
          timer.cancel();
          Navigator.pushReplacementNamed(context, '/intro');
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement build
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.Colors.primarycolor.withOpacity(0.5),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width - 150,
                height: 100.0,
                margin: EdgeInsets.only(
                    top: 10.0, right: 20.0, left: 20.0, bottom: 5.0),
                child: Image(
                  image: AssetImage("assets/images/thinq24_logo.png"),
                  fit: BoxFit.contain,
                )),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 100.0,
              child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width / 2,
                lineHeight: 5.0,
                percent: loadval,
                backgroundColor: Theme.Colors.greycolor,
                progressColor: Theme.Colors.secondcolor,
              ),
            )
          ],
        )));
  }
}
