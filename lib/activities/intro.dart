import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thinq24_demo/style/theme.dart' as Theme;

class intro extends StatefulWidget {
  @override
  introState createState() => introState();
}

class introState extends State<intro> {
  int currentScreen = 1;
  String imgName = "order", imgContent = "Order your favorites";
  List<Color> dotColors = [
    Theme.Colors.primarycolor,
    Theme.Colors.greycolor,
    Theme.Colors.greycolor
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement build
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.Colors.secondcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              currentScreen == 3 ? Container() :   GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 15.0, top: 20.0),
                  child: Text(
                "SKIP",
                    style: TextStyle(
                        color: Theme.Colors.primarycolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/map');
                },
              )
            ],
          ),
          Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: 300.0,
                  child: Image(
                    image: AssetImage("assets/images/$imgName.png"),
                    fit: BoxFit.contain,
                  )),
              Container(
                  child: Center(
                      child: Text(
                imgContent,
                style: TextStyle(
                    color: Theme.Colors.primarycolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
                textAlign: TextAlign.center,
              )))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Padding(
                    padding: EdgeInsets.only(
                        right: 20.0, left: 15.0, top: 20.0, bottom: 20.0),
                    child: currentScreen == 1
                        ? Container(width: 65.0,)
                        : Container(child:Icon(
                            Icons.arrow_back_ios,
                            color: Theme.Colors.primarycolor,
                            size: 35.0,
                          ),
                    width: 65.0,)),
                onTap: () {
                  setState(() {
                    currentScreen -= 1;
                  });
                  switchContent();
                },
              ),
              Row(
                children: [
                  dots(0),
                  dots(1),
                  dots(2),
                ],
              ),
              GestureDetector(
                child: Padding(
                    padding: EdgeInsets.only(
                        right: 20.0, left: 15.0, top: 20.0, bottom: 20.0),
                    child: currentScreen == 3
                        ? Container(child:Text(
                            "DONE",
                            style: TextStyle(
                                color: Theme.Colors.primarycolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                    width: 65.0,)
                        : Container(child:Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.Colors.primarycolor,
                            size: 35.0,
                          ),
                    width: 65.0,)),
                onTap: () {
                  if (currentScreen == 3) {
                    Navigator.pushReplacementNamed(context, '/map');
                  } else {
                    setState(() {
                      currentScreen += 1;
                    });
                    switchContent();
                  }
                },
              )
            ],
          ),
        ],
      ),
    ));
  }

  switchContent() {
    switch (currentScreen) {
      case 1:
        setState(() {
          imgName = "order";
          imgContent = "Order your favorites";
          dotColors = [Theme.Colors.primarycolor, Theme.Colors.greycolor, Theme.Colors.greycolor];
        });
        break;

      case 2:
        setState(() {
          imgName = "delivery";
          imgContent = "Fast delivery";
          dotColors = [Theme.Colors.primarycolor, Theme.Colors.primarycolor, Theme.Colors.greycolor];
        });
        break;

      case 3:
        setState(() {
          imgName = "eat";
          imgContent = "Happy eating";
          dotColors = [Theme.Colors.primarycolor, Theme.Colors.primarycolor, Theme.Colors.primarycolor];
        });
    }
  }

  Widget dots(index){
    return  Container(
      height: 10.0,
      width: 10.0,
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: dotColors[index],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
