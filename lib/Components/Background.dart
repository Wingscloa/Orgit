import 'package:flutter/widgets.dart';

class HomePageBackground extends StatefulWidget {
  @override
  State<HomePageBackground> createState() => _HomePageBackgroundState();
}

class _HomePageBackgroundState extends State<HomePageBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
              Color.fromRGBO(20, 33, 49, 1),
              Color.fromRGBO(0, 1, 19, 1)
            ],
                stops: [
              0.0,
              1.0
            ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated)));
  }
}
