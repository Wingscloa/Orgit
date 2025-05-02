import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/Overlays/Overlay.dart';
import 'package:orgit/components/Overlays/ovr_header.dart';
import 'package:orgit/pages/settings/components/section_entry.dart';
import 'package:orgit/pages/settings/components/section_line.dart';
import 'package:orgit/pages/settings/components/section_switch.dart';

class OverlaySilentMode extends StatefulOverlay {
  OverlaySilentMode({super.key, super.onClose});
  @override
  OverlaySilentModeState createState() => OverlaySilentModeState();
}

class OverlaySilentModeState extends State<OverlaySilentMode> {
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
          children: [],
        ),
      ),
    );
  }
}
