import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/overlays/overlay.dart';
import 'package:orgit/components/header/ovr_header.dart';

class OverlayOrlingoMute extends StatefulOverlay {
  OverlayOrlingoMute({super.key});
  @override
  OverlayOrlingoMuteState createState() => OverlayOrlingoMuteState();
}

class OverlayOrlingoMuteState extends State<OverlayOrlingoMute> {
  final ValueNotifier<bool> notificationDisabled = ValueNotifier<bool>(false);

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
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 45),
                  child: OverlayHeader(
                    label: "Orlingo",
                    onTap: widget.onClose,
                  )),
              SizedBox(
                height: 60,
              ),
            ],
          )),
    );
  }
}
