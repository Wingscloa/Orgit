import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/overlays/overlay.dart';
import 'package:orgit/components/header/ovr_header.dart';

class OverlayInformationApp extends StatefulOverlay {
  OverlayInformationApp({super.key});
  @override
  OverlayInformationAppState createState() => OverlayInformationAppState();
}

class OverlayInformationAppState extends State<OverlayInformationApp> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        animationDuration: 0.ms,
        borderOnForeground: false,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(60),
          topRight: const Radius.circular(60),
        ),
        elevation: 20,
        color: Global.settings,
        child: Column(
          spacing: 90,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 45),
              child: OverlayHeader(
                label: "Informace o aplikaci",
                onTap: widget.onClose,
              ),
            ),
            Column(
              spacing: 20,
              children: [
                Image(
                  image: AssetImage("assets/InformationAbout.png"),
                ),
                Text(
                  "Název aplikace : Orgit",
                  style: Global.defaultStyle(26, true),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 5,
                  children: [
                    InformationCard(
                      header: "Datum vydání",
                      headerIcon: Icons.timelapse,
                      text1: " 24. Června 2025",
                      icon1: Icons.calendar_month,
                    ),
                    InformationCard(
                      header: "Vývojáři",
                      headerIcon: Icons.developer_board,
                      text1: "Éder Filip",
                      icon1: Icons.precision_manufacturing,
                      text2: "Buriánek Lukáš",
                      icon2: Icons.directions_boat_rounded,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 5,
                  children: [
                    InformationCard(
                      header: "Počet stáhnutí",
                      headerIcon: Icons.download,
                      text1: "0",
                      icon1: Icons.numbers,
                    ),
                    InformationCard(
                      header: "Podpora",
                      headerIcon: Icons.support_agent,
                      text1: "Orgit@email.cz",
                      icon1: Icons.email,
                      text2: "+420 732 123 865",
                      icon2: Icons.directions_boat_rounded,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  final String header;
  final IconData headerIcon;
  final String? text1;
  final IconData? icon1;
  final String? text2;
  final IconData? icon2;

  const InformationCard({
    super.key,
    required this.header,
    required this.headerIcon,
    this.text1,
    this.icon1,
    this.text2,
    this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 34, 39, 40),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Color.fromARGB(255, 48, 45, 48),
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          spacing: 24,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(
                  headerIcon,
                  color: Color.fromARGB(255, 196, 156, 83),
                ),
                Text(
                  header,
                  style: TextStyle(
                    color: Color.fromARGB(255, 196, 156, 83),
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                  ),
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                text1 != null && icon1 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Icon(
                            color: Colors.white,
                            icon1!,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            text1!,
                            style: Global.defaultStyle(16, false),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                text2 != null && icon2 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Icon(
                            color: Colors.white,
                            icon2!,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            text2!,
                            style: Global.defaultStyle(16, false),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
