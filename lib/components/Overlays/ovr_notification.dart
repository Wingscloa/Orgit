import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/overlays/overlay.dart';
import 'package:orgit/components/header/ovr_header.dart';
import 'package:orgit/pages/settings/components/section_entry.dart';
import 'package:orgit/pages/settings/components/section_line.dart';
import 'package:orgit/pages/settings/components/section_switch.dart';
import 'package:orgit/utils/overlay_helper.dart';
import 'package:orgit/components/Overlays/ovr_silentmode.dart';

class OverlayNotification extends StatefulOverlay {
  OverlayNotification({
    super.key,
  });
  @override
  State<OverlayNotification> createState() => OverlayNotificationState();
}

class OverlayNotificationState extends State<OverlayNotification> {
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
                  label: "Upozornění",
                  onTap: widget.onClose,
                )),
            SizedBox(
              height: 60,
            ),
            Column(
              spacing: Global.settingsSpace,
              children: [
                SectionLine(),
                ValueListenableBuilder<bool>(
                  // stavi jen tenhle widget, dle zmeny hodnoty
                  valueListenable: notificationDisabled,
                  builder: (context, value, _) {
                    return SectionSwitch(
                        value: value,
                        onTap: (newValue) {
                          notificationDisabled.value = newValue;
                          print("Notification result : ${value}");
                        });
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                SettingEntry(
                  icon: Icons.no_cell,
                  label: "Tichý režim",
                  onTap: () => OverlayHelper.showOverlay(
                    context,
                    OverlaySilentMode(),
                  ),
                ),
                // SettingEntry(
                //   icon: Icons.message,
                //   label: "Zprávy",
                //   onTap: () => OverlayHelper.showOverlay(
                //     context,
                //     OverlayMessageMute(),
                //   ),
                // ),
                // SettingEntry(
                //   icon: Icons.school,
                //   label: "Orlingo",
                //   onTap: () => OverlayHelper.showOverlay(
                //     context,
                //     OverlayOrlingoMute(),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
