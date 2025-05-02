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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 175,
                      height: 175,
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
                          spacing: 40,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Icon(
                                  Icons.school,
                                  color: Color.fromARGB(255, 196, 156, 83),
                                ),
                                Text(
                                  "Datum vydání",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 196, 156, 83),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                "Test",
                                style: Global.defaultStyle(16, false),
                              ),
                            )
                          ],
                        ),
                      ),
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
