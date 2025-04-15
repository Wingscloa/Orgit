import 'package:flutter/material.dart';
import 'dart:math' as math;

class Cardgroup extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Image image;
  final String name;
  final String city;
  final String region;
  final GestureTapCallback? OnTap;

  const Cardgroup(
      {required this.primaryColor,
      required this.secondaryColor,
      required this.image,
      required this.name,
      required this.city,
      required this.region,
      required this.OnTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Transform.rotate(
        angle: math.pi,
        child: InkWell(
          onTap: OnTap,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      leading: image,
      title: Text(name.toUpperCase(),
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text("$city, $region",
          style: TextStyle(
            color: secondaryColor,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
